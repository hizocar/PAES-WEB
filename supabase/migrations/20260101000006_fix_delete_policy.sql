-- FIX: Add missing DELETE policy for questions
-- Currently, admins cannot delete questions due to missing RLS policy.

CREATE POLICY "Admins can delete questions"
ON public.questions FOR DELETE
TO authenticated
USING (
  (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin'
);
