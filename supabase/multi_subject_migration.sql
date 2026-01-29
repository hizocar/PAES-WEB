-- Migration: Add Subject support (M1/M2)

-- 1. Add subject column to 'questions'
alter table questions 
add column if not exists subject text not null default 'm2' 
check (subject in ('m1', 'm2'));

-- 2. Add subject column to 'ejes' (Axes)
-- Ejes are distinct between M1 and M2 (e.g., M2 has more advanced topics)
alter table ejes 
add column if not exists subject text not null default 'm2' 
check (subject in ('m1', 'm2'));

-- 3. Update existing records to be explicitly 'm2' (Redundant due to default, but good for clarity)
update questions set subject = 'm2' where subject is null;
update ejes set subject = 'm2' where subject is null;

-- 4. Create Index for performance
create index if not exists idx_questions_subject on questions(subject);
create index if not exists idx_ejes_subject on ejes(subject);

-- Note: We don't need to touch 'topics' because they belong to 'ejes', so they inherit the subject implicitly.
