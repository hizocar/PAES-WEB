import { createClient } from "@/lib/supabase/server"
import { Check, X } from "lucide-react"
import { Button } from "@/components/ui/button"
import Link from "next/link"

export const dynamic = 'force-dynamic'

async function getPlans() {
    const supabase = createClient()
    const { data: plans } = await (await supabase)
        .from('plans')
        .select('*')
        .order('price_clp')

    return plans || []
}

async function getUserTier() {
    const supabase = createClient()
    const { data: { user } } = await (await supabase).auth.getUser()

    if (!user) return 'free'

    const { data: profile } = await (await supabase)
        .from('profiles')
        .select('subscription_tier')
        .eq('id', user.id)
        .single()

    return (profile as any)?.subscription_tier || 'free'
}

export default async function PricingPage() {
    const plans = await getPlans()
    const currentTier = await getUserTier()

    // Fallback if no plans in DB (e.g. migration not run yet)
    const displayPlans = plans.length > 0 ? plans : [
        {
            name: 'Free',
            tier: 'free',
            price_clp: 0,
            features: ['10 Vidas diarias', '5 Explicaciones diarias', 'Publicidad'],
        },
        {
            name: 'Premium',
            tier: 'premium',
            price_clp: 9990,
            features: ['Vidas ilimitadas', 'Explicaciones ilimitadas', 'Sin publicidad'],
        },
        {
            name: 'Signature',
            tier: 'signature',
            price_clp: 29990,
            features: ['Todo lo de Premium', 'Clases personalizadas', 'Ensayos semanales'],
        }
    ]

    return (
        <div className="container max-w-6xl mx-auto py-12 px-4">
            <div className="text-center mb-12">
                <h1 className="text-4xl font-extrabold text-slate-900 mb-4">Elige tu plan de estudio</h1>
                <p className="text-xl text-slate-600 max-w-2xl mx-auto">
                    Invierte en tu futuro con las mejores herramientas para preparar la PAES.
                </p>
            </div>

            <div className="grid md:grid-cols-3 gap-8">
                {displayPlans.map((plan: any) => {
                    const isCurrent = currentTier === plan.tier
                    const isPremium = plan.tier === 'premium'
                    const isSignature = plan.tier === 'signature'

                    return (
                        <div
                            key={plan.tier}
                            className={`relative bg-white rounded-2xl shadow-xl border overflow-hidden transition-transform hover:-translate-y-1 ${isCurrent ? 'border-blue-500 ring-2 ring-blue-500 ring-opacity-50' :
                                isSignature ? 'border-purple-200' :
                                    'border-slate-200'
                                }`}
                        >
                            {isCurrent && (
                                <div className="absolute top-0 right-0 bg-blue-500 text-white text-xs font-bold px-3 py-1 rounded-bl-lg z-10">
                                    TU PLAN ACTUAL
                                </div>
                            )}

                            {isPremium && !isCurrent && (
                                <div className="absolute top-0 right-0 bg-yellow-400 text-yellow-900 text-xs font-bold px-3 py-1 rounded-bl-lg z-10">
                                    RECOMENDADO
                                </div>
                            )}

                            <div className={`p-8 ${isSignature ? 'bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 text-white' :
                                'bg-white text-slate-900'
                                }`}>
                                <h3 className={`text-xl font-bold mb-2 ${isSignature ? 'text-white' : 'text-slate-900'}`}>
                                    {plan.name}
                                </h3>
                                <div className="flex items-baseline gap-1 mb-6">
                                    <span className={`text-4xl font-extrabold ${isSignature ? 'text-white' : 'text-slate-900'}`}>
                                        ${plan.price_clp.toLocaleString('es-CL')}
                                    </span>
                                    <span className={`text-sm font-medium ${isSignature ? 'text-slate-400' : 'text-slate-500'}`}>
                                        /mes
                                    </span>
                                </div>
                                <p className={`text-sm mb-6 ${isSignature ? 'text-slate-300' : 'text-slate-500'}`}>
                                    {plan.tier === 'free' ? 'Para comenzar a practicar.' :
                                        plan.tier === 'premium' ? 'Para quienes van en serio.' :
                                            'Para alcanzar el máximo puntaje.'}
                                </p>
                            </div>

                            <div className="p-8 bg-slate-50 h-full border-t border-slate-100">
                                <ul className="space-y-4 mb-8">
                                    {plan.features.map((feature: string, i: number) => (
                                        <li key={i} className="flex items-start gap-3 text-sm">
                                            <div className={`mt-0.5 rounded-full p-0.5 ${isSignature ? 'bg-purple-100 text-purple-600' :
                                                'bg-green-100 text-green-600'
                                                }`}>
                                                <Check size={14} strokeWidth={3} />
                                            </div>
                                            <span className="text-slate-700">{feature}</span>
                                        </li>
                                    ))}
                                </ul>

                                {isCurrent ? (
                                    <Button disabled className="w-full bg-slate-200 text-slate-500 hover:bg-slate-200 cursor-default">
                                        Plan Actual
                                    </Button>
                                ) : (
                                    <Button
                                        className={`w-full ${isSignature
                                            ? 'bg-slate-900 hover:bg-slate-800 text-white'
                                            : 'bg-blue-600 hover:bg-blue-700 text-white'
                                            }`}
                                    >
                                        {plan.tier === 'signature' ? 'Próximamente' : 'Elegir Plan'}
                                    </Button>
                                )}
                            </div>
                        </div>
                    )
                })}
            </div>
        </div>
    )
}
