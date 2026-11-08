-- Ensayo M1 con la proporción de ejes de las pruebas oficiales (reconstrucción 2026-11).
--
-- Antes: 15 preguntas por eje (25% cada uno).
-- Ahora: proporción medida en 6 pruebas PAES M1 oficiales completas (390 ítems, ver
-- content/proporciones.json): Números 33,1% · Álgebra y Funciones 27,7% · Geometría 19,7%
-- · Probabilidad y Estadística 19,5%  →  sobre 60 preguntas: 20 / 17 / 12 / 11.
--
-- Solo se reemplaza la implementación interna; el wrapper con control de acceso de la
-- migración 061 (create_ensayo_m1) sigue delegando aquí.

create or replace function public.create_ensayo_m1__impl(p_user_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
declare
  v_ensayo_id uuid;
  v_questions jsonb;
begin
  with cuotas(eje_slug, n, orden) as (
    values ('numeros', 20, 1), ('algebra-y-funciones', 17, 2), ('geometria', 12, 3), ('probabilidad-y-estadistica', 11, 4)
  ),
  candidatas as (
    select distinct on (q.id) q.id, q.content, q.alternatives, q.image_url, e.slug as eje_slug
    from public.questions q
    join public.question_topics qt on qt.question_id = q.id
    join public.topics t on t.id = qt.topic_id
    join public.ejes e on e.id = t.eje_id
    where q.subject = 'm1' and q.is_active and e.subject = 'm1'
  ),
  ranqueadas as (
    select c.*, row_number() over (partition by c.eje_slug order by random()) as rn
    from candidatas c
  ),
  seleccion as (
    select r.*, cu.orden
    from ranqueadas r join cuotas cu on cu.eje_slug = r.eje_slug
    where r.rn <= cu.n
  )
  select coalesce(jsonb_agg(
    jsonb_build_object(
      'id', id,
      'question_id', id,
      'content', content,
      'alternatives', alternatives,
      'image_url', image_url,
      'eje_slug', eje_slug,
      'user_answer', null
    ) order by orden, rn
  ), '[]'::jsonb) into v_questions
  from seleccion;

  if jsonb_array_length(v_questions) < 60 then
    raise exception 'No hay suficientes preguntas activas (M1) para generar el ensayo. Encontradas: %', jsonb_array_length(v_questions);
  end if;

  insert into public.ensayos (user_id, subject, status, questions_data, total_questions)
  values (p_user_id, 'm1', 'in_progress', v_questions, 60)
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$$;

revoke all on function public.create_ensayo_m1__impl(uuid) from public, anon, authenticated;
