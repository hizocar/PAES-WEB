create or replace function public.create_ensayo_m1(p_user_id uuid)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_ensayo_id uuid;
  v_questions jsonb;
  v_numeros_id uuid;
  v_algebra_id uuid;
  v_geometria_id uuid;
  v_probabilidad_id uuid;
begin
  -- Get Axis IDs
  select id into v_numeros_id from public.ejes where slug = 'numeros';
  select id into v_algebra_id from public.ejes where slug = 'algebra-y-funciones';
  select id into v_geometria_id from public.ejes where slug = 'geometria';
  select id into v_probabilidad_id from public.ejes where slug = 'probabilidad-y-estadistica';

  -- Select 15 Random Questions from each Axis
  with selected_questions as (
    (
      select id, content, alternatives, 'numeros' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_numeros_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, 'algebra-y-funciones' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_algebra_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, 'geometria' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_geometria_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, 'probabilidad-y-estadistica' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_probabilidad_id))
      order by random() 
      limit 15
    )
  )
  select jsonb_agg(
    jsonb_build_object(
      'id', id,
      'question_id', id,
      'content', content,
      'alternatives', alternatives,
      'eje_slug', eje_slug,
      'user_answer', null
    )
  ) into v_questions from selected_questions;

  -- Create Ensayo Record
  insert into public.ensayos (user_id, subject, status, questions_data, total_questions)
  values (p_user_id, 'm1', 'in_progress', v_questions, 60)
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$$;
