-- FORCE: Create a V2 function to guarantee new logic is used and avoid return type conflicts.
-- Logic: 1 Life per Hour. Exact replenishment timestamp.

create or replace function public.get_admin_users_stats_v2(p_subject text default 'm1')
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
    replenish_at timestamptz, -- Exact timestamp for next life
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
        s.effective_lives as lives,
        
        -- Calculate EXACT timestamp for NEXT life
        case 
            when s.effective_lives >= 10 then null
            else s.last_activity + ((s.lives_to_add + 1) * interval '1 hour')
        end as replenish_at,

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
            
            -- Lives to add (full hours passed)
            -- If last_activity is null, result is 0
            coalesce(floor(extract(epoch from (now() - max(a.created_at))) / 3600), 0)::integer as lives_to_add,
            
            -- Effective lives logic
            least(10, (
                (case 
                    when p_subject = 'm1' then coalesce(p.lives_m1, 10) 
                    else coalesce(p.lives_m2, 10) 
                end) + 
                coalesce(floor(extract(epoch from (now() - max(a.created_at))) / 3600), 0)::integer
            ))::integer as effective_lives,

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

grant execute on function public.get_admin_users_stats_v2(text) to authenticated, service_role;
