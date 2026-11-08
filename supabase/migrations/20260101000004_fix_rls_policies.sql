-- FIX: Add missing RLS policies for question_topics
-- The table has RLS enabled but no policies were defined, causing default deny for all operations.

-- 1. Allow everyone (authenticated) to view question topics
CREATE POLICY "Question topics are viewable by authenticated users"
ON public.question_topics FOR SELECT
TO authenticated
USING (true);

-- 2. Allow Admins to insert question topics (linking questions to topics)
CREATE POLICY "Admins can insert question topics"
ON public.question_topics FOR INSERT
TO authenticated
WITH CHECK (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);

-- 3. Allow Admins to delete/update (if needed for editing)
CREATE POLICY "Admins can update question topics"
ON public.question_topics FOR UPDATE
TO authenticated
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);

CREATE POLICY "Admins can delete question topics"
ON public.question_topics FOR DELETE
TO authenticated
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);
