-- RPC to allow admins to safely delete a user's data
-- Note: This deletes public data. Deletion from 'auth.users' must be done via Service Role Key in the backend.
create or replace function public.admin_delete_user_data(
    p_user_id uuid
)
returns void
language plpgsql
security definer
as $$
begin
    -- The profiles table usually has foreign keys with 'on delete cascade' to other tables.
    -- If not, we delete manually here:
    
    delete from public.attempts where user_id = p_user_id;
    delete from public.subscriptions where user_id = p_user_id;
    delete from public.profiles where id = p_user_id;

    -- Note: If we had other user-specific tables, we should add them here.
end;
$$;
