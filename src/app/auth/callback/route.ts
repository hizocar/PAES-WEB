import { NextResponse } from 'next/server'
import { createClient } from '@/lib/supabase/server'

export async function GET(request: Request) {
    const { searchParams, origin } = new URL(request.url)
    const code = searchParams.get('code')
    // if "next" is in param, use it, otherwise default to /app
    const next = searchParams.get('next') ?? '/app'

    if (code) {
        const supabase = await createClient()
        const { error } = await supabase.auth.exchangeCodeForSession(code)
        if (!error) {
            const isLocalEnv = process.env.NODE_ENV === 'development'
            if (isLocalEnv) {
                return NextResponse.redirect(`${origin}${next}`)
            } else {
                const forwardedHost = request.headers.get('x-forwarded-host') // original origin before load balancer
                const isForwardedProtoHttps = request.headers.get('x-forwarded-proto') === 'https'

                if (forwardedHost) {
                    const protocol = isForwardedProtoHttps ? 'https' : 'http'
                    return NextResponse.redirect(`${protocol}://${forwardedHost}${next}`)
                } else {
                    return NextResponse.redirect(`${origin}${next}`)
                }
            }
        }
    }

    // return the user to an error page with instructions
    return NextResponse.redirect(`${origin}/auth/auth-code-error`)
}
