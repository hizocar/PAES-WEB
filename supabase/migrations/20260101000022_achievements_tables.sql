-- Achievements System Tables

-- 1. Achievements Definition Table
create table if not exists public.achievements (
    id uuid default gen_random_uuid() primary key,
    code text not null unique, -- e.g. 'FIRST_WIN', 'STREAK_3'
    name text not null,
    description text not null,
    icon_name text not null, -- Lucide icon name or custom
    xp_reward int default 0,
    created_at timestamp with time zone default now()
);

-- 2. User Achievements (Unlocked)
create table if not exists public.user_achievements (
    id uuid default gen_random_uuid() primary key,
    user_id uuid references auth.users(id) on delete cascade not null,
    achievement_id uuid references public.achievements(id) on delete cascade not null,
    unlocked_at timestamp with time zone default now(),
    unique(user_id, achievement_id) -- Prevent duplicate unlocks
);

-- 3. RLS Policies
alter table public.achievements enable row level security;
create policy "Achievements are viewable by everyone" 
    on public.achievements for select using (true);

alter table public.user_achievements enable row level security;
create policy "Users can view their own achievements" 
    on public.user_achievements for select using (auth.uid() = user_id);

-- 4. Seed Initial Achievements
insert into public.achievements (code, name, description, icon_name, xp_reward)
values
    ('FIRST_WIN', 'Primeros Pasos', 'Responde tu primera pregunta correctamente.', 'Footprints', 50),
    ('STREAK_3', 'En Llamas', 'Alcanza una racha de 3 días seguidos.', 'Flame', 100),
    ('STREAK_7', 'Imparable', 'Alcanza una racha de 7 días seguidos.', 'Zap', 300),
    ('SNIPER_5', 'Francotirador', 'Responde 5 preguntas correctas seguidas.', 'Crosshair', 200),
    ('CENTURION', 'Matemático', 'Responde 100 preguntas correctamente en total.', 'GraduationCap', 500)
on conflict (code) do nothing;
