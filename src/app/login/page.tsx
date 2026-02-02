"use client"

import { useState } from "react"
import { useAuth } from "@/context/auth-provider"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardHeader, CardTitle, CardFooter } from "@/components/ui/card"
import { Loader2, Chrome } from "lucide-react"
import Link from "next/link"
import { useRouter } from "next/navigation"

export default function LoginPage() {
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)
    const { signInWithEmail, signInWithGoogle } = useAuth()
    const router = useRouter()

    const handleEmailLogin = async (e: React.FormEvent) => {
        e.preventDefault()
        setLoading(true)
        setError(null)
        try {
            const { error } = await signInWithEmail(email, password)
            if (error) {
                setError("Correo o contraseña incorrectos")
            }
        } catch (err) {
            setError("Ocurrió un error al intentar iniciar sesión")
        } finally {
            setLoading(false)
        }
    }

    return (
        <div className="min-h-screen flex items-center justify-center bg-slate-950 p-4">
            <Card className="w-full max-w-md bg-slate-900 border-slate-800 text-white shadow-2xl rounded-3xl overflow-hidden">
                <CardHeader className="pt-10 pb-6 text-center">
                    <CardTitle className="text-3xl font-bold tracking-tight">Iniciar Sesión</CardTitle>
                </CardHeader>
                <CardContent className="space-y-6 px-8">
                    <form onSubmit={handleEmailLogin} className="space-y-4">
                        <div className="space-y-2">
                            <Input
                                type="email"
                                placeholder="Correo Electrónico"
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                required
                                className="bg-slate-800 border-slate-700 text-white placeholder:text-slate-500 h-14 rounded-xl focus:ring-blue-600 focus:border-blue-600"
                            />
                        </div>
                        <div className="space-y-2">
                            <Input
                                type="password"
                                placeholder="Contraseña"
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                required
                                className="bg-slate-800 border-slate-700 text-white placeholder:text-slate-500 h-14 rounded-xl focus:ring-blue-600 focus:border-blue-600"
                            />
                        </div>

                        {error && (
                            <p className="text-sm text-red-400 text-center animate-pulse">{error}</p>
                        )}

                        <Button
                            type="submit"
                            disabled={loading}
                            className="w-full h-14 bg-slate-800 hover:bg-slate-700 text-slate-200 font-black text-lg uppercase tracking-widest transition-all active:scale-95 disabled:opacity-50 border-b-4 border-slate-950 rounded-xl"
                        >
                            {loading ? <Loader2 className="mr-2 h-5 w-5 animate-spin" /> : "INGRESAR"}
                        </Button>
                    </form>

                    <div className="relative flex items-center py-2">
                        <div className="flex-grow border-t border-slate-800"></div>
                        <span className="flex-shrink mx-4 text-slate-500 text-sm">o</span>
                        <div className="flex-grow border-t border-slate-800"></div>
                    </div>

                    <Button
                        variant="outline"
                        type="button"
                        onClick={() => signInWithGoogle()}
                        className="w-full h-14 bg-white text-slate-900 hover:bg-slate-100 border-none font-bold text-lg rounded-xl flex items-center justify-center gap-3 transition-all active:scale-95"
                    >
                        <Chrome className="w-6 h-6 text-blue-600" />
                        Continuar con Google
                    </Button>
                </CardContent>
                <CardFooter className="pb-10 pt-4 flex flex-col gap-2">
                    <div className="text-sm text-slate-400 text-center">
                        ¿No tienes cuenta?{" "}
                        <Link href="/register" className="text-yellow-500 font-bold hover:underline">
                            Regístrate aquí
                        </Link>
                    </div>
                    <Link
                        href="/"
                        className="text-xs text-slate-600 hover:text-slate-400 transition-colors text-center mt-2"
                    >
                        Volver al inicio
                    </Link>
                </CardFooter>
            </Card>
        </div>
    )
}
