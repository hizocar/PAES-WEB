-- ENSAYOS SYSTEM

-- 1. Table for storing essay attempts
create table if not exists public.ensayos (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references public.profiles(id) on delete cascade not null,
  subject text not null check (subject in ('m1', 'm2')), -- For now only m1 is implemented fully
  status text not null check (status in ('in_progress', 'completed')) default 'in_progress',
  
  started_at timestamp with time zone default timezone('utc'::text, now()) not null,
  completed_at timestamp with time zone,
  
  -- Stores the specific questions selected for this essay
  -- Format: [{ "question_id": "...", "user_answer": "A" | null, "is_correct": boolean | null }]
  questions_data jsonb not null default '[]'::jsonb,
  
  score integer, -- PAES Score (100-1000)
  total_correct integer,
  total_questions integer default 60,
  
  answers jsonb -- Deprecated/Redundant if we use questions_data, but kept for simplicity if needed
);

-- RLS
alter table public.ensayos enable row level security;

create policy "Users can read own ensayos" 
  on public.ensayos for select 
  using (auth.uid() = user_id);

create policy "Users can insert own ensayos" 
  on public.ensayos for insert 
  with check (auth.uid() = user_id);

create policy "Users can update own ensayos" 
  on public.ensayos for update 
  using (auth.uid() = user_id);


-- 2. RPC: Create Ensayo M1
-- Selects 60 questions: 15 from each of the 4 axes
create or replace function public.create_ensayo_m1(p_user_id uuid)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_ensayo_id uuid;
  v_questions jsonb;
  v_numeros_id uuid;
  v_algebra_id uuid;
  v_geometria_id uuid;
  v_probabilidad_id uuid;
begin
  -- Get Axis IDs
  select id into v_numeros_id from public.ejes where slug = 'numeros';
  select id into v_algebra_id from public.ejes where slug = 'algebra-y-funciones';
  select id into v_geometria_id from public.ejes where slug = 'geometria';
  select id into v_probabilidad_id from public.ejes where slug = 'probabilidad-y-estadistica';

  -- Select 15 Random Questions from each Axis
  with selected_questions as (
    (
      select id, content, alternatives, eje_id, 'numeros' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_numeros_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, eje_id, 'algebra-y-funciones' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_algebra_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, eje_id, 'geometria' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_geometria_id))
      order by random() 
      limit 15
    )
    union all
    (
      select id, content, alternatives, eje_id, 'probabilidad-y-estadistica' as eje_slug
      from public.questions 
      where id in (select question_id from public.question_topics where topic_id in (select id from public.topics where eje_id = v_probabilidad_id))
      order by random() 
      limit 15
    )
  )
  select jsonb_agg(
    jsonb_build_object(
      'id', id,
      'question_id', id,
      'content', content,
      'alternatives', alternatives,
      'eje_slug', eje_slug,
      'user_answer', null
    )
  ) into v_questions from selected_questions;

  -- Create Ensayo Record
  insert into public.ensayos (user_id, subject, status, questions_data, total_questions)
  values (p_user_id, 'm1', 'in_progress', v_questions, 60)
  returning id into v_ensayo_id;

  return jsonb_build_object('ensayo_id', v_ensayo_id, 'questions', v_questions);
end;
$$;


-- 3. RPC: Submit Ensayo
-- Calculates score based on provided answers
create or replace function public.submit_ensayo(p_ensayo_id uuid, p_answers jsonb)
returns jsonb
language plpgsql
security definer
as $$
declare
  v_ensayo record;
  v_questions_data jsonb;
  v_total_correct integer := 0;
  v_score integer := 0;
  v_question_record record;
  v_user_answer text;
  v_is_correct boolean;
  v_updated_questions jsonb := '[]'::jsonb;
  
  -- Stats by Axis
  v_numeros_correct int := 0; v_numeros_total int := 0;
  v_algebra_correct int := 0; v_algebra_total int := 0;
  v_geometria_correct int := 0; v_geometria_total int := 0;
  v_probabilidad_correct int := 0; v_probabilidad_total int := 0;
  
