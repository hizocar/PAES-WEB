"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { createSubscriptionPreference } from "@/app/actions/subscription"
import { Loader2 } from "lucide-react"

interface PlanButtonProps {
    planId: string
    tier: string
    isSignature?: boolean
}

export function PlanButton({ planId, tier, isSignature }: PlanButtonProps) {
    const [loading, setLoading] = useState(false)

    const handleSubscribe = async () => {
        if (loading || isSignature) return

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
            disabled={loading || tier === 'signature'}
            className={`w-full ${tier === 'signature'
                ? 'bg-slate-900 hover:bg-slate-800 text-white cursor-default'
                : 'bg-blue-600 hover:bg-blue-700 text-white shadow-lg shadow-blue-200'
                }`}
        >
            {loading ? (
                <Loader2 className="h-4 w-4 animate-spin" />
            ) : tier === 'signature' ? (
                'Próximamente'
            ) : (
                'Elegir Plan'
            )}
        </Button>
    )
}
