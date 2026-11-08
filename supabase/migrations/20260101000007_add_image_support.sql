-- Add image_url to questions table
alter table public.questions add column if not exists image_url text;

-- Create storage bucket for question images
insert into storage.buckets (id, name, public)
values ('question-images', 'question-images', true)
on conflict (id) do nothing;

-- Policy: Public read access
create policy "Question images are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'question-images' );

-- Policy: Authenticated users (Admins) can upload
create policy "Authenticated users can upload question images."
  on storage.objects for insert
  with check ( bucket_id = 'question-images' and auth.role() = 'authenticated' );

-- Policy: Users can update their own uploads (or admins)
create policy "Users can update question images."
  on storage.objects for update
  using ( bucket_id = 'question-images' and auth.role() = 'authenticated' );
