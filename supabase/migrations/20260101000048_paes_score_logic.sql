-- Function to estimate PAES score based on accuracy
-- logic: Linear interpolation between 100 (0%) and 1000 (100%)
-- We can refine this curve later if we have exact data.
create or replace function public.calculate_paes_estimate(p_accuracy float)
returns integer
language sql
immutable
as $$
  -- score = 100 + (accuracy * 900)
  -- accuracy is between 0.0 and 1.0
  select (100 + (p_accuracy * 900))::integer;
$$;

-- Function to get score history for a student
-- Returns cumulative score evolution over time (grouped by day)
create or replace function public.get_student_score_history(p_user_id uuid, p_subject text default 'm1')
returns table (
    date date,
    cumulative_attempts bigint,
    cumulative_correct bigint,
    accuracy float,
    estimated_score integer
)
language plpgsql
security definer
set search_path = public
as $$
begin
    -- Check permissions (Admin or Self)
    if not public.is_admin() and auth.uid() <> p_user_id then
        raise exception 'Access denied';
    end if;

    return query
    with daily_stats as (
        select
            a.created_at::date as day,
            count(*) as day_attempts,
            count(case when a.is_correct then 1 end) as day_correct
        from public.attempts a
        -- join questions q on a.question_id = q.id -- If we need to filter by subject 
        -- For now assuming all attempts count or we rely on the p_subject filter logic later
        -- Use simple filtering if 'subject' column existed on attempts or questions
        where a.user_id = p_user_id
        group by a.created_at::date
    ),
    cumulative as (
        select
            day,
            sum(day_attempts) over (order by day) as total_attempts,
            sum(day_correct) over (order by day) as total_correct
        from daily_stats
    )
    select
        c.day,
        c.total_attempts::bigint,
        c.total_correct::bigint,
        (c.total_correct::float / c.total_attempts::float) as acc,
        public.calculate_paes_estimate(c.total_correct::float / c.total_attempts::float) as score
    from cumulative c
    order by c.day;
end;
$$;

-- Grant permissions
grant execute on function public.calculate_paes_estimate(float) to authenticated, service_role;
grant execute on function public.get_student_score_history(uuid, text) to authenticated, service_role;
