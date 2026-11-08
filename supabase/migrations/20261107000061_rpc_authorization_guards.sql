-- Endurecimiento de RPCs (reconstrucción 2026-11).
--
-- Problema: varias funciones SECURITY DEFINER confiaban en que la app validara el permiso antes
-- de llamarlas, pero la anon key es pública: cualquiera podía llamarlas directo por
-- /rest/v1/rpc/... (por ejemplo, admin_update_user_tier para darse plan premium gratis).
--
-- Solución sin reescribir la lógica: cada función se renombra a <nombre>__impl (inaccesible
-- desde la API) y se crea un wrapper con la misma firma que primero valida y luego delega.
--
--   admin  -> solo admin o service_role
--   self   -> p_user_id = auth.uid(), o admin, o service_role
--   ensayo -> el ensayo pertenece a auth.uid(), o admin, o service_role

do $$
declare
  t record;
  fn record;
  guard text;
  call_args text;
  body text;
begin
  for t in
    select * from (values
      ('admin_update_user_tier', 'admin'),
      ('get_admin_dashboard_stats', 'admin'),
      ('cleanup_expired_subscriptions', 'admin'),
      ('check_and_replenish_lives', 'self'),
      ('check_and_unlock_achievement', 'self'),
      ('check_explanation_replenishment', 'self'),
      ('claim_rewarded_ad', 'self'),
      ('complete_onboarding', 'self'),
      ('complete_practice_onboarding', 'self'),
      ('create_ensayo_m1', 'self'),
      ('deduct_explanation', 'self'),
      ('deduct_life', 'self'),
      ('get_admin_student_performance', 'self'),
      ('get_dashboard_stats', 'self'),
      ('get_smart_question', 'self'),
      ('get_smart_question_v2', 'self'),
      ('submit_ensayo', 'ensayo')
    ) as v(name, kind)
  loop
    for fn in
      select p.oid, p.proname,
             pg_get_function_identity_arguments(p.oid) as ident_args,
             pg_get_function_arguments(p.oid) as full_args,
             pg_get_function_result(p.oid) as result,
             p.proretset as retset,
             coalesce(p.proargnames, '{}') as argnames
      from pg_proc p join pg_namespace n on n.oid = p.pronamespace
      where n.nspname = 'public' and p.proname = t.name
    loop
      guard := case t.kind
        when 'admin' then
          'if not (public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
        when 'self' then
          'if not (p_user_id = auth.uid() or public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
        when 'ensayo' then
          'if not (exists (select 1 from public.ensayos e where e.id = p_ensayo_id and e.user_id = auth.uid()) or public.is_admin() or auth.role() = ''service_role'') then raise exception ''No autorizado'' using errcode = ''42501''; end if;'
      end;

      select coalesce(string_agg(quote_ident(a), ', '), '') into call_args from unnest(fn.argnames) a;

      body := case
        when fn.retset then format('return query select * from public.%I(%s);', fn.proname || '__impl', call_args)
        when fn.result = 'void' then format('perform public.%I(%s); return;', fn.proname || '__impl', call_args)
        else format('return public.%I(%s);', fn.proname || '__impl', call_args)
      end;

      execute format('alter function public.%I(%s) rename to %I', fn.proname, fn.ident_args, fn.proname || '__impl');
      execute format('revoke all on function public.%I(%s) from public, anon, authenticated', fn.proname || '__impl', fn.ident_args);

      execute format(
        'create function public.%I(%s) returns %s language plpgsql security definer set search_path = public, extensions, pg_temp as $w$ begin %s %s end $w$',
        fn.proname, fn.full_args, fn.result, guard, body
      );
    end loop;
  end loop;
end
$$;

-- Ninguna RPC se expone al rol anónimo (la app las llama siempre con sesión iniciada).
-- Las funciones de trigger no necesitan EXECUTE para dispararse.
do $$
declare fn record;
begin
  for fn in
    select p.proname, pg_get_function_identity_arguments(p.oid) as args, p.prorettype = 'trigger'::regtype as is_trigger
    from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.prokind = 'f'
  loop
    execute format('revoke execute on function public.%I(%s) from public, anon', fn.proname, fn.args);
    if fn.is_trigger then
      execute format('revoke execute on function public.%I(%s) from authenticated', fn.proname, fn.args);
    elsif fn.proname not like '%\_\_impl' then
      execute format('grant execute on function public.%I(%s) to authenticated, service_role', fn.proname, fn.args);
    end if;
    -- search_path fijo en todas (lint 0011)
    execute format('alter function public.%I(%s) set search_path = public, extensions, pg_temp', fn.proname, fn.args);
  end loop;
end
$$;

-- Que las funciones nuevas no queden ejecutables por anon por defecto.
alter default privileges in schema public revoke execute on functions from public, anon;
