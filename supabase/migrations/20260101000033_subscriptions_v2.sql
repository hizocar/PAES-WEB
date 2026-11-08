-- Create subscription tier enum
create type public.subscription_tier as enum ('free', 'premium', 'signature');

-- Add subscription_tier to profiles
alter table public.profiles 
add column if not exists subscription_tier public.subscription_tier default 'free'::public.subscription_tier;

-- Create plans table for pricing metadata
create table public.plans (
    id uuid default uuid_generate_v4() primary key,
    name text not null,
    tier public.subscription_tier not null unique,
    price_clp integer not null default 0,
    features text[] default '{}',
    is_active boolean default true,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Enable RLS on plans
alter table public.plans enable row level security;

-- Plans are viewable by everyone
create policy "Plans are viewable by everyone" on public.plans for select using (true);
-- Only admins can update plans
create policy "Admins can update plans" on public.plans for update using ((select role from public.profiles where id = auth.uid()) = 'admin');


-- Seed plans
insert into public.plans (name, tier, price_clp, features) values
('Free', 'free', 0, '{"10 Vidas diarias", "5 Explicaciones diarias", "Publicidad"}'),
('Premium', 'premium', 9990, '{"Vidas ilimitadas", "Explicaciones ilimitadas", "Sin publicidad"}'),
('Signature', 'signature', 29990, '{"Todo lo de Premium", "Clases personalizadas", "Ensayos semanales"}');


-- Update restart logic for unlimited tiers
-- Function to deduct a life (UPDATED)
create or replace function public.deduct_life(p_user_id uuid)
returns table (
    new_lives integer,
    replenish_at timestamp with time zone
)
language plpgsql
security definer
as $$
declare
    current_lives integer;
    new_lives_count integer;
    new_replenish_at timestamp with time zone;
    user_tier public.subscription_tier;
begin
    -- Get current lives and tier
    select lives, subscription_tier into current_lives, user_tier 
    from public.profiles where id = p_user_id;

    -- IF PREMIUM OR SIGNATURE, DO NOT DEDUCT
    if user_tier in ('premium', 'signature') then
        -- Return current lives (or 999 to indicate infinity, but let's keep it simple and just not deduct)
        -- Actually, usually UI wants to know. Let's return current lives.
        return query select current_lives, null::timestamp with time zone;
        return;
    end if;

    -- If already 0, do nothing
    if current_lives <= 0 then
        select lives, lives_replenish_at into new_lives_count, new_replenish_at 
        from public.profiles where id = p_user_id;
        return query select new_lives_count, new_replenish_at;
        return;
    end if;

    -- Deduct life
    new_lives_count := current_lives - 1;
    
    -- If reached 0, set replenish time
    if new_lives_count = 0 then
        new_replenish_at := now() + interval '24 hours';
    else
        new_replenish_at := null;
    end if;

    -- Update profile
    update public.profiles
    set lives = new_lives_count,
        lives_replenish_at = new_replenish_at
    where id = p_user_id;

    return query select new_lives_count, new_replenish_at;
end;
$$;


-- Function to deduct a credit (UPDATED)
create or replace function public.deduct_explanation(p_user_id uuid)
returns boolean
language plpgsql
security definer
as $$
declare
    v_credits integer;
    user_tier public.subscription_tier;
begin
    select explanation_credits, subscription_tier into v_credits, user_tier 
    from public.profiles where id = p_user_id;

    -- IF PREMIUM OR SIGNATURE, DO NOT DEDUCT
    if user_tier in ('premium', 'signature') then
        return true;
    end if;

    if v_credits > 0 then
        update public.profiles
        set explanation_credits = explanation_credits - 1,
            explanation_replenish_at = case 
                when explanation_credits - 1 = 0 then now() + interval '24 hours'
                else explanation_replenish_at 
            end
        where id = p_user_id;
        return true;
    else
        return false;
    end if;
end;
$$;
