-- Add onboarding status to profiles
alter table public.profiles 
add column if not exists onboarding_completed boolean default false;

-- Function to mark onboarding as completed
create or replace function public.complete_onboarding(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    update public.profiles
    set onboarding_completed = true
    where id = p_user_id;
end;
$$;
