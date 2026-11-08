-- FIX: Add missing image_url column if it doesn't exist
-- This resolves the "Could not find the 'image_url' column" error.

ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS image_url text;

-- Ensure the question-images bucket exists
INSERT INTO storage.buckets (id, name, public)
VALUES ('question-images', 'question-images', true)
ON CONFLICT (id) DO NOTHING;

-- Ensure policies exist (idempotent-ish)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'objects' AND policyname = 'Question images are publicly accessible.'
    ) THEN
        create policy "Question images are publicly accessible."
          on storage.objects for select
          using ( bucket_id = 'question-images' );
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_policies 
        WHERE tablename = 'objects' AND policyname = 'Authenticated users can upload question images.'
    ) THEN
      create policy "Authenticated users can upload question images."
        on storage.objects for insert
        with check ( bucket_id = 'question-images' and auth.role() = 'authenticated' );
    END IF;
END $$;

-- Force schema cache reload (usually happens automatically on DDL, but explicitly):
NOTIFY pgrst, 'reload schema';
