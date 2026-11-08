-- Update reset_user_progress to include gamification stats
create or replace function public.reset_user_progress(p_user_id uuid)
returns void
language plpgsql
security definer
as $$
begin
    -- 1. Delete activity data
    delete from public.attempts where user_id = p_user_id;
    delete from public.question_feedback where user_id = p_user_id;
    
    -- 2. Reset Profile Stats (Lives, Score, Streak)
    update public.profiles
    set lives = 10,
        lives_replenish_at = null,
        score = 0,
        current_streak = 0,
        last_streak_update = null
    where id = p_user_id;
end;
$$;
