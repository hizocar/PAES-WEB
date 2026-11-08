-- FIX: Calculate effective lives and return replenishment time
-- This ensures that if the 4-hour cooldown has passed, the Admin Panel shows 10 lives even if the user hasn't logged in.

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
    replenish_at timestamptz, -- NEW COLUMN
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
        au.id::uuid,
        au.email::text,
        (au.raw_user_meta_data->>'full_name')::text,
        (au.raw_user_meta_data->>'avatar_url')::text,
        au.created_at::timestamptz,
        au.last_sign_in_at::timestamptz,
        count(a.id)::bigint,
        count(case when a.is_correct then 1 end)::bigint,
        max(a.created_at)::timestamptz,
        
        -- Calculated Lives
        (case 
            when p_subject = 'm1' then 
                case 
                    when coalesce(p.lives_m1, 10) < 10 and p.replenish_at_m1 is not null and now() >= p.replenish_at_m1 then 10
                    else coalesce(p.lives_m1, 10)
                end
            else 
                case 
                    when coalesce(p.lives_m2, 10) < 10 and p.replenish_at_m2 is not null and now() >= p.replenish_at_m2 then 10
                    else coalesce(p.lives_m2, 10)
                end
        end)::integer as lives,

        -- Replenish At (only if < 10 and in future)
        (case 
            when p_subject = 'm1' then 
                case 
                    when coalesce(p.lives_m1, 10) < 10 and p.replenish_at_m1 > now() then p.replenish_at_m1
                    else null
                end
            else 
                case 
                    when coalesce(p.lives_m2, 10) < 10 and p.replenish_at_m2 > now() then p.replenish_at_m2
                    else null
                end
        end)::timestamptz as replenish_at,

        coalesce(p.explanation_credits, 5)::integer,
        coalesce(p.subscription_tier::text, 'free')::text
    from auth.users au
    join public.profiles p on p.id = au.id
    left join (
        select att.id, att.user_id, att.is_correct, att.created_at 
        from public.attempts att
        join public.questions q on att.question_id = q.id
        where q.subject = p_subject
    ) a on au.id = a.user_id 
    group by au.id, p.lives_m1, p.lives_m2, p.replenish_at_m1, p.replenish_at_m2, p.explanation_credits, p.subscription_tier;
end;
$$;

grant execute on function public.get_admin_users_stats(text) to authenticated, service_role;
