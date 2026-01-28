"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { BarChart3, Clock, Target, TrendingUp, ArrowRight, Flame } from "lucide-react"
import Link from "next/link"
import { MascotCard } from "@/components/dashboard/MascotCard"

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
        <div className="p-6 max-w-7xl mx-auto space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h1 className="text-2xl font-bold text-slate-900">Hola, Futuro Universitario 👋</h1>
                    <p className="text-sm text-slate-500 mt-1">Continuemos tu preparación para los 1000 puntos.</p>
                </div>
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
                {/* Mascot / Lives */}
                <MascotCard />

                {/* Meta Diaria */}
                <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-semibold text-sm">Meta Diaria</h3>
                            <div className="text-3xl font-bold text-slate-900 mt-2 whitespace-nowrap">
                                {stats.dailyProgress} / {stats.dailyTarget}
                            </div>
                            <p className={`text-xs mt-1 font-medium ${stats.dailyProgress >= stats.dailyTarget ? 'text-green-600' : 'text-slate-400'}`}>
                                {stats.dailyProgress >= stats.dailyTarget
                                    ? "¡Meta cumplida!"
                                    : `Faltan ${stats.dailyTarget - stats.dailyProgress}`}
                            </p>
                        </div>
                        <div className={`w-10 h-10 rounded-lg flex items-center justify-center text-xl ${stats.dailyProgress >= stats.dailyTarget ? 'bg-green-100 text-green-600' : 'bg-slate-100 text-slate-400'}`}>
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
                <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-semibold text-sm">Precisión Global</h3>
                            <div className="text-3xl font-bold text-slate-900 mt-2">{stats.globalAccuracy}%</div>
                            <p className="text-xs text-slate-400 mt-1">Últimos 7 días</p>
                        </div>
                        <div className="w-10 h-10 bg-blue-100 text-blue-600 rounded-lg flex items-center justify-center text-xl">
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
                <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40 bg-gradient-to-br from-orange-500 to-red-500 text-white">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-orange-100 font-semibold text-sm">Racha Actual</h3>
                            <div className="text-3xl font-bold mt-2 flex items-baseline gap-1">
                                {stats.streak} <span className="text-sm font-medium opacity-90">días</span>
                            </div>
                            <p className="text-xs text-orange-100 mt-1">
                                {stats.dailyProgress >= stats.dailyTarget
                                    ? "¡Racha extendida! 🔥"
                                    : "Completa la meta diaria"}
                            </p>
                        </div>
                        <div className="w-10 h-10 bg-white/20 rounded-lg flex items-center justify-center backdrop-blur-sm">
                            <Flame className="text-white" size={20} fill="currentColor" />
                        </div>
                    </div>
                    <div className="w-full bg-black/20 h-2 rounded-full overflow-hidden mt-1">
                        <div
                            className="bg-white h-full transition-all duration-1000"
                            style={{ width: `${Math.min((stats.dailyProgress / stats.dailyTarget) * 100, 100)}%` }}
                        />
                    </div>
                </div>
            </div>

            {/* Ejes Grid */}
            <div>
                <h2 className="text-xl font-bold text-slate-900 mb-4">Tus Ejes Temáticos</h2>
                <div className="grid md:grid-cols-3 gap-4">
                    {ejes.map((eje) => (
                        <Link href="/app/progress" key={eje.id}>
                            <div className="group bg-white p-4 rounded-xl border border-slate-100 shadow-sm hover:shadow-md transition-all cursor-pointer flex items-center justify-between h-full">
                                <div className="flex items-center gap-4">
                                    <div className="w-10 h-10 rounded-full bg-slate-100 group-hover:bg-blue-50 transition-colors flex items-center justify-center text-slate-500 group-hover:text-blue-600 font-bold text-lg">
                                        {eje.name.charAt(0)}
                                    </div>
                                    <div>
                                        <h3 className="font-bold text-sm text-slate-900 line-clamp-1">{eje.name}</h3>
                                        <p className="text-xs text-slate-500 mt-0.5">{eje.progress}% precisión</p>
                                    </div>
                                </div>
                                <div className="w-8 h-8 rounded-full border border-slate-200 flex items-center justify-center text-slate-300 group-hover:border-blue-200 group-hover:text-blue-500 transition-colors shrink-0">
                                    <ArrowRight size={16} />
                                </div>
                            </div>
                        </Link>
                    ))}
                    {ejes.length === 0 && (
                        <div className="col-span-3 text-center py-8 text-slate-500 text-sm">
                            Cargando ejes temáticos...
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
