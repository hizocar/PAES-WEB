"use client"

import { XCircle, AlertCircle, ArrowLeft } from "lucide-react"
import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function FailurePage() {
    return (
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-8 text-center px-4">
            <div className="bg-red-100 p-6 rounded-full">
                <XCircle className="h-20 w-20 text-red-600" />
            </div>

            <div>
                <h1 className="text-4xl font-extrabold text-slate-900 mb-4">Pago no procesado</h1>
                <p className="text-xl text-slate-600 max-w-md mx-auto">
                    No pudimos completar la transacción. Esto puede deberse a fondos insuficientes, error en los datos de la tarjeta o cancelación del pago.
                </p>
            </div>

            <div className="bg-orange-50 border border-orange-100 p-6 rounded-2xl max-w-md w-full flex items-start gap-4">
                <AlertCircle className="h-6 w-6 text-orange-600 shrink-0 mt-0.5" />
                <div className="text-left">
                    <h3 className="font-bold text-orange-900 mb-1">¿Qué puedo hacer?</h3>
                    <p className="text-sm text-orange-800">
                        Intenta nuevamente con otro método de pago o revisa si tus datos son correctos. Si el problema persiste, contacta a tu banco.
                    </p>
                </div>
            </div>

            <div className="flex flex-col sm:flex-row gap-4 w-full max-w-md">
                <Link href="/app" className="flex-1">
                    <Button variant="outline" size="lg" className="w-full rounded-2xl h-12 flex items-center justify-center gap-2">
                        <ArrowLeft className="h-4 w-4" />
                        Ir al Inicio
                    </Button>
                </Link>
                <Link href="/app/pricing" className="flex-1">
                    <Button size="lg" className="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-2xl h-12 shadow-lg shadow-blue-100">
                        Reintentar Pago
                    </Button>
                </Link>
            </div>
        </div>
    )
}
