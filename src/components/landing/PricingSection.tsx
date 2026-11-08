import Link from "next/link"
import { Check, Sparkles } from "lucide-react"

/**
 * Planes en la portada. Solo datos verificables: sin descuentos ni "más popular" inventados.
 * La monetización está pausada (PRODUCT.md, 2026-11-08); los montos se muestran como referencia.
 */
const FREE = ["M1 y M2 completas, con práctica por tema", "10 vidas por materia que se recargan solas", "5 explicaciones paso a paso al día", "Ensayos con puntaje PAES, ranking y logros"]
const PRO = ["Todo lo del plan gratis", "Vidas ilimitadas", "Explicaciones ilimitadas", "Sin anuncios para recargar vidas"]
const SIGNATURE = ["Todo lo de Pro", "Clases sincrónicas en vivo", "Clases asincrónicas en video"]

function Feature({ children }: { children: string }) {
    return (
        <li className="flex items-start gap-2.5 text-[15px] font-medium text-slate-700">
            <Check size={18} strokeWidth={3} className="mt-0.5 shrink-0 text-blue-600" aria-hidden />
            {children}
        </li>
    )
}

export function PricingSection() {
    return (
        <section id="pricing" className="scroll-mt-20 border-t border-slate-100 bg-white py-20 lg:py-28" aria-labelledby="pricing-title">
            <div className="mx-auto max-w-6xl px-4 sm:px-6">
                <h2 id="pricing-title" className="max-w-2xl text-3xl font-black tracking-tight text-slate-900 text-balance md:text-4xl">
                    Gratis para empezar
                </h2>
                <p className="mt-3 max-w-2xl text-lg text-slate-600">
                    Todo lo que necesitas para practicar está en el plan gratis. Pro suma vidas y explicaciones sin límite.
                </p>

                <div className="mt-10 grid gap-4 md:grid-cols-3">
                    <div className="flex flex-col rounded-2xl border-2 border-slate-200 p-6">
                        <h3 className="text-xl font-black text-slate-900">Gratis</h3>
                        <p className="mt-2 flex items-baseline gap-1">
                            <span className="text-4xl font-black tracking-tight text-slate-900 tabular-nums">$0</span>
                            <span className="font-bold text-slate-600">/mes</span>
                        </p>
                        <ul className="mt-6 flex-1 space-y-3">
                            {FREE.map((f) => <Feature key={f}>{f}</Feature>)}
                        </ul>
                        <Link
                            href="/register"
                            className="mt-8 inline-flex h-12 items-center justify-center rounded-2xl border-b-4 border-blue-800 bg-blue-600 font-black text-white transition-[background-color,transform] duration-150 hover:bg-blue-700 active:translate-y-0.5 active:border-b-2 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                        >
                            Empieza gratis
                        </Link>
                    </div>

                    <div className="flex flex-col rounded-2xl border-2 border-blue-200 bg-blue-50/40 p-6">
                        <h3 className="text-xl font-black text-slate-900">Pro</h3>
                        <p className="mt-2 flex items-baseline gap-1">
                            <span className="text-4xl font-black tracking-tight text-slate-900 tabular-nums">$990</span>
                            <span className="font-bold text-slate-600">/mes</span>
                        </p>
                        <ul className="mt-6 flex-1 space-y-3">
                            {PRO.map((f) => <Feature key={f}>{f}</Feature>)}
                        </ul>
                        <p className="mt-8 text-sm font-semibold text-slate-600">Se activa desde tu cuenta, cuando lo necesites.</p>
                    </div>
                    <div className="flex flex-col rounded-2xl border-2 border-dashed border-slate-300 p-6">
                        <div className="flex items-center justify-between gap-2">
                            <h3 className="text-xl font-black text-slate-900">Signature</h3>
                            <span className="inline-flex items-center gap-1 rounded-full bg-violet-50 px-2.5 py-1 text-xs font-bold text-violet-700">
                                <Sparkles size={13} aria-hidden /> Próximamente
                            </span>
                        </div>
                        <p className="mt-2 flex items-baseline gap-1">
                            <span className="text-4xl font-black tracking-tight text-slate-900 tabular-nums">$29.990</span>
                            <span className="font-bold text-slate-600">/mes</span>
                        </p>
                        <ul className="mt-6 flex-1 space-y-3">
                            {SIGNATURE.map((f) => <Feature key={f}>{f}</Feature>)}
                        </ul>
                        <p className="mt-8 text-sm font-semibold text-slate-600">Aún no disponible.</p>
                    </div>
                </div>

                <p className="mt-6 text-sm text-slate-600">
                    ¿Dudas sobre los planes?{" "}
                    <a href="mailto:hola@paeslab.cl" className="font-bold text-blue-700 underline underline-offset-2">Escríbenos</a>
                </p>
            </div>
        </section>
    )
}
