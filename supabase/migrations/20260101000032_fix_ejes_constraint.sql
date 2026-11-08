-- Fix for "Duplicate Key" error when creating same Eje name in different subjects
-- Currently, 'ejes_name_key' prevents having "Números" in both M1 and M2.
-- We need to relax this to be unique per (name, subject) pair.

-- 1. Drop the overly strict global uniqueness constraint
ALTER TABLE public.ejes DROP CONSTRAINT IF EXISTS ejes_name_key;

-- 2. Add a composite uniqueness constraint
-- This allows "Números" (M1) and "Números" (M2) to coexist, 
-- but prevents two "Números" in M1.
ALTER TABLE public.ejes DROP CONSTRAINT IF EXISTS ejes_name_subject_key; -- SAFETY DROP
ALTER TABLE public.ejes ADD CONSTRAINT ejes_name_subject_key UNIQUE (name, subject);

-- 3. ALSO fix the Slug constraint (which is likely the new error)
-- Drop strict slug constraint
ALTER TABLE public.ejes DROP CONSTRAINT IF EXISTS ejes_slug_key;

-- Add composite slug constraint
ALTER TABLE public.ejes DROP CONSTRAINT IF EXISTS ejes_slug_subject_key; -- SAFETY DROP
ALTER TABLE public.ejes ADD CONSTRAINT ejes_slug_subject_key UNIQUE (slug, subject);
