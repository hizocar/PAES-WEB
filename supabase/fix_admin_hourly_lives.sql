-- FIX: Calculate lives based on "1 Life Per Hour" rule
-- We use 'last_activity' as the best proxy for when the user stopped playing.
-- Effective Lives = Stored Lives + Hours Since Last Activity.

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
    minutes_to_next_life integer, -- New field for countdown
    explanation_credits integer,
    subscription_tier text
)
language plpgsql
security definer
as $$
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied';
    end if;

    return query
    select
        s.user_id,
        s.email,
        s.full_name,
        s.avatar_url,
        s.created_at,
        s.last_sign_in_at,
        s.total_attempts,
        s.correct_attempts,
        s.last_activity,
        -- Calculated Lives (Capped at 10)
        least(10, s.stored_lives + s.hours_since_activity)::integer as lives,
        -- Minutes to next life
        case 
            when s.stored_lives + s.hours_since_activity >= 10 then null
            else (60 - (extract(minute from (now() - s.last_activity))::integer + (extract(second from (now() - s.last_activity))::integer / 60)) % 60)::integer
            -- Simplified: 60 - (minutes_part_of_interval)
            -- Actually: (60 - floor(extract(epoch from (now() - s.last_activity)) / 60) % 60)::integer
        end as minutes_to_next_life,
        s.explanation_credits,
        s.subscription_tier
    from (
        select
            au.id::uuid as user_id,
            au.email::text,
            (au.raw_user_meta_data->>'full_name')::text as full_name,
            (au.raw_user_meta_data->>'avatar_url')::text as avatar_url,
            au.created_at::timestamptz,
            au.last_sign_in_at::timestamptz,
            count(a.id)::bigint as total_attempts,
            count(case when a.is_correct then 1 end)::bigint as correct_attempts,
            max(a.created_at)::timestamptz as last_activity,
            
            -- Get stored lives
            (case 
                when p_subject = 'm1' then coalesce(p.lives_m1, 10) 
                else coalesce(p.lives_m2, 10) 
            end)::integer as stored_lives,
            
            -- Calculate hours elapsed since last activity (default to 0 if no activity)
            coalesce(floor(extract(epoch from (now() - max(a.created_at))) / 3600), 0)::integer as hours_since_activity,

            coalesce(p.explanation_credits, 5)::integer as explanation_credits,
            coalesce(p.subscription_tier::text, 'free')::text as subscription_tier
        from auth.users au
        join public.profiles p on p.id = au.id
        left join (
            select att.id, att.user_id, att.is_correct, att.created_at 
            from public.attempts att
            join public.questions q on att.question_id = q.id
            where q.subject = p_subject
        ) a on au.id = a.user_id 
        group by au.id, p.lives_m1, p.lives_m2, p.explanation_credits, p.subscription_tier
    ) s;
end;
$$;

grant execute on function public.get_admin_users_stats(text) to authenticated, service_role;
