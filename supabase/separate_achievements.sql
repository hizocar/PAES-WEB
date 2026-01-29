-- Migration: Separate Achievements per Subject

-- 1. Add subject column to user_achievements
alter table public.user_achievements
add column if not exists subject text not null default 'm2'
check (subject in ('m1', 'm2'));

-- 2. Drop unique constraint if exists (user_id, achievement_id) and add new one (user_id, achievement_id, subject)
-- We need to check constraint name. Usually it's user_achievements_user_id_achievement_id_key or similar.
-- Let's try to drop it safely.
do $$
begin
    if exists (select 1 from pg_constraint where conname = 'user_achievements_pkey') then
        alter table user_achievements drop constraint user_achievements_pkey;
    end if;
     if exists (select 1 from pg_constraint where conname = 'user_achievements_user_id_achievement_id_key') then
        alter table user_achievements drop constraint user_achievements_user_id_achievement_id_key;
    end if;
end $$;

-- 3. Add new unique constraint so user can earn same achievement in different subjects
alter table public.user_achievements
add constraint user_achievements_user_id_achievement_id_subject_key unique (user_id, achievement_id, subject);

-- 4. Update check_and_unlock_achievement to support subject
create or replace function public.check_and_unlock_achievement(
    p_user_id uuid, 
    p_trigger_type text, -- 'ANSWER', 'STREAK', 'LOGIN'
    p_subject text default 'm2' -- New parameter
)
returns table (
    new_achievement_id uuid,
    new_achievement_name text,
    new_achievement_description text,
    new_achievement_icon text
)
language plpgsql
security definer
as $$
declare
    v_achievement_id uuid;
    v_streak int;
    v_total_correct int;
    v_recent_correct int;
begin
    -- Temp table to store unlocked IDs to return
    create temp table if not exists temp_unlocked_achievements (
        ach_id uuid
    ) on commit drop;

    -- 1. TRIGGER: ANSWER (Checked after a correct answer)
    if p_trigger_type = 'ANSWER' then
        
        -- Get various stats efficiently FILTERED BY SUBJECT
        select count(*) into v_total_correct
        from attempts
        join questions q on attempts.question_id = q.id
        where attempts.user_id = p_user_id 
        and attempts.is_correct = true
        and q.subject = p_subject;

        -- CHECK: FIRST_WIN (1 Correct)
        if v_total_correct >= 1 then
            select id into v_achievement_id from achievements where code = 'FIRST_WIN';
            
            -- If exists and not unlocked yet FOR THIS SUBJECT
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements 
                where user_id = p_user_id 
                and achievement_id = v_achievement_id
                and subject = p_subject
            ) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: CENTURION (100 Correct)
        if v_total_correct >= 100 then
            select id into v_achievement_id from achievements where code = 'CENTURION';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements 
                where user_id = p_user_id 
                and achievement_id = v_achievement_id
                and subject = p_subject
            ) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: SNIPER_5 (5 Correct in a row)
        -- Look at last 5 attempts FOR THIS SUBJECT
        select count(*) into v_recent_correct
        from (
            select a.is_correct 
            from attempts a
            join questions q on a.question_id = q.id
            where a.user_id = p_user_id 
            and q.subject = p_subject
            order by a.created_at desc 
            limit 5
        ) last_five
        where last_five.is_correct = true;

        if v_recent_correct = 5 then
            select id into v_achievement_id from achievements where code = 'SNIPER_5';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements 
                where user_id = p_user_id 
                and achievement_id = v_achievement_id
                and subject = p_subject
            ) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

    end if;

    -- 2. TRIGGER: STREAK (Checked on dashboard load/login)
    if p_trigger_type = 'STREAK' then
        -- Get current streak from profiles (Calculated via dashboard logic usually, but here checking helper or stored value)
        -- Wait, 'streak' in profiles is DEPRECATED or needs to be specific.
        -- We don't have streak_m1/m2 columns in profiles populated by trigger, we calculate them on fly.
        -- BUT we probably should store them if we want fast achievement checks.
        -- OR re-calculate here.
        
        -- Let's re-calculate streak quickly here similar to dashboard_rpc logic
        -- Or rely on dashboard having called this? No, dashboard calls this.
        
        declare
            curr_streak int := 0;
            v_check_date date := current_date;
            v_count int;
        begin
             -- Quick Streak Calc
             while true loop
                select count(*) into v_count
                from attempts a
                join questions q on a.question_id = q.id
                where a.user_id = p_user_id
                and q.subject = p_subject
                and date(a.created_at) = v_check_date;

                if v_count >= 10 then -- Goal trigger
                    curr_streak := curr_streak + 1;
                    v_check_date := v_check_date - 1;
                else
                    if v_check_date = current_date then
                        v_check_date := v_check_date - 1; -- Check yesterday if today not done
                        continue;
                    else
                        exit;
                    end if;
                end if;
             end loop;
             v_streak := curr_streak;
        end;

        -- CHECK: STREAK_3
        if v_streak >= 3 then
            select id into v_achievement_id from achievements where code = 'STREAK_3';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements 
                where user_id = p_user_id 
                and achievement_id = v_achievement_id
                and subject = p_subject
            ) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: STREAK_7
        if v_streak >= 7 then
            select id into v_achievement_id from achievements where code = 'STREAK_7';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements 
                where user_id = p_user_id 
                and achievement_id = v_achievement_id
                and subject = p_subject
            ) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;
    end if;

    -- Return details of newly unlocked achievements
    return query
    select 
        a.id, 
        a.name, 
        a.description, 
        a.icon_name
    from temp_unlocked_achievements t
    join achievements a on t.ach_id = a.id;
end;
$$;
