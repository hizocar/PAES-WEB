-- Function to check and unlock achievements
-- This function monitors various triggers and unlocks achievements if conditions are met.

create or replace function public.check_and_unlock_achievement(
    p_user_id uuid, 
    p_trigger_type text -- 'ANSWER', 'STREAK', 'LOGIN'
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
        
        -- Get various stats efficiently
        select count(*) into v_total_correct
        from attempts
        where user_id = p_user_id and is_correct = true;

        -- CHECK: FIRST_WIN (1 Correct)
        if v_total_correct >= 1 then
            select id into v_achievement_id from achievements where code = 'FIRST_WIN';
            
            -- If exists and not unlocked yet
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id
            ) then
                insert into user_achievements (user_id, achievement_id) values (p_user_id, v_achievement_id);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: CENTURION (100 Correct)
        if v_total_correct >= 100 then
            select id into v_achievement_id from achievements where code = 'CENTURION';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id
            ) then
                insert into user_achievements (user_id, achievement_id) values (p_user_id, v_achievement_id);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: SNIPER_5 (5 Correct in a row)
        -- Look at last 5 attempts
        select count(*) into v_recent_correct
        from (
            select is_correct from attempts 
            where user_id = p_user_id 
            order by created_at desc 
            limit 5
        ) last_five
        where last_five.is_correct = true;

        if v_recent_correct = 5 then
            select id into v_achievement_id from achievements where code = 'SNIPER_5';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id
            ) then
                insert into user_achievements (user_id, achievement_id) values (p_user_id, v_achievement_id);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

    end if;

    -- 2. TRIGGER: STREAK (Checked on dashboard load/login)
    if p_trigger_type = 'STREAK' then
        -- Get current streak from profiles (assuming it's updated elsewhere)
        select current_streak into v_streak from profiles where id = p_user_id;

        -- CHECK: STREAK_3
        if v_streak >= 3 then
            select id into v_achievement_id from achievements where code = 'STREAK_3';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id
            ) then
                insert into user_achievements (user_id, achievement_id) values (p_user_id, v_achievement_id);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CHECK: STREAK_7
        if v_streak >= 7 then
            select id into v_achievement_id from achievements where code = 'STREAK_7';
            if v_achievement_id is not null and not exists (
                select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id
            ) then
                insert into user_achievements (user_id, achievement_id) values (p_user_id, v_achievement_id);
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
