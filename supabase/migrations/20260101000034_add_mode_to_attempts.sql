-- Add mode column to attempts to distinguish between practice and review
ALTER TABLE IF EXISTS public.attempts ADD COLUMN IF NOT EXISTS mode text DEFAULT 'practice';

-- Commentary: We default to 'practice' so existing data still counts for ranking.
-- Future review attempts will be explicitly marked as 'review'.
