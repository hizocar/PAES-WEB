-- Migration: Separate Lives and Streak per Subject

-- 1. Add new columns to profiles
alter table public.profiles
add column if not exists lives_m1 integer default 10,
add column if not exists replenish_at_m1 timestamp with time zone,
add column if not exists lives_m2 integer default 10,
add column if not exists replenish_at_m2 timestamp with time zone;

-- 2. Migrate existing data (Assume current 'lives' are for M2)
update public.profiles
set 
    lives_m2 = coalesce(lives, 10),
    replenish_at_m2 = lives_replenish_at;

-- 3. Update deduct_life to support subject
create or replace function public.deduct_life(p_user_id uuid, p_subject text default 'm2')
returns table (
    new_lives integer,
    replenish_at timestamp with time zone
)
language plpgsql
security definer
as $$
declare
    current_lives integer;
    new_lives_count integer;
    new_replenish_at timestamp with time zone;
    col_lives text;
    col_replenish text;
begin
    -- Select columns based on subject
    if p_subject = 'm1' then
        select lives_m1, replenish_at_m1 into current_lives, new_replenish_at from profiles where id = p_user_id;
    else
        select lives_m2, replenish_at_m2 into current_lives, new_replenish_at from profiles where id = p_user_id;
    end if;

    if current_lives is null then current_lives := 10; end if;

    -- If already 0, return current
    if current_lives <= 0 then
        return query select current_lives, new_replenish_at;
        return;
    end if;

    -- Deduct
    new_lives_count := current_lives - 1;
    
    if new_lives_count = 0 then
        new_replenish_at := now() + interval '4 hours';
    else
        new_replenish_at := null;
    end if;

    -- Update
    if p_subject = 'm1' then
        update profiles set lives_m1 = new_lives_count, replenish_at_m1 = new_replenish_at where id = p_user_id;
    else
        update profiles set lives_m2 = new_lives_count, replenish_at_m2 = new_replenish_at where id = p_user_id;
    end if;

    return query select new_lives_count, new_replenish_at;
end;
$$;

-- 4. Update check_and_replenish_lives to support subject
create or replace function public.check_and_replenish_lives(p_user_id uuid, p_subject text default 'm2')
returns table (
    current_lives integer,
    replenish_at timestamp with time zone
)
language plpgsql
security definer
as $$
declare
    v_lives integer;
    v_replenish_at timestamp with time zone;
begin
    if p_subject = 'm1' then
        select lives_m1, replenish_at_m1 into v_lives, v_replenish_at from profiles where id = p_user_id;
    else
        select lives_m2, replenish_at_m2 into v_lives, v_replenish_at from profiles where id = p_user_id;
    end if;

    if v_lives is null then v_lives := 10; end if;

    -- Replenish Logic
    if v_lives < 10 and v_replenish_at is not null and now() >= v_replenish_at then
        v_lives := 10;
        v_replenish_at := null;
        
        if p_subject = 'm1' then
            update profiles set lives_m1 = 10, replenish_at_m1 = null where id = p_user_id;
        else
            update profiles set lives_m2 = 10, replenish_at_m2 = null where id = p_user_id;
        end if;
    end if;

    return query select v_lives, v_replenish_at;
end;
$$;

-- 5. Update get_dashboard_stats to include STREAK calculation per subject
create or replace function get_dashboard_stats(
    p_user_id uuid,
    p_subject text default 'm2'
)
returns json
language plpgsql
security definer
as $$
declare
    v_daily_progress int;
    v_mistakes_count int;
    v_ejes_stats json;
    v_habilidades_stats json;
    v_start_of_day timestamp;
    v_streak int := 0;
    v_check_date date;
    v_count int;
    v_today date;
begin
    v_start_of_day := date_trunc('day', now());
    v_today := current_date;

    -- A. Daily Progress
    select count(a.id)
    into v_daily_progress
    from attempts a
    join questions q on a.question_id = q.id 
    where a.user_id = p_user_id
    and a.created_at >= v_start_of_day
    and lower(q.subject) = lower(p_subject);

    -- B. Mistakes Count
    select count(distinct a.question_id)
    into v_mistakes_count
    from attempts a
    join questions q on a.question_id = q.id
    where a.user_id = p_user_id
    and a.is_correct = false
    and lower(q.subject) = lower(p_subject)
    and not exists (
        select 1 from attempts a2
        where a2.user_id = p_user_id
        and a2.question_id = a.question_id
        and a2.is_correct = true
    );

    -- C. Ejes Stats
    select json_agg(ea)
    into v_ejes_stats
    from (
        select 
            e.id as id,
            e.name as name,
            count(a.is_correct) as total_attempts,
            case when count(a.is_correct) > 0 then 
                round((count(a.is_correct) filter (where a.is_correct)::numeric / count(a.is_correct)) * 100) 
            else 0 end as progress
        from ejes e
        left join topics t on t.eje_id = e.id
        left join question_topics qt on qt.topic_id = t.id
        left join questions q on qt.question_id = q.id and lower(q.subject) = lower(p_subject)
        left join attempts a on a.question_id = q.id and a.user_id = p_user_id
        where lower(e.subject) = lower(p_subject)
        group by e.id, e.name
    ) ea;

    -- D. Habilidades Stats
    select json_agg(ha)
    into v_habilidades_stats
    from (
        select 
            hl.name,
            count(uah.is_correct) as total_attempts,
            case when count(uah.is_correct) > 0 then 
                round((count(uah.is_correct) filter (where uah.is_correct)::numeric / count(uah.is_correct)) * 100) 
            else 0 end as progress
        from (
            select 'resolver_problemas' as name union all 
            select 'modelar' union all 
            select 'representar' union all 
            select 'argumentar'
        ) hl
        left join (
            select q.habilidad, a.is_correct
            from attempts a
            join questions q on a.question_id = q.id
            where a.user_id = p_user_id and lower(q.subject) = lower(p_subject)
        ) uah on lower(hl.name) = lower(uah.habilidad)
        group by hl.name
    ) ha;

    -- E. Streak Calculation
    select count(*) into v_count
    from attempts a
    join questions q on a.question_id = q.id
    where a.user_id = p_user_id and lower(q.subject) = lower(p_subject) and date(a.created_at) = v_today;

    if v_count >= 10 then
        v_streak := 1;
        v_check_date := v_today - 1;
    else
        v_check_date := v_today - 1;
    end if;

    while true loop
        select count(*) into v_count
        from attempts a
        join questions q on a.question_id = q.id
        where a.user_id = p_user_id and lower(q.subject) = lower(p_subject) and date(a.created_at) = v_check_date;

        if v_count >= 10 then
            v_streak := v_streak + 1;
            v_check_date := v_check_date - 1;
        else
            exit;
        end if;
    end loop;

    return json_build_object(
        'daily_progress', v_daily_progress,
        'active_mistakes', v_mistakes_count,
        'ejes_stats', coalesce(v_ejes_stats, '[]'::json),
        'habilidades_stats', coalesce(v_habilidades_stats, '[]'::json),
        'streak', v_streak
    );
end;
$$;
