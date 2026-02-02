"use client"

import { useState } from "react"
import { useAuth } from "@/context/auth-provider"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardHeader, CardTitle, CardFooter } from "@/components/ui/card"
import { Loader2, Chrome } from "lucide-react"
import Link from "next/link"
import { useRouter } from "next/navigation"

export default function RegisterPage() {
    const [email, setEmail] = useState("")
    const [password, setPassword] = useState("")
    const [confirmPassword, setConfirmPassword] = useState("")
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState<string | null>(null)
    const [success, setSuccess] = useState(false)
    const { signUpWithEmail, signInWithGoogle } = useAuth()
    const router = useRouter()

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault()
        if (password !== confirmPassword) {
            setError("Las contraseñas no coinciden")
            return
        }
        if (password.length < 6) {
            setError("La contraseña debe tener al menos 6 caracteres")
            return
        }

        setLoading(true)
        setError(null)
        try {
            const { error } = await signUpWithEmail(email, password)
            if (error) {
                setError(error.message || "Error al registrarse")
            } else {
                setSuccess(true)
            }
        } catch (err) {
            setError("Ocurrió un error al intentar registrarse")
        } finally {
            setLoading(false)
        }
    }

    if (success) {
        return (
            <div className="min-h-screen flex items-center justify-center bg-slate-950 p-4">
                <Card className="w-full max-w-md bg-slate-900 border-slate-800 text-white p-8 text-center rounded-3xl">
                    <CardHeader>
                        <CardTitle className="text-2xl font-bold">¡Casi listo!</CardTitle>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        <p className="text-slate-400">
                            Hemos enviado un enlace de confirmación a <span className="text-blue-400 font-bold">{email}</span>.
                        </p>
                        <p className="text-sm text-slate-500">
                            Revisa tu bandeja de entrada para activar tu cuenta y empezar a practicar.
                        </p>
                    </CardContent>
                    <CardFooter>
                        <Button
                            onClick={() => router.push("/login")}
                            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold h-12 rounded-xl"
                        >
                            Ir al Inicio de Sesión
                        </Button>
                    </CardFooter>
                </Card>
            </div>
        )
    }

    return (
        <div className="min-h-screen flex items-center justify-center bg-slate-950 p-4">
            <Card className="w-full max-w-md bg-slate-900 border-slate-800 text-white shadow-2xl rounded-3xl overflow-hidden">
                <CardHeader className="pt-10 pb-6 text-center">
                    <CardTitle className="text-3xl font-bold tracking-tight">Crear Cuenta</CardTitle>
                </CardHeader>
                <CardContent className="space-y-6 px-8">
                    <form onSubmit={handleRegister} className="space-y-4">
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
                        <div className="space-y-2">
                            <Input
                                type="password"
                                placeholder="Confirmar Contraseña"
                                value={confirmPassword}
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                required
                                className="bg-slate-800 border-slate-700 text-white placeholder:text-slate-500 h-14 rounded-xl focus:ring-blue-600 focus:border-blue-600"
                            />
                        </div>

                        {error && (
                            <p className="text-sm text-red-400 text-center">{error}</p>
                        )}

                        <Button
                            type="submit"
                            disabled={loading}
                            className="w-full h-14 bg-slate-800 hover:bg-slate-700 text-slate-200 font-black text-lg uppercase tracking-widest transition-all active:scale-95 disabled:opacity-50 border-b-4 border-slate-950 rounded-xl"
                        >
                            {loading ? <Loader2 className="mr-2 h-5 w-5 animate-spin" /> : "REGISTRARME"}
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
                        Registrarse con Google
                    </Button>
                </CardContent>
                <CardFooter className="pb-10 pt-4 flex flex-col gap-2">
                    <div className="text-sm text-slate-400 text-center">
                        ¿Ya tienes cuenta?{" "}
                        <Link href="/login" className="text-yellow-500 font-bold hover:underline">
                            Inicia sesión aquí
                        </Link>
                    </div>
                </CardFooter>
            </Card>
        </div>
    )
}
