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
                numeros: { correct: 0, total: 0 },
                algebra: { correct: 0, total: 0 },
                geometria: { correct: 0, total: 0 },
                probabilidad: { correct: 0, total: 0 }
            }

            // Logic to populate processedStats by iterating questions_data
            // We need correct answers for this to work 100% client side if not returned by API
            // But wait, the questions_data usually stores the QUESTION content, not the result.
            // The score is in data.score.
            // The breakdown might need an extra RPC call or logic if we want details.
            // Let's assume we call a helper RPC "get_ensayo_results" or similar, OR we improve the previous RPC to save stats.
            // As a fallback, we can fetch question details.
            // Actually, let's create a small helper function here to simulate the breakdown if data.axis_stats isn't available.

            // To be precise: The submit RPC returned the stats, but didn't save them in a structured column (just updated score).
            // We should have saved the detailed stats or returned them. 
            // In a real app, storing `results_summary` JSONB on the ensayo row is best.
            // For now, we will perform a quick calculation if we have the answers.
            // Limitation: We don't have the "correct_answer" visible on the client in questions_data for security (usually).
            // Valid constraint: The client shouldn't know correct answers until after submission.
            // Fix: We'll fetch the FULL question data (including correct answer) since the exam is COMPLETED.

            const questionIds = (data.questions_data as any[]).map(q => q.question_id)
            const { data: fullQuestions } = await supabase
                .from('questions')
                .select('id, correct_answer, question_topics(topics(ejes(slug)))')
                .in('id', questionIds)

            if (fullQuestions) {
                fullQuestions.forEach(q => {
                    const userAnswer = (data.answers as Record<string, string>)[q.id]
                    const isCorrect = userAnswer === q.correct_answer
                    // @ts-ignore
                    const ejeSlug = q.question_topics[0]?.topics?.ejes?.slug

                    if (ejeSlug === 'numeros') {
                        processedStats.numeros.total++
                        if (isCorrect) processedStats.numeros.correct++
                    } else if (ejeSlug === 'algebra-y-funciones') {
                        processedStats.algebra.total++
                        if (isCorrect) processedStats.algebra.correct++
                    } else if (ejeSlug === 'geometria') {
                        processedStats.geometria.total++
                        if (isCorrect) processedStats.geometria.correct++
                    } else if (ejeSlug === 'probabilidad-y-estadistica') {
                        processedStats.probabilidad.total++
                        if (isCorrect) processedStats.probabilidad.correct++
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
                        <div key={key} className="bg-white p-6 rounded-2xl border border-slate-100 shadow-sm flex items-center gap-5">
                            <div className={`
                                w-14 h-14 rounded-xl flex items-center justify-center text-white shadow-lg
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
