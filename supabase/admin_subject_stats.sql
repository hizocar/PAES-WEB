-- Admin Stats & Subscriptions Update

-- 1. Update Subscriptions Table to support Subject (M1/M2)
-- We need to change Primary Key from (user_id) to (user_id, subject) to allow multiple subs.
alter table public.subscriptions
add column if not exists subject text default 'm2' check (subject in ('m1', 'm2'));

-- Safely drop old PK
alter table public.subscriptions drop constraint if exists subscriptions_pkey;

-- Add new PK
alter table public.subscriptions add primary key (user_id, subject);

-- 2. RPC for Subject-Aware Admin Stats
create or replace function get_admin_dashboard_stats(
    p_subject text default 'm2'
)
returns json
language plpgsql
security definer
as $$
declare
    v_total_questions int;
    v_total_users int; -- "Registered" in this context? 
    -- User said: "un usuario podria estar M1 y M2". 
    -- Since we don't have explicit "enrollment", we'll count users who have AT LEAST 1 attempt in that subject
    -- OR users who have a subscription in that subject?
    -- Let's stick to "Users with Activity (Attempts)" as a proxy for "Users in M1".
    -- OR: Just return Total Users (Global) + Active Users (Subject). 
    -- User asked for separation. Let's return "Active Students" (>=1 attempt).
    v_active_users int;
    v_active_subs int;
begin
    -- 1. Questions Count
    select count(*) into v_total_questions
    from questions
    where subject = p_subject;

    -- 2. Active Users (Proxy for "Users in M1/M2")
    -- Count distinct users who have attempts in this subject
    select count(distinct user_id) into v_active_users
    from attempts a
    join questions q on a.question_id = q.id
    where q.subject = p_subject;

    -- 3. Active Subscriptions
    select count(*) into v_active_subs
    from subscriptions
    where subject = p_subject
    and status = 'active';

    return json_build_object(
        'total_questions', v_total_questions,
        'active_users', v_active_users,
        'active_subscriptions', v_active_subs
    );
end;
$$;
