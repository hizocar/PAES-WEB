--Diagnostic and Fix for Admin Permissions
-- Run this if you are getting "No tienes permisos de administrador"

-- 1. Check current admin status
select email, raw_user_meta_data->>'full_name' as name, p.role
from auth.users u
left join profiles p on u.id = p.id
where email = 'hizocar@gmail.com';

-- 2. Force promote to admin if not already
update profiles
set role = 'admin'
where id in (
    select id from auth.users where email = 'hizocar@gmail.com'
);
