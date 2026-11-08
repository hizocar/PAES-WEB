-- Add habilidad column to questions table
alter table public.questions 
add column if not exists habilidad text 
check (habilidad in ('resolver_problemas', 'modelar', 'representar', 'argumentar'));

-- Comment on the column for clarity
comment on column public.questions.habilidad is 'Classification by skill: resolver_problemas, modelar, representar, argumentar';
