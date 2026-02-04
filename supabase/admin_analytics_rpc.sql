-- RPC to get Admin Analytics Data (Last 30 Days)
-- Returns two arrays: new_users_trend and daily_active_users_trend

create or replace function public.get_admin_analytics()
returns json
language plpgsql
security definer
as $$
declare
    v_start_date date := current_date - interval '29 days';
    v_new_users json;
    v_active_users json;
begin
    -- Security Check
    if not public.is_admin() then
        raise exception 'Access denied';
    end if;

    -- 1. New Users per Day
    -- We generate a series of dates to ensure we have entries for days with 0 users
    select json_agg(t) into v_new_users
    from (
        select 
            to_char(d.date, 'DD/MM') as date,
            count(u.id) as count
        from generate_series(v_start_date, current_date, '1 day'::interval) d(date)
        left join auth.users u on date_trunc('day', u.created_at) = d.date
        group by d.date
        order by d.date
    ) t;

    -- 2. Daily Active Users (Unique users who created an attempt)
    select json_agg(t) into v_active_users
    from (
        select 
            to_char(d.date, 'DD/MM') as date,
            count(distinct a.user_id) as count
        from generate_series(v_start_date, current_date, '1 day'::interval) d(date)
        left join public.attempts a on date_trunc('day', a.created_at) = d.date
        group by d.date
        order by d.date
    ) t;

    return json_build_object(
        'new_users', coalesce(v_new_users, '[]'::json),
        'active_users', coalesce(v_active_users, '[]'::json)
    );
end;
$$;

grant execute on function public.get_admin_analytics() to authenticated, service_role;
