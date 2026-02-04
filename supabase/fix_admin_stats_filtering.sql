-- FIX: Update get_admin_users_stats to filter attempts by subject
-- This ensures that "Total Attempts", "Correct Attempts", and "Accuracy" in the Admin List/Cards reflect ONLY the selected subject (M1 or M2).

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
        -- Lives selection (already correctly implemented)
        (case 
            when p_subject = 'm1' then coalesce(p.lives_m1, 10) 
            else coalesce(p.lives_m2, 10) 
         end)::integer as lives,
        coalesce(p.explanation_credits, 5)::integer,
        coalesce(p.subscription_tier::text, 'free')::text
    from auth.users au
    join public.profiles p on p.id = au.id
    -- JOIN Logic to filter ONLY attempts for the selected subject
    left join (
        select att.id, att.user_id, att.is_correct, att.created_at 
        from public.attempts att
        join public.questions q on att.question_id = q.id
        where q.subject = p_subject
    ) a on au.id = a.user_id 
    group by au.id, p.lives_m1, p.lives_m2, p.explanation_credits, p.subscription_tier;
end;
$$;

-- Grant permissions
grant execute on function public.get_admin_users_stats(text) to authenticated, service_role;
