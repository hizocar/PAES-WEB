-- Check counts of questions per axis (slug) AND subject
SELECT 
    e.slug as axis_slug,
    q.subject,
    COUNT(q.id) as question_count
FROM 
    public.ejes e
LEFT JOIN 
    public.topics t ON e.id = t.eje_id
LEFT JOIN 
    public.question_topics qt ON t.id = qt.topic_id
LEFT JOIN 
    public.questions q ON qt.question_id = q.id
GROUP BY 
    e.slug, q.subject
ORDER BY 
    q.subject, axis_slug;

-- Check for questions with NULL subject
SELECT count(*) as null_subject_questions 
FROM public.questions 
WHERE subject IS NULL;
