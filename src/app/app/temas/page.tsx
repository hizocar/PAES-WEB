"use client"

import { useEffect, useMemo, useState } from "react"
import Link from "next/link"
import { Mascot } from "@/components/mascot/Mascot"
import { ArrowRight, Calculator, Crown, PieChart, RotateCcw, Shapes, Tangent } from "lucide-react"
import { createClient, getSessionUser } from "@/lib/supabase/client"
import { useSubject } from "@/components/providers/SubjectContext"
import { cn } from "@/lib/utils"

type TopicRow = {
    eje_id: string
    eje_name: string
    eje_slug: string
    eje_order: number
    topic_id: string
    topic_name: string
    topic_slug: string
    total_questions: number
    answered: number
    mastered: number
    attempts: number
    correct: number
    accuracy: number
    last_at: string | null
}

type Level = "nuevo" | "progreso" | "dominado"

function levelOf(t: TopicRow): Level {
    if (t.answered === 0) return "nuevo"
    if (t.total_questions > 0 && t.mastered / t.total_questions >= 0.8 && t.accuracy >= 70) return "dominado"
    return "progreso"
}

const EJE_ICON: Record<string, typeof Calculator> = {
    numeros: Calculator,
    "algebra-y-funciones": Tangent,
    geometria: Shapes,
    "probabilidad-y-estadistica": PieChart,
}

function LevelBadge({ level }: { level: Level }) {
    if (level === "dominado")
        return (
            <span className="inline-flex items-center gap-1 rounded-full bg-amber-50 px-2 py-0.5 text-xs font-bold text-amber-700">
                <Crown size={12} className="fill-amber-400 text-amber-500" aria-hidden /> Dominado
            </span>
        )
    if (level === "progreso")
        return <span className="rounded-full bg-blue-50 px-2 py-0.5 text-xs font-bold text-blue-700">En progreso</span>
    return <span className="rounded-full bg-slate-100 px-2 py-0.5 text-xs font-bold text-slate-600">Nuevo</span>
}

