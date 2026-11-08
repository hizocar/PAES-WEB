import { createClient } from '@supabase/supabase-js'

/**
 * Cliente con service role. SOLO para código de servidor (server actions, route handlers)
 * que ya verificó por su cuenta que la operación es legítima: por ejemplo, un pago
 * confirmado directamente con la API de MercadoPago.
 *
 * Se salta RLS y los triggers de protección de columnas, así que nunca debe importarse
 * desde un componente cliente.
 */
export function createAdminClient() {
    const url = process.env.NEXT_PUBLIC_SUPABASE_URL
    const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
    if (!url || !serviceRoleKey) {
        throw new Error('Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SERVICE_ROLE_KEY')
    }
    return createClient(url, serviceRoleKey, {
        auth: { persistSession: false, autoRefreshToken: false },
    })
}
