-- Ensayos M2 (2026-11-08).
-- Antes solo existía el ensayo M1 y la app mostraba "Ensayos M2: Próximamente".

-- 1) Puntaje M2 en submit_ensayo (M1 queda igual).
create or replace function public.submit_ensayo__impl(p_ensayo_id uuid, p_answers jsonb)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $fn$

declare
  v_ensayo record;
  v_questions_data jsonb;
  v_total_correct integer := 0;
  v_score integer := 0;
  v_question_record record;
  v_user_answer text;
  v_is_correct boolean;
  v_updated_questions jsonb := '[]'::jsonb;
  
  -- Stats by Axis
  v_numeros_correct int := 0; v_numeros_total int := 0;
  v_algebra_correct int := 0; v_algebra_total int := 0;
  v_geometria_correct int := 0; v_geometria_total int := 0;
  v_probabilidad_correct int := 0; v_probabilidad_total int := 0;
  
begin
  select * into v_ensayo from public.ensayos where id = p_ensayo_id;
  
  if v_ensayo.status = 'completed' then
    return jsonb_build_object('error', 'Ensayo already submitted');
  end if;

  v_questions_data := v_ensayo.questions_data;

  -- Iterate through user answers and validate
  -- p_answers format: { "question_id_uuid": "A", ... }
  
  for v_question_record in (
    select q.id, q.correct_answer, t.eje_id, e.slug as eje_slug
    from public.questions q
    join public.question_topics qt on q.id = qt.question_id
    join public.topics t on qt.topic_id = t.id
    join public.ejes e on t.eje_id = e.id
    where q.id in (select (value->>'question_id')::uuid from jsonb_array_elements(v_questions_data))
  ) loop
    
    v_user_answer := p_answers->>v_question_record.id::text;
    v_is_correct := (v_user_answer is not null and v_user_answer = v_question_record.correct_answer);
    
    if v_is_correct then
      v_total_correct := v_total_correct + 1;
      
      -- Update Axis Stats
      if v_question_record.eje_slug = 'numeros' then v_numeros_correct := v_numeros_correct + 1; end if;
      if v_question_record.eje_slug = 'algebra-y-funciones' then v_algebra_correct := v_algebra_correct + 1; end if;
      if v_question_record.eje_slug = 'geometria' then v_geometria_correct := v_geometria_correct + 1; end if;
      if v_question_record.eje_slug = 'probabilidad-y-estadistica' then v_probabilidad_correct := v_probabilidad_correct + 1; end if;
    end if;

    -- Track totals by axis (implicitly 15, but good to count dynamically)
    if v_question_record.eje_slug = 'numeros' then v_numeros_total := v_numeros_total + 1; end if;
    if v_question_record.eje_slug = 'algebra-y-funciones' then v_algebra_total := v_algebra_total + 1; end if;
    if v_question_record.eje_slug = 'geometria' then v_geometria_total := v_geometria_total + 1; end if;
    if v_question_record.eje_slug = 'probabilidad-y-estadistica' then v_probabilidad_total := v_probabilidad_total + 1; end if;

    -- Rebuild questions data with result
    -- Note: This is a complex update, for simplicity we might just perform a big update at the end or assume the frontend sends the structure
    -- Ideally, we keep the original structure and just append the result. 
    -- For now, let's keep it simple: we calculate the score and return it.
    
  end loop;

  -- CALCULATE PAES SCORE (Scale provided by user)
  -- 0-60 Correct -> 100-1000 Points
  v_score := case v_total_correct
    when 0 then 100 when 1 then 170 when 2 then 194 when 3 then 216 when 4 then 236
    when 5 then 256 when 6 then 275 when 7 then 292 when 8 then 307 when 9 then 320
    when 10 then 334 when 11 then 349 when 12 then 365 when 13 then 380 when 14 then 393
    when 15 then 403 when 16 then 412 when 17 then 421 when 18 then 432 when 19 then 446
    when 20 then 460 when 21 then 474 when 22 then 486 when 23 then 495 when 24 then 502
    when 25 then 508 when 26 then 516 when 27 then 526 when 28 then 539 when 29 then 553
    when 30 then 567 when 31 then 579 when 32 then 587 when 33 then 595 when 34 then 601
    when 35 then 609 when 36 then 618 when 37 then 631 when 38 then 645 when 39 then 660
    when 40 then 672 when 41 then 682 when 42 then 690 when 43 then 699 when 44 then 710
    when 45 then 723 when 46 then 738 when 47 then 753 when 48 then 767 when 49 then 780
    when 50 then 793 when 51 then 807 when 52 then 824 when 53 then 842 when 54 then 861
    when 55 then 880 when 56 then 900 when 57 then 923 when 58 then 948 when 59 then 975
    when 60 then 1000
    else 100
  end;

  -- M2: 55 preguntas. Tabla oficial DEMRE de transformación M2 (PAES de Invierno, Admisión 2027;
  -- 0 a 49 correctas puntuadas). El acierto del ensayo se lleva a esa escala: puntaje estimado.
  if v_ensayo.subject = 'm2' then
    v_score := (array[100,204,231,255,278,298,317,336,354,371,386,399,412,426,441,456,470,481,491,501,
                      512,525,540,553,565,574,583,592,603,616,630,644,656,666,676,687,699,714,729,744,
                      757,770,785,801,819,837,856,876,898,1000])[
      least(49, round(v_total_correct * 49.0 / greatest(jsonb_array_length(v_questions_data), 1)))::int + 1
    ];
  end if;

  -- Update Ensayo Record
  update public.ensayos
  set 
    status = 'completed',
    completed_at = timezone('utc'::text, now()),
    score = v_score,
    total_correct = v_total_correct,
    answers = p_answers -- Save the raw answers map
  where id = p_ensayo_id;

  return jsonb_build_object(
    'ensayo_id', p_ensayo_id,
    'score', v_score,
    'total_correct', v_total_correct,
    'axis_stats', jsonb_build_object(
      'numeros', jsonb_build_object('correct', v_numeros_correct, 'total', v_numeros_total),
      'algebra', jsonb_build_object('correct', v_algebra_correct, 'total', v_algebra_total),
      'geometria', jsonb_build_object('correct', v_geometria_correct, 'total', v_geometria_total),
      'probabilidad', jsonb_build_object('correct', v_probabilidad_correct, 'total', v_probabilidad_total)
    )
  );
