"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { BarChart3, Clock, Target, TrendingUp, ArrowRight, Flame, Heart, Zap, Trophy, AlertCircle, Star } from "lucide-react"
import Link from "next/link"
import { cn } from "@/lib/utils"

import { useSubject } from "@/components/providers/SubjectContext"
import { AchievementNotification } from "@/components/achievements/AchievementNotification"
import { OnboardingTour, OnboardingStep } from "@/components/onboarding/OnboardingTour"

const DASHBOARD_STEPS: OnboardingStep[] = [
    {
        title: "¡Bienvenido a PAES Lab!",
        description: "Estamos aquí para ayudarte a entrar a la universidad de tus sueños. Vamos a darte un tour rápido por tu nuevo centro de entrenamiento.",
        icon: <Star className="text-yellow-500 fill-yellow-500" />,
        position: 'center'
    },
    {
        targetId: "tour-switcher",
        title: "Cambia de asignatura",
        description: "Puedes alternar entre M1 y M2 en cualquier momento. Cada una tiene su propio progreso, ranking y banco de errores independiente.",
        icon: <ArrowRight className="text-blue-500" />,
        position: 'right'
    },
    {
        targetId: "tour-practice",
        title: "Entrena sin límites",
        description: "En 'Practicar' encontrarás miles de ejercicios actualizados a los nuevos temarios PAES. Es el corazón de tu estudio.",
        icon: <Zap className="text-blue-500 fill-blue-500" />,
        position: 'right'
    },
    {
        targetId: "tour-mistakes",
        title: "Tus errores son tus maestros",
        description: "El 'Modo Repaso' guarda tus fallos automáticamente para que puedas volver a intentarlos hasta dominarlos.",
        icon: <Target className="text-red-500" />,
        position: 'right'
    },
    {
        targetId: "tour-lives",
        title: "Cuida tus vidas",
        description: "Cada error resta una vida. Se recargan cada 12 horas, ¡así que piensa bien tus respuestas! (O hazte Premium para ∞ vidas).",
        icon: <Heart className="text-red-500 fill-red-500" />,
        position: 'bottom'
    },
    {
        targetId: "tour-target",
        title: "Tu meta diaria",
        description: "Intenta responder al menos 10 preguntas al día. La constancia es lo que te llevará al puntaje nacional.",
        icon: <Target className="text-green-500" />,
        position: 'bottom'
    },
    {
        targetId: "tour-ranking",
        title: "Compite con Chile",
        description: "Mira cómo subes en el ranking nacional. ¡Cada punto acumulado te acerca más a la cima! Haz clic para ver la tabla completa.",
        icon: <Trophy className="text-yellow-500 fill-yellow-600" />,
        position: 'bottom'
    },
    {
        targetId: "tour-profile",
        title: "Tu identidad PAES",
        description: "Aquí puedes ver tu alias y avatar. Ve a 'Configuración' para cambiarlos y darle tu toque personal a tu perfil.",
        icon: <Star className="text-purple-500 fill-purple-500" />,
        position: 'right'
    }
]

