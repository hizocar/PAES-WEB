-- Migration: Rewarded Ads System
-- Allows users to get 1 extra life or 1 extra explanation per day by watching an ad.

-- 1. Add tracking column to profiles
alter table public.profiles
add column if not exists last_rewarded_ad_at timestamptz;

-- 2. Function to claim the reward
create or replace function public.claim_rewarded_ad(
    p_user_id uuid,
    p_reward_type text, -- 'life' or 'explanation'
    p_subject text default 'm2'
)
returns jsonb
language plpgsql
security definer
as $$
declare
    v_last_ad timestamptz;
    v_can_claim boolean;
begin
    -- Get last ad time
    select last_rewarded_ad_at into v_last_ad
    from public.profiles
    where id = p_user_id;

    -- check if can claim (once per calendar day in Chile time or 24h)
    -- Using the simplest approach: 24h cooldown
    v_can_claim := v_last_ad is null or (now() - v_last_ad) > interval '24 hours';

    if not v_can_claim then
        return jsonb_build_object(
            'success', false,
            'message', 'Ya has reclamado tu recompensa diaria. Vuelve más tarde.'
        );
    end if;

    -- Grant reward
    if p_reward_type = 'life' then
        if p_subject = 'm1' then
            update public.profiles 
            set lives_m1 = lives_m1 + 1,
                last_rewarded_ad_at = now()
            where id = p_user_id;
        else
            update public.profiles 
            set lives_m2 = lives_m2 + 1,
                last_rewarded_ad_at = now()
            where id = p_user_id;
        end if;
    elsif p_reward_type = 'explanation' then
        update public.profiles 
        set explanation_credits = explanation_credits + 1,
            last_rewarded_ad_at = now()
        where id = p_user_id;
    else
        return jsonb_build_object(
            'success', false,
            'message', 'Tipo de recompensa no válido.'
        );
    end if;

    return jsonb_build_object(
        'success', true,
        'message', 'Recompensa otorgada con éxito.'
    );
end;
$$;