begin
  select * into v_ensayo from public.ensayos where id = p_ensayo_id;
  
  if v_ensayo.status = 'completed' then
    return jsonb_build_object('error', 'Ensayo already submitted');
  end if;

  v_questions_data := v_ensayo.questions_data;

  -- Iterate through user answers and validate
  -- p_answers format: { "question_id_uuid": "A", ... }
  
  for v_question_record in (
    select q.id, q.correct_answer, t.eje_id, e.slug as eje_slug
    from public.questions q
    join public.question_topics qt on q.id = qt.question_id
    join public.topics t on qt.topic_id = t.id
    join public.ejes e on t.eje_id = e.id
    where q.id in (select (value->>'question_id')::uuid from jsonb_array_elements(v_questions_data))
  ) loop
    
    v_user_answer := p_answers->>v_question_record.id::text;
    v_is_correct := (v_user_answer is not null and v_user_answer = v_question_record.correct_answer);
    
    if v_is_correct then
      v_total_correct := v_total_correct + 1;
      
      -- Update Axis Stats
      if v_question_record.eje_slug = 'numeros' then v_numeros_correct := v_numeros_correct + 1; end if;
      if v_question_record.eje_slug = 'algebra-y-funciones' then v_algebra_correct := v_algebra_correct + 1; end if;
      if v_question_record.eje_slug = 'geometria' then v_geometria_correct := v_geometria_correct + 1; end if;
      if v_question_record.eje_slug = 'probabilidad-y-estadistica' then v_probabilidad_correct := v_probabilidad_correct + 1; end if;
    end if;

    -- Track totals by axis (implicitly 15, but good to count dynamically)
    if v_question_record.eje_slug = 'numeros' then v_numeros_total := v_numeros_total + 1; end if;
    if v_question_record.eje_slug = 'algebra-y-funciones' then v_algebra_total := v_algebra_total + 1; end if;
    if v_question_record.eje_slug = 'geometria' then v_geometria_total := v_geometria_total + 1; end if;
    if v_question_record.eje_slug = 'probabilidad-y-estadistica' then v_probabilidad_total := v_probabilidad_total + 1; end if;

    -- Rebuild questions data with result
    -- Note: This is a complex update, for simplicity we might just perform a big update at the end or assume the frontend sends the structure
    -- Ideally, we keep the original structure and just append the result. 
    -- For now, let's keep it simple: we calculate the score and return it.
    
  end loop;

  -- CALCULATE PAES SCORE (Scale provided by user)
  -- 0-60 Correct -> 100-1000 Points
  v_score := case v_total_correct
    when 0 then 100 when 1 then 170 when 2 then 194 when 3 then 216 when 4 then 236
    when 5 then 256 when 6 then 275 when 7 then 292 when 8 then 307 when 9 then 320
    when 10 then 334 when 11 then 349 when 12 then 365 when 13 then 380 when 14 then 393
    when 15 then 403 when 16 then 412 when 17 then 421 when 18 then 432 when 19 then 446
    when 20 then 460 when 21 then 474 when 22 then 486 when 23 then 495 when 24 then 502
    when 25 then 508 when 26 then 516 when 27 then 526 when 28 then 539 when 29 then 553
    when 30 then 567 when 31 then 579 when 32 then 587 when 33 then 595 when 34 then 601
    when 35 then 609 when 36 then 618 when 37 then 631 when 38 then 645 when 39 then 660
    when 40 then 672 when 41 then 682 when 42 then 690 when 43 then 699 when 44 then 710
    when 45 then 723 when 46 then 738 when 47 then 753 when 48 then 767 when 49 then 780
    when 50 then 793 when 51 then 807 when 52 then 824 when 53 then 842 when 54 then 861
    when 55 then 880 when 56 then 900 when 57 then 923 when 58 then 948 when 59 then 975
    when 60 then 1000
    else 100
  end;

  -- Update Ensayo Record
  update public.ensayos
  set 
    status = 'completed',
    completed_at = timezone('utc'::text, now()),
    score = v_score,
    total_correct = v_total_correct,
    answers = p_answers -- Save the raw answers map
  where id = p_ensayo_id;

  return jsonb_build_object(
    'ensayo_id', p_ensayo_id,
    'score', v_score,
    'total_correct', v_total_correct,
    'axis_stats', jsonb_build_object(
      'numeros', jsonb_build_object('correct', v_numeros_correct, 'total', v_numeros_total),
      'algebra', jsonb_build_object('correct', v_algebra_correct, 'total', v_algebra_total),
      'geometria', jsonb_build_object('correct', v_geometria_correct, 'total', v_geometria_total),
      'probabilidad', jsonb_build_object('correct', v_probabilidad_correct, 'total', v_probabilidad_total)
    )
  );
end;
$$;
