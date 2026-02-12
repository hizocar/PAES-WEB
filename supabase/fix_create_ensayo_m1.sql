create or replace function public.create_ensayo_m1(p_user_id uuid)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_ensayo_id uuid;
  v_questions jsonb;

begin
  -- Select 15 Random Questions from each Axis (handling duplicate slugs)
  with selected_questions as (
    (
      select id, content, alternatives, image_url, 'numeros' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id in (select id from public.ejes where slug = 'numeros')))
      and subject = 'm1'
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, image_url, 'algebra-y-funciones' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id in (select id from public.ejes where slug in ('algebra-y-funciones', 'algebra-y-propiedades'))))
      and subject = 'm1'
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, image_url, 'geometria' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id in (select id from public.ejes where slug = 'geometria')))
      and subject = 'm1'
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, image_url, 'probabilidad-y-estadistica' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id in (select id from public.ejes where slug = 'probabilidad-y-estadistica')))
      and subject = 'm1'
      order by random() 
      limit 15
    )
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
    )
  ), '[]'::jsonb) into v_questions from selected_questions;

  -- Verify we actually found questions
  if jsonb_array_length(v_questions) < 60 then
     raise exception 'No hay suficientes preguntas activas (M1) para generar el ensayo. Encontradas: %', jsonb_array_length(v_questions);
  end if;

  -- Create Ensayo Record
  insert into public.ensayos (user_id, subject, status, questions_data, total_questions)
  values (p_user_id, 'm1', 'in_progress', v_questions, 60)
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$$;
