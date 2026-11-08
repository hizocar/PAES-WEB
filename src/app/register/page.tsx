"use client"

import { useState } from "react"
import Link from "next/link"
import { Check, Loader2, MailCheck } from "lucide-react"
import { useAuth } from "@/context/auth-provider"
import { AuthShell, Divider, GoogleButton, authErrorMessage, inputClass } from "@/components/auth/AuthShell"
import { cn } from "@/lib/utils"

function Rule({ ok, children }: { ok: boolean; children: React.ReactNode }) {
    return (
        <li className={cn("flex items-center gap-1.5 text-xs font-medium transition-colors", ok ? "text-emerald-700" : "text-slate-500")}>
            <span className={cn("flex h-4 w-4 items-center justify-center rounded-full", ok ? "bg-emerald-100" : "bg-slate-100")} aria-hidden>
                {ok && <Check size={11} strokeWidth={3} />}
            </span>
            {children}
            <span className="sr-only">{ok ? "(cumplido)" : "(pendiente)"}</span>
        </li>
    )
}

export default function RegisterPage() {
    const [name, setName] = useState("")
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [confirmPassword, setConfirmPassword] = useState("")
    const [loading, setLoading] = useState(false)
    const [googleLoading, setGoogleLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)
    const [success, setSuccess] = useState(false)
    const { signUpWithEmail, signInWithGoogle } = useAuth()

    const hasMinLength = password.length >= 8
    const hasNumber = /\d/.test(password)
    const hasUppercase = /[A-Z]/.test(password)
    const passwordsMatch = password !== "" && password === confirmPassword
    const isFormValid = name.trim().length >= 3 && hasMinLength && hasNumber && hasUppercase && passwordsMatch && email.includes("@")

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault()
        if (!isFormValid) return
        setLoading(true)
        setError(null)
        try {
            const { error } = await signUpWithEmail(email, password, name.trim())
            if (error) {
                setError(authErrorMessage(error.message))
            } else {
                setSuccess(true)
                if ((window as any).fbq) (window as any).fbq("track", "CompleteRegistration")
            }
        } catch {
            setError(authErrorMessage("unknown"))
        } finally {
            setLoading(false)
        }
    }

    if (success) {
        return (
            <AuthShell title="¡Revisa tu correo!" subtitle="Te falta un paso para empezar a entrenar.">
                <div className="flex flex-col items-center gap-4 text-center">
                    <MailCheck size={40} className="text-blue-600" aria-hidden />
                    <p className="text-slate-700">
                        Enviamos un enlace de confirmación a <strong className="break-all text-slate-900">{email}</strong>. Ábrelo desde este
                        dispositivo para activar tu cuenta.
                    </p>
                    <p className="text-sm text-slate-500">¿No llega? Revisa la carpeta de spam o promociones.</p>
                    <Link
                        href="/login"
                        className="mt-2 inline-flex h-12 w-full items-center justify-center rounded-xl border border-slate-300 font-bold text-slate-800 hover:bg-slate-50"
                    >
                        Ir a iniciar sesión
                    </Link>
                </div>
            </AuthShell>
        )
    }

    return (
        <AuthShell
            title="Crea tu cuenta gratis"
            subtitle="Entrena M1 y M2 todos los días, como un juego."
            footer={
                <>
                    ¿Ya tienes cuenta?{" "}
                    <Link href="/login" className="font-bold text-blue-700 underline-offset-2 hover:underline">
                        Inicia sesión
                    </Link>
                </>
            }
        >
            <GoogleButton
                label="Registrarme con Google"
                loading={googleLoading}
                onClick={async () => {
                    setGoogleLoading(true)
                    await signInWithGoogle()
                }}
            />

            <Divider />

            <form onSubmit={handleRegister} className="space-y-3" noValidate>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Nombre</span>
                    <input type="text" autoComplete="name" value={name} onChange={(e) => setName(e.target.value)} required className={inputClass} />
                </label>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Correo</span>
                    <input type="email" autoComplete="email" inputMode="email" value={email} onChange={(e) => setEmail(e.target.value)} required className={inputClass} />
                </label>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Contraseña</span>
                    <input
                        type="password"
                        autoComplete="new-password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                        required
                        aria-describedby="pw-rules"
                        className={inputClass}
                    />
                </label>
                <ul id="pw-rules" className="flex flex-wrap gap-x-4 gap-y-1 px-1">
                    <Rule ok={hasMinLength}>8 caracteres</Rule>
                    <Rule ok={hasNumber}>Un número</Rule>
                    <Rule ok={hasUppercase}>Una mayúscula</Rule>
                </ul>
                <label className="block">
                    <span className="mb-1.5 block text-sm font-semibold text-slate-700">Repite la contraseña</span>
                    <input
                        type="password"
                        autoComplete="new-password"
                        value={confirmPassword}
                        onChange={(e) => setConfirmPassword(e.target.value)}
                        required
                        aria-invalid={confirmPassword !== "" && !passwordsMatch}
                        className={cn(inputClass, confirmPassword !== "" && !passwordsMatch && "border-red-400 focus:border-red-500 focus:ring-red-500/15")}
                    />
                </label>
                {confirmPassword !== "" && !passwordsMatch && <p className="px-1 text-xs font-medium text-red-700">Las contraseñas no coinciden.</p>}

                {error && (
                    <p role="alert" className="rounded-xl bg-red-50 px-3 py-2.5 text-sm font-medium text-red-800">
                        {error}
                    </p>
                )}

                <button
                    type="submit"
                    disabled={loading || !isFormValid}
                    className="mt-2 flex h-12 w-full items-center justify-center rounded-xl border-b-4 border-blue-800 bg-blue-600 text-base font-black text-white transition-[background-color,transform] hover:bg-blue-700 active:translate-y-0.5 active:border-b-2 disabled:cursor-not-allowed disabled:border-b-0 disabled:bg-slate-300 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                >
                    {loading ? <Loader2 className="h-5 w-5 animate-spin" aria-label="Creando cuenta" /> : "Crear mi cuenta"}
                </button>
            </form>
        </AuthShell>
    )
}
