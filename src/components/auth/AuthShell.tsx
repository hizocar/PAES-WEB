"use client"

import { Mascot } from "@/components/mascot/Mascot"
import Link from "next/link"
import type { ReactNode } from "react"
import { Loader2 } from "lucide-react"

/** Marco común de login y registro, en la identidad clara del resto de la app. */
export function AuthShell({ title, subtitle, children, footer }: { title: string; subtitle?: string; children: ReactNode; footer?: ReactNode }) {
    return (
        <div className="flex min-h-[100dvh] flex-col items-center justify-center bg-slate-50 px-4 py-10">
            <Link href="/" className="mb-6 text-2xl font-black text-blue-600 focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-blue-600">
                PAES Lab
            </Link>
            <main className="w-full max-w-md rounded-[1.75rem] border border-slate-200 bg-white p-6 shadow-[0_20px_50px_-20px_rgba(15,23,42,0.18)] sm:p-8">
                <div className="mb-6 flex flex-col items-center text-center">
                    <Mascot mood="idle" size={84} message={false} className="mb-2" />
                    <h1 className="text-2xl font-black tracking-tight text-slate-900">{title}</h1>
                    {subtitle && <p className="mt-1 text-sm text-slate-600">{subtitle}</p>}
                </div>
                {children}
            </main>
            {footer && <div className="mt-6 text-center text-sm text-slate-600">{footer}</div>}
        </div>
    )
}

/** Botón de Google con el logotipo oficial (no el de Chrome). */
export function GoogleButton({ onClick, loading, label = "Continuar con Google" }: { onClick: () => void; loading?: boolean; label?: string }) {
    return (
        <button
            type="button"
            onClick={onClick}
            disabled={loading}
            className="flex h-12 w-full items-center justify-center gap-3 rounded-xl border border-slate-300 bg-white text-base font-bold text-slate-800 transition-colors hover:bg-slate-50 disabled:opacity-60 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
        >
            {loading ? (
                <Loader2 className="h-5 w-5 animate-spin" aria-hidden />
            ) : (
                <svg viewBox="0 0 48 48" className="h-5 w-5" aria-hidden>
                    <path fill="#FFC107" d="M43.6 20.5H42V20H24v8h11.3C33.7 32.7 29.2 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.4-.4-3.5z" />
                    <path fill="#FF3D00" d="M6.3 14.7l6.6 4.8C14.7 15.1 19 12 24 12c3.1 0 5.8 1.2 7.9 3.1l5.7-5.7C34 6.1 29.3 4 24 4 16.3 4 9.7 8.3 6.3 14.7z" />
                    <path fill="#4CAF50" d="M24 44c5.2 0 9.9-2 13.4-5.2l-6.2-5.2C29.2 35.1 26.7 36 24 36c-5.2 0-9.6-3.3-11.3-8l-6.5 5C9.5 39.6 16.2 44 24 44z" />
                    <path fill="#1976D2" d="M43.6 20.5H42V20H24v8h11.3c-.8 2.2-2.2 4.2-4.1 5.6l6.2 5.2C37 39.2 44 34 44 24c0-1.3-.1-2.4-.4-3.5z" />
                </svg>
            )}
            {label}
        </button>
    )
}

export function Divider() {
    return (
        <div className="my-5 flex items-center gap-4" aria-hidden>
            <span className="h-px flex-1 bg-slate-200" />
            <span className="text-sm font-medium text-slate-500">o con tu correo</span>
            <span className="h-px flex-1 bg-slate-200" />
        </div>
    )
}

/** Traduce los errores de Supabase Auth a mensajes claros en español. */
export function authErrorMessage(raw?: string | null): string | null {
    if (!raw) return null
    const m = raw.toLowerCase()
    if (m.includes("invalid login credentials")) return "Correo o contraseña incorrectos."
    if (m.includes("email not confirmed")) return "Aún no confirmas tu correo. Revisa tu bandeja de entrada (y spam) y haz clic en el enlace que te enviamos."
    if (m.includes("already registered") || m.includes("already been registered")) return "Ya existe una cuenta con ese correo. Inicia sesión o usa Google."
    if (m.includes("rate limit") || m.includes("too many")) return "Demasiados intentos seguidos. Espera un minuto y vuelve a intentarlo."
    if (m.includes("password should be")) return "La contraseña es muy corta."
    if (m.includes("auth_exchange_failed") || m.includes("code verifier")) return "No pudimos completar el inicio de sesión. Inténtalo de nuevo desde este navegador."
    if (m.includes("access_denied")) return "Cancelaste el inicio de sesión con Google."
    return "Ocurrió un error inesperado. Inténtalo de nuevo."
}

export const inputClass =
    "h-12 w-full rounded-xl border border-slate-300 bg-white px-4 text-base text-slate-900 placeholder:text-slate-500 transition-colors focus:border-blue-600 focus:outline-none focus:ring-4 focus:ring-blue-600/15"
