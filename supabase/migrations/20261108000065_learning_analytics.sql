-- Analítica de aprendizaje (2026-11-08).
-- Objetivo: registrar cada respuesta con la información que necesitan los modelos futuros
-- (calibración de ítems / IRT, dominio por tópico / knowledge tracing, predicción de puntaje)
-- y exponer vistas listas para análisis en el esquema `analytics` (no expuesto por la API).

-- ─────────────────────────────────────────────────────────────────────────────
-- 1) study_sessions.subject: el código la usa, pero la columna se había creado a mano en la
--    base original y nunca quedó en un SQL. Sin ella, todas las sesiones fallaban (HTTP 400).
-- ─────────────────────────────────────────────────────────────────────────────
alter table public.study_sessions
  add column if not exists subject text check (subject in ('m1', 'm2'));
create index if not exists idx_study_sessions_user_started on public.study_sessions (user_id, started_at desc);

-- ─────────────────────────────────────────────────────────────────────────────
-- 2) questions.external_key: vínculo estable con el banco versionado en git
--    (content/questions/*.json). Permite cruzar las respuestas con la fuente y sus metadatos.
-- ─────────────────────────────────────────────────────────────────────────────
alter table public.questions add column if not exists external_key text unique;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3) attempts: señales de proceso por respuesta
-- ─────────────────────────────────────────────────────────────────────────────
alter table public.attempts
  add column if not exists time_spent_ms integer check (time_spent_ms is null or (time_spent_ms >= 0 and time_spent_ms <= 3600000)),
  add column if not exists session_id uuid references public.study_sessions (id) on delete set null,
  add column if not exists attempt_number integer;

comment on column public.attempts.time_spent_ms is 'Milisegundos desde que se mostró la pregunta hasta que se respondió (o se agotó el tiempo).';
comment on column public.attempts.session_id is 'Sesión de estudio (study_sessions) en que ocurrió la respuesta; permite modelar secuencias.';
comment on column public.attempts.attempt_number is 'N° de intento de este usuario sobre esta pregunta (1 = primera exposición). Calculado en la base.';

create index if not exists idx_attempts_user_created on public.attempts (user_id, created_at);
create index if not exists idx_attempts_question on public.attempts (question_id);

-- El trigger que ya calcula is_correct ahora también calcula attempt_number y valida
-- que la sesión informada pertenezca al mismo usuario.
create or replace function public.compute_attempt_correctness()
returns trigger
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
begin
  select coalesce(new.selected_answer = q.correct_answer, false)
    into new.is_correct
  from public.questions q
  where q.id = new.question_id;
  new.is_correct := coalesce(new.is_correct, false);

  select count(*) + 1 into new.attempt_number
  from public.attempts a
  where a.user_id = new.user_id and a.question_id = new.question_id;

  if new.session_id is not null and not exists (
    select 1 from public.study_sessions s where s.id = new.session_id and s.user_id = new.user_id
  ) then
    new.session_id := null;
  end if;

  return new;
end;
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4) ensayo_responses: cada respuesta de ensayo como una fila analizable
--    (antes solo existía dentro del JSON ensayos.answers).
-- ─────────────────────────────────────────────────────────────────────────────
create table if not exists public.ensayo_responses (
  ensayo_id uuid not null references public.ensayos (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete cascade,
  position integer not null,
  eje_slug text,
  selected_answer text,
  is_correct boolean not null,
  answered_at timestamptz not null default now(),
  primary key (ensayo_id, question_id)
);
alter table public.ensayo_responses enable row level security;
drop policy if exists "Users can read own ensayo responses" on public.ensayo_responses;
create policy "Users can read own ensayo responses" on public.ensayo_responses
  for select to authenticated using (auth.uid() = user_id or public.is_admin());
create index if not exists idx_ensayo_responses_user on public.ensayo_responses (user_id);
create index if not exists idx_ensayo_responses_question on public.ensayo_responses (question_id);

create or replace function public.explode_ensayo_responses()
returns trigger
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
begin
  if new.status = 'completed' and old.status is distinct from 'completed' then
    insert into public.ensayo_responses (ensayo_id, user_id, question_id, position, eje_slug, selected_answer, is_correct, answered_at)
    select new.id, new.user_id, (item->>'question_id')::uuid, ord::int, item->>'eje_slug',
           nullif(new.answers->>(item->>'question_id'), ''),
           coalesce(new.answers->>(item->>'question_id') = q.correct_answer, false),
           coalesce(new.completed_at, now())
    from jsonb_array_elements(new.questions_data) with ordinality as t(item, ord)
    join public.questions q on q.id = (item->>'question_id')::uuid
    on conflict (ensayo_id, question_id) do nothing;
  end if;
  return new;
end;
$$;

drop trigger if exists explode_ensayo_responses on public.ensayos;
create trigger explode_ensayo_responses
  after update of status on public.ensayos
  for each row execute function public.explode_ensayo_responses();
revoke execute on function public.explode_ensayo_responses() from public, anon, authenticated;

-- Retroalimentar ensayos ya completados
insert into public.ensayo_responses (ensayo_id, user_id, question_id, position, eje_slug, selected_answer, is_correct, answered_at)
select e.id, e.user_id, (item->>'question_id')::uuid, ord::int, item->>'eje_slug',
       nullif(e.answers->>(item->>'question_id'), ''),
       coalesce(e.answers->>(item->>'question_id') = q.correct_answer, false),
       coalesce(e.completed_at, e.started_at)
from public.ensayos e
cross join lateral jsonb_array_elements(e.questions_data) with ordinality as t(item, ord)
join public.questions q on q.id = (item->>'question_id')::uuid
where e.status = 'completed'
on conflict do nothing;

-- ─────────────────────────────────────────────────────────────────────────────
-- 5) explanation_views: el alumno puede registrar que abrió la explicación de una pregunta.
-- ─────────────────────────────────────────────────────────────────────────────
create index if not exists idx_explanation_views_user_question on public.explanation_views (user_id, question_id);

-- ─────────────────────────────────────────────────────────────────────────────
-- 6) Esquema analytics: vistas para modelamiento. No está expuesto por PostgREST; se lee
--    por SQL directo (service_role / postgres) o desde exportaciones.
-- ─────────────────────────────────────────────────────────────────────────────
create schema if not exists analytics;
revoke all on schema analytics from public, anon, authenticated;
grant usage on schema analytics to service_role;

-- Metadatos de cada ítem (una fila por pregunta; si tiene varios tópicos, se toma el primero).
create or replace view analytics.items as
select distinct on (q.id)
  q.id as question_id, q.external_key, q.subject, e.slug as eje, t.slug as topic,
  q.habilidad, q.difficulty::text as authored_difficulty, q.is_active, q.created_at
from public.questions q
left join public.question_topics qt on qt.question_id = q.id
left join public.topics t on t.id = qt.topic_id
left join public.ejes e on e.id = t.eje_id
order by q.id, t.slug;

-- Todas las respuestas (práctica + ensayo) en un formato único, listo para IRT / knowledge tracing.
-- user_key es un seudónimo estable (sha256 del uuid), para exportar sin datos personales.
create or replace view analytics.responses as
select
  encode(extensions.digest(a.user_id::text, 'sha256'), 'hex') as user_key,
  a.user_id, a.question_id, i.external_key, i.subject, i.eje, i.topic, i.habilidad, i.authored_difficulty,
  coalesce(a.mode, 'practice') as source, null::uuid as ensayo_id, a.session_id,
  a.created_at as responded_at, a.selected_answer,
  (a.selected_answer = 'TIMEOUT') as timed_out,
  a.is_correct, a.time_spent_ms, a.attempt_number,
  exists (select 1 from public.explanation_views v
          where v.user_id = a.user_id and v.question_id = a.question_id and v.viewed_at < a.created_at) as saw_explanation_before
from public.attempts a
join analytics.items i on i.question_id = a.question_id
union all
select
  encode(extensions.digest(r.user_id::text, 'sha256'), 'hex'),
  r.user_id, r.question_id, i.external_key, i.subject, i.eje, i.topic, i.habilidad, i.authored_difficulty,
  'ensayo', r.ensayo_id, null::uuid,
  r.answered_at, r.selected_answer, false, r.is_correct, null::integer, null::integer, false
from public.ensayo_responses r
join analytics.items i on i.question_id = r.question_id;

-- Estadística clásica de ítems (base para calibrar dificultad real vs. la asignada).
-- p_correct usa solo primeras exposiciones; la discriminación es la correlación punto-biserial
-- entre acertar el ítem y la tasa de acierto global del alumno.
create or replace view analytics.item_stats as
with first_exposure as (
  select * from analytics.responses where coalesce(attempt_number, 1) = 1 and not timed_out
),
user_ability as (
  select user_id, avg(is_correct::int)::float as ability, count(*) as n_user
  from analytics.responses group by user_id
)
select
  i.question_id, i.external_key, i.subject, i.eje, i.topic, i.habilidad, i.authored_difficulty,
  count(f.*) as n_first_attempts,
  round(avg(f.is_correct::int)::numeric, 3) as p_correct,
  percentile_cont(0.5) within group (order by f.time_spent_ms) filter (where f.time_spent_ms is not null) as median_time_ms,
  round(corr(f.is_correct::int, u.ability)::numeric, 3) as discrimination,
  case
    when count(f.*) < 30 then 'insuficiente'
    when avg(f.is_correct::int) >= 0.75 then 'easy'
    when avg(f.is_correct::int) >= 0.40 then 'medium'
    else 'hard'
  end as empirical_difficulty
from analytics.items i
left join first_exposure f on f.question_id = i.question_id
left join user_ability u on u.user_id = f.user_id
group by i.question_id, i.external_key, i.subject, i.eje, i.topic, i.habilidad, i.authored_difficulty;

-- Dominio por alumno y tópico (insumo directo para recomendaciones y modelos de dominio).
create or replace view analytics.user_topic_mastery as
with ranked as (
  select r.*, row_number() over (partition by r.user_id, r.subject, r.topic order by r.responded_at desc) as recency
  from analytics.responses r
)
select
  user_key, user_id, subject, eje, topic,
  count(*) as n_responses,
  round(avg(is_correct::int)::numeric, 3) as accuracy,
  round(avg(is_correct::int) filter (where recency <= 10)::numeric, 3) as accuracy_last_10,
  percentile_cont(0.5) within group (order by time_spent_ms) filter (where time_spent_ms is not null) as median_time_ms,
  min(responded_at) as first_at, max(responded_at) as last_at
from ranked
group by user_key, user_id, subject, eje, topic;

-- Comportamiento de estudio por día.
create or replace view analytics.daily_activity as
select
  encode(extensions.digest(s.user_id::text, 'sha256'), 'hex') as user_key, s.user_id, s.subject,
  (s.started_at at time zone 'America/Santiago')::date as day,
  count(*) as sessions, coalesce(sum(s.duration_seconds), 0) as seconds_studied
from public.study_sessions s
group by 1, 2, 3, 4;

grant select on all tables in schema analytics to service_role;
