-- Clean up expired subscriptions
-- This script downgrades users whose subscription has ended (next_payment_at in the past)
-- AND the subscription was explicitly canceled or not renewed.

create or replace function public.cleanup_expired_subscriptions()
returns void
language plpgsql
security definer
as $$
begin
    -- Downgrade users where the subscription is canceled and the expiry date has passed
    update public.profiles
    set subscription_tier = 'free'
    where id in (
        select user_id 
        from public.subscriptions 
        where status = 'canceled' 
        and next_payment_at < now()
    )
    and subscription_tier != 'free';

    -- Optional: also mark subscriptions as ended in the subscriptions table
    update public.subscriptions
    set status = 'ended'
    where status = 'canceled'
    and next_payment_at < now();
end;
$$;

-- To test it manually run:
-- select public.cleanup_expired_subscriptions();

-- TIP: You can schedule this in Supabase using pg_cron if enabled:
-- select cron.schedule('downgrade-expired-subs', '0 0 * * *', 'select public.cleanup_expired_subscriptions()');
