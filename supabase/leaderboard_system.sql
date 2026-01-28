-- Add score column to profiles
alter table public.profiles 
add column if not exists score bigint default 0;

-- Function to calculate score on new attempt
create or replace function public.handle_new_attempt_score()
returns trigger
language plpgsql
security definer
as $$
declare
    v_difficulty text;
    v_points integer := 0;
    v_daily_count integer;
    v_user_score bigint;
begin
    -- 1. Calculate points for the Question (if correct)
    if NEW.is_correct then
        -- Get difficulty of the question
        select difficulty into v_difficulty
        from public.questions
        where id = NEW.question_id;

        -- Assign points
        if v_difficulty = 'easy' then
            v_points := 10;
        elsif v_difficulty = 'medium' then
            v_points := 20;
        elsif v_difficulty = 'hard' then
            v_points := 30;
        else 
            v_points := 10; -- Default fallback
        end if;
    end if;

    -- 2. Check Daily Goal Bonus (100 pts)
    -- Count attempts for this user today (inclusive of this one, as valid insert)
    select count(*) into v_daily_count
    from public.attempts
    where user_id = NEW.user_id
    and created_at >= current_date
    and created_at < current_date + interval '1 day';

    -- If this is exactly the 10th attempt, award bonus
    -- Note: This trigger runs AFTER insert, so if count is 10 now, this was the 10th.
    if v_daily_count = 10 then
        v_points := v_points + 100;
    end if;

    -- 3. Update Profile Score
    if v_points > 0 then
        update public.profiles
        set score = coalesce(score, 0) + v_points
        where id = NEW.user_id;
    end if;

    return NEW;
end;
$$;

-- Create Trigger
drop trigger if exists on_attempt_created_score on public.attempts;
create trigger on_attempt_created_score
after insert on public.attempts
for each row
execute function public.handle_new_attempt_score();

-- RPC to get leaderboard
create or replace function public.get_leaderboard()
returns table (
    user_id uuid,
    full_name text,
    avatar_url text,
    score bigint,
    rank bigint
)
language sql
security definer
as $$
    select 
        p.id as user_id,
        coalesce(p.full_name, 'Usuario') as full_name,
        p.avatar_url,
        coalesce(p.score, 0) as score,
        row_number() over (order by coalesce(p.score, 0) desc) as rank
    from public.profiles p
    order by score desc
    limit 50;
$$;
