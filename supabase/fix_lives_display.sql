-- Fix Admin RPC to read correct lives columns (m1 vs m2) and filter attempts roughly if possible

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
declare
    -- Variable to hold the result of the lives selection if needed, currently doing it in SQL
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied: User % is not an administrator', auth.uid();
    end if;

    return query
    select
        au.id::uuid,
        au.email::text,
        (au.raw_user_meta_data->>'full_name')::text,
        (au.raw_user_meta_data->>'avatar_url')::text,
        au.created_at::timestamptz,
        au.last_sign_in_at::timestamptz,
        count(a.id)::bigint,
        count(case when a.is_correct then 1 end)::bigint,
        max(a.created_at)::timestamptz,
        -- Dynamically select lives based on subject
        (case 
            when p_subject = 'm1' then coalesce(p.lives_m1, 10) 
            else coalesce(p.lives_m2, 10) 
         end)::integer as lives,
        coalesce(p.explanation_credits, 5)::integer,
        coalesce(p.subscription_tier::text, 'free')::text
    from auth.users au
    join public.profiles p on p.id = au.id
    left join public.attempts a on au.id = a.user_id 
    group by au.id, p.lives_m1, p.lives_m2, p.explanation_credits, p.subscription_tier;
end;
$$;

-- Grant permissions again just in case
grant execute on function public.get_admin_users_stats(text) to authenticated, service_role;
