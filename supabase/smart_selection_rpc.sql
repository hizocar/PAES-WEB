-- Function to get a random question based on weights
-- Parameters:
--   p_retry_mode: If true, focuses on questions with past errors.

create or replace function public.get_smart_question(p_user_id uuid, p_retry_mode boolean default false)
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
                    -- NORMAL MODE
                    case
                        -- If currently correct (any attempt is correct), exclude it 
                        -- (Assumption: mastery = at least one correct answer)
                        when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id 
                            and a.is_correct = true
                        ) then 0
                        -- If attempted implies it was incorrect (due to above clause), weight 1
                        when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id
                        ) then 1
                        -- Unseen: weight 10
                        else 10
                    end
                else
                    -- RETRY MODE (Review past mistakes)
                    case
                        -- Priority 1: Questions with MORE wrong attempts get higher weight.
                        -- Subquery to count wrong attempts for this user and question
                        when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id 
                            and a.is_correct = false
                        ) then 
                             (select count(*) * 10 
                              from attempts a 
                              where a.question_id = q.id 
                              and a.user_id = p_user_id 
                              and a.is_correct = false)
                        -- Exclude perfectly answered ones (or never seen)
                        else 0
                    end
            end as weight
        from questions q
    ),
    valid_questions as (
        select * from weighted_questions where weight > 0
    )
    select valid_questions.id into v_question_id
    from valid_questions
    -- Weighted Random Selection
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
