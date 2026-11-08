"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import { Plus, Trash, Edit, ThumbsUp, ThumbsDown, AlertTriangle, Clock } from "lucide-react"
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import 'katex/dist/katex.min.css'

type QStats = {
    question_id: string
    responses: number
    first_attempts: number
    pct_correct: number | null
    pct_correct_first: number | null
    median_time_ms: number | null
    answer_counts: Record<string, number> | null
    top_wrong: string | null
    top_wrong_share: number | null
    empirical_difficulty: string
    flag: string | null
}

const FLAG_LABEL: Record<string, string> = {
    revisar_clave: "Revisar clave: una alternativa incorrecta atrae más respuestas que la correcta",
    demasiado_dificil: "Menos del 15% acierta: revisar enunciado o clave",
    mas_facil_que_asignada: "Más fácil de lo asignado (Avanzado)",
    mas_dificil_que_asignada: "Más difícil de lo asignado (Principiante)",
}

const DIFF_LABEL: Record<string, string> = { easy: "Principiante", medium: "Intermedio", hard: "Avanzado", insuficiente: "Faltan datos" }

function pctColor(p: number | null | undefined) {
    if (p === null || p === undefined) return "text-slate-500"
    return p >= 70 ? "text-emerald-700" : p >= 40 ? "text-amber-700" : "text-red-700"
}

