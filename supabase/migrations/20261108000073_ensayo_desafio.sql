-- Ensayo DESAFÍO (2026-11-08): versión exigente del ensayo para que el alumno suba de nivel.
-- Mismas cuotas por eje que el ensayo oficial, pero prioriza preguntas difíciles que el
-- alumno aún no domina; completa con intermedias si faltan. Puntaje en la misma escala PAES.

alter table public.ensayos
  add column if not exists level text not null default 'normal' check (level in ('normal', 'desafio'));

create or replace function public.create_ensayo_desafio__impl(p_user_id uuid, p_subject text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $fn$
#variable_conflict use_column
declare
  v_ensayo_id uuid;
  v_questions jsonb;
  v_total int := case when p_subject = 'm2' then 55 else 60 end;
begin
  if p_subject not in ('m1', 'm2') then
    raise exception 'Materia inválida';
  end if;

  with cuotas(eje_slug, n, orden) as (
    select * from (values
      ('numeros',                    case when p_subject = 'm2' then 14 else 20 end, 1),
      ('algebra-y-funciones',        case when p_subject = 'm2' then 17 else 17 end, 2),
      ('geometria',                  case when p_subject = 'm2' then 11 else 12 end, 3),
      ('probabilidad-y-estadistica', case when p_subject = 'm2' then  9 else 11 end, 4)
    ) v(eje_slug, n, orden)
  ),
  dominadas as (
    select distinct a.question_id from public.attempts a where a.user_id = p_user_id and a.is_correct
  ),
  candidatas as (
    select distinct on (q.id)
      q.id, q.content, q.alternatives, q.image_url, e.slug as eje_slug,
      (q.alternatives @> '[{"id": "F"}]'::jsonb) as es_suficiencia,
      -- 0 = difícil no dominada, 1 = difícil ya dominada, 2 = intermedia no dominada, 3 = resto
      case
        when q.difficulty = 'hard' and q.id not in (select question_id from dominadas) then 0
        when q.difficulty = 'hard' then 1
        when q.difficulty = 'medium' and q.id not in (select question_id from dominadas) then 2
        else 3
      end as prioridad
    from public.questions q
    join public.question_topics qt on qt.question_id = q.id
    join public.topics t on t.id = qt.topic_id
    join public.ejes e on e.id = t.eje_id
    where q.subject = p_subject and q.is_active and e.subject = p_subject and q.difficulty <> 'easy'
  ),
  estandar as (
    select c.*, row_number() over (partition by c.eje_slug order by c.prioridad, random()) as rn
    from candidatas c where not c.es_suficiencia
  ),
  sel_estandar as (
    select e.id, e.content, e.alternatives, e.image_url, e.eje_slug, cu.orden, e.rn
    from estandar e join cuotas cu on cu.eje_slug = e.eje_slug
    where e.rn <= cu.n
  ),
  sel_suficiencia as (
    select c.id, c.content, c.alternatives, c.image_url, c.eje_slug, 5 as orden,
           row_number() over (order by c.prioridad, random()) as rn
    from candidatas c where c.es_suficiencia and p_subject = 'm2'
  ),
  seleccion as (
    select * from sel_estandar
    union all
    select * from sel_suficiencia where rn <= 4
  )
  select coalesce(jsonb_agg(
    jsonb_build_object(
      'id', id, 'question_id', id, 'content', content, 'alternatives', alternatives,
      'image_url', image_url, 'eje_slug', eje_slug, 'user_answer', null
    ) order by orden, rn
  ), '[]'::jsonb) into v_questions
  from seleccion;

  if jsonb_array_length(v_questions) < v_total then
    raise exception 'Aún no hay suficientes preguntas difíciles para un desafío completo (%). Encontradas: %', upper(p_subject), jsonb_array_length(v_questions);
  end if;

  insert into public.ensayos (user_id, subject, status, questions_data, total_questions, level)
  values (p_user_id, p_subject, 'in_progress', v_questions, v_total, 'desafio')
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$fn$;
revoke all on function public.create_ensayo_desafio__impl(uuid, text) from public, anon, authenticated;

create or replace function public.create_ensayo_desafio(p_user_id uuid, p_subject text)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $fn$
begin
  if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = 'service_role') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  return public.create_ensayo_desafio__impl(p_user_id, p_subject);
end;
$fn$;
revoke all on function public.create_ensayo_desafio(uuid, text) from public, anon;
grant execute on function public.create_ensayo_desafio(uuid, text) to authenticated, service_role;
