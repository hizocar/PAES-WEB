-- Admin Users Stats & Actions with Subject Support

-- 1. Update get_admin_users_stats to accept p_subject
drop function if exists public.get_admin_users_stats();

create or replace function public.get_admin_users_stats(
    p_subject text default 'm2'
)
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
    explanation_credits integer,
    subscription_tier text
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
        -- Attempts specific to Subject
        count(a.id) as total_attempts,
        count(case when a.is_correct then 1 end) as correct_attempts,
        max(a.created_at) as last_activity,
        -- Lives specific to Subject (using dynamic selection tricky in SQL, standard CASE)
        case 
            when p_subject = 'm1' then coalesce(p.lives_m1, 10)
            else coalesce(p.lives_m2, 10)
        end as lives,
        -- Global Credits
        coalesce(p.explanation_credits, 5) as explanation_credits,
        coalesce(p.subscription_tier, 'free')::text as subscription_tier
    from auth.users au
    left join public.profiles p on au.id = p.id
    -- Join attempts filtered by subject
    left join (
        select a1.* 
        from public.attempts a1
        join public.questions q on a1.question_id = q.id
        where q.subject = p_subject
    ) a on au.id = a.user_id
    group by au.id, au.email, au.raw_user_meta_data, au.created_at, au.last_sign_in_at, p.lives_m1, p.lives_m2, p.explanation_credits, p.subscription_tier;
end;
$$;

-- 2. Update admin_refill_lives to accept p_subject
drop function if exists public.admin_refill_lives(uuid); -- Drop old signature if needed or overload

create or replace function public.admin_refill_lives(
    p_user_id uuid,
    p_subject text default 'm2'
)
returns void
language plpgsql
security definer
as $$
begin
    if p_subject = 'm1' then
        update public.profiles
        set lives_m1 = 10,
            replenish_at_m1 = null
        where id = p_user_id;
    else
        update public.profiles
        set lives_m2 = 10,
            replenish_at_m2 = null
        where id = p_user_id;
    end if;
end;
$$;
