"use client"

import { useEffect, useState } from "react"
import { createClient, getSessionUser } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { useRouter } from "next/navigation"
import { Loader2, Play, LayoutGrid, Clock, Trophy, History, AlertCircle, Flame } from "lucide-react"
import Link from "next/link"
import { useSubject } from "@/components/providers/SubjectContext"
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts'

const LEVELS = [
    { n: 1, name: "Calentando", min: 0 },
    { n: 2, name: "En ruta", min: 450 },
    { n: 3, name: "Competitivo", min: 600 },
    { n: 4, name: "Élite", min: 750 },
    { n: 5, name: "Puntaje nacional", min: 900 },
]

function levelFor(best: number) {
    let cur = LEVELS[0]
    for (const l of LEVELS) if (best >= l.min) cur = l
    const next = LEVELS.find((l) => l.min > best) ?? null
    return { cur, next }
}

export default function EnsayosDashboard() {
    const { subject } = useSubject()
    const [loading, setLoading] = useState(true)
    const [creating, setCreating] = useState(false)
    const [creatingLevel, setCreatingLevel] = useState<"normal" | "desafio">("normal")
    const [error, setError] = useState<string | null>(null)
    const [ensayos, setEnsayos] = useState<any[]>([])
    const supabase = createClient()
    const router = useRouter()

    useEffect(() => {
        const fetchEnsayos = async () => {
            const user = await getSessionUser(supabase)
            if (!user) return

            const { data } = await supabase
                .from('ensayos')
                .select('*')
                .eq('user_id', user.id)
                .eq('subject', subject) // Filter by subject
                .order('started_at', { ascending: false })

            if (data) setEnsayos(data)
            setLoading(false)
        }
        fetchEnsayos()
    }, [subject]) // Refetch when subject changes

    const handleStartEnsayo = async (level: "normal" | "desafio" = "normal") => {
        setCreating(true)
        setCreatingLevel(level)
        setError(null)
        try {
            const user = await getSessionUser(supabase)
            if (!user) {
                setError("Debes iniciar sesión para comenzar.")
                setCreating(false)
                return
            }

            // Call RPC to create ensayo and get ID
            const { data, error } = level === 'desafio'
                ? await supabase.rpc('create_ensayo_desafio', { p_user_id: user.id, p_subject: subject })
                : await supabase.rpc(subject === 'm2' ? 'create_ensayo_m2' : 'create_ensayo_m1', { p_user_id: user.id })

            if (error) {
                console.error("RPC Error:", error)
                throw error
            }

            if (!data || !(data as any).ensayo_id) {
                throw new Error("No se recibió el ID del ensayo.")
            }

            // Redirect to the new ensayo
            const ensayoId = (data as any).ensayo_id
            router.push(`/app/ensayos/${ensayoId}`)
        } catch (e: any) {
            console.error("Error creating ensayo:", e)
            setError(e.message || "Error desconocido al crear el ensayo.")
            setCreating(false)
        }
    }

    if (loading) {
        return <div className="flex h-96 items-center justify-center"><Loader2 className="animate-spin text-blue-600" /></div>
    }

    const history = ensayos.slice(0) // All essays
    const nQuestions = subject === 'm2' ? 55 : 60

    return (
        <div className="max-w-5xl mx-auto p-6 space-y-8">
            <header className="mb-8">
                <h1 className="text-3xl font-black text-slate-900">Ensayos {subject.toUpperCase()}</h1>
                <p className="text-slate-500 text-lg">Simula la experiencia real de la PAES. {nQuestions} preguntas, 2 horas 20 minutos.</p>
            </header>



            {(() => {
                const done = ensayos.filter(e => e.status === 'completed')
                const best = done.reduce((m, e) => Math.max(m, e.score ?? 0), 0)
                const bestDesafio = done.filter(e => e.level === 'desafio').reduce((m, e) => Math.max(m, e.score ?? 0), 0)
                const { cur, next } = levelFor(best)
                const pct = next ? Math.round(((best - cur.min) / (next.min - cur.min)) * 100) : 100
                const recommendDesafio = cur.n >= 3
                return (
                    <>
                        <section className="rounded-2xl border border-slate-200 bg-white p-5 shadow-sm" aria-label="Tu nivel">
                            <div className="flex flex-wrap items-end justify-between gap-3">
                                <div>
                                    <p className="text-sm font-semibold text-slate-500">Tu nivel {subject.toUpperCase()}</p>
                                    <p className="text-2xl font-black text-slate-900">Nivel {cur.n} · {cur.name}</p>
                                </div>
                                <p className="text-sm font-semibold text-slate-600 tabular-nums">
                                    {done.length ? <>Mejor puntaje: <strong className="text-slate-900">{best}</strong>{bestDesafio ? <> · Mejor desafío: <strong className="text-slate-900">{bestDesafio}</strong></> : null}</> : "Haz tu primer ensayo para medir tu nivel"}
                                </p>
                            </div>
                            <div className="mt-3 h-2.5 overflow-hidden rounded-full bg-slate-100" role="progressbar" aria-valuenow={pct} aria-valuemin={0} aria-valuemax={100} aria-label="Avance al siguiente nivel">
                                <div className="h-full rounded-full bg-blue-600 transition-[width] duration-700" style={{ width: `${pct}%` }} />
                            </div>
                            <p className="mt-2 text-xs font-semibold text-slate-500 tabular-nums">
                                {next ? `Te faltan ${next.min - best} puntos para el nivel ${next.n} (${next.name}).` : "¡Estás en el nivel máximo!"}
                            </p>
                        </section>

                        <div className="grid gap-4 md:grid-cols-2">
                            <div className="flex flex-col rounded-2xl bg-blue-600 p-6 text-white shadow-[0_16px_32px_-16px_rgba(37,99,235,0.7)]">
                                <h2 className="text-2xl font-black">Ensayo PAES</h2>
                                <p className="mt-2 flex-1 text-blue-100">
                                    {nQuestions} preguntas al azar con la proporción de ejes de la prueba oficial{subject === "m2" ? " (suficiencia de datos al final)" : ""}. Puntaje estimado en escala PAES.
                                </p>
                                <p className="mt-4 flex items-center gap-4 text-sm font-semibold text-blue-100">
                                    <span className="flex items-center gap-1.5"><Clock size={15} aria-hidden /> 2 h 20 min</span>
                                    <span className="flex items-center gap-1.5"><LayoutGrid size={15} aria-hidden /> {nQuestions} preguntas</span>
                                </p>
                                <Button
                                    size="lg"
                                    onClick={() => handleStartEnsayo("normal")}
                                    disabled={creating}
                                    className="mt-5 h-14 rounded-2xl border-b-4 border-blue-200 bg-white text-lg font-black text-blue-700 hover:bg-blue-50"
                                >
                                    {creating && creatingLevel === "normal" ? <Loader2 className="mr-2 animate-spin" /> : <Play className="mr-2 fill-current" />}
                                    {creating && creatingLevel === "normal" ? "Generando…" : "Comenzar ensayo"}
                                </Button>
                            </div>

                            <div className="flex flex-col rounded-2xl border-2 border-amber-300 bg-amber-50 p-6">
                                <div className="flex items-center justify-between gap-2">
                                    <h2 className="flex items-center gap-2 text-2xl font-black text-slate-900"><Flame className="fill-orange-500 text-orange-500" aria-hidden /> Desafío</h2>
                                    {recommendDesafio && <span className="rounded-full bg-amber-200 px-2.5 py-1 text-xs font-bold text-amber-900">Recomendado para ti</span>}
                                </div>
                                <p className="mt-2 flex-1 text-slate-700">
                                    Solo preguntas intermedias y difíciles que aún no dominas, con la misma proporción de ejes. Para subir de nivel{!recommendDesafio ? " (ideal desde el nivel 3)" : ""}.
                                </p>
                                <p className="mt-4 flex items-center gap-4 text-sm font-semibold text-amber-900">
                                    <span className="flex items-center gap-1.5"><Clock size={15} aria-hidden /> 2 h 20 min</span>
                                    <span className="flex items-center gap-1.5"><Trophy size={15} aria-hidden /> Mismo puntaje PAES</span>
                                </p>
                                <Button
                                    size="lg"
                                    onClick={() => handleStartEnsayo("desafio")}
                                    disabled={creating}
                                    className="mt-5 h-14 rounded-2xl border-b-4 border-orange-700 bg-orange-500 text-lg font-black text-white hover:bg-orange-600"
                                >
                                    {creating && creatingLevel === "desafio" ? <Loader2 className="mr-2 animate-spin" /> : <Flame className="mr-2 fill-current" />}
                                    {creating && creatingLevel === "desafio" ? "Generando…" : "Aceptar el desafío"}
                                </Button>
                            </div>
                        </div>

                        {error && (
                            <p role="alert" className="flex items-center gap-2 rounded-xl bg-red-50 px-4 py-3 text-sm font-medium text-red-800">
                                <AlertCircle size={16} aria-hidden /> {error}
                            </p>
                        )}
                    </>
                )
            })()}

            {/* Score Evolution Chart */}
            {ensayos.filter(e => e.status === 'completed').length > 1 && (
                <div className="bg-white p-6 md:p-8 rounded-3xl border border-slate-100 shadow-xl space-y-6">
                    <div className="flex items-center justify-between">
                        <div className="flex items-center gap-3">
                            <div className="bg-blue-100 p-2 rounded-lg text-blue-600">
                                <Trophy size={24} />
                            </div>
                            <div>
                                <h2 className="text-xl font-bold text-slate-800">Evolución de Puntajes</h2>
                                <p className="text-slate-500 text-sm">Tu progreso en los últimos ensayos</p>
                            </div>
                        </div>
                        <div className="text-right">
                            <span className="text-xs font-bold text-slate-400 uppercase tracking-wider block">Último Puntaje</span>
                            <span className="text-2xl font-black text-blue-600">
                                {ensayos
                                    .filter(e => e.status === 'completed')
                                    .sort((a, b) => new Date(b.started_at).getTime() - new Date(a.started_at).getTime())[0]?.score}
                            </span>
                        </div>
                    </div>

                    <div className="h-[300px] w-full">
                        <ResponsiveContainer width="100%" height="100%">
                            <AreaChart
                                data={ensayos
                                    .filter(e => e.status === 'completed')
                                    .sort((a, b) => new Date(a.started_at).getTime() - new Date(b.started_at).getTime())
                                    .map(e => ({
                                        date: new Date(e.started_at).toLocaleDateString('es-CL', { day: '2-digit', month: 'short' }),
                                        score: e.score
                                    }))
                                }
                                margin={{ top: 10, right: 10, left: -20, bottom: 0 }}
                            >
                                <defs>
                                    <linearGradient id="colorScore" x1="0" y1="0" x2="0" y2="1">
                                        <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                                        <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                                    </linearGradient>
                                </defs>
                                <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#e2e8f0" />
                                <XAxis
                                    dataKey="date"
                                    axisLine={false}
                                    tickLine={false}
                                    tick={{ fill: '#94a3b8', fontSize: 12 }}
                                    dy={10}
                                />
                                <YAxis
                                    axisLine={false}
                                    tickLine={false}
                                    tick={{ fill: '#94a3b8', fontSize: 12 }}
                                    domain={[0, 1000]}
                                />
                                <Tooltip
                                    contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)' }}
                                    cursor={{ stroke: '#3b82f6', strokeWidth: 2 }}
                                />
                                <Area
                                    type="monotone"
                                    dataKey="score"
                                    stroke="#3b82f6"
                                    strokeWidth={4}
                                    fillOpacity={1}
                                    fill="url(#colorScore)"
                                    activeDot={{ r: 6, strokeWidth: 0, fill: '#2563eb' }}
                                />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>
                </div>
            )}

            {/* History Section */}
            <div className="space-y-4">
                <div className="flex items-center gap-2 text-slate-900 font-bold text-xl">
                    <History className="text-slate-400" />
                    Historial de Ensayos
                </div>

                {history.length === 0 ? (
                    <div className="text-center py-12 bg-slate-50 rounded-2xl border border-dashed border-slate-200">
                        <p className="text-slate-400">Aún no has realizado ningún ensayo. ¡Es hora de empezar!</p>
                    </div>
                ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        {history.map((ensayo) => (
                            <Link href={ensayo.status === 'completed' ? `/app/ensayos/${ensayo.id}/results` : `/app/ensayos/${ensayo.id}`} key={ensayo.id}>
                                <div className="bg-white p-5 rounded-xl border border-slate-100 shadow-sm hover:shadow-md hover:border-blue-200 transition-all flex items-center justify-between group">
                                    <div className="space-y-1">
                                        <div className="flex items-center gap-2">
                                            <span className={`w-2.5 h-2.5 rounded-full ${ensayo.status === 'completed' ? 'bg-green-500' : 'bg-orange-500'}`} />
                                            <span className="font-bold text-slate-800">
                                                {new Date(ensayo.started_at).toLocaleDateString('es-CL', { day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' })}
                                            </span>
                                            {ensayo.level === 'desafio' && (
                                                <span className="rounded-full bg-amber-100 px-2 py-0.5 text-xs font-bold text-amber-800">Desafío</span>
                                            )}
                                        </div>
                                        <div className="text-sm text-slate-500 pl-4">
                                            {ensayo.status === 'completed'
                                                ? `Finalizado • ${ensayo.score} Puntos`
                                                : "En Progreso • Continuar..."}
                                        </div>
                                    </div>
                                    <div className="w-10 h-10 rounded-lg bg-slate-50 flex items-center justify-center text-slate-400 group-hover:bg-blue-50 group-hover:text-blue-600 transition-colors">
                                        {ensayo.status === 'completed' ? <Trophy size={20} /> : <Play size={20} className="ml-1" />}
                                    </div>
                                </div>
                            </Link>
                        ))}
                    </div>
                )}
            </div>
        </div>
    )
}
