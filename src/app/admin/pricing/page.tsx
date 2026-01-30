"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { updatePlanPrice } from "@/app/actions/admin-pricing"
import { Loader2 } from "lucide-react"

type Plan = {
    id: string
    name: string
    tier: string
    price_clp: number
}

export default function AdminPricingPage() {
    const [plans, setPlans] = useState<Plan[]>([])
    const [loading, setLoading] = useState(true)
    const [updating, setUpdating] = useState<string | null>(null)
    const [prices, setPrices] = useState<Record<string, number>>({})

    useEffect(() => {
        const fetchPlans = async () => {
            const supabase = createClient()
            const { data } = await supabase
                .from('plans')
                .select('*')
                .order('price_clp')

            if (data) {
                setPlans(data)
                const initialPrices: Record<string, number> = {}
                data.forEach(plan => {
                    initialPrices[plan.tier] = plan.price_clp
                })
                setPrices(initialPrices)
            }
            setLoading(false)
        }

        fetchPlans()
    }, [])

    const handleUpdate = async (tier: string) => {
        setUpdating(tier)
        const newPrice = prices[tier]

        const result = await updatePlanPrice(tier, newPrice)

        if (result.success) {
            alert('Precio actualizado correctamente')
        } else {
            alert('Error al actualizar precio')
        }
        setUpdating(null)
    }

    if (loading) return <div className="p-8"><Loader2 className="animate-spin" /></div>

    // Fallback if no plans found
    if (plans.length === 0) {
        return (
            <div className="space-y-6">
                <h2 className="text-2xl font-bold">Gestión de Precios</h2>
                <div className="bg-yellow-50 p-4 rounded-md border border-yellow-200 text-yellow-800">
                    No se encontraron planes en la base de datos. Asegúrate de ejecutar la migración.
                </div>
            </div>
        )
    }

    return (
        <div className="space-y-8 max-w-4xl">
            <h2 className="text-2xl font-bold text-slate-900">Gestión de Precios</h2>

            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                {plans.filter(p => p.tier !== 'free').map((plan) => (
                    <Card key={plan.id}>
                        <CardHeader>
                            <CardTitle className="flex justify-between items-center">
                                {plan.name}
                                <span className={`text-xs px-2 py-1 rounded-full ${plan.tier === 'premium' ? 'bg-yellow-100 text-yellow-800' : 'bg-purple-100 text-purple-800'
                                    }`}>
                                    {plan.tier.toUpperCase()}
                                </span>
                            </CardTitle>
                        </CardHeader>
                        <CardContent className="space-y-4">
                            <div className="space-y-2">
                                <label className="text-sm font-medium text-slate-500">Precio (CLP)</label>
                                <Input
                                    type="number"
                                    value={prices[plan.tier]}
                                    onChange={(e) => setPrices(prev => ({ ...prev, [plan.tier]: parseInt(e.target.value) || 0 }))}
                                />
                            </div>
                            <Button
                                className="w-full"
                                onClick={() => handleUpdate(plan.tier)}
                                disabled={updating === plan.tier}
                            >
                                {updating === plan.tier ? <Loader2 className="animate-spin mr-2 h-4 w-4" /> : null}
                                Guardar Cambios
                            </Button>
                        </CardContent>
                    </Card>
                ))}
            </div>
        </div>
    )
}
