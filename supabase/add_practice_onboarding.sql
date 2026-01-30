-- Add practice onboarding status to profiles
alter table public.profiles 
add column if not exists practice_onboarding_completed boolean default false;

-- Function to mark practice onboarding as completed
create or replace function public.complete_practice_onboarding(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    update public.profiles
    set practice_onboarding_completed = true
    where id = p_user_id;
end;
$$;
