"use client"

import { useEffect, useState } from "react"
import { useRouter, useSearchParams } from "next/navigation"
import { exchangeAuthCode } from "@/app/actions/auth"
import { Loader2 } from "lucide-react"

export default function AuthCallbackPage() {
    const router = useRouter()
    const searchParams = useSearchParams()
    const [error, setError] = useState<string | null>(null)

    useEffect(() => {
        const handleCallback = async () => {
            const code = searchParams.get("code")
            const next = searchParams.get("next") ?? "/app"

            if (!code) {
                // No code, redirect to home or login
                router.replace("/")
                return
            }

            try {
                const result = await exchangeAuthCode(code)

                if (result.error) {
                    setError(result.error)
                    // Redirect to error page after a delay or show error button
                    setTimeout(() => router.replace("/login?error=auth_exchange_failed"), 3000)
                } else {
                    // Success! Redirect to the destination
                    router.refresh() // Refresh to update auth state in context
                    router.replace(next)
                }
            } catch (err) {
                console.error("Callback error:", err)
                setError("Ocurrió un error inesperado al iniciar sesión.")
            }
        }

        handleCallback()
    }, [router, searchParams])

    if (error) {
        return (
            <div className="flex h-screen w-full flex-col items-center justify-center bg-slate-50 gap-4">
                <div className="bg-white p-8 rounded-xl shadow-lg max-w-md w-full text-center">
                    <div className="text-red-500 mb-4 font-bold text-xl">Algo salió mal</div>
                    <p className="text-slate-600 mb-6">{error}</p>
                    <p className="text-sm text-slate-400">Redirigiendo al inicio...</p>
                </div>
            </div>
        )
    }

    return (
        <div className="flex h-screen w-full flex-col items-center justify-center bg-slate-50 gap-6">
            <div className="flex flex-col items-center animate-in fade-in zoom-in duration-500">
                <div className="relative mb-8">
                    <div className="absolute inset-0 bg-blue-500 blur-xl opacity-20 rounded-full animate-pulse"></div>
                    <div className="h-20 w-20 bg-white rounded-2xl shadow-xl flex items-center justify-center relative z-10 border border-slate-100">
                        <Loader2 className="h-10 w-10 text-blue-600 animate-spin" />
                    </div>
                </div>

                <h1 className="text-2xl font-bold text-slate-900 mb-2">
                    Iniciando sesión...
                </h1>
                <p className="text-slate-500 animate-pulse">
                    Preparando tu espacio de estudio
                </p>
            </div>
        </div>
    )
}
