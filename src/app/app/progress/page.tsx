"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { BarChart3, Clock, Target, TrendingUp, Lock, Brain, LineChart as LineChartIcon } from "lucide-react"
import { useSubject } from "@/components/providers/SubjectContext"
import {
    LineChart,
    Line,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer
} from "recharts"

// Since we don't have a dedicated Card component yet, I'll use raw tailwind for containers
// or simple divs.

type EjeProgress = {
    id: string
    name: string
    total_attempts: number
    correct_attempts: number
    accuracy: number
    level: 'Principiante' | 'Intermedio' | 'Avanzado'
}

type StudyStats = {
    todaySeconds: number
    totalSeconds: number
    streakDays: number
}

export default function ProgressPage() {
    const supabase = createClient()
    const { subject } = useSubject()
    const [loading, setLoading] = useState(true)
    const [stats, setStats] = useState<StudyStats>({ todaySeconds: 0, totalSeconds: 0, streakDays: 0 })
    const [ejeProgress, setEjeProgress] = useState<EjeProgress[]>([])

    // Advanced Stats States
    const [totalAttemptsCount, setTotalAttemptsCount] = useState(0)
    const [isUnlocked, setIsUnlocked] = useState(false)
    const [scoreHistory, setScoreHistory] = useState<any[]>([])
    const [matrixStats, setMatrixStats] = useState<any[]>([])
    const [predictedScore, setPredictedScore] = useState<number | null>(null)

    const LOCK_THRESHOLD = 100

    useEffect(() => {
        fetchData()
    }, [subject])

    const fetchData = async () => {
        setLoading(true)
        try {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            // 1. Fetch Study Sessions (Stats)
            const { data: sessions } = await supabase
                .from('study_sessions')
                .select('duration_seconds, started_at')
                .eq('user_id', user.id)
                .eq('subject', subject)

            let today = 0
            let total = 0
            const now = new Date()
            const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate()).toISOString()

            sessions?.forEach(s => {
                const dur = s.duration_seconds || 0
                total += dur
                if (s.started_at >= startOfDay) {
                    today += dur
                }
            })

            setStats({
                todaySeconds: today,
                totalSeconds: total,
                streakDays: 1
            })

            // 2. Fetch All Ejes for current subject
            const { data: allEjes } = await supabase
                .from('ejes')
                .select('id, name')
                .eq('subject', subject)

            // 3. Fetch User Attempts for current subject
            const { data: attempts } = await supabase
                .from('attempts')
                .select('is_correct, question_id, created_at, questions!inner(subject)')
                .eq('user_id', user.id)
                .eq('questions.subject', subject)

            const attemptCount = attempts?.length || 0
            setTotalAttemptsCount(attemptCount)
            const unlocked = attemptCount >= LOCK_THRESHOLD
            setIsUnlocked(unlocked)

            // 4. Map Questions to Ejes
            const qIds = attempts?.map(a => a.question_id) || []
            const uniqueQIds = Array.from(new Set(qIds))

            let qEjeMap: Record<string, string> = {} // question_id -> eje_name

            if (uniqueQIds.length > 0) {
                const { data: qTopics } = await supabase
                    .from('question_topics')
                    .select('question_id, topics(ejes(name))')
                    .in('question_id', uniqueQIds)

                qTopics?.forEach((row: any) => {
                    const ejeName = row.topics?.ejes?.name
                    if (ejeName) {
                        qEjeMap[row.question_id] = ejeName
                    }
                })
            }

            // 5. Aggregate Stats per Eje
            const progressMap: Record<string, { total: number, correct: number }> = {}

            // Initialize with all ejes
            allEjes?.forEach(eje => {
                progressMap[eje.name] = { total: 0, correct: 0 }
            })

            attempts?.forEach(a => {
                const ejeName = qEjeMap[a.question_id]
                if (ejeName && progressMap[ejeName]) {
                    progressMap[ejeName].total++
                    if (a.is_correct) progressMap[ejeName].correct++
                }
            })

            // 6. Calculate Proficiency and Format
            const finalProgress: EjeProgress[] = allEjes?.map(eje => {
                const stats = progressMap[eje.name]
                const accuracy = stats.total > 0 ? Math.round((stats.correct / stats.total) * 100) : 0

                let level: 'Principiante' | 'Intermedio' | 'Avanzado' = 'Principiante'
                if (stats.total > 0) {
                    if (accuracy >= 70) level = 'Avanzado'
                    else if (accuracy >= 40) level = 'Intermedio'
                }

                return {
                    id: eje.id,
                    name: eje.name,
                    total_attempts: stats.total,
                    correct_attempts: stats.correct,
                    accuracy,
                    level
                }
            }) || []

            setEjeProgress(finalProgress)

            // 7. Fetch Advaned Stats if Unlocked
            if (unlocked) {
                // Fetch History
                const { data: historyData } = await supabase.rpc('get_student_score_history', {
                    p_user_id: user.id,
                    p_subject: subject
                })
                if (historyData) {
                    setScoreHistory(historyData)
                    if (historyData.length > 0) {
                        setPredictedScore(historyData[historyData.length - 1].estimated_score)
                    }
                }

                // Fetch Performance Matrix
                const { data: performanceData } = await supabase.rpc('get_admin_student_performance', {
                    p_user_id: user.id,
                    p_subject: subject
                })

                if (performanceData && performanceData.matrix) {
                    setMatrixStats(performanceData.matrix)
                }
            } else {
                setScoreHistory([])
                setMatrixStats([])
                setPredictedScore(null)
            }

        } catch (e) {
            console.error(e)
        } finally {
            setLoading(false)
        }
    }

    const formatTime = (secs: number) => {
        const h = Math.floor(secs / 3600)
        const m = Math.floor((secs % 3600) / 60)
        if (h > 0) return `${h}h ${m}m`
        return `${m}m`
    }

    const getLevelColor = (level: string) => {
        switch (level) {
            case 'Avanzado': return 'bg-green-100 text-green-700 border-green-200'
            case 'Intermedio': return 'bg-yellow-100 text-yellow-700 border-yellow-200'
            default: return 'bg-slate-100 text-slate-600 border-slate-200'
        }
    }

    const getBarColor = (level: string) => {
        switch (level) {
            case 'Avanzado': return 'bg-green-500'
            case 'Intermedio': return 'bg-yellow-500'
            default: return 'bg-slate-400'
        }
    }

    if (loading) {
        return (
            <div className="flex h-[50vh] items-center justify-center">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-slate-900"></div>
            </div>
        )
    }

    return (
        <div className="p-8 max-w-6xl mx-auto space-y-10 mb-20">
            <div>
                <h1 className="text-3xl font-bold text-slate-900">Tu Progreso 🚀</h1>
                <p className="text-slate-500 mt-2">Mantén la racha y domina cada eje temático.</p>
            </div>

            {/* Stats Grid */}
            <div className="grid md:grid-cols-3 gap-6">
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div className="flex items-center gap-4 mb-4">
                        <div className="p-3 bg-blue-100 text-blue-600 rounded-xl">
                            <Clock size={24} />
                        </div>
                        <div>
                            <p className="text-sm text-slate-500 font-medium">Tiempo Hoy</p>
                            <h3 className="text-2xl font-bold text-slate-900">{formatTime(stats.todaySeconds)}</h3>
                        </div>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div className="flex items-center gap-4 mb-4">
                        <div className="p-3 bg-green-100 text-green-600 rounded-xl">
                            <Target size={24} />
                        </div>
                        <div>
                            <p className="text-sm text-slate-500 font-medium">Tiempo Total</p>
                            <h3 className="text-2xl font-bold text-slate-900">{formatTime(stats.totalSeconds)}</h3>
                        </div>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100">
                    <div className="flex items-center gap-4 mb-4">
                        <div className="p-3 bg-purple-100 text-purple-600 rounded-xl">
                            <TrendingUp size={24} />
                        </div>
                        <div>
                            <p className="text-sm text-slate-500 font-medium">Ejercicios</p>
                            <h3 className="text-2xl font-bold text-slate-900">
                                {totalAttemptsCount}
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            {/* LOCKED VS UNLOCKED SECTION */}
            <div className="mt-8">
                {!isUnlocked ? (
                    <div className="bg-slate-900 text-white rounded-2xl p-8 relative overflow-hidden">
                        <div className="absolute top-0 right-0 p-12 opacity-10">
                            <Lock size={200} />
                        </div>
                        <div className="relative z-10 max-w-2xl">
                            <div className="flex items-center gap-3 mb-4 text-blue-300">
                                <Lock size={24} />
                                <span className="font-bold tracking-wide text-sm uppercase">Estadísticas Avanzadas Bloqueadas</span>
                            </div>
                            <h2 className="text-3xl font-bold mb-4">Desbloquea tu Predicción de Puntaje PAES</h2>
                            <p className="text-slate-300 mb-8 text-lg">
                                Necesitamos más datos para calcular tu puntaje estimado con precisión.
                                Completa {LOCK_THRESHOLD} ejercicios para desbloquear tu predicción, gráfico de evolución y matriz de habilidades.
                            </p>

                            <div className="space-y-2">
                                <div className="flex justify-between text-sm font-medium">
                                    <span>Tu Progreso</span>
                                    <span>{totalAttemptsCount} / {LOCK_THRESHOLD} ejercicios</span>
                                </div>
                                <div className="h-4 w-full bg-slate-800 rounded-full overflow-hidden border border-slate-700">
                                    <div
                                        className="h-full bg-blue-500 rounded-full transition-all duration-1000 ease-out relative"
                                        style={{ width: `${Math.min((totalAttemptsCount / LOCK_THRESHOLD) * 100, 100)}%` }}
                                    >
                                        <div className="absolute inset-0 bg-white/20 animate-pulse"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                ) : (
                    <div className="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-700">
                        {/* UNLOCKED: Score & Evolution */}
                        <div className="grid lg:grid-cols-3 gap-6">
                            {/* Score Card */}
                            <div className="bg-gradient-to-br from-blue-600 to-indigo-700 rounded-2xl p-8 text-white shadow-lg flex flex-col justify-between relative overflow-hidden">
                                <div className="absolute top-0 right-0 p-8 opacity-20">
                                    <Brain size={120} />
                                </div>
                                <div className="relative z-10">
                                    <div className="flex items-center gap-2 text-blue-100 mb-1">
                                        <Brain size={20} />
                                        <h3 className="font-bold uppercase tracking-wider text-sm">Puntaje PAES Estimado</h3>
                                    </div>
                                    <div className="text-6xl font-black mb-2 tracking-tight">
                                        {predictedScore || "---"}
                                    </div>
                                    <p className="text-blue-100 text-sm">
                                        Basado en tu precisión histórica y dificultad de preguntas.
                                    </p>
                                </div>
                                <div className="mt-8 pt-6 border-t border-white/20 relative z-10">
                                    <div className="flex justify-between items-center text-sm">
                                        <span className="font-medium">Tendencia</span>
                                        <span className="bg-white/20 px-3 py-1 rounded-full text-xs font-bold">
                                            ACTUALIZADO HOY
                                        </span>
                                    </div>
                                </div>
                            </div>

                            {/* Evolution Chart */}
                            <div className="lg:col-span-2 bg-white p-6 rounded-2xl border border-slate-100 shadow-sm">
                                <h3 className="font-bold text-slate-800 mb-6 flex items-center gap-2">
                                    <LineChartIcon className="text-blue-600" size={20} /> Evolución de tu Puntaje
                                </h3>
                                <div className="h-[250px] w-full">
                                    <ResponsiveContainer width="100%" height="100%">
                                        <LineChart data={scoreHistory}>
                                            <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#f1f5f9" />
                                            <XAxis
                                                dataKey="date"
                                                tickFormatter={(date) => new Date(date).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}
                                                stroke="#94a3b8"
                                                fontSize={12}
                                                tickLine={false}
                                                axisLine={false}
                                                dy={10}
                                            />
                                            <YAxis
                                                stroke="#94a3b8"
                                                fontSize={12}
                                                tickLine={false}
                                                axisLine={false}
                                                domain={[300, 1000]}
                                                dx={-10}
                                            />
                                            <Tooltip
                                                content={({ active, payload, label }) => {
                                                    if (active && payload && payload.length && label) {
                                                        return (
                                                            <div className="bg-slate-800 text-white text-xs p-3 rounded-lg shadow-xl border border-slate-700">
                                                                <p className="font-bold mb-2 text-slate-300">{new Date(label).toLocaleDateString()}</p>
                                                                <div className="flex flex-col gap-1">
                                                                    <span className="text-lg font-black">{payload[0].value} pts</span>
                                                                    <span className="text-slate-400">Estimado</span>
                                                                </div>
                                                            </div>
                                                        )
                                                    }
                                                    return null
                                                }}
                                            />
                                            <Line
                                                type="monotone"
                                                dataKey="estimated_score"
                                                stroke="#2563eb"
                                                strokeWidth={3}
                                                dot={{ r: 4, fill: "#2563eb", strokeWidth: 2, stroke: "#fff" }}
                                                activeDot={{ r: 6, strokeWidth: 0 }}
                                            />
                                        </LineChart>
                                    </ResponsiveContainer>
                                </div>
                            </div>
                        </div>

                        {/* Performance Matrix */}
                        <div className="space-y-6">
                            <h2 className="text-xl font-bold text-slate-900">Matriz de Rendimiento (Detallado)</h2>
                            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-4">
                                {matrixStats.map((item, idx) => (
                                    <div key={idx} className="bg-white p-5 rounded-xl border border-slate-100 shadow-sm hover:shadow-md transition-shadow">
                                        <div className="text-xs font-bold text-blue-600 uppercase tracking-wider mb-1">
                                            {item.eje_name}
                                        </div>
                                        <h4 className="font-bold text-slate-800 mb-2 line-clamp-2 min-h-[3rem]">
                                            {item.topic_name}
                                        </h4>
                                        <div className="flex justify-between items-center text-sm text-slate-500 mb-3">
                                            <span className="bg-slate-100 px-2 py-1 rounded text-xs font-medium">{item.skill_name}</span>
                                        </div>

                                        <div className="flex items-end justify-between">
                                            <div className="flex gap-1">
                                                {/* Simple pills for score visualization */}
                                                {[20, 40, 60, 80, 100].map((t) => (
                                                    <div
                                                        key={t}
                                                        className={`h-1.5 w-6 rounded-full ${item.progress >= t ?
                                                            (item.progress >= 70 ? 'bg-green-500' : item.progress >= 40 ? 'bg-yellow-400' : 'bg-red-400')
                                                            : 'bg-slate-100'}`}
                                                    />
                                                ))}
                                            </div>
                                            <span className="font-black text-lg text-slate-900">{item.progress}%</span>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                )}
            </div>

            {/* Ejes List (Always Visible) */}
            <div className="space-y-6">
                <h2 className="text-xl font-bold text-slate-900">Rendimiento por Eje Temático</h2>
                <div className="grid gap-4">
                    {ejeProgress.map((eje) => (
                        <div key={eje.id} className="bg-white p-6 rounded-xl border border-slate-100 shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-6">
                            <div className="w-full md:w-1/3">
                                <h3 className="font-bold text-lg text-slate-800">{eje.name}</h3>
                                <p className="text-xs text-slate-400 font-medium mt-1">{eje.total_attempts} preguntas intentadas</p>
                            </div>

                            <div className="flex-1 w-full">
                                <div className="flex justify-between text-xs mb-2 font-medium">
                                    <span className="text-slate-500">Precisión Actual</span>
                                    <span className="text-slate-900 font-bold">
                                        {eje.accuracy}%
                                    </span>
                                </div>
                                <div className="h-3 w-full bg-slate-100 rounded-full overflow-hidden">
                                    <div
                                        className={`h-full rounded-full transition-all duration-500 ${getBarColor(eje.level)}`}
                                        style={{ width: `${eje.accuracy}%` }}
                                    />
                                </div>
                            </div>

                            <div className="w-full md:w-auto flex justify-end">
                                <span className={`px-4 py-2 rounded-lg text-xs font-bold uppercase tracking-wider border ${getLevelColor(eje.level)}`}>
                                    {eje.level}
                                </span>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )
}
