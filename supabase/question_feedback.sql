create table if not exists public.question_feedback (
    id uuid default gen_random_uuid() primary key,
    user_id uuid references auth.users(id) on delete cascade not null,
    question_id uuid references public.questions(id) on delete cascade not null,
    vote text check (vote in ('up', 'down')) not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    unique(user_id, question_id)
);

-- RLS Policies
alter table public.question_feedback enable row level security;

create policy "Users can insert their own feedback"
    on public.question_feedback for insert
    with check (auth.uid() = user_id);

create policy "Users can update their own feedback"
    on public.question_feedback for update
    using (auth.uid() = user_id);

create policy "Users can view their own feedback"
    on public.question_feedback for select
    using (auth.uid() = user_id);

-- Admin can view all (optional, but good for analytics later)
create policy "Admins can view all feedback"
    on public.question_feedback for select
    using (
        exists (
            select 1 from public.profiles
            where profiles.id = auth.uid()
            and profiles.role = 'admin'
        )
    );
