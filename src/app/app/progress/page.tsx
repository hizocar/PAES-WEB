"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { BarChart3, Clock, Target, TrendingUp } from "lucide-react"
import { useSubject } from "@/components/providers/SubjectContext"

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
                .select('is_correct, question_id, questions!inner(subject)')
                .eq('user_id', user.id)
                .eq('questions.subject', subject)

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
                                {ejeProgress.reduce((acc, curr) => acc + curr.total_attempts, 0)}
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            {/* Ejes List */}
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
