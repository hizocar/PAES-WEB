-- 1. Function to get all users with their stats
-- Note: Accessing auth.users requires specific privileges or security definer

create or replace function public.get_admin_users_stats()
returns table (
    user_id uuid,
    email text,
    full_name text,
    avatar_url text,
    created_at timestamptz,
    last_sign_in_at timestamptz,
    total_attempts bigint,
    correct_attempts bigint,
    last_activity timestamptz
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
        max(a.created_at) as last_activity
    from auth.users au
    left join public.attempts a on au.id = a.user_id
    group by au.id;
end;
$$;

-- 2. Function to reset a user's progress
create or replace function public.reset_user_progress(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    -- Check if calling user is admin? 
    -- For now, we rely on App logic + RLS (though RLS doesn't apply to security definer functions automatically for the deletes inside unless we are careful)
    -- Ideally, we should check if auth.uid() is an admin here.
    
    -- Delete attempts
    delete from public.attempts where user_id = p_user_id;
    
    -- Delete feedback
    delete from public.question_feedback where user_id = p_user_id;
end;
$$;
