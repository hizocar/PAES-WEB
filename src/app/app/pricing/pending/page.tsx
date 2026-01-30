"use client"

import { Clock, AlertCircle, ArrowLeft } from "lucide-react"
import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function PendingPage() {
    return (
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-8 text-center px-4">
            <div className="bg-yellow-100 p-6 rounded-full">
                <Clock className="h-20 w-20 text-yellow-600" />
            </div>

            <div>
                <h1 className="text-4xl font-extrabold text-slate-900 mb-4">Pago Pendiente</h1>
                <p className="text-xl text-slate-600 max-w-md mx-auto">
                    Tu pago está siendo procesado por Mercado Pago. Esto puede tardar unos minutos o hasta 48 horas dependiendo del método elegido.
                </p>
            </div>

            <div className="bg-blue-50 border border-blue-100 p-6 rounded-2xl max-w-md w-full flex items-start gap-4 text-left">
                <AlertCircle className="h-6 w-6 text-blue-600 shrink-0 mt-0.5" />
                <div>
                    <h3 className="font-bold text-blue-900 mb-1">¿Cuándo se activará mi plan?</h3>
                    <p className="text-sm text-blue-800">
                        Tan pronto como recibamos la confirmación del pago, tu cuenta se actualizará automáticamente a Premium. Te enviaremos un correo cuando esto suceda.
                    </p>
                </div>
            </div>

            <Link href="/app">
                <Button size="lg" className="bg-blue-600 hover:bg-blue-700 text-white px-8 h-14 text-lg rounded-2xl shadow-xl shadow-blue-200 flex items-center gap-2">
                    <ArrowLeft className="h-5 w-5" />
                    Volver al Inicio
                </Button>
            </Link>
        </div>
    )
}
