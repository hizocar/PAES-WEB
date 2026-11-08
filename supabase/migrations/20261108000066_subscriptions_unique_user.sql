-- subscriptions.user_id único (2026-11-08).
-- El código hace upsert con onConflict 'user_id' (activación del pago, webhook de
-- MercadoPago y admin_update_user_tier). La restricción se había creado a mano en la base
-- original y nunca quedó en un SQL; sin ella, esos tres flujos fallan con
-- "there is no unique or exclusion constraint matching the ON CONFLICT specification".

-- Por seguridad, si existieran duplicados se conserva la fila más reciente por usuario.
delete from public.subscriptions s
using public.subscriptions newer
where s.user_id = newer.user_id
  and s.ctid <> newer.ctid
  and coalesce(s.created_at, 'epoch') < coalesce(newer.created_at, 'epoch');

alter table public.subscriptions
  add constraint subscriptions_user_id_key unique (user_id);
