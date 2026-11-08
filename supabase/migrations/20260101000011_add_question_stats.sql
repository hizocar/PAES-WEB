-- 1. Add columns to store statistics efficiently
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS total_attempts INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS correct_attempts INTEGER DEFAULT 0;

-- 2. Create a function to update these counters automatically
CREATE OR REPLACE FUNCTION public.update_question_stats()
RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'INSERT') THEN
    UPDATE public.questions
    SET 
      total_attempts = total_attempts + 1,
      correct_attempts = correct_attempts + (CASE WHEN NEW.is_correct THEN 1 ELSE 0 END)
    WHERE id = NEW.question_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Create the trigger on the attempts table
DROP TRIGGER IF EXISTS on_attempt_created ON public.attempts;
CREATE TRIGGER on_attempt_created
AFTER INSERT ON public.attempts
FOR EACH ROW
EXECUTE PROCEDURE public.update_question_stats();

-- 4. Backfill existing data (in case there are already attempts in the DB)
WITH stats AS (
  SELECT 
    question_id, 
    COUNT(*) as total, 
    COUNT(*) FILTER (WHERE is_correct) as correct
  FROM public.attempts
  GROUP BY question_id
)
UPDATE public.questions q
SET 
  total_attempts = s.total,
  correct_attempts = s.correct
FROM stats s
WHERE q.id = s.question_id;
