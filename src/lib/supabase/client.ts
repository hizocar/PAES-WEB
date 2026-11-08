import { createBrowserClient } from '@supabase/ssr'

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}

/**
 * Usuario de la sesión local del navegador, sin ir a la red.
 *
 * `auth.getUser()` consulta el servidor de Auth en cada llamada (un viaje de red); en el
 * cliente se usaba antes de cada pregunta y de cada respuesta. La identidad igual la
 * verifica la base de datos (RLS y los guards de las RPCs), así que en el navegador basta
 * con la sesión local. En código de servidor se sigue usando `getUser()`.
 */
export async function getSessionUser(supabase: ReturnType<typeof createClient>) {
  const { data } = await supabase.auth.getSession()
  return data.session?.user ?? null
}
