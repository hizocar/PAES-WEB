-- RPC to allow admins to manually update a user's subscription tier
create or replace function public.admin_update_user_tier(
    p_user_id uuid,
    p_tier text
)
returns void
language plpgsql
security definer
as $$
begin
    -- 1. Update the profile
    update public.profiles
    set subscription_tier = lower(p_tier)
    where id = p_user_id;

    -- 2. Ensure an active subscription record exists for this tier
    -- (This helps maintain consistency between the profiles table and the subscriptions table)
    insert into public.subscriptions (user_id, status, mp_preapproval_id)
    values (p_user_id, 'active', null)
    on conflict (user_id) 
    do update set 
        status = 'active',
        canceled_at = null;
end;
$$;
