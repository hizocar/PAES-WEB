-- Function to get deep performance breakdown for a specific student
create or replace function get_admin_student_performance(
    p_user_id uuid,
    p_subject text default 'm2'
)
returns json
language plpgsql
security definer
as $$
declare
    v_ejes_stats json;
    v_habilidades_stats json;
    v_topics_stats json;
    v_matrix_stats json;
    v_usage_stats json;
begin
    -- 1. Ejes Performance
    with user_attempts as (
        select 
            e.id as eje_id,
            e.name as eje_name,
            a.is_correct
        from ejes e
        left join topics t on t.eje_id = e.id
        left join question_topics qt on qt.topic_id = t.id
        left join questions q on qt.question_id = q.id and q.subject = p_subject
        left join attempts a on a.question_id = q.id and a.user_id = p_user_id
        where e.subject = p_subject
    )
    select json_agg(row) into v_ejes_stats
    from (
        select 
            eje_name as name,
            count(is_correct) as total,
            sum(case when is_correct then 1 else 0 end) as correct,
            case when count(is_correct) > 0 then round((sum(case when is_correct then 1 else 0 end)::numeric / count(is_correct)) * 100) else 0 end as progress
        from user_attempts
        group by eje_id, eje_name
        order by eje_name
    ) row;

    -- 2. Habilidades Performance
    with skill_list as (
        select unnest(array['resolver_problemas', 'modelar', 'representar', 'argumentar']) as skill_name
    ),
    user_skill_attempts as (
        select 
            q.habilidad as skill_name,
            a.is_correct
        from attempts a
        join questions q on a.question_id = q.id 
        where a.user_id = p_user_id
        and q.subject = p_subject
    )
    select json_agg(row) into v_habilidades_stats
    from (
        select 
            sl.skill_name as name,
            count(usa.is_correct) as total,
            sum(case when usa.is_correct then 1 else 0 end) as correct,
            case when count(usa.is_correct) > 0 then round((sum(case when usa.is_correct then 1 else 0 end)::numeric / count(usa.is_correct)) * 100) else 0 end as progress
        from skill_list sl
        left join user_skill_attempts usa on sl.skill_name = usa.skill_name
        group by sl.skill_name
    ) row;

    -- 3. Topics Performance
    with topic_attempts as (
        select 
            t.id as topic_id,
            t.name as topic_name,
            e.name as eje_name,
            a.is_correct
        from topics t
        join ejes e on t.eje_id = e.id
        left join question_topics qt on qt.topic_id = t.id
        left join questions q on qt.question_id = q.id and q.subject = p_subject
        left join attempts a on a.question_id = q.id and a.user_id = p_user_id
        where e.subject = p_subject
    )
    select json_agg(row) into v_topics_stats
    from (
        select 
            topic_name as name,
            eje_name,
            count(is_correct) as total,
            sum(case when is_correct then 1 else 0 end) as correct,
            case when count(is_correct) > 0 then round((sum(case when is_correct then 1 else 0 end)::numeric / count(is_correct)) * 100) else 0 end as progress
        from topic_attempts
        group by topic_id, topic_name, eje_name
        having count(is_correct) > 0
        order by eje_name, topic_name
    ) row;

    -- 4. Matrix Performance (Eje + Topic + Habilidad)
    with matrix_attempts as (
        select 
            e.name as eje_name,
            t.name as topic_name,
            q.habilidad as skill_name,
            a.is_correct
        from attempts a
        join questions q on a.question_id = q.id
        join question_topics qt on q.id = qt.question_id
        join topics t on qt.topic_id = t.id
        join ejes e on t.eje_id = e.id
        where a.user_id = p_user_id
        and q.subject = p_subject
    )
    select json_agg(row) into v_matrix_stats
    from (
        select 
            eje_name,
            topic_name,
            skill_name,
            count(is_correct) as total,
            sum(case when is_correct then 1 else 0 end) as correct,
            case when count(is_correct) > 0 then round((sum(case when is_correct then 1 else 0 end)::numeric / count(is_correct)) * 100) else 0 end as progress
        from matrix_attempts
        group by eje_name, topic_name, skill_name
        order by eje_name, topic_name, skill_name
    ) row;

    -- 5. Usage By Hour (0-23)
    with hourly_usage as (
        select 
            extract(hour from (a.created_at at time zone 'America/Santiago')) as hour_of_day,
            count(*) as count
        from attempts a
        join questions q on a.question_id = q.id
        where a.user_id = p_user_id
        and q.subject = p_subject
        group by 1
        order by 1
    )
    select json_object_agg(row.hour_of_day, row.count) into v_usage_stats
    from hourly_usage row;

    return json_build_object(
        'ejes', coalesce(v_ejes_stats, '[]'::json),
        'habilidades', coalesce(v_habilidades_stats, '[]'::json),
        'topics', coalesce(v_topics_stats, '[]'::json),
        'matrix', coalesce(v_matrix_stats, '[]'::json),
        'usage', coalesce(v_usage_stats, '{}'::json)
    );
end;
$$;
