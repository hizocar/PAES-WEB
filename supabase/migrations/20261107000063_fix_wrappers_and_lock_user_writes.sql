-- Correcciones detectadas por el smoke test con un usuario real (reconstrucción 2026-11).

-- ─────────────────────────────────────────────────────────────────────────────
-- 1) Wrappers de la migración 061: en funciones RETURNS TABLE, proargnames incluye las
--    columnas de salida, y se pasaban como argumentos al __impl. Se recrean los wrappers
--    usando solo los argumentos de entrada (modos i, b, v).
-- ─────────────────────────────────────────────────────────────────────────────
do $$
declare
  fn record;
  base text;
  kind text;
  guard text;
  call_args text;
  body text;
begin
  for fn in
    select p.oid, p.proname,
           pg_get_function_identity_arguments(p.oid) as ident_args,
           pg_get_function_arguments(p.oid) as full_args,
           pg_get_function_result(p.oid) as result,
           p.proretset as retset,
           coalesce(p.proargnames, '{}') as argnames,
           p.proargmodes as argmodes
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname like '%\_\_impl'
  loop
    base := left(fn.proname, length(fn.proname) - length('__impl'));
    kind := case
      when base in ('admin_update_user_tier', 'get_admin_dashboard_stats', 'cleanup_expired_subscriptions') then 'admin'
      when base = 'submit_ensayo' then 'ensayo'
      else 'self'
    end;
    guard := case kind
      when 'admin' then
        'if not (public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
      when 'self' then
        'if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
      else
        'if not (exists (select 1 from public.ensayos e where e.id = p_ensayo_id and e.user_id = auth.uid()) or public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
    end;

    -- Solo argumentos de entrada
    select coalesce(string_agg(quote_ident(fn.argnames[i]), ', ' order by i), '')
      into call_args
    from generate_subscripts(fn.argnames, 1) as i
    where fn.argmodes is null or fn.argmodes[i] in ('i', 'b', 'v');

    body := case
      when fn.retset then format('return query select * from public.%I(%s);', fn.proname, call_args)
      when fn.result = 'void' then format('perform public.%I(%s); return;', fn.proname, call_args)
      else format('return public.%I(%s);', fn.proname, call_args)
    end;

    execute format('drop function if exists public.%I(%s)', base, fn.ident_args);
    execute format(
      'create function public.%I(%s) returns %s language plpgsql security definer set search_path = public, extensions, pg_temp as $w$ begin %s %s end $w$',
      base, fn.full_args, fn.result, guard, body
    );
    execute format('revoke all on function public.%I(%s) from public, anon', base, fn.ident_args);
    execute format('grant execute on function public.%I(%s) to authenticated, service_role', base, fn.ident_args);
  end loop;
end
$$;

-- ─────────────────────────────────────────────────────────────────────────────
-- 2) profiles: un alumno podía hacer UPDATE de su propio perfil sin restricción de
--    columnas (role = 'admin', subscription_tier = 'premium', vidas, créditos...).
--    Ahora, en una escritura directa desde la API, solo se pueden cambiar full_name y
--    avatar_url. Las RPCs (SECURITY DEFINER, corren como el dueño) y el service_role
--    no se ven afectados.
-- ─────────────────────────────────────────────────────────────────────────────
create or replace function public.protect_profile_columns()
returns trigger
language plpgsql
security definer
set search_path = public, extensions, pg_temp
as $$
declare
  editable constant text[] := array['full_name', 'avatar_url'];
begin
  -- current_user es 'authenticated'/'anon' solo cuando la escritura viene directo de la API.
  if current_user in ('authenticated', 'anon') and not public.is_admin() then
    if (to_jsonb(new) - editable) is distinct from (to_jsonb(old) - editable) then
      raise exception 'Solo puedes modificar tu nombre y tu foto de perfil' using errcode = '42501';
    end if;
  end if;
  return new;
end;
$$;

drop trigger if exists protect_profile_columns on public.profiles;
create trigger protect_profile_columns
  before update on public.profiles
  for each row execute function public.protect_profile_columns();

revoke execute on function public.protect_profile_columns() from public, anon, authenticated;

-- ─────────────────────────────────────────────────────────────────────────────
-- 3) ensayos: el cliente nunca actualiza un ensayo directamente (lo hace submit_ensayo).
--    La política permitía a un alumno escribirse cualquier puntaje.
-- ─────────────────────────────────────────────────────────────────────────────
drop policy if exists "Users can update own ensayos" on public.ensayos;

-- ─────────────────────────────────────────────────────────────────────────────
-- 4) attempts: is_correct venía del navegador y alimenta el puntaje y el ranking.
--    Se recalcula en la base a partir de la respuesta correcta.
-- ─────────────────────────────────────────────────────────────────────────────
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
  return new;
end;
$$;

-- Nombre con prefijo "a_" para que corra antes que otros triggers BEFORE INSERT (orden alfabético).
drop trigger if exists a_compute_attempt_correctness on public.attempts;
create trigger a_compute_attempt_correctness
  before insert on public.attempts
  for each row execute function public.compute_attempt_correctness();

revoke execute on function public.compute_attempt_correctness() from public, anon, authenticated;
