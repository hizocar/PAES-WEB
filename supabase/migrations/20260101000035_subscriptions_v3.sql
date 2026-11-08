-- Add MP fields to subscriptions table for recurring billing tracking
ALTER TABLE public.subscriptions 
ADD COLUMN IF NOT EXISTS mp_preapproval_id text,
ADD COLUMN IF NOT EXISTS mp_customer_id text,
ADD COLUMN IF NOT EXISTS next_payment_at timestamp with time zone,
ADD COLUMN IF NOT EXISTS canceled_at timestamp with time zone;

-- Ensure the status column supports Mercado Pago statuses (they are similar to Stripe)
-- Statuses: authorized, paused, cancelled, pending
DO $$ 
BEGIN 
    ALTER TABLE public.subscriptions DROP CONSTRAINT IF EXISTS subscriptions_status_check;
    ALTER TABLE public.subscriptions ADD CONSTRAINT subscriptions_status_check 
    CHECK (status IN ('active', 'trialing', 'past_due', 'canceled', 'unpaid', 'incomplete', 'incomplete_expired', 'paused', 'authorized', 'cancelled', 'pending'));
EXCEPTION
    WHEN undefined_column THEN
        -- table might not exist in some environments or has different structure
        NULL;
END $$;
