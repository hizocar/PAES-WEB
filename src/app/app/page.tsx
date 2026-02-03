"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { BarChart3, Clock, Target, TrendingUp, ArrowRight, Flame, Heart, Zap, Trophy, AlertCircle, Star, RotateCcw } from "lucide-react"
import Link from "next/link"
import { cn } from "@/lib/utils"

import { useSubject } from "@/components/providers/SubjectContext"
import { AchievementNotification } from "@/components/achievements/AchievementNotification"
import { OnboardingTour, OnboardingStep } from "@/components/onboarding/OnboardingTour"

const DASHBOARD_STEPS: OnboardingStep[] = [
    {
        title: "¡Bienvenido a tu Centro de Alto Rendimiento! 🚀",
        description: "PAES Lab no es solo una app de ejercicios. Es un sistema diseñado para detectar cada uno de tus vacíos y llevarte al puntaje nacional.",
        icon: <Star className="text-yellow-500 fill-yellow-500" />,
        position: 'center'
    },
    {
        targetId: "tour-practice",
        title: "Entrenamiento Inteligente",
        description: "El botón 'Practicar' te dará ejercicios adaptados a tu nivel actual. Cada respuesta nos ayuda a conocerte mejor.",
        icon: <Zap className="text-blue-500 fill-blue-500" />,
        position: 'right'
    },
    {
        targetId: "tour-lives",
        title: "El Sistema de Vidas",
        description: "Entrenar con seriedad requiere concentración. Cada error consume una vida. Se recargan con el tiempo, ¡así que cuídalas!",
        icon: <Heart className="text-red-500 fill-red-500" />,
        position: 'bottom'
    },
    {
        targetId: "tour-ranking",
        title: "Mídete con Chile",
        description: "Mira cómo subes en el ranking nacional mientras acumulas puntos. ¡La competencia sana te llevará más lejos!",
        icon: <Trophy className="text-yellow-500 fill-yellow-600" />,
        position: 'top'
    },
    {
        targetId: "tour-mistakes",
        title: "Modo Repaso: Sin fallos",
        description: "Tus errores son oro. En el 'Modo Repaso' guardamos tus fallos para que los enfrentes una y otra vez hasta que desaparezcan de tu banco de errores.",
        icon: <RotateCcw className="text-orange-500" />,
        position: 'right'
    },
    {
        targetId: "tour-ejes",
        title: "Tu Mapa del Éxito (DEMRE)",
        description: "Aquí verás tu dominio real en los Ejes Temáticos oficiales de la PAES. Medimos tu precisión según el temario actualizado del DEMRE para que sepas dónde enfocar tu estudio.",
        icon: <Target className="text-blue-500" />,
        position: 'top'
    },
    {
        targetId: "tour-habilidades",
        title: "Tus Habilidades de Pensador",
        description: "La PAES evalúa cómo razonas. Aquí rastreamos tu fortaleza en Resolver Problemas, Modelar, Representar y Argumentar. ¡Conviértete en un experto en las 4!",
        icon: <TrendingUp className="text-indigo-500" />,
        position: 'top'
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
        tier: 'free',
        habilidades: [] as any[],
        userName: ""
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
                const name = ((profileData as any)?.full_name || user.user_metadata?.full_name || 'Aspirante').split(' ')[0]
                const onboardingCompleted = (profileData as any)?.onboarding_completed || false

                if (!onboardingCompleted) {
                    setShowOnboarding(true)
                }

                if (statsError) throw statsError

                // Unpack RPC Data
                const currentDailyProgress = dashboardStats?.daily_progress || 0
                const activeMistakes = dashboardStats?.active_mistakes || 0
                const processedEjes = dashboardStats?.ejes_stats || []
                const processedHabilidades = dashboardStats?.habilidades_stats || []
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
                    tier: tier,
                    habilidades: processedHabilidades,
                    userName: name
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
        // Run timer if not premium AND (lives < 10 OR lives is null) AND replenishAt exists
        if (stats.tier !== 'free' || (stats.lives !== null && stats.lives >= 10) || !stats.replenishAt) {
            return
        }

        const updateTimer = () => {
            const now = new Date()
            const end = new Date(stats.replenishAt!)
            const diff = end.getTime() - now.getTime()

            if (diff <= 0) {
                setTimeLeft("00:00:00")
                // Optional: Trigger a refresh here if you want immediate update
                return
            }

            const hrs = Math.floor(diff / (1000 * 60 * 60))
            const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
            const secs = Math.floor((diff % (1000 * 60)) / 1000)

            setTimeLeft(
                `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
            )
        }

        updateTimer()
        const interval = setInterval(updateTimer, 1000)
        return () => clearInterval(interval)
    }, [stats.lives, stats.replenishAt, stats.tier])

    const getHabilidadLabel = (h: string) => {
        const labels: Record<string, string> = {
            'resolver_problemas': 'Resolver Problemas',
            'modelar': 'Modelar',
            'representar': 'Representar',
            'argumentar': 'Argumentar'
        }
        return labels[h] || h
    }

    if (loading) {
        return (
            <div className="flex h-[50vh] items-center justify-center">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-slate-900"></div>
            </div>
        )
    }

    const getStatusMessage = () => {
        // 1. Goal Met Today
        if (stats.dailyProgress >= stats.dailyTarget) {
            return "¡Meta cumplida! Has dado un paso gigante hacia la universidad hoy 🚀";
        }

        // 2. Streak in Danger (Has streak but hasn't finished today's goal)
        if (stats.streak > 0 && stats.dailyProgress < stats.dailyTarget) {
            return `¡Tu racha de ${stats.streak} ${stats.streak === 1 ? 'día' : 'días'} está en riesgo! Haz ${stats.dailyTarget - stats.dailyProgress} ejercicios más para mantenerla 🔥`;
        }

        // 3. No streak (Either lost it or never had one)
        if (stats.streak === 0) {
            if (stats.dailyProgress > 0) {
                return `¡Buen comienzo! Te faltan ${stats.dailyTarget - stats.dailyProgress} ejercicios más para iniciar tu primera racha.`;
            }
            return "¡Oh no! No tienes racha activa. Haz 10 ejercicios hoy para empezar tu camino al puntaje nacional ⚡";
        }

        // 4. Achievement highlights (Fallback if something fails)
        if (stats.streak >= 7) return "¡Nivel: Constancia Pura! Estás en el top de regularidad esta semana 🔥";
        if (stats.mistakes > 10) return "Tienes varios errores pendientes. ¡A repasarlos para limpiar tu historial! 🧠";

        return "El éxito es la suma de pequeños esfuerzos diarios. ¡Vamos por esos puntos!";
    }

    const bestEje = ejes.length > 0 ? [...ejes].sort((a, b) => b.progress - a.progress)[0] : null;

    return (
        <div className="p-6 max-w-7xl mx-auto space-y-6">
            <AchievementNotification
                achievement={unlockedAchievement}
                onClose={() => setUnlockedAchievement(null)}
            />

            {/* Smart Dashboard Hero */}
            <div className="relative overflow-hidden bg-white p-6 md:p-10 rounded-[2rem] border border-slate-100 shadow-sm flex flex-col md:flex-row items-center justify-between gap-8 group">
                {/* Decorative background element */}
                <div className="absolute top-0 right-0 -translate-y-12 translate-x-12 w-64 h-64 bg-blue-50/50 rounded-full blur-3xl group-hover:bg-blue-100/50 transition-colors duration-700" />
                <div className="absolute bottom-0 left-0 translate-y-24 -translate-x-12 w-48 h-48 bg-purple-50/30 rounded-full blur-3xl pointer-events-none" />

                <div className="relative z-10 flex flex-col md:flex-row items-center gap-6 text-center md:text-left">
                    <div className="w-20 h-20 md:w-24 md:h-24 bg-gradient-to-br from-blue-600 to-indigo-700 rounded-3xl flex items-center justify-center text-white shadow-2xl shadow-blue-200 shrink-0 transform group-hover:rotate-3 transition-transform duration-500">
                        <Trophy size={40} className="fill-white/20" />
                    </div>

                    <div className="space-y-2">
                        <h1 className="text-3xl md:text-4xl font-black text-slate-900 tracking-tight leading-tight">
                            ¡Hola de nuevo, <span className="text-blue-600">{stats.userName}</span>! 👋
                        </h1>
                        <p className="text-slate-500 font-medium max-w-xl text-lg md:text-xl leading-relaxed">
                            {getStatusMessage()}
                        </p>

                        <div className="flex flex-wrap items-center justify-center md:justify-start gap-3 mt-4">
                            <div className="flex items-center gap-1.5 px-4 py-1.5 bg-orange-50 text-orange-600 rounded-full border border-orange-100 text-sm font-bold shadow-sm" title="Racha de días seguidos">
                                <Flame size={16} className="fill-orange-500" />
                                {stats.streak} {stats.streak === 1 ? 'día' : 'días'} de racha
                            </div>
                            {bestEje && bestEje.progress > 0 && (
                                <div className="flex items-center gap-1.5 px-4 py-1.5 bg-green-50 text-green-600 rounded-full border border-green-100 text-sm font-bold shadow-sm">
                                    <Star size={16} className="fill-green-500" />
                                    Master: {bestEje.name}
                                </div>
                            )}
                        </div>
                    </div>
                </div>

                <div className="relative z-10 w-full md:w-auto">
                    {(stats.lives !== null && (stats.lives > 0 || stats.tier !== 'free')) && (
                        <Link href="/app/practice" id="tour-practice">
                            <Button size="lg" className="w-full md:w-auto bg-blue-600 hover:bg-blue-700 text-white shadow-xl shadow-blue-200 transform hover:-translate-y-1 transition-all h-16 px-10 rounded-2xl font-bold text-xl border-b-4 border-blue-800 active:border-b-0 active:translate-y-0">
                                <Zap className="w-6 h-6 mr-2 fill-current" />
                                <Entrenar Ahora
                            </Button>
                        </Link>
                    )}
                </div>
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
                                ) : (
                                    <div className="mt-2">
                                        <div className="text-2xl md:text-3xl font-bold text-slate-900 flex items-center gap-2">
                                            {stats.lives !== null ? stats.lives : 0}
                                        </div>
                                        {stats.lives !== null && stats.lives < 10 && (
                                            <div className="text-xs font-mono font-bold text-blue-500 bg-blue-50 px-2 py-0.5 rounded-md w-fit mt-1 flex items-center gap-1">
                                                <Clock size={10} />
                                                Next: {timeLeft}
                                            </div>
                                        )}
                                    </div>
                                )}
                                <p className="text-xs text-slate-400 mt-1 uppercase tracking-wider font-semibold">
                                    {stats.tier !== 'free' ? "Beneficio Premium" : stats.lives !== null && stats.lives > 0 ? "¡Sigue así!" : "Sin Vidas"}
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
                        <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden mt-4">
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
                <Link href="/app/practice?mode=retry" id="tour-mistakes">
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
            <div className="space-y-6">
                <div className="flex items-center justify-between">
                    <h2 className="text-xl font-bold text-slate-900">Progreso por Eje Temático</h2>
                    <Link href="/app/progress" className="text-sm font-semibold text-blue-600 hover:text-blue-700 flex items-center gap-1">
                        Ver todo <ArrowRight size={14} />
                    </Link>
                </div>
                <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4" id="tour-ejes">
                    {ejes.map((eje) => (
                        <Link href="/app/progress" key={eje.id}>
                            <div className="group bg-white p-4 rounded-2xl border border-slate-100 shadow-sm hover:shadow-md transition-all cursor-pointer">
                                <div className="flex items-center justify-between mb-3">
                                    <div className="w-10 h-10 rounded-xl bg-slate-50 group-hover:bg-blue-50 transition-colors flex items-center justify-center text-slate-500 group-hover:text-blue-600 font-bold text-lg">
                                        {eje.name.charAt(0)}
                                    </div>
                                    <span className={cn(
                                        "px-2 py-0.5 rounded-full text-[10px] font-black uppercase tracking-widest",
                                        eje.progress >= 70 ? "bg-green-100 text-green-700" :
                                            eje.progress >= 40 ? "bg-blue-100 text-blue-700" : "bg-slate-100 text-slate-500"
                                    )}>
                                        {eje.progress}% Precisión
                                    </span>
                                </div>
                                <h3 className="font-bold text-sm text-slate-900 line-clamp-1">{eje.name}</h3>
                                <div className="w-full bg-slate-100 h-1.5 rounded-full mt-3 overflow-hidden">
                                    <div
                                        className={cn(
                                            "h-full transition-all duration-1000",
                                            eje.progress >= 70 ? "bg-green-500" :
                                                eje.progress >= 40 ? "bg-blue-500" : "bg-slate-300"
                                        )}
                                        style={{ width: `${eje.progress}%` }}
                                    />
                                </div>
                            </div>
                        </Link>
                    ))}
                </div>

                <div className="pt-4" id="tour-habilidades">
                    <h2 className="text-xl font-bold text-slate-900 mb-4">Fortaleza por Habilidad</h2>
                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                        {stats.habilidades.map((hab: any) => (
                            <div key={hab.name} className="bg-white p-4 rounded-2xl border border-slate-100 shadow-sm flex flex-col items-center text-center group">
                                <div className={cn(
                                    "w-12 h-12 rounded-2xl flex items-center justify-center mb-3 transition-transform group-hover:scale-110",
                                    hab.progress >= 70 ? "bg-green-50 text-green-600" :
                                        hab.progress >= 40 ? "bg-indigo-50 text-indigo-600" : "bg-slate-50 text-slate-400"
                                )}>
                                    <BarChart3 size={24} />
                                </div>
                                <h4 className="text-xs font-bold text-slate-500 uppercase tracking-tighter mb-1 line-clamp-1">
                                    {getHabilidadLabel(hab.name)}
                                </h4>
                                <div className="text-xl font-black text-slate-900">
                                    {hab.progress}%
                                </div>
                                <div className="text-[10px] text-slate-400 mt-1">
                                    {hab.total_attempts} intentos
                                </div>
                            </div>
                        ))}
                    </div>
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