end;


$fn$;
revoke all on function public.submit_ensayo__impl(uuid, jsonb) from public, anon, authenticated;

-- 2) Ensayo M2: 55 preguntas con la proporción oficial medida en 6 pruebas M2
--    (Álgebra 33,3% · Números 26,1% · Geometría 22,4% · Prob. y Est. 18,2%; ~7% suficiencia
--    de datos, siempre al final del cuadernillo). Cuotas: 4 de suficiencia + 51 estándar
--    (Álgebra 17 · Números 14 · Geometría 11 · Prob. y Est. 9).
create or replace function public.create_ensayo_m2__impl(p_user_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $fn$
declare
  v_ensayo_id uuid;
  v_questions jsonb;
begin
  with cuotas(eje_slug, n, orden) as (
    values ('numeros', 14, 1), ('algebra-y-funciones', 17, 2), ('geometria', 11, 3), ('probabilidad-y-estadistica', 9, 4)
  ),
  candidatas as (
    select distinct on (q.id) q.id, q.content, q.alternatives, q.image_url, e.slug as eje_slug,
           (q.alternatives @> '[{"id": "F"}]'::jsonb) as es_suficiencia
    from public.questions q
    join public.question_topics qt on qt.question_id = q.id
    join public.topics t on t.id = qt.topic_id
    join public.ejes e on e.id = t.eje_id
    where q.subject = 'm2' and q.is_active and e.subject = 'm2'
  ),
  estandar as (
    select c.*, row_number() over (partition by c.eje_slug order by random()) as rn
    from candidatas c where not c.es_suficiencia
  ),
  sel_estandar as (
    select e.id, e.content, e.alternatives, e.image_url, e.eje_slug, cu.orden, e.rn
    from estandar e join cuotas cu on cu.eje_slug = e.eje_slug
    where e.rn <= cu.n
  ),
  sel_suficiencia as (
    select c.id, c.content, c.alternatives, c.image_url, c.eje_slug, 5 as orden,
           row_number() over (order by random()) as rn
    from candidatas c where c.es_suficiencia
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

  if jsonb_array_length(v_questions) < 55 then
    raise exception 'No hay suficientes preguntas activas (M2) para generar el ensayo. Encontradas: %', jsonb_array_length(v_questions);
  end if;

  insert into public.ensayos (user_id, subject, status, questions_data, total_questions)
  values (p_user_id, 'm2', 'in_progress', v_questions, 55)
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$fn$;
revoke all on function public.create_ensayo_m2__impl(uuid) from public, anon, authenticated;

create or replace function public.create_ensayo_m2(p_user_id uuid)
returns jsonb
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $fn$
begin
  if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = 'service_role') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  return public.create_ensayo_m2__impl(p_user_id);
end;
$fn$;
revoke all on function public.create_ensayo_m2(uuid) from public, anon;
grant execute on function public.create_ensayo_m2(uuid) to authenticated, service_role;
