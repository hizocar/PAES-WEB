import { NextResponse, type NextRequest } from "next/server"
import { createClient } from "@/lib/supabase/server"

/**
 * Callback de OAuth (Google) y de confirmación de correo.
 *
 * Es un route handler de servidor a propósito: el canje del código PKCE ocurre antes de que
 * cargue cualquier JavaScript del navegador. Antes era una página cliente y el código se
 * canjeaba dos veces (el cliente de Supabase con detectSessionInUrl + una server action),
 * lo que producía "PKCE code verifier not found in storage" aunque el login funcionara.
 */
export async function GET(request: NextRequest) {
    const { searchParams, origin } = new URL(request.url)
    const code = searchParams.get("code")
    const rawNext = searchParams.get("next") ?? "/app"
    // Solo rutas internas: evita redirecciones abiertas a otros dominios
    const next = rawNext.startsWith("/") && !rawNext.startsWith("//") ? rawNext : "/app"

    const providerError = searchParams.get("error_description") ?? searchParams.get("error")
    if (providerError) {
        return NextResponse.redirect(`${origin}/login?error=${encodeURIComponent(providerError)}`)
    }

    if (code) {
        const supabase = await createClient()
        const { error } = await supabase.auth.exchangeCodeForSession(code)
        if (!error) {
            const sep = next.includes("?") ? "&" : "?"
            return NextResponse.redirect(`${origin}${next}${sep}login=ok`)
        }
        console.error("[auth/callback] exchangeCodeForSession:", error.message)
    }

    return NextResponse.redirect(`${origin}/login?error=auth_exchange_failed`)
}
