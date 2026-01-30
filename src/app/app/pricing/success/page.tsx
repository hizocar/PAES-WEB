"use client"

import { useEffect, useState, Suspense } from "react"
import { useSearchParams, useRouter } from "next/navigation"
import { updateUserSubscription } from "@/app/actions/subscription"
import { CheckCircle2, Loader2, ArrowRight } from "lucide-react"
import { Button } from "@/components/ui/button"
import Link from "next/link"

function SuccessContent() {
    const searchParams = useSearchParams()
    const router = useRouter()
    const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading')
    const [message, setMessage] = useState('Procesando tu suscripción...')

    useEffect(() => {
        const handleSuccess = async () => {
            const paymentId = searchParams.get('payment_id')
            const paymentStatus = searchParams.get('status')
            const externalReference = searchParams.get('external_reference')

            if (!paymentStatus || paymentStatus !== 'approved') {
                setStatus('error')
                setMessage('El pago no fue aprobado o los datos son inválidos.')
                return
            }

            try {
                const result = await updateUserSubscription(
                    paymentId || 'n/a',
                    paymentStatus,
                    externalReference || ''
                )

                if (result.success) {
                    setStatus('success')
                    setMessage(`¡Bienvenido al plan ${result.tier}!`)
                    // Refresh the page/auth state
                    router.refresh()
                } else {
                    setStatus('error')
                    setMessage(result.error || 'Error al actualizar tu suscripción.')
                }
            } catch (error) {
                console.error("Error confirmando pago:", error)
                setStatus('error')
                setMessage('Ocurrió un error inesperado al procesar tu pago.')
            }
        }

        handleSuccess()
    }, [searchParams, router])

    if (status === 'loading') {
        return (
            <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
                <Loader2 className="h-12 w-12 text-blue-600 animate-spin" />
                <h1 className="text-2xl font-bold text-slate-900">Confirmando tu pago</h1>
                <p className="text-slate-500">{message}</p>
            </div>
        )
    }

    if (status === 'error') {
        return (
            <div className="flex flex-col items-center justify-center min-h-[60vh] gap-6 text-center px-4">
                <div className="bg-red-100 p-4 rounded-full">
                    <CheckCircle2 className="h-12 w-12 text-red-600 rotate-180" />
                </div>
                <div>
                    <h1 className="text-3xl font-bold text-slate-900 mb-2">Algo salió mal</h1>
                    <p className="text-slate-500 max-w-md">{message}</p>
                </div>
                <div className="flex gap-4">
                    <Link href="/app/pricing">
                        <Button variant="outline">Reintentar</Button>
                    </Link>
                    <Link href="/app">
                        <Button>Ir al Inicio</Button>
                    </Link>
                </div>
            </div>
        )
    }

    return (
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-8 text-center px-4 animate-in fade-in zoom-in duration-500">
            <div className="relative">
                <div className="absolute inset-0 bg-green-500 blur-2xl opacity-20 rounded-full animate-pulse"></div>
                <div className="bg-green-100 p-6 rounded-full relative z-10">
                    <CheckCircle2 className="h-20 w-20 text-green-600" />
                </div>
            </div>

            <div>
                <h1 className="text-4xl font-extrabold text-slate-900 mb-4">¡Pago Exitoso!</h1>
                <p className="text-xl text-slate-600 max-w-md mx-auto">
                    {message} Ahora tienes acceso desbloqueado a todas las herramientas de PAES Lab.
                </p>
            </div>

            <div className="bg-blue-50 border border-blue-100 p-6 rounded-2xl max-w-md w-full">
                <h3 className="font-bold text-blue-900 mb-2">Próximos pasos</h3>
                <ul className="text-left text-sm text-blue-800 space-y-2">
                    <li className="flex gap-2">
                        <div className="h-5 w-5 rounded-full bg-blue-200 flex items-center justify-center text-[10px] font-bold">1</div>
                        Explora los nuevos ejes temáticos
                    </li>
                    <li className="flex gap-2">
                        <div className="h-5 w-5 rounded-full bg-blue-200 flex items-center justify-center text-[10px] font-bold">2</div>
                        Usa las explicaciones ilimitadas
                    </li>
                    <li className="flex gap-2">
                        <div className="h-5 w-5 rounded-full bg-blue-200 flex items-center justify-center text-[10px] font-bold">3</div>
                        ¡Aprende sin límites!
                    </li>
                </ul>
            </div>

            <Link href="/app">
                <Button size="lg" className="bg-blue-600 hover:bg-blue-700 text-white px-8 h-14 text-lg rounded-2xl shadow-xl shadow-blue-200 group flex items-center gap-2">
                    Comenzar a Estudiar
                    <ArrowRight className="h-5 w-5 group-hover:translate-x-1 transition-transform" />
                </Button>
            </Link>
        </div>
    )
}

export default function SuccessPage() {
    return (
        <Suspense fallback={
            <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
                <Loader2 className="h-12 w-12 text-blue-600 animate-spin" />
                <h1 className="text-2xl font-bold text-slate-900">Cargando...</h1>
            </div>
        }>
            <SuccessContent />
        </Suspense>
    )
}
