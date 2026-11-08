-- Add video url column to questions table
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS explanation_video_url text;

COMMENT ON COLUMN public.questions.explanation_video_url IS 'URL of the video explanation (e.g. YouTube)';
