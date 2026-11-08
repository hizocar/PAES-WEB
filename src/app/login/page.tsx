"use client"

import { Suspense, useEffect, useState } from "react"
import Link from "next/link"
import { useSearchParams } from "next/navigation"
import { Loader2 } from "lucide-react"
import { useAuth } from "@/context/auth-provider"
import { AuthShell, Divider, GoogleButton, authErrorMessage, inputClass } from "@/components/auth/AuthShell"

function LoginForm() {
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [loading, setLoading] = useState(false)
    const [googleLoading, setGoogleLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)
    const { signInWithEmail, signInWithGoogle } = useAuth()
    const searchParams = useSearchParams()

    // Errores que llegan desde /auth/callback
    useEffect(() => {
        const e = searchParams.get("error")
        if (e) setError(authErrorMessage(e))
    }, [searchParams])

    const handleEmailLogin = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault()
        // El autocompletado del navegador puede no disparar onChange: leemos el formulario
        const form = new FormData(e.currentTarget)
        const mail = String(form.get("email") ?? email).trim()
        const pass = String(form.get("password") ?? password)
        if (!mail || !pass) {
            setError("Ingresa tu correo y tu contraseña.")
            return
        }
        setLoading(true)
        setError(null)
        try {
            const { error } = await signInWithEmail(mail, pass)
            if (error) setError(authErrorMessage(error.message))
        } catch {
            setError(authErrorMessage("unknown"))
        } finally {
            setLoading(false)
        }
    }

    return (
        <AuthShell
            title="¡Qué bueno verte!"
            subtitle="Inicia sesión para seguir con tu racha."
            footer={
                <>
                    ¿No tienes cuenta?{" "}
                    <Link href="/register" className="font-bold text-blue-700 underline-offset-2 hover:underline">
                        Créala gratis
                    </Link>
                </>
            }
        >
            <GoogleButton
                loading={googleLoading}
                onClick={async () => {
                    setGoogleLoading(true)
                    await signInWithGoogle()
                }}
            />

            <Divider />

            <form onSubmit={handleEmailLogin} className="space-y-3" noValidate>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Correo</span>
                    <input
                        type="email"
                        name="email"
                        autoComplete="email"
                        inputMode="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                        required
                        className={inputClass}
                    />
                </label>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Contraseña</span>
                    <input
                        type="password"
                        name="password"
                        autoComplete="current-password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                        className={inputClass}
                    />
                </label>

                {error && (
                    <p role="alert" className="rounded-xl bg-red-50 px-3 py-2.5 text-sm font-medium text-red-800">
                        {error}
                    </p>
                )}

                <button
                    type="submit"
                    disabled={loading}
                    className="mt-2 flex h-12 w-full items-center justify-center rounded-xl border-b-4 border-blue-800 bg-blue-600 text-base font-black text-white transition-[background-color,transform] hover:bg-blue-700 active:translate-y-0.5 active:border-b-2 disabled:cursor-not-allowed disabled:border-b-0 disabled:bg-slate-300 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                >
                    {loading ? <Loader2 className="h-5 w-5 animate-spin" aria-label="Ingresando" /> : "Ingresar"}
                </button>
            </form>
        </AuthShell>
    )
}

export default function LoginPage() {
    return (
        <Suspense fallback={null}>
            <LoginForm />
        </Suspense>
    )
}
