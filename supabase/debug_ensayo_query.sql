-- 1. Check Axis IDs
SELECT id, name, slug FROM public.ejes;

-- 2. Check Subject Values (Exact)
SELECT DISTINCT subject, length(subject) as len, ascii(substr(subject, 1, 1)) as first_char_ascii FROM public.questions;

-- 3. Check Count for 'numeros' M1 specifically
WITH target_axis AS (
    SELECT id FROM public.ejes WHERE slug = 'numeros'
)
SELECT 
    count(q.id) as numeros_m1_count
FROM 
    public.questions q
WHERE 
    q.subject = 'm1' -- Try exact match first
    AND q.id IN (
        SELECT qt.question_id 
        FROM public.question_topics qt 
        JOIN public.topics t ON qt.topic_id = t.id 
        WHERE t.eje_id = (SELECT id FROM target_axis)
    );

-- 4. Check global M1 count regardless of axis
SELECT count(*) as total_m1_questions FROM public.questions WHERE subject = 'm1';
