-- Helper function to check if current user is admin
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid()
    and role = 'admin'
  );
$$;

-- 1. Secure get_admin_users_stats
drop function if exists public.get_admin_users_stats(text);
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
as $$
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied: User is not an administrator';
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

-- 2. Secure reset_user_progress
drop function if exists public.reset_user_progress(uuid);
create or replace function public.reset_user_progress(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied: User is not an administrator';
    end if;

    delete from public.attempts where user_id = p_user_id;
    delete from public.question_feedback where user_id = p_user_id;
    delete from public.study_sessions where user_id = p_user_id;
end;
$$;

-- 3. Secure admin_delete_user_data
drop function if exists public.admin_delete_user_data(uuid);
create or replace function public.admin_delete_user_data(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied: User is not an administrator';
    end if;

    delete from public.attempts where user_id = p_user_id;
    delete from public.subscriptions where user_id = p_user_id;
    delete from public.profiles where id = p_user_id;
end;
$$;

-- 4. Secure admin_grant_explanation_credits
drop function if exists public.admin_grant_explanation_credits(uuid);
create or replace function public.admin_grant_explanation_credits(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    if not public.is_admin() then
        raise exception 'Access denied';
    end if;

    update public.profiles
    set explanation_credits = explanation_credits + 5
    where id = p_user_id;
end;
$$;

-- 5. Secure admin_refill_lives
drop function if exists public.admin_refill_lives(uuid, text);
create or replace function public.admin_refill_lives(p_user_id uuid, p_subject text)
returns void
language plpgsql
security definer
as $$
begin
    if not public.is_admin() then
        raise exception 'Access denied';
    end if;
    
    update public.profiles
    set lives = 10
    where id = p_user_id;
end;
$$;
