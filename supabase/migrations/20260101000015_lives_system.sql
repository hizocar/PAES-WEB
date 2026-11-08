-- Add lives columns to profiles
alter table public.profiles 
add column if not exists lives integer default 10,
add column if not exists lives_replenish_at timestamp with time zone;

-- Function to deduct a life
create or replace function public.deduct_life(p_user_id uuid)
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
begin
    -- Get current lives
    select lives into current_lives from public.profiles where id = p_user_id;

    -- If already 0, do nothing (should be handled by frontend/logic, but for safety)
    if current_lives <= 0 then
        select lives, lives_replenish_at into new_lives_count, new_replenish_at 
        from public.profiles where id = p_user_id;
        return query select new_lives_count, new_replenish_at;
        return;
    end if;

    -- Deduct life
    new_lives_count := current_lives - 1;
    
    -- If reached 0, set replenish time
    if new_lives_count = 0 then
        new_replenish_at := now() + interval '24 hours';
    else
        new_replenish_at := null;
    end if;

    -- Update profile
    update public.profiles
    set lives = new_lives_count,
        lives_replenish_at = new_replenish_at
    where id = p_user_id;

    return query select new_lives_count, new_replenish_at;
end;
$$;

-- Function to check and replenish lives if cooldown passed
create or replace function public.check_and_replenish_lives(p_user_id uuid)
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
    select lives, lives_replenish_at into v_lives, v_replenish_at
    from public.profiles where id = p_user_id;

    -- If lives < 10 AND (replenish time passed OR replenish time is null which shouldn't happen if lives < 10 but strictly speaking safeguard)
    -- Actually logic: If lives = 0 AND time passed, reset to 10. 
    -- User wanted: "if they burn all lives, they replenish in 24 hours". 
    -- So only replenish if the timer set at 0 lives has expired.
    
    if v_lives < 10 and v_replenish_at is not null and now() >= v_replenish_at then
        update public.profiles
        set lives = 10,
            lives_replenish_at = null
        where id = p_user_id;
        
        v_lives := 10;
        v_replenish_at := null;
    end if;

    return query select v_lives, v_replenish_at;
end;
$$;
