"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { createSubscriptionPreference, cancelSubscription } from "@/app/actions/subscription"
import { Loader2, AlertTriangle } from "lucide-react"

interface PlanButtonProps {
    planId: string
    tier: string
    currentTier: string
    isSignature?: boolean
}

export function PlanButton({ planId, tier, currentTier, isSignature }: PlanButtonProps) {
    const [loading, setLoading] = useState(false)

    const handleSubscribe = async () => {
        if (loading || isSignature) return

        // 1. Logic for CANCELLATION (Downgrade to Free)
        if (tier === 'free') {
            const confirm1 = confirm("¿Estás 100% seguro de que quieres volver al plan Free?\n\nPerderás tus vidas ilimitadas, explicaciones infinitas y el Modo Repaso con IA inmediatamente. Tu futuro universitario merece lo mejor.")
            if (!confirm1) return

            const confirm2 = confirm("¡Última oportunidad! Si cancelas ahora, Mercado Pago detendrá tus cobros automáticos y volverás a tener límites diarios. ¿Confirmar cancelación?")
            if (!confirm2) return

            setLoading(true)
            try {
                const result = await cancelSubscription()
                if (result.error) {
                    alert("Error: " + result.error)
                } else {
                    alert("Suscripción cancelada. Tu cuenta ahora es Free.")
                    window.location.reload()
                }
            } catch (e) {
                alert("Ocurrió un error al procesar la cancelación.")
            } finally {
                setLoading(false)
            }
            return
        }

        // 2. Logic for SUBSCRIBING (Premium)
        setLoading(true)
        try {
            const result = await createSubscriptionPreference(planId)

            if (result.error) {
                alert(result.error)
                return
            }

            if (result.url) {
                window.location.href = result.url
            }
        } catch (error) {
            console.error("Error subscribing:", error)
            alert("Ocurrió un error inesperado. Por favor intenta de nuevo.")
        } finally {
            setLoading(false)
        }
    }

    return (
        <Button
            onClick={handleSubscribe}
            disabled={loading || tier === 'signature' || (tier === 'free' && currentTier === 'free')}
            className={`w-full font-bold shadow-md transition-all ${tier === 'free'
                    ? 'bg-white text-slate-600 border border-slate-200 hover:bg-slate-50'
                    : tier === 'signature'
                        ? 'bg-slate-900 hover:bg-slate-800 text-white cursor-default'
                        : 'bg-blue-600 hover:bg-blue-700 text-white shadow-blue-200'
                }`}
        >
            {loading ? (
                <Loader2 className="h-4 w-4 animate-spin" />
            ) : tier === 'signature' ? (
                'Próximamente'
            ) : tier === 'free' ? (
                'Elegir Plan'
            ) : (
                'Elegir Plan'
            )}
        </Button>
    )
}
