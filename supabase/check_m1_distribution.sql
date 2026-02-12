-- Check M1 question distribution by Axis Slug
SELECT 
    e.slug,
    count(q.id) as m1_question_count
FROM 
    public.ejes e
JOIN 
    public.topics t ON t.eje_id = e.id
JOIN 
    public.question_topics qt ON qt.topic_id = t.id
JOIN 
    public.questions q ON qt.question_id = q.id
WHERE 
    q.subject = 'm1'
GROUP BY 
    e.slug
ORDER BY 
    m1_question_count DESC;
