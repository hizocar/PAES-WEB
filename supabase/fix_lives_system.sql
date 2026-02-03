-- FIX: Continuous Lives Regeneration System (1 life per hour, max 10)

-- 1. Update check_and_replenish_lives
-- Calculates how many lives to restore based on time passed since replenish_at.
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
    v_lives_to_add integer;
    v_new_replenish_at timestamp with time zone;
begin
    -- Select data based on subject
    if p_subject = 'm1' then
        select lives_m1, replenish_at_m1 into v_lives, v_replenish_at from profiles where id = p_user_id;
    else
        select lives_m2, replenish_at_m2 into v_lives, v_replenish_at from profiles where id = p_user_id;
    end if;

    -- Default to max lives if null (shouldn't happen for active users)
    if v_lives is null then v_lives := 10; end if;

    -- If we are at max lives, ensure replenish_at is null and return
    if v_lives >= 10 then
        if v_replenish_at is not null then
            if p_subject = 'm1' then
                update profiles set replenish_at_m1 = null where id = p_user_id;
            else
                update profiles set replenish_at_m2 = null where id = p_user_id;
            end if;
        end if;
        return query select 10, null::timestamp with time zone;
        return;
    end if;

    -- Standard Check: If replenish_at is set and passed
    if v_replenish_at is not null and now() >= v_replenish_at then
        -- Calculate how many 1-hour intervals have passed since the target time
        -- (now - v_replenish_at) gives the "overdue" time.
        -- We add 1 because reaching the time itself counts as the first life.
        v_lives_to_add := 1 + floor(extract(epoch from (now() - v_replenish_at)) / 3600)::integer;
        
        -- Don't exceed max of 10
        if (v_lives + v_lives_to_add) >= 10 then
            v_lives := 10;
            v_new_replenish_at := null;
        else
            v_lives := v_lives + v_lives_to_add;
            -- Advance the replenish time by the number of lives added * 1 hour
            -- This keeps the "next life" timer relative to the original schedule, preserving partial progress
            v_new_replenish_at := v_replenish_at + (v_lives_to_add || ' hour')::interval;
        end if;

        -- Update the database
        if p_subject = 'm1' then
            update profiles set lives_m1 = v_lives, replenish_at_m1 = v_new_replenish_at where id = p_user_id;
        else
            update profiles set lives_m2 = v_lives, replenish_at_m2 = v_new_replenish_at where id = p_user_id;
        end if;

        v_replenish_at := v_new_replenish_at;
    end if;

    -- Return current state
    return query select v_lives, v_replenish_at;
end;
$$;


-- 2. Update deduct_life
-- Deducts a life. If we drop below 10, start the timer (if not already started).
create or replace function public.deduct_life(p_user_id uuid, p_subject text default 'm2')
returns table (
    new_lives integer,
    replenish_at timestamp with time zone
)
language plpgsql
security definer
as $$
declare
    v_lives integer;
    v_replenish_at timestamp with time zone;
    v_new_lives integer;
    v_new_replenish_at timestamp with time zone;
begin
    -- Get current state
    -- We assume check_and_replenish_lives is called on app load, but just in case, we could call it here.
    -- To be safe and atomic, let's just read and apply logic purely.
    
    if p_subject = 'm1' then
        select lives_m1, replenish_at_m1 into v_lives, v_replenish_at from profiles where id = p_user_id;
    else
        select lives_m2, replenish_at_m2 into v_lives, v_replenish_at from profiles where id = p_user_id;
    end if;

    if v_lives is null then v_lives := 10; end if;

    -- If 0 lives, can't deduct (frontend should prevent this, but safety first)
    if v_lives <= 0 then
        return query select 0, v_replenish_at;
        return;
    end if;

    v_new_lives := v_lives - 1;
    v_new_replenish_at := v_replenish_at;

    -- If we didn't have a timer running (meaning we were at max lives or just reached it), start it now.
    -- Since we just dropped a life, we need to recover it in 1 hour.
    if v_new_replenish_at is null then
        v_new_replenish_at := now() + interval '1 hour';
    end if;
    -- If timer was already running (e.g. we had 9 lives and dropped to 8), we DON'T touch it.
    -- The next life is still due at the same original time.

    -- Update
    if p_subject = 'm1' then
        update profiles set lives_m1 = v_new_lives, replenish_at_m1 = v_new_replenish_at where id = p_user_id;
    else
        update profiles set lives_m2 = v_new_lives, replenish_at_m2 = v_new_replenish_at where id = p_user_id;
    end if;

    return query select v_new_lives, v_new_replenish_at;
end;
$$;
