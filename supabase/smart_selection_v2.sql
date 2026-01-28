-- Function: get_smart_question_v2
-- Logic:
--   Mode Normal (false): Shows ONLY questions NOT answered correctly yet. Prioritizes Unseen (x10) over Failed (x1).
--   Mode Retry (true): Shows ONLY questions answered incorrectly at least once. Prioritizes heavily failed ones.

create or replace function public.get_smart_question_v2(p_user_id uuid, p_retry_mode boolean default false)
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
                        -- EXCLUDE if MASTERED (Has at least one correct attempt)
                        when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id 
                            and a.is_correct = true
                        ) then 0
                        
                        -- If we are here, it means NO correct attempts exist.
                        -- Weight 1: If it has WRONG attempts (Failed but not corrected)
                        when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id
                        ) then 1
                        
                        -- Weight 10: UNSEEN (No attempts at all)
                        else 10
                    end
                else
                    -- RETRY MODE
                    -- Only show questions with active errors (Failed attempts present)
                    -- For now, simple logic: If has wrong attempts, show it.
                    -- Note: Ideally we exclude if it was eventually corrected.
                    -- But user wants "Banco de Errores". If I corrected it, it should leave the bank?
                    -- "active mistakes" logic in Dashboard was: hasWrong && !hasCorrect.
                    -- Let's apply STRICT Mistake Bank: Only questions with NO correct answer yet, but WITH wrong answer.
                    -- OR questions with wrong answers regardless of correction?
                    -- User said: "priorizando aquellas con mas intentos fallidos".
                    -- Usually "Repaso" implies things I haven't mastered OR things I struggle with.
                    -- Let's stick to: Prioritize questions with Wrong attempts.
                    
                    case
                         -- If I have CORRECTED it, maybe allow review but lower priority?
                         -- User said "mostrar solo los que tengan 0 intentos correctos" for PRACTICE mode.
                         -- For RETRY mode, they see "preguntas aleatorias (priorizando aquellas con mas intentos fallidos)".
                         -- It avoids saying "exclude correct".
                         -- But usually, if I fixed it, I don't need to retry effectively immediately.
                         -- Let's assume Retry Mode = Re-do wrong stuff.
                         
                         when exists (
                            select 1 from attempts a 
                            where a.question_id = q.id 
                            and a.user_id = p_user_id 
                            and a.is_correct = false
                        ) then 
                             -- Multiplier based on fail count
                             (select count(*) * 10 
                              from attempts a 
                              where a.question_id = q.id 
                              and a.user_id = p_user_id 
                              and a.is_correct = false)
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
