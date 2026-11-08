-- Migration: New Fun & Master Achievements

-- 1. Insert New Achievements
insert into public.achievements (code, name, description, icon_name, xp_reward)
values
    -- Time/Habit based
    ('EARLY_BIRD', 'Mañanero', 'Completa un ejercicio entre las 5:00 y 9:00 AM.', 'Sun', 150),
    ('NIGHT_OWL', 'Noctámbulo', 'Completa un ejercicio entre las 23:00 y 3:00 AM.', 'Moon', 150),
    ('WEEKEND_WARRIOR', 'Finde a Full', 'Practica un sábado o domingo.', 'Calendar', 200),
    
    -- Mastery based (Generic names, apply to current subject context primarily)
    -- We will check the EJE of the question answered.
    ('MASTER_NUMBERS', 'Maestro de Números', '50 respuestas correctas en el eje Números.', 'Calculator', 500),
    ('MASTER_ALGEBRA', 'Genio del Álgebra', '50 respuestas correctas en el eje Álgebra y Funciones.', 'FunctionSquare', 500),
    ('MASTER_GEOMETRY', 'Arquitecto Visual', '50 respuestas correctas en el eje Geometría.', 'Shapes', 500),
    ('MASTER_PROBABILITY', 'Oráculo de Datos', '50 respuestas correctas en el eje Probabilidad y Estadística.', 'PieChart', 500)
on conflict (code) do nothing;

-- 2. Update check_and_unlock_achievement to handle these new types
create or replace function public.check_and_unlock_achievement(
    p_user_id uuid, 
    p_trigger_type text, -- 'ANSWER', 'STREAK'
    p_subject text default 'm2'
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
    v_hour int;
    v_dow int;
    v_eje_name text;
    v_eje_correct int;
begin
    -- Temp table to store unlocked IDs to return
    create temp table if not exists temp_unlocked_achievements (
        ach_id uuid
    ) on commit drop;

    v_hour := extract(hour from now());
    v_dow := extract(dow from now()); -- 0=Sun, 6=Sat

    -- 1. TRIGGER: ANSWER (Checked after a correct answer)
    -- We assume this is called AFTER an attempt insertion
    if p_trigger_type = 'ANSWER' then
        
        -- A. Time-based checks (Triggered by ANY answer, right or wrong? Usually simple participation is enough, but let's say "Complete" implies "at least trying")
        -- Let's stick to valid attempts (we don't check correctness for time habits, just doing it? Or maybe correct? Let's say Just Doing it is fine, but usually this trigger runs on 'correct' or just 'attempt'. 
        -- NOTE: The current caller in separate_achievements.sql V1 seemed to imply logic inside handles correctness. 
        -- Let's check the Attempt that just happened? 
        -- To be safe, let's assume this trigger checks general conditions.
        
        -- EARLY BIRD (5-9 AM)
        if v_hour between 5 and 9 then
            select id into v_achievement_id from achievements where code = 'EARLY_BIRD';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- NIGHT OWL (23-03)
        if v_hour >= 23 or v_hour <= 3 then
            select id into v_achievement_id from achievements where code = 'NIGHT_OWL';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- WEEKEND WARRIOR (Sat/Sun)
        if v_dow = 0 or v_dow = 6 then
            select id into v_achievement_id from achievements where code = 'WEEKEND_WARRIOR';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;


        -- B. Correctness dependent checks
        select count(*) into v_total_correct
        from attempts
        join questions q on attempts.question_id = q.id
        where attempts.user_id = p_user_id 
        and attempts.is_correct = true
        and q.subject = p_subject;

        -- FIRST_WIN
        if v_total_correct >= 1 then
            select id into v_achievement_id from achievements where code = 'FIRST_WIN';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- CENTURION
        if v_total_correct >= 100 then
            select id into v_achievement_id from achievements where code = 'CENTURION';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- C. Mastery Checks (By Eje)
        -- We need to check correct answers per Eje.
        -- Let's loop through potential mastery achievements to check.
        -- Optimisation: Only check if total_correct is enough? No, we need breakdown.
        
        for v_eje_name, v_achievement_id in 
            select 'Números', id from achievements where code = 'MASTER_NUMBERS'
            union select 'Álgebra y Funciones', id from achievements where code = 'MASTER_ALGEBRA'
            union select 'Geometría', id from achievements where code = 'MASTER_GEOMETRY'
            union select 'Probabilidad y Estadística', id from achievements where code = 'MASTER_PROBABILITY'
        loop
            -- Check if already unlocked
            if not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                -- Count correct for this eje
                select count(a.id) into v_eje_correct
                from attempts a
                join questions q on a.question_id = q.id
                join question_topics qt on q.id = qt.question_id
                join topics t on qt.topic_id = t.id
                join ejes e on t.eje_id = e.id
                where a.user_id = p_user_id 
                and a.is_correct = true
                and q.subject = p_subject
                and e.name = v_eje_name;

                if v_eje_correct >= 50 then
                    insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                    insert into temp_unlocked_achievements values (v_achievement_id);
                end if;
            end if;
        end loop;


        -- SNIPER_5 (Streak of 5 correct)
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
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

    end if;

    -- 2. TRIGGER: STREAK
    if p_trigger_type = 'STREAK' then
         declare
            curr_streak int := 0;
            v_check_date date := current_date;
            v_count_d int;
        begin
             -- Streak Calc
             while true loop
                select count(*) into v_count_d
                from attempts a
                join questions q on a.question_id = q.id
                where a.user_id = p_user_id
                and q.subject = p_subject
                and date(a.created_at) = v_check_date;

                if v_count_d >= 10 then 
                    curr_streak := curr_streak + 1;
                    v_check_date := v_check_date - 1;
                else
                    if v_check_date = current_date then
                        v_check_date := v_check_date - 1; 
                        continue;
                    else
                        exit;
                    end if;
                end if;
             end loop;
             v_streak := curr_streak;
        end;

        -- STREAK_3
        if v_streak >= 3 then
            select id into v_achievement_id from achievements where code = 'STREAK_3';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;

        -- STREAK_7
        if v_streak >= 7 then
            select id into v_achievement_id from achievements where code = 'STREAK_7';
            if v_achievement_id is not null and not exists (select 1 from user_achievements where user_id = p_user_id and achievement_id = v_achievement_id and subject = p_subject) then
                insert into user_achievements (user_id, achievement_id, subject) values (p_user_id, v_achievement_id, p_subject);
                insert into temp_unlocked_achievements values (v_achievement_id);
            end if;
        end if;
    end if;

    -- Return details
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
