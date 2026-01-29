-- Function to get efficient dashboard stats in one go
create or replace function get_dashboard_stats(p_user_id uuid)
returns json
language plpgsql
security definer
as $$
declare
    v_daily_progress int;
    v_mistakes_count int;
    v_ejes_stats json;
    v_start_of_day timestamp;
begin
    v_start_of_day := date_trunc('day', now());

    -- 1. Daily Progress (Attempts today)
    select count(*)
    into v_daily_progress
    from attempts
    where user_id = p_user_id
    and created_at >= v_start_of_day;

    -- 2. Mistakes Count (Questions with AT LEAST one wrong answer and NO correct answers)
    select count(distinct a.question_id)
    into v_mistakes_count
    from attempts a
    where a.user_id = p_user_id
    and a.is_correct = false
    and not exists (
        select 1 from attempts a2
        where a2.user_id = p_user_id
        and a2.question_id = a.question_id
        and a2.is_correct = true
    );

    -- 3. Ejes Stats (Proficiency per Eje)
    -- We join attempts -> (question) -> question_topics -> topics -> ejes
    with user_attempts_enriched as (
        select 
            e.id as eje_id,
            e.name as eje_name,
            a.is_correct
        from attempts a
        join question_topics qt on a.question_id = qt.question_id
        join topics t on qt.topic_id = t.id
        join ejes e on t.eje_id = e.id
        where a.user_id = p_user_id
    ),
    eje_aggregates as (
        select 
            eje_id,
            eje_name,
            count(*) as total_attempts,
            sum(case when is_correct then 1 else 0 end) as correct_count
        from user_attempts_enriched
        group by eje_id, eje_name
    )
    select json_agg(
        json_build_object(
            'id', ea.eje_id,
            'name', ea.eje_name,
            'total_attempts', ea.total_attempts,
            'progress', case when ea.total_attempts > 0 then round((ea.correct_count::numeric / ea.total_attempts) * 100) else 0 end
        )
    )
    into v_ejes_stats
    from eje_aggregates as ea;

    -- Return combined JSON
    return json_build_object(
        'daily_progress', v_daily_progress,
        'active_mistakes', v_mistakes_count,
        'ejes_stats', coalesce(v_ejes_stats, '[]'::json)
    );
end;
$$;
