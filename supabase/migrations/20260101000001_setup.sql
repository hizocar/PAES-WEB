-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Create types
create type user_role as enum ('student', 'admin');
create type difficulty_level as enum ('easy', 'medium', 'hard');
create type subscription_plan as enum ('weekly', 'monthly', 'semiannual');

-- PROFILES
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text,
  full_name text,
  avatar_url text,
  role user_role default 'student'::user_role,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- EJES (Axes)
create table public.ejes (
  id uuid default uuid_generate_v4() primary key,
  name text not null unique,
  slug text not null unique
);

-- TOPICS
create table public.topics (
  id uuid default uuid_generate_v4() primary key,
  eje_id uuid references public.ejes(id) on delete cascade not null,
  name text not null,
  slug text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- QUESTIONS
create table public.questions (
  id uuid default uuid_generate_v4() primary key,
  content text not null, -- Markdown/LaTeX
  alternatives jsonb not null, -- [{"id": "A", "content": "..."}]
  correct_answer text not null, -- "A"
  difficulty difficulty_level default 'medium'::difficulty_level,
  explanation text, -- Markdown/LaTeX explanation
  explanation_video_url text,
  is_active boolean default true,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- QUESTION_TOPICS (Many-to-Many)
create table public.question_topics (
  question_id uuid references public.questions(id) on delete cascade not null,
  topic_id uuid references public.topics(id) on delete cascade not null,
  primary key (question_id, topic_id)
);

-- ATTEMPTS
create table public.attempts (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  question_id uuid references public.questions(id) on delete cascade not null,
  selected_answer text not null,
  is_correct boolean not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- STUDY SESSIONS
create table public.study_sessions (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  started_at timestamp with time zone default timezone('utc'::text, now()) not null,
  ended_at timestamp with time zone,
  duration_seconds integer
);

-- SUBSCRIPTIONS
create table public.subscriptions (
  user_id uuid references public.profiles(id) on delete cascade not null primary key,
  stripe_customer_id text,
  stripe_subscription_id text,
  status text check (status in ('active', 'trialing', 'past_due', 'canceled', 'unpaid', 'incomplete', 'incomplete_expired', 'paused')),
  plan_id text,
  current_period_end timestamp with time zone,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- EXPLANATION VIEWS (Freemium tracking)
create table public.explanation_views (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  question_id uuid references public.questions(id) on delete cascade not null,
  viewed_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- RLS POLICIES
alter table public.profiles enable row level security;
alter table public.ejes enable row level security;
alter table public.topics enable row level security;
alter table public.questions enable row level security;
alter table public.question_topics enable row level security;
alter table public.attempts enable row level security;
alter table public.study_sessions enable row level security;
alter table public.subscriptions enable row level security;
alter table public.explanation_views enable row level security;

-- Profiles: Public read (for now, maybe restrict), Update own
create policy "Public profiles are viewable by everyone" on public.profiles for select using (true);
create policy "Users can update own profile" on public.profiles for update using (auth.uid() = id);

-- Ejes & Topics: Public read
create policy "Ejes are viewable by everyone" on public.ejes for select using (true);
create policy "Topics are viewable by everyone" on public.topics for select using (true);

-- Questions: Public read (or authenticated)
create policy "Questions are viewable by authenticated users" on public.questions for select to authenticated using (true);
create policy "Admins can insert questions" on public.questions for insert to authenticated with check ((select role from public.profiles where id = auth.uid()) = 'admin');
create policy "Admins can update questions" on public.questions for update to authenticated using ((select role from public.profiles where id = auth.uid()) = 'admin');

-- Attempts: Users read own, insert own
create policy "Users can read own attempts" on public.attempts for select using (auth.uid() = user_id);
create policy "Users can insert own attempts" on public.attempts for insert with check (auth.uid() = user_id);

-- Study Sessions: Users read/insert own
create policy "Users can read own sessions" on public.study_sessions for select using (auth.uid() = user_id);
create policy "Users can insert own sessions" on public.study_sessions for insert with check (auth.uid() = user_id);
create policy "Users can update own sessions" on public.study_sessions for update using (auth.uid() = user_id);

-- Subscriptions: Users read own
create policy "Users can read own subscription" on public.subscriptions for select using (auth.uid() = user_id);

-- Explanation Views: Users read/insert own
create policy "Users can read own explanation views" on public.explanation_views for select using (auth.uid() = user_id);
create policy "Users can insert own explanation views" on public.explanation_views for insert with check (auth.uid() = user_id);

-- FUNCTIONS & TRIGGERS
-- Handle new user creation
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, full_name, avatar_url)
  values (new.id, new.email, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- SEED DATA
insert into public.ejes (name, slug) values
('Números', 'numeros'),
('Álgebra y Funciones', 'algebra-y-funciones'),
('Geometría', 'geometria'),
('Probabilidad y Estadística', 'probabilidad-y-estadistica');

-- Add some topics (example)
do $$
declare
  numeros_id uuid;
begin
  select id into numeros_id from public.ejes where slug = 'numeros';
  insert into public.topics (eje_id, name, slug) values
  (numeros_id, 'Conjuntos Numéricos', 'conjuntos-numericos'),
  (numeros_id, 'Porcentajes', 'porcentajes');
end $$;
