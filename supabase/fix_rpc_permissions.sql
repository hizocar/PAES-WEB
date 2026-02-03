-- Robust Fix for is_admin and Permissions

-- 1. Drop existing functions to ensure clean slate
drop function if exists public.is_admin();
drop function if exists public.get_admin_users_stats(text);
drop function if exists public.get_admin_users_stats(); -- Drop no-arg version just in case

-- 2. Create is_admin with simplified Logic
-- Removing "set search_path" to inherit environment path (usually includes public and extensions)
-- Using text comparison for role to avoid enum casting issues
create or replace function public.is_admin()
returns boolean
language plpgsql
security definer
as $$
declare
  _role text;
begin
  select role::text into _role
  from public.profiles
  where id = auth.uid();
  
  return _role = 'admin';
end;
$$;

-- 3. Re-create get_admin_users_stats with simplified security
create or replace function public.get_admin_users_stats(p_subject text default 'm1')
returns table (
    user_id uuid,
    email text,
    full_name text,
    avatar_url text,
    created_at timestamptz,
    last_sign_in_at timestamptz,
    total_attempts bigint,
    correct_attempts bigint,
    last_activity timestamptz,
    lives integer,
    explanation_credits integer,
    subscription_tier text
)
language plpgsql
security definer
-- We keep security definer to access auth.users, but remove specific search_path to minimize friction
as $$
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied: User % is not an administrator', auth.uid();
    end if;

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
        coalesce(p.explanation_credits, 5) as explanation_credits,
        coalesce(p.subscription_tier, 'free') as subscription_tier
    from auth.users au
    join public.profiles p on p.id = au.id
    left join public.attempts a on au.id = a.user_id 
    group by au.id, p.lives, p.explanation_credits, p.subscription_tier;
end;
$$;

-- 4. Explicit GRANTs
grant execute on function public.is_admin() to authenticated, service_role;
grant execute on function public.get_admin_users_stats(text) to authenticated, service_role;

-- 5. Re-grant for other hardened functions (safety net)
grant execute on function public.reset_user_progress(uuid) to authenticated, service_role;
grant execute on function public.admin_delete_user_data(uuid) to authenticated, service_role;
grant execute on function public.admin_grant_explanation_credits(uuid) to authenticated, service_role;
grant execute on function public.admin_refill_lives(uuid, text) to authenticated, service_role;
