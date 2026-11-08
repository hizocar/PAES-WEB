-- Add missing streak columns to profiles
alter table public.profiles 
add column if not exists current_streak integer default 0,
add column if not exists last_streak_update date;