export default function AdminQuestionsPage() {
    const [questions, setQuestions] = useState<any[]>([])
    const [filteredQuestions, setFilteredQuestions] = useState<any[]>([])
    const [ejes, setEjes] = useState<any[]>([])
    const [topics, setTopics] = useState<any[]>([])

    // Filters
    const [subject, setSubject] = useState<'m1' | 'm2'>('m2')
    const [filterEje, setFilterEje] = useState("all")
    const [filterTopic, setFilterTopic] = useState("all")
    const [filterDifficulty, setFilterDifficulty] = useState("all")
    const [filterHabilidad, setFilterHabilidad] = useState("all")
    // Estadísticas reales por pregunta (práctica + ensayos)
    const [stats, setStats] = useState<Record<string, QStats>>({})
    const [sortBy, setSortBy] = useState<"recent" | "pct_asc" | "pct_desc" | "responses" | "flags">("recent")
    const [onlyFlagged, setOnlyFlagged] = useState(false)

    const supabase = createClient()

    useEffect(() => {
        fetchData()
    }, [])

    useEffect(() => {
        supabase.rpc('get_admin_question_stats', { p_subject: subject }).then(({ data, error }) => {
            if (error) { console.error('get_admin_question_stats:', error.message); return }
            const map: Record<string, QStats> = {}
            for (const r of (data as QStats[]) ?? []) map[r.question_id] = r
            setStats(map)
        })
    }, [subject])

    useEffect(() => {
        let res = questions

        // Filter by Subject
        if (subject) {
            res = res.filter(q => q.subject === subject)
        }

        if (filterEje !== "all") {
            res = res.filter(q => q.eje_id === filterEje)
        }

        if (filterTopic !== "all") {
            const selectedTopic = topics.find(t => t.id === filterTopic)
            if (selectedTopic) {
                res = res.filter(q => q.topic_name === selectedTopic.name)
            }
        }

        if (filterDifficulty !== "all") {
            res = res.filter(q => q.difficulty === filterDifficulty)
        }

        if (filterHabilidad !== "all") {
            res = res.filter(q => q.habilidad === filterHabilidad)
        }

        if (onlyFlagged) {
            res = res.filter(q => stats[q.id]?.flag)
        }

        const pct = (q: any) => stats[q.id]?.pct_correct_first ?? stats[q.id]?.pct_correct
        const sorted = [...res]
        if (sortBy === "pct_asc") sorted.sort((a, b) => (pct(a) ?? 999) - (pct(b) ?? 999))
        if (sortBy === "pct_desc") sorted.sort((a, b) => (pct(b) ?? -1) - (pct(a) ?? -1))
        if (sortBy === "responses") sorted.sort((a, b) => (stats[b.id]?.responses ?? 0) - (stats[a.id]?.responses ?? 0))
        if (sortBy === "flags") sorted.sort((a, b) => Number(!!stats[b.id]?.flag) - Number(!!stats[a.id]?.flag))

        setFilteredQuestions(sorted)
    }, [questions, filterEje, filterTopic, filterDifficulty, filterHabilidad, topics, subject, stats, sortBy, onlyFlagged])

    const fetchData = async () => {
        // 1. Fetch Ejes and Topics
        const { data: axes } = await supabase.from('ejes').select('*')
        if (axes) setEjes(axes)

        const { data: allTopics } = await supabase.from('topics').select('*')
        if (allTopics) setTopics(allTopics)

        // 2. Fetch Questions
        const { data: qData } = await supabase
            .from('questions')
            .select('*')
            .order('created_at', { ascending: false })

        if (!qData) return

        // 3. Fetch Topics/Ejes mapping for questions
        const qIds = qData.map(q => q.id)
        const { data: qtData } = await supabase
            .from('question_topics')
            .select('question_id, topics(name, eje_id)')
            .in('question_id', qIds)

        const mapEje: Record<string, string> = {}
        const mapTopic: Record<string, string> = {}

        qtData?.forEach((item: any) => {
            if (item.topics) {
                mapEje[item.question_id] = item.topics.eje_id
                mapTopic[item.question_id] = item.topics.name
            }
        })

        // 4. Fetch Feedback
        const { data: feedbackData } = await supabase
            .from('question_feedback')
            .select('question_id, vote') // Assuming table has 'vote' column with 'up'/'down'
            .in('question_id', qIds)

        const mapFeedback: Record<string, { up: number, down: number }> = {}

        // Initialize map
        qIds.forEach(id => {
            mapFeedback[id] = { up: 0, down: 0 }
        })

        feedbackData?.forEach((item: any) => {
            if (mapFeedback[item.question_id]) {
                if (item.vote === 'up') mapFeedback[item.question_id].up++
                if (item.vote === 'down') mapFeedback[item.question_id].down++
            }
        })

        const questionsWithMeta = qData.map(q => ({
            ...q,
            eje_id: mapEje[q.id],
            topic_name: mapTopic[q.id],
            votes: mapFeedback[q.id] || { up: 0, down: 0 }
        }))

        setQuestions(questionsWithMeta)
        setFilteredQuestions(questionsWithMeta)
    }

    const handleDelete = async (id: string) => {
        if (!confirm("¿Estás seguro de eliminar esta pregunta?")) return
        const { error } = await supabase.from('questions').delete().eq('id', id)
        if (!error) {
            fetchData()
        } else {
            alert("Error al eliminar: " + error.message)
        }
    }

    const getDifficultyLabel = (d: string) => {
        switch (d) {
            case 'easy': return 'Principiante'
            case 'medium': return 'Intermedio'
            case 'hard': return 'Avanzado'
            default: return d
        }
    }

    const getHabilidadLabel = (h: string) => {
        switch (h) {
            case 'resolver_problemas': return 'Resolver Problemas'
            case 'modelar': return 'Modelar'
            case 'representar': return 'Representar'
            case 'argumentar': return 'Argumentar'
            default: return h
        }
    }

    return (
        <div className="space-y-6 pb-8">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h2 className="text-2xl font-bold text-slate-900">Gestión de Preguntas</h2>
                    <p className="text-slate-500 text-sm">Administra el banco de ejercicios</p>
                </div>
                <div className="flex items-center gap-3">
                    <div className="bg-slate-100 p-1 rounded-lg flex items-center gap-1">
                        <button
                            onClick={() => setSubject('m1')}
                            className={`px-3 py-1.5 rounded-md text-xs font-bold transition-all ${subject === 'm1'
                                ? 'bg-white text-slate-900 shadow-sm'
                                : 'text-slate-500 hover:text-slate-700'
                                }`}
                        >
                            M1
                        </button>
                        <button
                            onClick={() => setSubject('m2')}
                            className={`px-3 py-1.5 rounded-md text-xs font-bold transition-all ${subject === 'm2'
                                ? 'bg-white text-slate-900 shadow-sm'
                                : 'text-slate-500 hover:text-slate-700'
                                }`}
                        >
                            M2
                        </button>
                    </div>
                    <Link href="/admin/questions/new">
                        <Button>
                            <Plus className="mr-2" size={18} />
                            Nueva Pregunta
                        </Button>
                    </Link>
                </div>
            </div>

            {/* Filters */}
            <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm flex flex-col md:flex-row gap-4">
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Eje</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterEje}
                        onChange={e => {
                            setFilterEje(e.target.value)
                            setFilterTopic("all")
                        }}
                    >
                        <option value="all">Todos los Ejes</option>
                        {ejes.map(e => (
                            <option key={e.id} value={e.id}>{e.name}</option>
                        ))}
                    </select>
                </div>
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Tema</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterTopic}
                        onChange={e => setFilterTopic(e.target.value)}
                        disabled={filterEje === "all"}
                    >
                        <option value="all">Todos los Temas</option>
                        {topics
                            .filter(t => filterEje === "all" || t.eje_id === filterEje)
                            .map(t => (
                                <option key={t.id} value={t.id}>{t.name}</option>
                            ))}
                    </select>
                </div>
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Dificultad</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterDifficulty}
                        onChange={e => setFilterDifficulty(e.target.value)}
                    >
                        <option value="all">Todos</option>
                        <option value="easy">Principiante</option>
                        <option value="medium">Intermedio</option>
                        <option value="hard">Avanzado</option>
                    </select>
                </div>
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Habilidad</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterHabilidad}
                        onChange={e => setFilterHabilidad(e.target.value)}
                    >
                        <option value="all">Todas</option>
                        <option value="resolver_problemas">Resolver Problemas</option>
                        <option value="modelar">Modelar</option>
                        <option value="representar">Representar</option>
                        <option value="argumentar">Argumentar</option>
                    </select>
                </div>
            </div>

            {(() => {
                const subjQ = questions.filter(q => q.subject === subject)
                const withData = subjQ.filter(q => stats[q.id]?.responses)
                const flagged = subjQ.filter(q => stats[q.id]?.flag)
                return (
                    <div className="flex flex-col gap-3 rounded-xl border border-slate-200 bg-white p-4 shadow-sm md:flex-row md:items-center md:justify-between">
                        <p className="text-sm text-slate-600">
                            <strong className="text-slate-900">{subjQ.length}</strong> preguntas · <strong className="text-slate-900">{withData.length}</strong> con respuestas ·{" "}
                            <strong className={flagged.length ? "text-red-700" : "text-slate-900"}>{flagged.length}</strong> con alerta
                            <span className="block text-xs text-slate-500">% de acierto en el primer intento de cada alumno, sumando práctica y ensayos. Dificultad real desde 20 respuestas.</span>
                        </p>
                        <div className="flex flex-wrap items-center gap-3">
                            <label className="flex items-center gap-2 text-sm font-semibold text-slate-700">
                                <input type="checkbox" checked={onlyFlagged} onChange={e => setOnlyFlagged(e.target.checked)} className="h-4 w-4 accent-red-600" />
                                Solo con alerta
                            </label>
                            <select className="rounded-md border p-2 text-sm" value={sortBy} onChange={e => setSortBy(e.target.value as any)} aria-label="Ordenar">
                                <option value="recent">Más recientes</option>
                                <option value="pct_asc">Menor % de acierto</option>
                                <option value="pct_desc">Mayor % de acierto</option>
                                <option value="responses">Más respondidas</option>
                                <option value="flags">Con alerta primero</option>
                            </select>
                        </div>
                    </div>
                )
            })()}

            <div className="grid gap-4">
                {filteredQuestions.map((q) => (
                    <div key={q.id} className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm hover:border-blue-300 transition-colors">

                        {/* Header: Badges and Actions */}
                        <div className="flex flex-wrap items-start justify-between gap-4 mb-4">
                            <div className="flex flex-wrap items-center gap-2">
                                <span className={`px-2 py-0.5 rounded textxs font-bold uppercase tracking-wider text-[10px] bg-slate-100 text-slate-600`}>
                                    {ejes.find(e => e.id === q.eje_id)?.name || 'Sin Eje'}
                                </span>
                                {q.topic_name && (
                                    <span className="px-2 py-0.5 rounded textxs font-bold uppercase tracking-wider text-[10px] bg-purple-100 text-purple-600">
                                        {q.topic_name}
                                    </span>
                                )}
                                {q.habilidad && (
                                    <span className="px-2 py-0.5 rounded textxs font-bold uppercase tracking-wider text-[10px] bg-indigo-100 text-indigo-600">
                                        {getHabilidadLabel(q.habilidad)}
                                    </span>
                                )}
                                <span className="text-xs text-slate-400 font-mono">ID: {q.id.slice(0, 8)}</span>
                            </div>

                            <div className="flex items-center gap-4">
                                {/* % de acierto real */}
                                <div className="flex flex-col items-end">
                                    <span className="text-[11px] font-bold text-slate-500">% acierto (1er intento)</span>
                                    {stats[q.id]?.responses ? (
                                        <span className={`text-lg font-black tabular-nums ${pctColor(stats[q.id].pct_correct_first ?? stats[q.id].pct_correct)}`}>
                                            {Math.round((stats[q.id].pct_correct_first ?? stats[q.id].pct_correct) ?? 0)}%
                                            <span className="ml-1 text-xs font-semibold text-slate-500">de {stats[q.id].responses}</span>
                                        </span>
                                    ) : (
                                        <span className="text-xs font-bold text-slate-500">Sin respuestas</span>
                                    )}
                                </div>

                                {/* Feedback Stats */}
                                <div className="flex flex-col items-end">
                                    <span className="text-[10px] uppercase font-bold text-slate-400">Feedback</span>
                                    <div className="flex items-center gap-3">
                                        <div className="flex items-center gap-1 text-xs font-bold text-green-600">
                                            <ThumbsUp size={14} />
                                            <span>{q.votes?.up || 0}</span>
                                        </div>
                                        <div className="flex items-center gap-1 text-xs font-bold text-red-500">
                                            <ThumbsDown size={14} />
                                            <span>{q.votes?.down || 0}</span>
                                        </div>
                                    </div>
                                </div>

                                {/* Actions */}
                                <div className="flex gap-2">
                                    <Link href={`/admin/questions/${q.id}`}>
                                        <Button size="sm" variant="outline" className="h-8 text-slate-600">
                                            <Edit size={14} className="mr-2" />
                                            Editar
                                        </Button>
                                    </Link>
                                    <Button
                                        size="sm"
                                        variant="ghost"
                                        className="h-8 text-red-500 hover:text-red-700 hover:bg-red-50"
                                        onClick={() => handleDelete(q.id)}
                                    >
                                        <Trash size={14} />
                                    </Button>
                                </div>
                            </div>
                        </div>

                        {/* Question Content */}
                        <div className="text-slate-900 text-lg font-medium leading-relaxed mb-4 break-words">
                            <Latex>{q.content}</Latex>
                        </div>

                        {/* Footer */}
                        <div className="flex items-center gap-4 text-sm text-slate-500 border-t border-slate-100 pt-4">
                            <span className="flex items-center gap-1 font-medium">
                                Respuesta: <span className="text-slate-900 font-bold">{q.correct_answer}</span>
                            </span>
                            <span className="w-1 h-1 rounded-full bg-slate-300"></span>
                            <span className="flex items-center gap-1.5">
                                Asignada: <span className="font-bold text-slate-900">{getDifficultyLabel(q.difficulty)}</span>
                                {stats[q.id] && stats[q.id].empirical_difficulty !== 'insuficiente' && (
                                    <> · Real: <span className="font-bold text-slate-900">{DIFF_LABEL[stats[q.id].empirical_difficulty]}</span></>
                                )}
                            </span>
                            {stats[q.id]?.median_time_ms && (
                                <span className="flex items-center gap-1 tabular-nums"><Clock size={14} aria-hidden /> {Math.round(stats[q.id].median_time_ms! / 1000)} s mediana</span>
                            )}
                            {q.external_key && <span className="font-mono text-xs text-slate-500">{q.external_key}</span>}
                        </div>

                        {stats[q.id]?.answer_counts && (
                            <div className="mt-3 flex flex-wrap items-center gap-1.5" aria-label="Respuestas por alternativa">
                                {Object.entries(stats[q.id].answer_counts!).sort(([a], [b]) => a.localeCompare(b)).map(([alt, n]) => (
                                    <span
                                        key={alt}
                                        className={`rounded-md px-2 py-0.5 text-xs font-bold tabular-nums ${alt === q.correct_answer ? 'bg-emerald-100 text-emerald-800' : alt === stats[q.id].top_wrong ? 'bg-red-100 text-red-800' : 'bg-slate-100 text-slate-600'}`}
                                    >
                                        {alt === 'TIMEOUT' ? 'Sin tiempo' : alt}: {n}
                                    </span>
                                ))}
                            </div>
                        )}

                        {stats[q.id]?.flag && (
                            <p role="status" className="mt-3 flex items-start gap-2 rounded-lg bg-red-50 px-3 py-2 text-sm font-semibold text-red-800">
                                <AlertTriangle size={16} className="mt-0.5 shrink-0" aria-hidden />
                                {FLAG_LABEL[stats[q.id].flag!] ?? stats[q.id].flag}
                            </p>
                        )}
                    </div>
                ))
                }
                {
                    filteredQuestions.length === 0 && (
                        <div className="text-center py-12 bg-slate-50 rounded-xl border border-dashed border-slate-300">
                            <p className="text-slate-500">No se encontraron preguntas con estos filtros.</p>
                        </div>
                    )
                }
            </div >
        </div >
    )
}
