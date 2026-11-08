-- Estadísticas por pregunta para el panel admin (2026-11-08).
-- Objetivos del dueño: (1) encontrar errores (por ejemplo, una clave mal puesta) y
-- (2) ver la dificultad real de cada pregunta.
-- Fuente: analytics.responses (práctica + ensayos), con dificultad medida en la primera
-- exposición de cada alumno para que las repeticiones no inflen el acierto.

create or replace function public.get_admin_question_stats(p_subject text)
returns table (
  question_id uuid,
  responses int,
  first_attempts int,
  pct_correct numeric,
  pct_correct_first numeric,
  median_time_ms numeric,
  answer_counts jsonb,
  top_wrong text,
  top_wrong_share numeric,
  empirical_difficulty text,
  flag text
)
language plpgsql
security definer
set search_path = public, analytics, extensions, pg_temp
as $$
begin
  if not (public.is_admin() or auth.role() = 'service_role') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;

  return query
  with r as (
    select resp.*, q.correct_answer, q.difficulty::text as assigned
    from analytics.responses resp
    join public.questions q on q.id = resp.question_id
    where resp.subject = p_subject
  ),
  agg as (
    select
      r.question_id,
      count(*)::int as responses,
      count(*) filter (where coalesce(r.attempt_number, 1) = 1)::int as first_attempts,
      round(100.0 * avg(r.is_correct::int), 1) as pct_correct,
      round(100.0 * avg(r.is_correct::int) filter (where coalesce(r.attempt_number, 1) = 1), 1) as pct_correct_first,
      percentile_cont(0.5) within group (order by r.time_spent_ms) filter (where r.time_spent_ms is not null) as median_time_ms,
      max(r.correct_answer) as correct_answer,
      max(r.assigned) as assigned
    from r
    group by r.question_id
  ),
  dist as (
    select r.question_id, jsonb_object_agg(coalesce(r.selected_answer, 'sin respuesta'), c) as answer_counts
    from (select question_id, selected_answer, count(*) as c from r group by 1, 2) r
    group by r.question_id
  ),
  wrong as (
    select distinct on (r.question_id) r.question_id, r.selected_answer as top_wrong, count(*) as c
    from r
    where not r.is_correct and r.selected_answer is not null and r.selected_answer <> 'TIMEOUT'
      and r.selected_answer <> (select (x->>'id') from public.questions qq, jsonb_array_elements(qq.alternatives) x
                                where qq.id = r.question_id and x->>'content' = 'No sé responder esta pregunta' limit 1)
    group by r.question_id, r.selected_answer
    order by r.question_id, count(*) desc
  )
  select
    a.question_id, a.responses, a.first_attempts, a.pct_correct, a.pct_correct_first, a.median_time_ms,
    d.answer_counts,
    w.top_wrong,
    round(100.0 * coalesce(w.c, 0) / nullif(a.responses, 0), 1) as top_wrong_share,
    case
      when a.first_attempts < 20 then 'insuficiente'
      when a.pct_correct_first >= 75 then 'easy'
      when a.pct_correct_first >= 40 then 'medium'
      else 'hard'
    end as empirical_difficulty,
    case
      -- Una alternativa incorrecta atrae más respuestas que la correcta: posible clave errónea
      when a.responses >= 10 and coalesce(w.c, 0) > (a.pct_correct / 100.0) * a.responses then 'revisar_clave'
      when a.first_attempts >= 20 and a.pct_correct_first < 15 then 'demasiado_dificil'
      when a.first_attempts >= 20 and a.assigned = 'hard' and a.pct_correct_first >= 75 then 'mas_facil_que_asignada'
      when a.first_attempts >= 20 and a.assigned = 'easy' and a.pct_correct_first < 40 then 'mas_dificil_que_asignada'
      else null
    end as flag
  from agg a
  left join dist d on d.question_id = a.question_id
  left join wrong w on w.question_id = a.question_id;
end;
$$;

revoke all on function public.get_admin_question_stats(text) from public, anon;
grant execute on function public.get_admin_question_stats(text) to authenticated, service_role;
