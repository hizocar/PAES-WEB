"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { useParams, useRouter } from "next/navigation"
import { Loader2, TrendingUp, Target, BarChart3, Calculator, Shapes, PieChart, Tangent, RotateCcw, CheckCircle2, XCircle } from "lucide-react"
import Link from "next/link"
import { Button } from "@/components/ui/button"

export default function EnsayoResultsPage() {
    const { id } = useParams()
    const router = useRouter()
    const supabase = createClient()
    const [ensayo, setEnsayo] = useState<any>(null)
    const [stats, setStats] = useState<any>(null)
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const fetchResults = async () => {
            const { data, error } = await supabase
                .from('ensayos')
                .select('*')
                .eq('id', id)
                .single()

            if (error || !data) {
                console.error("Error fetching results:", error)
                router.push('/app/ensayos')
                return
            }

            if (data.status !== 'completed') {
                router.push(`/app/ensayos/${id}`)
                return
            }

            // Calculate axis stats manually from questions_data + answers
            // Note: Ideally the "submit_ensayo" RPC returns this structure, but we might need to recalculate or parse it if we didn't save it explicitly.
            // Let's rely on re-calculating or assuming the structure.
            // For now, let's process the raw data to be robust.

            const processedStats = {
                numeros: { correct: 0, total: 0, topics: {} as Record<string, { correct: number, total: number }> },
                algebra: { correct: 0, total: 0, topics: {} as Record<string, { correct: number, total: number }> },
                geometria: { correct: 0, total: 0, topics: {} as Record<string, { correct: number, total: number }> },
                probabilidad: { correct: 0, total: 0, topics: {} as Record<string, { correct: number, total: number }> }
            }

            const questionIds = (data.questions_data as any[]).map(q => q.question_id)
            const { data: fullQuestions } = await supabase
                .from('questions')
                .select('id, correct_answer, question_topics(topics(name, ejes(slug)))')
                .in('id', questionIds)

            if (fullQuestions) {
                fullQuestions.forEach(q => {
                    const userAnswer = (data.answers as Record<string, string>)[q.id]
                    const isCorrect = userAnswer === q.correct_answer
                    // @ts-ignore
                    const topicInner = q.question_topics[0]?.topics
                    const topicData = Array.isArray(topicInner) ? topicInner[0] : topicInner

                    // @ts-ignore
                    const ejeInner = topicData?.ejes
                    const ejeData = Array.isArray(ejeInner) ? ejeInner[0] : ejeInner

                    const ejeSlug = ejeData?.slug
                    const topicName = topicData?.name || "General"

                    let targetAxis = null
                    if (ejeSlug === 'numeros') targetAxis = processedStats.numeros
                    else if (ejeSlug === 'algebra-y-funciones') targetAxis = processedStats.algebra
                    else if (ejeSlug === 'geometria') targetAxis = processedStats.geometria
                    else if (ejeSlug === 'probabilidad-y-estadistica') targetAxis = processedStats.probabilidad

                    if (targetAxis) {
                        targetAxis.total++
                        if (isCorrect) targetAxis.correct++

                        if (!targetAxis.topics[topicName]) {
                            targetAxis.topics[topicName] = { correct: 0, total: 0 }
                        }
                        targetAxis.topics[topicName].total++
                        if (isCorrect) targetAxis.topics[topicName].correct++
                    }
                })
            }

            setStats(processedStats)
            setEnsayo(data)
            setLoading(false)
        }
        fetchResults()
    }, [id, supabase, router])

    if (loading) {
        return <div className="flex h-screen items-center justify-center"><Loader2 className="animate-spin" /></div>
    }

    const { score, total_correct, total_questions } = ensayo

    // Helper for icons
    const getAxisIcon = (slug: string) => {
        if (slug === 'numeros') return <Calculator />
        if (slug === 'algebra') return <Tangent />
        if (slug === 'geometria') return <Shapes />
        return <PieChart />
    }

    const getAxisName = (slug: string) => {
        if (slug === 'numeros') return "Números"
        if (slug === 'algebra') return "Álgebra y Funciones"
        if (slug === 'geometria') return "Geometría"
        return "Probabilidad y Estadística"
    }

    return (
        <div className="max-w-4xl mx-auto p-6 md:p-12 space-y-12">

            {/* Header / Score Card */}
            <div className="text-center space-y-6">
                <h1 className="text-3xl font-bold text-slate-800">Resultados del Ensayo</h1>

                <div className="relative inline-block group">
                    <div className="absolute inset-0 bg-blue-500 blur-2xl opacity-20 group-hover:opacity-30 transition-opacity rounded-full"></div>
                    <div className="relative bg-white border-4 border-blue-50 w-64 h-64 rounded-full flex flex-col items-center justify-center shadow-xl mx-auto">
                        <span className="text-sm font-bold text-slate-400 uppercase tracking-widest mb-2">Puntaje PAES</span>
                        <div className="text-7xl font-black text-slate-900 tracking-tighter">
                            {score}
                        </div>
                        <span className="text-blue-500 font-bold mt-2 text-lg">
                            {total_correct} / {total_questions} Correctas
                        </span>
                    </div>
                </div>

                <p className="text-slate-500 max-w-lg mx-auto text-lg">
                    {score >= 850 ? "¡Excelente trabajo! Estás en un nivel muy competitivo." :
                        score >= 700 ? "¡Muy bien! Sigue practicando para alcanzar la excelencia." :
                            "Buen esfuerzo. Revisa tus errores y enfócate en tus áreas más débiles."}
                </p>
            </div>

            {/* Axis Breakdown */}
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                {Object.entries(stats).map(([key, stat]: [string, any]) => {
                    const percentage = Math.round((stat.correct / stat.total) * 100) || 0
                    return (
                        <div key={key} className="bg-white rounded-2xl border border-slate-100 shadow-sm overflow-hidden">
                            <div className="p-6 flex items-center gap-5 border-b border-slate-50">
                                <div className={`
                                    w-14 h-14 rounded-xl flex items-center justify-center text-white shadow-lg shrink-0
                                    ${percentage >= 70 ? 'bg-green-500 shadow-green-200' :
                                        percentage >= 40 ? 'bg-blue-500 shadow-blue-200' : 'bg-orange-400 shadow-orange-200'}
                                `}>
                                    {getAxisIcon(key)}
                                </div>
                                <div className="flex-1 space-y-2">
                                    <div className="flex justify-between items-center">
                                        <h3 className="font-bold text-slate-700">{getAxisName(key)}</h3>
                                        <span className={`font-black text-lg ${percentage >= 70 ? 'text-green-600' : percentage >= 40 ? 'text-blue-600' : 'text-orange-500'}`}>
                                            {percentage}%
                                        </span>
                                    </div>
                                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                                        <div
                                            className={`h-full rounded-full ${percentage >= 70 ? 'bg-green-500' : percentage >= 40 ? 'bg-blue-500' : 'bg-orange-400'}`}
                                            style={{ width: `${percentage}%` }}
                                        />
                                    </div>
                                    <p className="text-xs text-slate-400 font-medium">
                                        {stat.correct} de {stat.total} respuestas correctas
                                    </p>
                                </div>
                            </div>

                            {/* Topic Breakdown */}
                            <div className="bg-slate-50/50 p-4 space-y-3">
                                <h4 className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Detalle por Tema</h4>
                                {Object.entries(stat.topics).map(([topicName, topicStat]: [string, any]) => {
                                    const topicPct = Math.round((topicStat.correct / topicStat.total) * 100) || 0
                                    return (
                                        <div key={topicName} className="flex flex-col gap-1">
                                            <div className="flex justify-between text-sm">
                                                <span className="text-slate-600 font-medium">{topicName}</span>
                                                <span className={`font-bold ${topicPct >= 70 ? 'text-green-600' : topicPct >= 40 ? 'text-blue-600' : 'text-orange-500'}`}>
                                                    {topicStat.correct}/{topicStat.total} ({topicPct}%)
                                                </span>
                                            </div>
                                            <div className="w-full bg-slate-200 h-1.5 rounded-full overflow-hidden">
                                                <div
                                                    className={`h-full rounded-full ${topicPct >= 70 ? 'bg-green-500' : topicPct >= 40 ? 'bg-blue-500' : 'bg-orange-400'}`}
                                                    style={{ width: `${topicPct}%` }}
                                                />
                                            </div>
                                        </div>
                                    )
                                })}
                            </div>
                        </div>
                    )
                })}
            </div>

            {/* Actions */}
            <div className="flex justify-center gap-4 pt-8">
                <Link href="/app/ensayos">
                    <Button variant="outline" size="lg" className="px-8 border-slate-200 text-slate-600 hover:bg-slate-50">
                        <RotateCcw className="mr-2 h-4 w-4" />
                        Volver a Ensayos
                    </Button>
                </Link>
                <Link href="/app">
                    <Button size="lg" className="px-8 bg-slate-900 text-white hover:bg-slate-800 shadow-lg shadow-slate-200">
                        Ir al Dashboard
                    </Button>
                </Link>
            </div>
        </div>
    )
}
