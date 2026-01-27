-- Fix RLS: Allow reading the Many-to-Many table public.question_topics
create policy "Question topics are viewable by everyone" 
on public.question_topics 
for select 
using (true);