export default function TemasPage() {
    const { subject } = useSubject()
    const [rows, setRows] = useState<TopicRow[] | null>(null)
    const [error, setError] = useState(false)
    const [reload, setReload] = useState(0)

    useEffect(() => {
        const supabase = createClient()
        let alive = true
        setRows(null)
        setError(false)
        ;(async () => {
            const user = await getSessionUser(supabase)
            if (!user) return
            const { data, error } = await supabase.rpc("get_topic_progress", { p_user_id: user.id, p_subject: subject })
            if (!alive) return
            if (error) {
                console.error("get_topic_progress:", error.message)
                setError(true)
                return
            }
            setRows((data as TopicRow[]) ?? [])
        })()
        return () => {
            alive = false
        }
    }, [subject, reload])

    const ejes = useMemo(() => {
        const map = new Map<string, { id: string; name: string; slug: string; order: number; topics: TopicRow[] }>()
        for (const r of rows ?? []) {
            if (!map.has(r.eje_id)) map.set(r.eje_id, { id: r.eje_id, name: r.eje_name, slug: r.eje_slug, order: r.eje_order, topics: [] })
            map.get(r.eje_id)!.topics.push(r)
        }
        return [...map.values()].sort((a, b) => a.order - b.order)
    }, [rows])

    const totals = useMemo(() => {
        const list = rows ?? []
        return {
            topics: list.length,
            dominated: list.filter((t) => levelOf(t) === "dominado").length,
            started: list.filter((t) => t.answered > 0).length,
        }
    }, [rows])

    // Sugerencia: el tema empezado con menor acierto, o el primero sin empezar
    const suggestion = useMemo(() => {
        const list = rows ?? []
        const weak = list.filter((t) => t.answered > 0 && levelOf(t) !== "dominado").sort((a, b) => a.accuracy - b.accuracy)[0]
        return weak ?? list.find((t) => t.answered === 0) ?? null
    }, [rows])

    return (
        <div className="mx-auto max-w-5xl space-y-6 p-4 md:p-6">
            <header className="flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
                <div>
                    <h1 className="text-3xl font-black tracking-tight text-slate-900">Practica por tema</h1>
                    <p className="mt-1 max-w-2xl text-slate-600">
                        Elige un tema del temario oficial {subject.toUpperCase()} y entrénalo hasta dominarlo. Un tema queda dominado cuando
                        aciertas al menos el 80% de sus preguntas.
                    </p>
                </div>
                {rows && totals.topics > 0 && (
                    <div className="flex shrink-0 items-center gap-3 rounded-2xl border border-slate-200 bg-white px-4 py-3 shadow-sm">
                        <Crown size={22} className="fill-amber-400 text-amber-500" aria-hidden />
                        <p className="text-sm font-semibold text-slate-600">
                            <span className="text-2xl font-black text-slate-900 tabular-nums">{totals.dominated}</span>
                            <span className="tabular-nums"> de {totals.topics}</span> temas dominados
                        </p>
                    </div>
                )}
            </header>

            {error && (
                <div role="alert" className="flex flex-col items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 sm:flex-row sm:items-center sm:justify-between">
                    <p className="text-sm font-medium text-red-800">No pudimos cargar tus temas. Revisa tu conexión e inténtalo de nuevo.</p>
                    <button
                        type="button"
                        onClick={() => setReload((n) => n + 1)}
                        className="inline-flex items-center gap-1.5 rounded-lg border border-red-200 bg-white px-3 py-1.5 text-sm font-bold text-red-700 hover:bg-red-100"
                    >
                        <RotateCcw size={14} aria-hidden /> Reintentar
                    </button>
                </div>
            )}

            {rows === null && !error && (
                <div className="space-y-4" aria-busy="true" aria-label="Cargando temas">
                    {[0, 1, 2].map((i) => (
                        <div key={i} className="h-40 animate-pulse rounded-2xl bg-slate-100" />
                    ))}
                </div>
            )}

            {rows && suggestion && (
                <Link
                    href={`/app/practice?topic=${suggestion.topic_id}`}
                    className="group flex items-center gap-4 rounded-2xl border border-blue-200 bg-blue-50 p-4 transition-colors hover:bg-blue-100 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                >
                    <Mascot mood="idle" size={52} interactive={false} message={false} />
                    <div className="min-w-0 flex-1">
                        <p className="text-sm font-semibold text-blue-800">
                            {suggestion.answered > 0 ? "Te recomiendo reforzar" : "Te recomiendo empezar por"}
                        </p>
                        <p className="truncate text-lg font-black text-slate-900">{suggestion.topic_name}</p>
                    </div>
                    <ArrowRight className="shrink-0 text-blue-700 transition-transform group-hover:translate-x-0.5" aria-hidden />
                </Link>
            )}

            {ejes.map((eje) => {
                const Icon = EJE_ICON[eje.slug] ?? Calculator
                const ans = eje.topics.reduce((s, t) => s + t.attempts, 0)
                const cor = eje.topics.reduce((s, t) => s + t.correct, 0)
                const ejeAcc = ans ? Math.round((100 * cor) / ans) : null
                return (
                    <section key={eje.id} id={`eje-${eje.id}`} className="scroll-mt-24 rounded-[1.5rem] border border-slate-200 bg-white shadow-sm" aria-labelledby={`t-${eje.id}`}>
                        <div className="flex items-center justify-between gap-3 border-b border-slate-100 px-5 py-4">
                            <div className="flex items-center gap-3">
                                <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-blue-50 text-blue-600">
                                    <Icon size={20} aria-hidden />
                                </div>
                                <h2 id={`t-${eje.id}`} className="text-lg font-black text-slate-900">{eje.name}</h2>
                            </div>
                            <p className="text-sm font-semibold text-slate-500 tabular-nums">
                                {ejeAcc === null ? "Sin respuestas aún" : `${ejeAcc}% de acierto`}
                            </p>
                        </div>
                        <ul className="divide-y divide-slate-100">
                            {eje.topics.map((t) => {
                                const level = levelOf(t)
                                const pct = t.total_questions ? Math.round((100 * t.mastered) / t.total_questions) : 0
                                return (
                                    <li key={t.topic_id} className="flex flex-col gap-3 px-5 py-4 sm:flex-row sm:items-center sm:gap-6">
                                        <div className="min-w-0 flex-1">
                                            <div className="flex flex-wrap items-center gap-2">
                                                <h3 className="font-bold text-slate-900">{t.topic_name}</h3>
                                                <LevelBadge level={level} />
                                            </div>
                                            <div className="mt-2 flex items-center gap-3">
                                                <div
                                                    className="h-2 flex-1 overflow-hidden rounded-full bg-slate-100"
                                                    role="progressbar"
                                                    aria-valuenow={pct}
                                                    aria-valuemin={0}
                                                    aria-valuemax={100}
                                                    aria-label={`Dominio de ${t.topic_name}`}
                                                >
                                                    <div
                                                        className={cn("h-full rounded-full transition-[width] duration-700",
                                                            level === "dominado" ? "bg-amber-400" : level === "progreso" ? "bg-blue-600" : "bg-slate-200")}
                                                        style={{ width: `${pct}%` }}
                                                    />
                                                </div>
                                                <span className="w-10 text-right text-sm font-black text-slate-900 tabular-nums">{pct}%</span>
                                            </div>
                                            <p className="mt-1.5 text-xs font-medium text-slate-500 tabular-nums">
                                                {t.mastered} de {t.total_questions} preguntas dominadas
                                                {t.attempts > 0 && ` · ${t.accuracy}% de acierto`}
                                            </p>
                                        </div>
                                        <Link
                                            href={`/app/practice?topic=${t.topic_id}`}
                                            className={cn(
                                                "inline-flex h-11 shrink-0 items-center justify-center gap-1.5 rounded-xl px-5 text-sm font-black transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600",
                                                level === "dominado"
                                                    ? "border border-slate-200 text-slate-700 hover:bg-slate-50"
                                                    : "bg-blue-600 text-white hover:bg-blue-700"
                                            )}
                                        >
                                            {level === "nuevo" ? "Empezar" : level === "dominado" ? "Repasar" : "Continuar"}
                                        </Link>
                                    </li>
                                )
                            })}
                        </ul>
                    </section>
                )
            })}

            {rows && rows.length === 0 && !error && (
                <p className="rounded-2xl border border-dashed border-slate-300 p-8 text-center text-slate-600">
                    Aún no hay temas con preguntas para {subject.toUpperCase()}.
                </p>
            )}
        </div>
    )
}
