-- Corrección de la migración 063: protect_profile_columns era SECURITY DEFINER, y dentro de
-- ella current_user siempre es el dueño (postgres), nunca 'authenticated'; por eso la
-- protección no se activaba. Como SECURITY INVOKER, current_user refleja quién escribe:
--   · escritura directa desde la API  → 'authenticated' → se restringen las columnas
--   · desde una RPC SECURITY DEFINER  → 'postgres'      → permitido (la RPC ya validó)
--   · service_role (webhook de pago)  → 'service_role'  → permitido
alter function public.protect_profile_columns() security invoker;