export default function DashboardPage() {
    const { subject } = useSubject()
    const [loading, setLoading] = useState(true)
    const [unlockedAchievement, setUnlockedAchievement] = useState<any>(null)
    const [showOnboarding, setShowOnboarding] = useState(false)

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
        mistakes: 0,
        tier: 'free'
    })
    const [timeLeft, setTimeLeft] = useState<string>("")
    const [ejes, setEjes] = useState<any[]>([])

    const supabase = createClient()

    useEffect(() => {
        let isMounted = true

        const fetchData = async () => {
            setLoading(true)
            try {
                const { data: { user } } = await supabase.auth.getUser()
                if (!user) return

                // 0. Check Achievements (Streak)
                if (subject) {
                    const { data: newAchievements } = await supabase
                        .rpc('check_and_unlock_achievement', {
                            p_user_id: user.id,
                            p_trigger_type: 'STREAK',
                            p_subject: subject
                        })

                    if (isMounted && newAchievements && newAchievements.length > 0) {
                        setUnlockedAchievement(newAchievements[0])
                    }
                }

                // 1. Parallel Fetch: Stats (RPC), Lives, Leaderboard, Profile Tier
                const [statsResult, livesResult, leaderboardResult, profileResult] = await Promise.all([
                    supabase.rpc('get_dashboard_stats', { p_user_id: user.id, p_subject: subject }),
                    supabase.rpc('check_and_replenish_lives', { p_user_id: user.id, p_subject: subject }),
                    supabase.rpc('get_leaderboard', { p_subject: subject }),
                    supabase.from('profiles').select('subscription_tier, onboarding_completed').eq('id', user.id).single()
                ])

                if (!isMounted) return

                const { data: dashboardStats, error: statsError } = statsResult
                const { data: livesData } = livesResult
                const { data: leaderboardData } = leaderboardResult
                const { data: profileData, error: profileError } = profileResult

                const tier = profileData?.subscription_tier || 'free'
                const onboardingCompleted = (profileData as any)?.onboarding_completed || false

                if (!onboardingCompleted) {
                    setShowOnboarding(true)
                }

                if (statsError) throw statsError

                // Unpack RPC Data
                const currentDailyProgress = dashboardStats?.daily_progress || 0
                const activeMistakes = dashboardStats?.active_mistakes || 0
                const processedEjes = dashboardStats?.ejes_stats || []
                const currentStreak = dashboardStats?.streak || 0

                // Process Lives
                let currentLives = null
                let replenishAt = null
                if (livesData && livesData.length > 0) {
                    currentLives = livesData[0].current_lives
                    replenishAt = livesData[0].replenish_at
                }

                // Process Rank & Score
                let userRank = null
                let userScore = 0
                if (leaderboardData) {
                    const myEntry = leaderboardData.find((u: any) => u.user_id === user.id)
                    if (myEntry) {
                        userRank = myEntry.rank
                        userScore = myEntry.score
                    }
                }

                // Update State
                setStats({
                    dailyProgress: currentDailyProgress,
                    dailyTarget: 10,
                    globalAccuracy: 0,
                    totalAttemptsLast7Days: 0,
                    streak: currentStreak,
                    lives: currentLives,
                    replenishAt: replenishAt,
                    rank: userRank,
                    score: userScore,
                    mistakes: activeMistakes,
                    tier: tier
                })

                // Add tier to local state if needed or just use profileData directly
                // For now let's just use profileData for the UI logic below
                const userTier = tier
                setEjes(processedEjes)

            } catch (error) {
                console.error("Error fetching dashboard:", error)
            } finally {
                if (isMounted) setLoading(false)
            }
        }

        fetchData()

        return () => { isMounted = false }
    }, [subject])

    // Countdown logic for lives
    useEffect(() => {
        if (stats.tier !== 'free' || (stats.lives !== null && stats.lives > 0) || !stats.replenishAt) {
            return
        }

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
    }, [stats.lives, stats.replenishAt, stats.tier])

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
                            <span className="text-xs font-bold">{stats.streak} {stats.streak === 1 ? 'día' : 'días'}</span>
                        </div>
                    </div>

                    <div className="flex items-center gap-3 mt-1">
                        <p className="text-sm text-slate-500">Continuemos tu preparación.</p>
                        {/* Streak Badge (Desktop) */}
                        <div className="hidden md:flex items-center gap-1.5 px-3 py-1 bg-orange-50 text-orange-600 rounded-full border border-orange-100 shadow-sm" title="Racha de días seguidos">
                            <Flame size={14} className="fill-orange-500" />
                            <span className="text-sm font-bold">{stats.streak} {stats.streak === 1 ? 'día' : 'días'}</span>
                        </div>
                    </div>
                </div>
                {stats.lives !== null && (stats.lives > 0 || stats.tier !== 'free') && (
                    <Link href="/app/practice" className="w-full md:w-auto">
                        <Button size="lg" className="w-full md:w-auto bg-blue-600 hover:bg-blue-700 text-white shadow-md hover:shadow-lg transition-all transform hover:-translate-y-0.5 font-bold text-base px-6 h-12 rounded-xl">
                            <Zap className="w-5 h-5 mr-2 fill-current" />
                            ¡Practicar Ahora!
                        </Button>
                    </Link>
                )}
            </div>

            <div className="grid grid-cols-2 md:grid-cols-2 lg:grid-cols-4 gap-3 md:gap-4">
                {/* Vidas Card (Simple) */}
                <Link href="/app/pricing" className="group" id="tour-lives">
                    <div className="bg-white p-3 md:p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-32 md:h-40 group-hover:border-blue-200 transition-all">
                        <div className="flex items-start justify-between">
                            <div>
                                <h3 className="text-slate-500 font-semibold text-sm group-hover:text-blue-600 transition-colors">Vidas</h3>
                                {stats.tier !== 'free' ? (
                                    <div className="text-4xl md:text-5xl font-extrabold bg-gradient-to-r from-amber-500 to-yellow-300 bg-clip-text text-transparent mt-1 drop-shadow-[0_0_8px_rgba(245,158,11,0.3)]">
                                        ∞
                                    </div>
                                ) : stats.lives !== null && stats.lives > 0 ? (
                                    <div className="text-2xl md:text-3xl font-bold text-slate-900 mt-2 flex items-center gap-2">
                                        {stats.lives}
                                    </div>
                                ) : (
                                    <div className="text-xl font-bold text-slate-900 mt-2 font-mono text-red-600">
                                        {timeLeft}
                                    </div>
                                )}
                                <p className="text-xs text-slate-400 mt-1 uppercase tracking-wider font-semibold">
                                    {stats.tier !== 'free' ? "Beneficio Premium" : stats.lives && stats.lives > 0 ? "¡Sigue así!" : "Siguiente vida en:"}
                                </p>
                            </div>
                            <div className={cn(
                                "w-10 h-10 rounded-lg flex items-center justify-center transition-transform group-hover:scale-110",
                                stats.tier !== 'free' ? "bg-amber-50 text-amber-500" :
                                    stats.lives === 0 ? "bg-red-50 text-red-500" : "bg-blue-50 text-blue-500"
                            )}>
                                {stats.tier !== 'free' ? <Zap size={20} className="fill-amber-500" /> : <Heart size={20} className={stats.lives === 0 ? "fill-red-500" : ""} />}
                            </div>
                        </div>
                        <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                            <div
                                className={cn(
                                    "h-full transition-all duration-1000",
                                    stats.tier !== 'free' ? "bg-amber-500" :
                                        stats.lives && stats.lives > 5 ? 'bg-blue-500' :
                                            stats.lives && stats.lives > 2 ? 'bg-orange-500' : 'bg-red-500'
                                )}
                                style={{ width: stats.tier !== 'free' ? '100%' : `${(stats.lives || 0) * 10}%` }}
                            />
                        </div>
                    </div>
                </Link>

                {/* Meta Diaria */}
                <div className="bg-white p-3 md:p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-32 md:h-40" id="tour-target">
                    <div className="flex items-start justify-between">
                        <div>
                            <h3 className="text-slate-500 font-semibold text-sm">Meta Diaria</h3>
                            <div className="text-2xl md:text-3xl font-bold text-slate-900 mt-2 whitespace-nowrap">
                                {stats.dailyProgress} / {stats.dailyTarget}
                            </div>
                            <p className={`text-xs mt-1 font-medium ${stats.dailyProgress >= stats.dailyTarget ? 'text-green-600' : 'text-slate-400'}`}>
                                {stats.dailyProgress >= stats.dailyTarget
                                    ? "¡Meta cumplida!"
                                    : `Faltan ${stats.dailyTarget - stats.dailyProgress}`}
                            </p>
                        </div>
                        <div className={`w-8 h-8 md:w-10 md:h-10 rounded-lg flex items-center justify-center text-lg md:text-xl ${stats.dailyProgress >= stats.dailyTarget ? 'bg-green-100 text-green-600' : 'bg-slate-100 text-slate-400'}`}>
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
                <Link href="/app/leaderboard" id="tour-ranking">
                    <div className="bg-white p-3 md:p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-32 md:h-40 hover:border-yellow-200 hover:shadow-md transition-all cursor-pointer group">
                        <div className="flex items-start justify-between">
                            <div>
                                <h3 className="text-slate-500 font-semibold text-sm group-hover:text-yellow-600 transition-colors">Tu Ranking</h3>
                                <div className="text-2xl md:text-3xl font-bold text-slate-900 mt-2 flex items-center gap-2">
                                    {stats.rank ? `#${stats.rank}` : '-'}
                                </div>
                                <p className="text-xs text-slate-400 mt-1">
                                    {stats.score} pts totales
                                </p>
                            </div>
                            <div className="w-8 h-8 md:w-10 md:h-10 bg-yellow-100 text-yellow-600 rounded-lg flex items-center justify-center group-hover:scale-110 transition-transform">
                                <Trophy size={16} className="fill-yellow-600 md:w-5 md:h-5" />
                            </div>
                        </div>
                        <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                            <div
                                className="bg-yellow-500 h-full transition-all duration-1000"
                                style={{ width: `${Math.max(5, Math.min(stats.score / 10, 100))}%` }}
                            />
                        </div>
                    </div>
                </Link>

                {/* Banco de Errores */}
                <Link href="/app/practice?mode=retry">
                    <div className="bg-white p-3 md:p-5 rounded-xl shadow-sm border border-slate-100 flex flex-col justify-between h-32 md:h-40 hover:border-red-200 hover:shadow-md transition-all cursor-pointer group">
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

            {showOnboarding && (
                <OnboardingTour
                    steps={DASHBOARD_STEPS}
                    onComplete={async () => {
                        const { data: { user } } = await supabase.auth.getUser()
                        if (user) {
                            await supabase.rpc('complete_onboarding', { p_user_id: user.id })
                        }
                        setShowOnboarding(false)
                    }}
                />
            )}
        </div>
    )
}
