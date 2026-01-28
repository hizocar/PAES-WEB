-- Add explanation credits columns to profiles
alter table public.profiles 
add column if not exists explanation_credits integer default 5,
add column if not exists explanation_replenish_at timestamptz;

-- Function to check and replenish credits (similar to lives)
create or replace function public.check_explanation_replenishment(p_user_id uuid)
returns jsonb
language plpgsql
security definer
as $$
declare
    v_credits integer;
    v_replenish_at timestamptz;
begin
    select explanation_credits, explanation_replenish_at 
    into v_credits, v_replenish_at
    from public.profiles 
    where id = p_user_id;

    -- If unlimited/null, treat as full (handle initial state)
    if v_credits is null then
        v_credits := 5;
        update public.profiles set explanation_credits = 5 where id = p_user_id;
    end if;

    -- Check if replenishment is needed
    if v_credits = 0 and v_replenish_at is not null and v_replenish_at < now() then
        update public.profiles
        set explanation_credits = 5,
            explanation_replenish_at = null
        where id = p_user_id;
        
        v_credits := 5;
        v_replenish_at := null;
    end if;

    return jsonb_build_object(
        'credits', v_credits,
        'replenish_at', v_replenish_at
    );
end;
$$;

-- Function to deduct a credit
create or replace function public.deduct_explanation(p_user_id uuid)
returns boolean
language plpgsql
security definer
as $$
declare
    v_credits integer;
begin
    select explanation_credits into v_credits from public.profiles where id = p_user_id;

    if v_credits > 0 then
        update public.profiles
        set explanation_credits = explanation_credits - 1,
            explanation_replenish_at = case 
                when explanation_credits - 1 = 0 then now() + interval '24 hours'
                else explanation_replenish_at 
            end
        where id = p_user_id;
        return true;
    else
        return false;
    end if;
end;
$$;
