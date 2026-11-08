-- FIX: admin_refill_lives to correctly update lives_m1 or lives_m2
-- Explicitly handle the subject parameter so the Admin Panel updates correctly.

create or replace function public.admin_refill_lives(
    p_user_id uuid,
    p_subject text default 'm2'
)
returns void
language plpgsql
security definer
as $$
begin
    -- Security check
    if not public.is_admin() then
        raise exception 'Access denied';
    end if;

    if p_subject = 'm1' then
        update public.profiles
        set lives_m1 = 10,
            replenish_at_m1 = null
        where id = p_user_id;
    else
        -- Logic for M2
        -- We update both lives_m2 (if specific) and the legacy/default columns just in case
        update public.profiles
        set lives_m2 = 10,
            lives_replenish_at = null
        where id = p_user_id;
    end if;
end;
$$;

grant execute on function public.admin_refill_lives(uuid, text) to authenticated, service_role;
