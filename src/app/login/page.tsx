"use client"

import { Button } from "@/components/ui/button"
import { useAuth } from "@/context/auth-provider"
import { Play } from "lucide-react"

export default function LoginPage() {
    const { signInWithGoogle } = useAuth()

    return (
        <div className="flex min-h-screen flex-col items-center justify-center bg-slate-50 relative overflow-hidden">
            {/* Abstract Background Shapes */}
            <div className="absolute top-0 left-0 w-full h-full overflow-hidden z-0">
                <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] bg-blue-200/30 rounded-full blur-3xl" />
                <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-purple-200/30 rounded-full blur-3xl" />
            </div>

            <div className="w-full max-w-md space-y-8 rounded-2xl bg-white p-10 shadow-xl z-10 border border-slate-100">
                <div className="text-center">
                    <div className="mx-auto w-12 h-12 bg-blue-600 rounded-xl flex items-center justify-center mb-4 shadow-lg shadow-blue-600/20">
                        <Play className="text-white fill-white" size={24} />
                    </div>
                    <h2 className="mt-2 text-3xl font-bold tracking-tight text-slate-900">
                        PAES Lab
                    </h2>
                    <p className="mt-2 text-sm text-slate-600">
                        Plataforma de entrenamiento PAES
                    </p>
                </div>

                <div className="mt-8 space-y-6">
                    <div className="space-y-4">
                        <Button
                            variant="outline"
                            className="w-full h-12 text-base relative flex items-center justify-center gap-3 hover:bg-slate-50 transition-all border-slate-200"
                            onClick={() => signInWithGoogle()}
                        >
                            <img src="https://www.svgrepo.com/show/475656/google-color.svg" alt="Google" className="w-5 h-5" />
                            Iniciar sesión con Google
                        </Button>
                    </div>

                    <div className="text-center text-xs text-slate-400">
                        Al continuar, aceptas nuestros Términos de Servicio y Política de Privacidad.
                    </div>
                </div>
            </div>
        </div>
    )
}
