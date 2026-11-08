-- Práctica por tema (2026-11-08).
-- Permite al alumno elegir un tópico del temario, practicar solo ese tópico y ver su avance.

-- Progreso del alumno por tópico (solo tópicos con preguntas activas).
create or replace function public.get_topic_progress(p_user_id uuid, p_subject text)
returns table (
  eje_id uuid, eje_name text, eje_slug text, eje_order int,
  topic_id uuid, topic_name text, topic_slug text,
  total_questions int, answered int, mastered int,
  attempts int, correct int, accuracy int, last_at timestamptz
)
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
begin
  if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = 'service_role') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;

  return query
  with tq as (
    select t.id as topic_id, q.id as question_id
    from public.topics t
    join public.ejes e on e.id = t.eje_id and e.subject = p_subject
    join public.question_topics qt on qt.topic_id = t.id
    join public.questions q on q.id = qt.question_id and q.is_active and q.subject = p_subject
  ),
  ua as (
    select a.question_id, count(*) as n, count(*) filter (where a.is_correct) as c, max(a.created_at) as last_at
    from public.attempts a
    where a.user_id = p_user_id
    group by a.question_id
  )
  select
    e.id, e.name::text, e.slug::text,
    coalesce(array_position(array['numeros','algebra-y-funciones','geometria','probabilidad-y-estadistica'], e.slug::text), 99)::int,
    t.id, t.name::text, t.slug::text,
    count(tq.question_id)::int,
    count(ua.question_id)::int,
    count(ua.question_id) filter (where ua.c > 0)::int,
    coalesce(sum(ua.n), 0)::int,
    coalesce(sum(ua.c), 0)::int,
    case when coalesce(sum(ua.n), 0) = 0 then 0 else round(100.0 * sum(ua.c) / sum(ua.n))::int end,
    max(ua.last_at)
  from public.topics t
  join public.ejes e on e.id = t.eje_id and e.subject = p_subject
  join tq on tq.topic_id = t.id
  left join ua on ua.question_id = tq.question_id
  group by e.id, e.name, e.slug, t.id, t.name, t.slug
  order by 4, t.name;
end;
$$;

-- Siguiente pregunta de un tópico: primero nuevas, luego falladas, y si ya domina todas,
-- cualquiera al azar para reforzar. Misma forma de salida que get_smart_question.
create or replace function public.get_topic_question(p_user_id uuid, p_topic_id uuid)
returns table (
  id uuid, content text, alternatives jsonb, correct_answer text, explanation text,
  difficulty text, explanation_video_path text, image_url text, topic_name text, eje_name text
)
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
declare
  v_question_id uuid;
begin
  if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = 'service_role') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;

  select q.id into v_question_id
  from public.questions q
  join public.question_topics qt on qt.question_id = q.id and qt.topic_id = p_topic_id
  where q.is_active
  order by
    case
      when not exists (select 1 from public.attempts a where a.question_id = q.id and a.user_id = p_user_id) then 0
      when not exists (select 1 from public.attempts a where a.question_id = q.id and a.user_id = p_user_id and a.is_correct) then 1
      else 2
    end,
    -- evita repetir la última pregunta vista
    (select max(a.created_at) from public.attempts a where a.question_id = q.id and a.user_id = p_user_id) asc nulls first,
    random()
  limit 1;

  if v_question_id is null then
    return;
  end if;

  return query
  select q.id, q.content::text, q.alternatives::jsonb, q.correct_answer::text, q.explanation::text,
         q.difficulty::text, q.explanation_video_path::text, q.image_url::text, t.name::text, e.name::text
  from public.questions q
  join public.topics t on t.id = p_topic_id
  join public.ejes e on e.id = t.eje_id
  where q.id = v_question_id;
end;
$$;

revoke all on function public.get_topic_progress(uuid, text) from public, anon;
revoke all on function public.get_topic_question(uuid, uuid) from public, anon;
grant execute on function public.get_topic_progress(uuid, text) to authenticated, service_role;
grant execute on function public.get_topic_question(uuid, uuid) to authenticated, service_role;
