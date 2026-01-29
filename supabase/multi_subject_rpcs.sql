-- PHASE 2: Update RPCs to support Subject Filtering

-- 1. update get_smart_question to accept p_subject
create or replace function public.get_smart_question(
    p_user_id uuid, 
    p_retry_mode boolean default false,
    p_subject text default 'm2' -- New Parameter
)
returns table (
    id uuid,
    content text,
    alternatives jsonb,
    correct_answer text,
    explanation text,
    difficulty text,
    explanation_video_path text,
    topic_name text,
    eje_name text
)
language plpgsql
security definer
as $$
declare
    v_question_id uuid;
begin
    -- 1. Select a random question ID based on weights
    with weighted_questions as (
        select
            q.id,
            case
                when p_retry_mode = false then
                    case
                        when exists (select 1 from attempts a where a.question_id = q.id and a.user_id = p_user_id and a.is_correct = true) then 0
                        when exists (select 1 from attempts a where a.question_id = q.id and a.user_id = p_user_id) then 1
                        else 10
                    end
                else -- RETRY MODE
                    case
                        when exists (select 1 from attempts a where a.question_id = q.id and a.user_id = p_user_id and a.is_correct = false) then 
                             (select count(*) * 10 from attempts a where a.question_id = q.id and a.user_id = p_user_id and a.is_correct = false)
                        else 0
                    end
            end as weight
        from questions q
        where q.subject = p_subject -- FILTER BY SUBJECT
    ),
    valid_questions as (
        select * from weighted_questions where weight > 0
    )
    select valid_questions.id into v_question_id
    from valid_questions
    order by -ln(random()) / valid_questions.weight
    limit 1;

    -- 2. Return the full question details
    return query
    select
        q.id,
        q.content::text,
        q.alternatives::jsonb,
        q.correct_answer::text,
        q.explanation::text,
        q.difficulty::text,
        q.explanation_video_path::text,
        t.name::text as topic_name,
        e.name::text as eje_name
    from questions q
    left join question_topics qt on q.id = qt.question_id
    left join topics t on qt.topic_id = t.id
    left join ejes e on t.eje_id = e.id
    where q.id = v_question_id;
end;
$$;

-- 2. update get_dashboard_stats to accept p_subject
create or replace function get_dashboard_stats(
    p_user_id uuid,
    p_subject text default 'm2' -- New Parameter
)
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

    -- 1. Daily Progress (Attempts today for THIS subject)
    -- Note: Ideally we want daily progress to be TOTAL or per subject? usually TOTAL is better for habit, 
    -- but let's filter by subject to keep it focused if requested.
    -- Assuming daily goal is generic, but let's count only relevant subject questions for strictness.
    select count(a.id)
    into v_daily_progress
    from attempts a
    join questions q on a.question_id = q.id -- Helper join
    where a.user_id = p_user_id
    and a.created_at >= v_start_of_day
    and q.subject = p_subject;

    -- 2. Mistakes Count
    select count(distinct a.question_id)
    into v_mistakes_count
    from attempts a
    join questions q on a.question_id = q.id
    where a.user_id = p_user_id
    and a.is_correct = false
    and q.subject = p_subject -- Filter
    and not exists (
        select 1 from attempts a2
        where a2.user_id = p_user_id
        and a2.question_id = a.question_id
        and a2.is_correct = true
    );

    -- 3. Ejes Stats
    with user_attempts_enriched as (
        select 
            e.id as eje_id,
            a.is_correct
        from ejes e
        left join topics t on t.eje_id = e.id
        left join question_topics qt on qt.topic_id = t.id
        left join questions q on qt.question_id = q.id and q.subject = p_subject
        left join attempts a on a.question_id = q.id and a.user_id = p_user_id
        where e.subject = p_subject -- Filter Ejes by subject
    ),
    eje_aggregates as (
        select 
            e.id as eje_id,
            e.name as eje_name,
            count(ua.is_correct) as total_attempts,
            sum(case when ua.is_correct then 1 else 0 end) as correct_count
        from ejes e
        left join user_attempts_enriched ua on e.id = ua.eje_id
        where e.subject = p_subject
        group by e.id, e.name
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

    return json_build_object(
        'daily_progress', v_daily_progress,
        'active_mistakes', v_mistakes_count,
        'ejes_stats', coalesce(v_ejes_stats, '[]'::json)
    );
end;
$$;

-- 3. update get_leaderboard to accept p_subject
create or replace function get_leaderboard(
    p_subject text default 'm2'
)
returns table (
    rank bigint,
    user_id uuid,
    full_name text,
    avatar_url text,
    score bigint
)
language plpgsql
security definer
as $$
begin
    return query
    with user_scores as (
        select 
            a.user_id,
            -- Score logic: +10 per correct answer in the specific subject
            count(*) * 10 as calculated_score
        from attempts a
        join questions q on a.question_id = q.id
        where a.is_correct = true
        and q.subject = p_subject -- Filter by subject
        group by a.user_id
    )
    select 
        rank() over (order by us.calculated_score desc) as rank,
        us.user_id,
        coalesce(p.full_name, 'Usuario') as full_name,
        p.avatar_url,
        us.calculated_score as score
    from user_scores us
    join profiles p on us.user_id = p.id
    order by rank asc
    limit 50;
end;
$$;
