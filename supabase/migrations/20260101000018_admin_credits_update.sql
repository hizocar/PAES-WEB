-- Drop function first because return type changed
drop function if exists public.get_admin_users_stats();

-- Update get_admin_users_stats to include explanation_credits
create or replace function public.get_admin_users_stats()
returns table (
    user_id uuid,
    email text,
    full_name text,
    avatar_url text,
    created_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    total_attempts bigint,
    correct_attempts bigint,
    last_activity timestamp with time zone,
    lives integer,
    explanation_credits integer
)
language plpgsql
security definer
as $$
begin
    return query
    select 
        au.id as user_id,
        au.email::text,
        (au.raw_user_meta_data->>'full_name')::text as full_name,
        (au.raw_user_meta_data->>'avatar_url')::text as avatar_url,
        au.created_at,
        au.last_sign_in_at,
        count(a.id) as total_attempts,
        count(case when a.is_correct then 1 end) as correct_attempts,
        max(a.created_at) as last_activity,
        coalesce(p.lives, 10) as lives,
        coalesce(p.explanation_credits, 5) as explanation_credits
    from auth.users au
    left join public.attempts a on au.id = a.user_id
    left join public.profiles p on au.id = p.id
    group by au.id, au.email, au.raw_user_meta_data, au.created_at, au.last_sign_in_at, p.lives, p.explanation_credits;
end;
$$;

-- Function to grant credits (Admin only)
create or replace function public.admin_grant_explanation_credits(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    -- Add 5 credits and clear cooldown logic if present, allowing user to view more
    update public.profiles
    set explanation_credits = coalesce(explanation_credits, 0) + 5,
        explanation_replenish_at = null -- Clear cooldown so they can use them immediately if they were blocked
    where id = p_user_id;
end;
$$;
