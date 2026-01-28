"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { BarChart3, Clock, Target, TrendingUp, ArrowRight, Flame, Heart, Zap, Trophy, AlertCircle } from "lucide-react"
import Link from "next/link"

import { AchievementNotification } from "@/components/achievements/AchievementNotification"

export default function DashboardPage() {
    const [loading, setLoading] = useState(true)
    const [unlockedAchievement, setUnlockedAchievement] = useState<any>(null)

    // Stats State
    const [stats, setStats] = useState({
        dailyProgress: 0,
        dailyTarget: 10,
        globalAccuracy: 0,
        totalAttemptsLast7Days: 0,
        streak: 0,
        lives: null as number | null,
        replenishAt: null as string | null,
        rank: null as number | null,
        score: 0,
        mistakes: 0
    })
    const [timeLeft, setTimeLeft] = useState<string>("")
    const [ejes, setEjes] = useState<any[]>([])

    const supabase = createClient()

    useEffect(() => {
        const init = async () => {
            // Check for Streak Achievements
            const { data: { user } } = await supabase.auth.getUser()
            if (user) {
                const { data: newAchievements } = await supabase
                    .rpc('check_and_unlock_achievement', {
                        p_user_id: user.id,
                        p_trigger_type: 'STREAK'
                    })

                if (newAchievements && newAchievements.length > 0) {
                    setUnlockedAchievement(newAchievements[0])
                }
            }

            fetchDashboardData()
        }
        init()
    }, [])

    // Timer logic for lives
    useEffect(() => {
        if (stats.lives === null || (stats.lives > 0) || !stats.replenishAt) return

        const updateTimer = () => {
            const now = new Date()
            const end = new Date(stats.replenishAt!)
            const diff = end.getTime() - now.getTime()

            if (diff <= 0) {
                setTimeLeft("00:00:00")
                return
            }

            const hrs = Math.floor(diff / (1000 * 60 * 60))
            const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
            const secs = Math.floor((diff % (1000 * 60)) / 1000)

            setTimeLeft(
                `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
            )
        }

        updateTimer()
        const interval = setInterval(updateTimer, 1000)
        return () => clearInterval(interval)
    }, [stats.lives, stats.replenishAt])

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

            // 3. Streak
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
                const todayStr = now.toISOString().split('T')[0]
                let checkDate = new Date(now)
                const todayDone = (attemptsByDay[todayStr] || 0) >= 10
                if (!todayDone) {
                    checkDate.setDate(checkDate.getDate() - 1)
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

            // 4. Fetch Lives
            let currentLives = null
            let replenishAt = null
            const { data: livesData } = await supabase.rpc('check_and_replenish_lives', { p_user_id: user.id })
            if (livesData && livesData.length > 0) {
                currentLives = livesData[0].current_lives
                replenishAt = livesData[0].replenish_at
            }

            // 5. Fetch Rank & Score
            let userRank = null
            let userScore = 0
            const { data: leaderboardData } = await supabase.rpc('get_leaderboard')
            if (leaderboardData) {
                const myEntry = leaderboardData.find((u: any) => u.user_id === user.id)
                if (myEntry) {
                    userRank = myEntry.rank
                    userScore = myEntry.score
                }
            }

            // 6. Calculate Mistakes (Questions failed and NEVER corrected)
            const { data: allAttempts } = await supabase
                .from('attempts')
                .select('question_id, is_correct')
                .eq('user_id', user.id)

            const questionStatus: Record<string, { hasCorrect: boolean, hasWrong: boolean }> = {}

            allAttempts?.forEach(a => {
                if (!questionStatus[a.question_id]) questionStatus[a.question_id] = { hasCorrect: false, hasWrong: false }
                if (a.is_correct) questionStatus[a.question_id].hasCorrect = true
                else questionStatus[a.question_id].hasWrong = true
            })

            const activeMistakes = Object.values(questionStatus).filter(s => s.hasWrong && !s.hasCorrect).length

            setStats({
                dailyProgress: currentDailyProgress,
                dailyTarget: 10,
                globalAccuracy: accuracy,
                totalAttemptsLast7Days: recentAttempts?.length || 0,
                streak: currentStreak,
                lives: currentLives,
                replenishAt: replenishAt,
                rank: userRank,
                score: userScore,
                mistakes: activeMistakes
            })

            // 7. Fetch Ejes (for chart below)
            const { data: allEjes } = await supabase.from('ejes').select('id, name')

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

            const processedEjes = allEjes?.map(eje => {
                const ejeAttempts = allAttempts?.filter(a => qEjeMap[a.question_id] === eje.name) || []
                const correct = ejeAttempts.filter(a => a.is_correct).length
                const total = ejeAttempts.length
                const acc = total > 0 ? Math.round((correct / total) * 100) : 0

                return {
                    ...eje,
                    progress: acc,
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
            <AchievementNotification
                achievement={unlockedAchievement}
                onClose={() => setUnlockedAchievement(null)}
            />
            <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-4">
                <div className="w-full">
                    <div className="flex items-center justify-between w-full">
                        <h1 className="text-2xl font-bold text-slate-900">Hola, Futuro Universitario 👋</h1>
                        {/* Streak Badge (Mobile Right) */}
                        <div className="md:hidden flex items-center gap-1.5 px-2 py-1 bg-orange-50 text-orange-600 rounded-full border border-orange-100 shadow-sm shrink-0">
                            <Flame size={12} className="fill-orange-500" />
                            <span className="text-xs font-bold">{stats.streak} días</span>
                        </div>
                    </div>

                    <div className="flex items-center gap-3 mt-1">
                        <p className="text-sm text-slate-500">Continuemos tu preparación.</p>
                        {/* Streak Badge (Desktop) */}
                        <div className="hidden md:flex items-center gap-1.5 px-3 py-1 bg-orange-50 text-orange-600 rounded-full border border-orange-100 shadow-sm" title="Racha de días seguidos">
                            <Flame size={14} className="fill-orange-500" />
                            <span className="text-sm font-bold">{stats.streak} días</span>
                        </div>
                    </div>
                </div>
                {stats.lives !== null && stats.lives > 0 && (
                    <Link href="/app/practice" className="w-full md:w-auto">
                        <Button size="lg" className="w-full md:w-auto bg-blue-600 hover:bg-blue-700 text-white shadow-md hover:shadow-lg transition-all transform hover:-translate-y-0.5 font-bold text-base px-6 h-12 rounded-xl">
                            <Zap className="w-5 h-5 mr-2 fill-current" />
                            ¡Practicar Ahora!
                        </Button>
                    </Link>
                )}
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-4">
                {/* Vidas Card (Simple) */}
                <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-semibold text-sm">Vidas</h3>
                            {stats.lives && stats.lives > 0 ? (
                                <div className="text-3xl font-bold text-slate-900 mt-2 flex items-center gap-2">
                                    {stats.lives}
                                </div>
                            ) : (
                                <div className="text-xl font-bold text-slate-900 mt-2 font-mono text-red-600">
                                    {timeLeft}
                                </div>
                            )}
                            <p className="text-xs text-slate-400 mt-1">
                                {stats.lives && stats.lives > 0 ? "¡Sigue así!" : "Recargando..."}
                            </p>
                        </div>
                        <div className="w-10 h-10 bg-red-50 text-red-500 rounded-lg flex items-center justify-center">
                            {stats.lives === 0 ? <Clock size={20} /> : <Heart size={20} className="fill-red-500" />}
                        </div>
                    </div>
                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                        <div
                            className={`h-full transition-all duration-1000 ${stats.lives && stats.lives > 1 ? 'bg-red-500' : 'bg-red-300'}`}
                            style={{ width: `${Math.min(((stats.lives || 0) / 5) * 100, 100)}%` }}
                        />
                    </div>
                </div>

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

                {/* Ranking */}
                <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-semibold text-sm">Tu Ranking</h3>
                            <div className="text-3xl font-bold text-slate-900 mt-2 flex items-center gap-2">
                                {stats.rank ? `#${stats.rank}` : '-'}
                            </div>
                            <p className="text-xs text-slate-400 mt-1">
                                {stats.score} pts totales
                            </p>
                        </div>
                        <div className="w-10 h-10 bg-yellow-100 text-yellow-600 rounded-lg flex items-center justify-center">
                            <Trophy size={20} className="fill-yellow-600" />
                        </div>
                    </div>
                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                        <div
                            className="bg-yellow-500 h-full transition-all duration-1000"
                            style={{ width: `${Math.max(5, Math.min(stats.score / 10, 100))}%` }}
                        />
                    </div>
                </div>

                {/* Banco de Errores */}
                <Link href="/app/practice?mode=retry">
                    <div className="bg-white p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-40 hover:border-red-200 hover:shadow-md transition-all cursor-pointer group">
                        <div className="flex items-start justify-between">
                            <div>
                                <h3 className="text-slate-500 font-semibold text-sm group-hover:text-red-500 transition-colors">Banco de Errores</h3>
                                <div className="text-3xl font-bold text-slate-900 mt-2 flex items-center gap-2">
                                    {stats.mistakes}
                                </div>
                                <p className="text-xs text-slate-400 mt-1">
                                    {stats.mistakes > 0 ? "Preguntas por corregir" : "¡Todo limpio!"}
                                </p>
                            </div>
                            <div className="w-10 h-10 bg-red-50 text-red-500 rounded-lg flex items-center justify-center group-hover:scale-110 transition-transform">
                                <AlertCircle size={20} />
                            </div>
                        </div>
                        <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                            <div
                                className={`h-full transition-all duration-1000 ${stats.mistakes > 5 ? 'bg-red-500' : 'bg-green-500'}`}
                                style={{ width: `${Math.min(stats.mistakes * 5, 100)}%` }}
                            />
                        </div>
                    </div>
                </Link>
            </div>

            {/* Ejes Grid */}
            <div>
                <h2 className="text-xl font-bold text-slate-900 mb-4">Tus Ejes Temáticos</h2>
                <div className="grid md:grid-cols-2 lg:grid-cols-2 gap-4">
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
                        <div className="col-span-2 text-center py-8 text-slate-500 text-sm">
                            Cargando ejes temáticos...
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
