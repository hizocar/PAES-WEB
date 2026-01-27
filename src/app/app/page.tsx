"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { BarChart3, Clock, Target, TrendingUp, ArrowRight, Flame } from "lucide-react"
import Link from "next/link"

export default function DashboardPage() {
    const [loading, setLoading] = useState(true)
    const [stats, setStats] = useState({
        dailyProgress: 0,
        dailyTarget: 10,
        globalAccuracy: 0,
        totalAttemptsLast7Days: 0,
        streak: 0,
        subscribed: false
    })
    const [ejes, setEjes] = useState<any[]>([])

    const supabase = createClient()

    useEffect(() => {
        fetchDashboardData()
    }, [])

    const fetchDashboardData = async () => {
        try {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            const now = new Date()
            const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate()).toISOString()
            const sevenDaysAgo = new Date(now.getTime() - 7 * 24 * 60 * 60 * 1000).toISOString()

            // 1. Fetch Attempts for Daily Goal (Today)
            const { count: todayCount } = await supabase
                .from('attempts')
                .select('*', { count: 'exact', head: true })
                .eq('user_id', user.id)
                .gte('created_at', startOfDay)

            const currentDailyProgress = todayCount || 0

            // 2. Fetch Attempts for Proficiency (Last 7 Days)
            const { data: recentAttempts } = await supabase
                .from('attempts')
                .select('is_correct')
                .eq('user_id', user.id)
                .gte('created_at', sevenDaysAgo)

            let accuracy = 0
            if (recentAttempts && recentAttempts.length > 0) {
                const correct = recentAttempts.filter(a => a.is_correct).length
                accuracy = Math.round((correct / recentAttempts.length) * 100)
            }

            // 3. Calculate Streak (Client-side for MVP)
            // Fetch daily counts for the last 60 days
            const sixtyDaysAgo = new Date(now.getTime() - 60 * 24 * 60 * 60 * 1000).toISOString()
            const { data: streakAttempts } = await supabase
                .from('attempts')
                .select('created_at')
                .eq('user_id', user.id)
                .gte('created_at', sixtyDaysAgo)
                .order('created_at', { ascending: false })

            let currentStreak = 0

            if (streakAttempts && streakAttempts.length > 0) {
                const attemptsByDay: Record<string, number> = {}
                streakAttempts.forEach(a => {
                    const day = new Date(a.created_at).toISOString().split('T')[0]
                    attemptsByDay[day] = (attemptsByDay[day] || 0) + 1
                })

                // Check dates going backward from today or yesterday
                const todayStr = now.toISOString().split('T')[0]
                const yesterday = new Date(now)
                yesterday.setDate(yesterday.getDate() - 1)
                const yesterdayStr = yesterday.toISOString().split('T')[0]

                // If completed today, streak includes today. 
                // If not completed today, check if completed yesterday. 
                // If neither, streak is 0.

                let checkDate = new Date(now)

                // If we haven't hit the target today yet, we start checking from yesterday
                // because the streak isn't "broken" until the day ends without hitting target.
                // BUT, if we HAVE hit the target today, we start from today.
                const todayDone = (attemptsByDay[todayStr] || 0) >= 10

                if (!todayDone) {
                    checkDate.setDate(checkDate.getDate() - 1) // Start checking from yesterday
                }

                while (true) {
                    const dateStr = checkDate.toISOString().split('T')[0]
                    const count = attemptsByDay[dateStr] || 0
                    if (count >= 10) {
                        currentStreak++
                        checkDate.setDate(checkDate.getDate() - 1)
                    } else {
                        break
                    }
                }
            }

            setStats({
                dailyProgress: currentDailyProgress,
                dailyTarget: 10,
                globalAccuracy: accuracy,
                totalAttemptsLast7Days: recentAttempts?.length || 0,
                streak: currentStreak,
                subscribed: false
            })


            // 3. Fetch Ejes with progress
            // We need to fetch all Ejes + User's progress per eje.
            // Simplified approach: Fetch all Ejes, then fetch all user attempts, then map.
            // (Same strategy as ProgressPage for consistency)

            const { data: allEjes } = await supabase.from('ejes').select('id, name')
            const { data: allAttempts } = await supabase
                .from('attempts')
                .select('question_id, is_correct')
                .eq('user_id', user.id)

            // Map Questions to Ejes
            const qIds = allAttempts?.map(a => a.question_id) || []
            const uniqueQIds = Array.from(new Set(qIds))
            let qEjeMap: Record<string, string> = {}

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

            // Calculate completion/accuracy per Eje
            const processedEjes = allEjes?.map(eje => {
                const ejeAttempts = allAttempts?.filter(a => qEjeMap[a.question_id] === eje.name) || []
                const correct = ejeAttempts.filter(a => a.is_correct).length
                const total = ejeAttempts.length
                const acc = total > 0 ? Math.round((correct / total) * 100) : 0

                return {
                    ...eje,
                    progress: acc, // Using accuracy as "progress" for now, or could count questions done vs total questions
                    total_attempts: total
                }
            }) || []

            setEjes(processedEjes)

        } catch (error) {
            console.error("Error fetching dashboard:", error)
        } finally {
            setLoading(false)
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
        <div className="p-8 max-w-6xl mx-auto space-y-8">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-3xl font-bold text-slate-900">Hola, Futuro Universitario 👋</h1>
                    <p className="text-slate-500 mt-2">Continuemos tu preparación para los 1000 puntos.</p>
                </div>
            </div>

            <div className="grid md:grid-cols-3 gap-6">
                {/* Meta Diaria */}
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 flex flex-col justify-between h-48">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium">Meta Diaria</h3>
                            <div className="text-3xl font-bold text-slate-900 mt-2">
                                {stats.dailyProgress} / {stats.dailyTarget}
                            </div>
                            <p className={`text-sm mt-1 font-medium ${stats.dailyProgress >= stats.dailyTarget ? 'text-green-600' : 'text-slate-400'}`}>
                                {stats.dailyProgress >= stats.dailyTarget
                                    ? "¡Meta cumplida!"
                                    : `Faltan ${stats.dailyTarget - stats.dailyProgress} ejercicios`}
                            </p>
                        </div>
                        <div className={`w-10 h-10 rounded-xl flex items-center justify-center ${stats.dailyProgress >= stats.dailyTarget ? 'bg-green-100 text-green-600' : 'bg-slate-100 text-slate-400'}`}>
                            🎯
                        </div>
                    </div>
                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                        <div
                            className={`h-full transition-all duration-1000 ${stats.dailyProgress >= stats.dailyTarget ? 'bg-green-500' : 'bg-blue-500'}`}
                            style={{ width: `${Math.min((stats.dailyProgress / stats.dailyTarget) * 100, 100)}%` }}
                        />
                    </div>
                </div>

                {/* Precisión Global */}
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 flex flex-col justify-between h-48">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium">Precisión Global</h3>
                            <div className="text-3xl font-bold text-slate-900 mt-2">{stats.globalAccuracy}%</div>
                            <p className="text-sm text-slate-400 mt-1">Últimos 7 días ({stats.totalAttemptsLast7Days} respuestas)</p>
                        </div>
                        <div className="w-10 h-10 bg-blue-100 text-blue-600 rounded-xl flex items-center justify-center">
                            📈
                        </div>
                    </div>
                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                        <div
                            className={`h-full transition-all duration-1000 ${stats.globalAccuracy >= 70 ? 'bg-green-500' : stats.globalAccuracy >= 40 ? 'bg-yellow-500' : 'bg-red-500'}`}
                            style={{ width: `${stats.globalAccuracy}%` }}
                        />
                    </div>
                </div>

                {/* Racha / Streak */}
                <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 flex flex-col justify-between h-48 bg-gradient-to-br from-orange-500 to-red-500 text-white">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-orange-100 font-medium">Racha Actual</h3>
                            <div className="text-4xl font-bold mt-2 flex items-center gap-2">
                                {stats.streak} <span className="text-lg font-normal opacity-80">días</span>
                            </div>
                            <p className="text-sm text-orange-100 mt-2">
                                {stats.dailyProgress >= stats.dailyTarget
                                    ? "¡Racha extendida! 🔥"
                                    : "Completa la meta para extender 🔥"}
                            </p>
                        </div>
                        <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center backdrop-blur-sm">
                            <Flame className="text-white" size={28} fill="currentColor" />
                        </div>
                    </div>
                    {/* Mini visual indicator of streak stability or simple message */}
                    <div className="w-full bg-black/20 h-2 rounded-full overflow-hidden mt-2">
                        <div
                            className="bg-white h-full transition-all duration-1000"
                            style={{ width: `${Math.min((stats.dailyProgress / stats.dailyTarget) * 100, 100)}%` }}
                        />
                    </div>
                </div>
            </div>

            {/* Ejes Grid */}
            <div>
                <h2 className="text-xl font-bold text-slate-900 mb-6">Tus Ejes Temáticos</h2>
                <div className="grid md:grid-cols-2 gap-4">
                    {ejes.map((eje) => (
                        <Link href="/app/progress" key={eje.id}>
                            <div className="group bg-white p-5 rounded-xl border border-slate-100 shadow-sm hover:shadow-md transition-all cursor-pointer flex items-center justify-between">
                                <div className="flex items-center gap-4">
                                    <div className="w-12 h-12 rounded-full bg-slate-100 group-hover:bg-blue-50 transition-colors flex items-center justify-center text-slate-500 group-hover:text-blue-600 font-bold text-lg">
                                        {eje.name.charAt(0)}
                                    </div>
                                    <div>
                                        <h3 className="font-semibold text-slate-900">{eje.name}</h3>
                                        <p className="text-xs text-slate-500">{eje.progress}% precisión ({eje.total_attempts} intentos)</p>
                                    </div>
                                </div>
                                <div className="w-8 h-8 rounded-full border border-slate-200 flex items-center justify-center text-slate-300 group-hover:border-blue-200 group-hover:text-blue-500 transition-colors">
                                    <ArrowRight size={16} />
                                </div>
                            </div>
                        </Link>
                    ))}
                    {ejes.length === 0 && (
                        <div className="col-span-2 text-center py-8 text-slate-500">
                            Cargando ejes temáticos...
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
