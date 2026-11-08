-- 1. Create Private Bucket for Videos
insert into storage.buckets (id, name, public)
values ('explanation-videos', 'explanation-videos', false)
on conflict (id) do nothing;

-- 2. RLS Policies for the Bucket

-- Allow authenticated users (anyone logged in) to DOWNLOAD/SELECT files
-- In a stricter app, you might check subscription status here directly using a custom hook/function,
-- but checks are also done in the UI/App layer before even trying to fetch the URL.
create policy "Authenticated users can view videos"
  on storage.objects for select
  using ( bucket_id = 'explanation-videos' and auth.role() = 'authenticated' );

-- Allow authenticated users (Admins effectively, via app logic constraints) to UPLOAD/INSERT
-- Ideally, you'd restrict this to specific roles, but for this MVP 'authenticated' is standard base.
create policy "Authenticated users can upload videos"
  on storage.objects for insert
  with check ( bucket_id = 'explanation-videos' and auth.role() = 'authenticated' );

-- Allow updates/deletes for authenticated users
create policy "Authenticated users can update videos"
  on storage.objects for update
  using ( bucket_id = 'explanation-videos' and auth.role() = 'authenticated' );

create policy "Authenticated users can delete videos"
  on storage.objects for delete
  using ( bucket_id = 'explanation-videos' and auth.role() = 'authenticated' );


-- 3. Modify Questions Table
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS explanation_video_path text;

COMMENT ON COLUMN public.questions.explanation_video_path IS 'Storage path of the secure video explanation';

-- Optional: Drop the old column if you want to clean up immediately, 
-- or keep it for transition. We will just ignore it in the app.
-- ALTER TABLE public.questions DROP COLUMN IF EXISTS explanation_video_url;
