import { Check } from "lucide-react"
import { Button } from "@/components/ui/button"
import { LoginButton } from "@/components/auth/login-button"

interface Plan {
    id: string
    name: string
    tier: string
    price_clp: number
    features: string[]
}

const DEFAULT_PLANS: Plan[] = [
    {
        id: 'free',
        name: 'Free',
        tier: 'free',
        price_clp: 0,
        features: ['Acceso a M1 y M2', '10 Vidas diarias', '5 Explicaciones diarias', 'Ranking nacional'],
    },
    {
        id: 'premium',
        name: 'Premium',
        tier: 'premium',
        price_clp: 1990,
        features: ['Acceso a M1 y M2', 'Vidas ilimitadas (∞)', 'Explicaciones ilimitadas (∞)', 'IA: Modo Repaso Inteligente', 'Sin publicidad'],
    },
    {
        id: 'signature',
        name: 'Signature',
        tier: 'signature',
        price_clp: 29990,
        features: ['Acceso a M1 y M2', 'Todo lo de Premium', 'Clases personalizadas', 'Ensayos semanales', 'Plan de estudio a medida'],
    }
]

export function PricingSection({ plans = DEFAULT_PLANS }: { plans?: Plan[] }) {
    return (
        <section id="pricing" className="py-24 md:py-32 bg-slate-50 relative overflow-hidden">
            {/* Background elements */}
            <div className="absolute top-0 right-0 w-[500px] h-[500px] bg-blue-100/30 rounded-full blur-3xl -translate-y-1/2 translate-x-1/2" />
            <div className="absolute bottom-0 left-0 w-[500px] h-[500px] bg-purple-100/30 rounded-full blur-3xl translate-y-1/2 -translate-x-1/2" />

            <div className="container mx-auto px-6 relative z-10">
                <div className="text-center mb-16 md:mb-24 max-w-3xl mx-auto">
                    <h2 className="text-4xl md:text-6xl font-black text-slate-900 mb-6 tracking-tight">
                        Elige tu camino al <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-600">Éxito</span>
                    </h2>
                    <p className="text-xl text-slate-600 font-medium leading-relaxed">
                        Planes diseñados para que nada te detenga. <br className="hidden md:block" />
                        Empieza gratis y escala cuando estés listo para el máximo puntaje.
                    </p>
                </div>

                <div className="grid md:grid-cols-3 gap-8 max-w-6xl mx-auto items-stretch">
                    {plans.map((plan) => {
                        const isPremium = plan.tier === 'premium'
                        const isSignature = plan.tier === 'signature'

                        return (
                            <div
                                key={plan.tier}
                                className={`relative group bg-white rounded-[2.5rem] p-10 border transition-all duration-500 hover:-translate-y-2 flex flex-col ${isPremium ? 'border-blue-200 shadow-[0_20px_50px_rgba(59,130,246,0.15)] ring-4 ring-blue-50' :
                                    isSignature ? 'border-purple-200 shadow-xl' :
                                        'border-slate-100 shadow-xl shadow-slate-200/50'
                                    }`}
                            >
                                {isPremium && (
                                    <div className="absolute -top-5 left-1/2 -translate-x-1/2 bg-gradient-to-r from-blue-600 to-indigo-600 text-white text-[10px] md:text-xs font-black px-6 py-2 rounded-full tracking-widest uppercase shadow-xl z-20 border-2 border-white">
                                        LO MÁS POPULAR
                                    </div>
                                )}

                                {isSignature && (
                                    <div className="absolute -top-5 left-1/2 -translate-x-1/2 bg-slate-200 text-slate-600 text-[10px] md:text-xs font-black px-6 py-2 rounded-full tracking-widest uppercase z-20 border-2 border-white">
                                        PRÓXIMAMENTE
                                    </div>
                                )}

                                <div className="mb-8">
                                    <div className={`w-14 h-14 rounded-2xl flex items-center justify-center mb-6 ${isPremium ? 'bg-blue-100 text-blue-600' :
                                        isSignature ? 'bg-purple-100 text-purple-600' :
                                            'bg-slate-100 text-slate-600'
                                        }`}>
                                        {isPremium ? (
                                            <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M11.3 1.047a1 1 0 01.4 1.187l-2.113 5.469h4.914a1 1 0 01.893 1.447l-6 11A1 1 0 018 18.13V12.67l-4.914.077a1 1 0 01-.893-1.447l6-11a1 1 0 011.107-.253z" clipRule="evenodd" /></svg>
                                        ) : isSignature ? (
                                            <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 20 20"><path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM9.555 7.168A1 1 0 008 8v4a1 1 0 001.555.832l3-2a1 1 0 000-1.664l-3-2z" clipRule="evenodd" /></svg>
                                        ) : (
                                            <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 20 20"><path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" /></svg>
                                        )}
                                    </div>
                                    <h3 className={`text-2xl font-black mb-2 ${isSignature ? 'text-purple-600' : 'text-slate-900'}`}>
                                        {plan.name}
                                    </h3>
                                    <div className="flex items-baseline gap-1">
                                        <span className="text-4xl md:text-5xl font-black text-slate-900 tracking-tighter">
                                            ${plan.price_clp.toLocaleString('es-CL')}
                                        </span>
                                        <span className="text-slate-400 font-bold">/mes</span>
                                    </div>
                                    {isPremium && (
                                        <div className="flex items-center gap-2 mt-3">
                                            <span className="text-xs font-bold text-blue-600 bg-blue-50 px-2 py-1 rounded-lg">
                                                -75% OFF
                                            </span>
                                            <span className="text-xs font-bold text-slate-400 line-through">
                                                $7.990
                                            </span>
                                        </div>
                                    )}
                                </div>

                                <ul className="space-y-4 mb-10 flex-1">
                                    {plan.features.map((feature, i) => (
                                        <li key={i} className="flex items-start gap-3">
                                            <div className={`mt-1 rounded-full p-0.5 ${isSignature ? 'bg-purple-100 text-purple-600' : 'bg-blue-500 text-white'}`}>
                                                <Check size={12} strokeWidth={4} />
                                            </div>
                                            <span className="text-[15px] font-semibold text-slate-600 leading-tight">
                                                {feature}
                                            </span>
                                        </li>
                                    ))}
                                </ul>

                                <LoginButton
                                    size="lg"
                                    disabled={isSignature}
                                    onClick={() => {
                                        if (isPremium && (window as any).fbq) {
                                            (window as any).fbq("track", "InitiateCheckout", {
                                                content_name: 'Premium Plan (Landing)',
                                                value: 1990.00,
                                                currency: 'CLP'
                                            })
                                        }
                                    }}
                                    className={`w-full h-16 rounded-[1.25rem] font-black text-lg transition-all border-b-4 active:border-b-0 active:translate-y-1 ${isPremium ? 'bg-blue-600 hover:bg-blue-700 text-white border-blue-800 shadow-xl shadow-blue-200' :
                                        isSignature ? 'bg-slate-50 text-slate-400 border-slate-200 cursor-not-allowed' :
                                            'bg-slate-100 hover:bg-slate-200 text-slate-900 border-slate-300'
                                        }`}
                                >
                                    {isSignature ? 'Próximamente 🔒' : '¡Empezar Ya! 🚀'}
                                </LoginButton>
                            </div>
                        )
                    })}
                </div>

                <div className="mt-20 text-center bg-white border border-slate-100 p-6 md:p-8 rounded-[2rem] max-w-2xl mx-auto shadow-sm">
                    <p className="text-slate-600 text-sm md:text-base font-medium">
                        💡 Todos los planes incluyen acceso a M1 y M2. <br />
                        ¿Necesitas ayuda? <a href="mailto:hola@paeslab.cl" className="text-blue-600 underline font-extrabold hover:text-blue-700 transition-colors">Escríbenos</a>
                    </p>
                </div>
            </div>
        </section>
    )
}
