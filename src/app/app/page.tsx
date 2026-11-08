"use client"


import { useEffect, useState, useCallback } from "react"
import { createClient, getSessionUser } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { BarChart3, Target, ArrowRight, Flame, Heart, Zap, Trophy, AlertCircle, Star, Calculator, Tangent, Shapes, PieChart, MessageSquareQuote, Network, BoxSelect, Lightbulb, Sparkles } from "lucide-react"
import Link from "next/link"
import { Mascot } from "@/components/mascot/Mascot"
import { useRouter } from "next/navigation"
import { cn } from "@/lib/utils"

import { useSubject } from "@/components/providers/SubjectContext"
import { AchievementNotification } from "@/components/achievements/AchievementNotification"
import { OnboardingTour, OnboardingStep } from "@/components/onboarding/OnboardingTour"
import { PaesCountdown } from "@/components/dashboard/PaesCountdown"

function buildDashboardSteps(subject: "m1" | "m2", setSubject: (s: "m1" | "m2") => void): OnboardingStep[] {
    return [
        {
            title: "¡Bienvenido a PAES Lab!",
            description: "Aquí entrenas la PAES de Matemática como un juego: respondes, sumas racha y subes en el ranking. ¿Qué prueba quieres preparar primero?",
            icon: <Mascot mood="happy" size={40} interactive={false} message={false} />,
            position: "center",
            content: (
                <div className="grid grid-cols-2 gap-2" role="radiogroup" aria-label="Prueba a preparar">
                    {([
                        { id: "m1", name: "M1", hint: "Obligatoria" },
                        { id: "m2", name: "M2", hint: "Ciencias e ingeniería" },
                    ] as const).map((o) => (
                        <button
                            key={o.id}
                            type="button"
                            role="radio"
                            aria-checked={subject === o.id}
                            onClick={() => setSubject(o.id)}
                            className={cn(
                                "rounded-2xl border-2 px-3 py-3 text-left transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600",
                                subject === o.id ? "border-blue-600 bg-blue-50" : "border-slate-200 hover:border-slate-300"
                            )}
                        >
                            <span className="block text-lg font-black text-slate-900">{o.name}</span>
                            <span className="block text-xs font-semibold text-slate-500">{o.hint}</span>
                        </button>
                    ))}
                </div>
            ),
        },
        {
            targetId: "tour-lives",
            title: "Tus vidas",
            description: "Tienes 10 vidas por materia. Cada error gasta una y se recargan solas con el tiempo. ¡Cuídalas!",
            icon: <Heart className="text-red-500 fill-red-500" size={22} />,
            position: "bottom",
        },
        {
            targetId: "tour-practice",
            title: "Tu primer desafío",
            description: "Responde 10 preguntas al día para mantener tu racha 🔥. Puedes cambiar entre M1 y M2 cuando quieras desde el menú.",
            icon: <Zap className="text-blue-600 fill-blue-600" size={22} />,
            position: "bottom",
            primaryLabel: "¡A la primera pregunta!",
        },
    ]
}

export default function DashboardPage() {
    const { subject, setSubject } = useSubject()
    const router = useRouter()
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

    const fetchData = useCallback(async () => {
        // Only set loading on initial load to avoid flash when refreshing lives
        if (stats.lives === null) setLoading(true)

        try {
            const user = await getSessionUser(supabase)
            if (!user) return

            // 0. Logros de racha: en segundo plano, sin bloquear la carga del panel
            if (subject) {
                supabase
                    .rpc('check_and_unlock_achievement', { p_user_id: user.id, p_trigger_type: 'STREAK', p_subject: subject })
                    .then(({ data: newAchievements }) => {
                        if (newAchievements && newAchievements.length > 0) setUnlockedAchievement(newAchievements[0])
                    })
            }

            // 1. Parallel Fetch: Stats (RPC), Lives, Leaderboard, Profile Tier
            const [statsResult, livesResult, leaderboardResult, profileResult] = await Promise.all([
                supabase.rpc('get_dashboard_stats', { p_user_id: user.id, p_subject: subject }),
                supabase.rpc('check_and_replenish_lives', { p_user_id: user.id, p_subject: subject }),
                supabase.rpc('get_leaderboard', { p_subject: subject }),
                supabase.from('profiles').select('subscription_tier, onboarding_completed').eq('id', user.id).single()
            ])

            const { data: dashboardStats, error: statsError } = statsResult
            const { data: livesData } = livesResult
            const { data: leaderboardData } = leaderboardResult
            const { data: profileData } = profileResult

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
            const EJE_ORDER = ["Números", "Álgebra", "Geometría", "Probabilidad"]
            const rank = (n: string) => { const i = EJE_ORDER.findIndex((k) => n?.startsWith(k)); return i === -1 ? 99 : i }
            setEjes([...processedEjes].sort((a: any, b: any) => rank(a.name) - rank(b.name)))

        } catch (error) {
            console.error("Error fetching dashboard:", error)
        } finally {
            setLoading(false)
        }
    }, [subject, supabase, stats.lives])

    // Meta Pixel: el callback de auth redirige con ?login=ok; lo registramos y limpiamos la URL
    useEffect(() => {
        const url = new URL(window.location.href)
        if (url.searchParams.get("login") === "ok") {
            if ((window as any).fbq) (window as any).fbq("track", "CompleteRegistration")
            url.searchParams.delete("login")
            window.history.replaceState(null, "", url.pathname + url.search)
        }
    }, [])

    useEffect(() => {
        let isMounted = true
        fetchData()
        return () => { isMounted = false }
    }, [fetchData])

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
                setTimeLeft("00:00")
                // Timer finished! Refresh data to show new life
                fetchData()
                return
            }

            const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
            const secs = Math.floor((diff % (1000 * 60)) / 1000)

            setTimeLeft(
                `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
            )
        }

        updateTimer()
        const interval = setInterval(updateTimer, 1000)
        return () => clearInterval(interval)
    }, [stats.lives, stats.replenishAt, stats.tier, fetchData])

    const getHabilidadIcon = (h: string) => {
        const iconSize = 24
        switch (h) {
            case 'resolver_problemas': return <Lightbulb size={iconSize} />
            case 'modelar': return <BoxSelect size={iconSize} />
            case 'representar': return <Network size={iconSize} />
            case 'argumentar': return <MessageSquareQuote size={iconSize} />
            default: return <BarChart3 size={iconSize} />
        }
    }

    const getHabilidadLabel = (h: string) => {
        const labels: Record<string, string> = {
            'resolver_problemas': 'Resolver Problemas',
            'modelar': 'Modelar',
            'representar': 'Representar',
            'argumentar': 'Argumentar'
        }
        return labels[h] || h
    }

    const getEjeIcon = (ejeName: string) => {
        const iconSize = 20
        if (ejeName.includes('Números')) return <Calculator size={iconSize} />
        if (ejeName.includes('Álgebra')) return <Tangent size={iconSize} />
        if (ejeName.includes('Geometría')) return <Shapes size={iconSize} />
        if (ejeName.includes('Probabilidad')) return <PieChart size={iconSize} />
        return <Star size={iconSize} />
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
            if (stats.dailyProgress === 0 && stats.mistakes === 0 && stats.score === 0) {
                return "Responde tus primeras 10 preguntas hoy y enciende tu racha 🔥";
            }
            if (stats.dailyProgress > 0) {
                return `¡Buen comienzo! Te faltan ${stats.dailyTarget - stats.dailyProgress} ejercicios más para iniciar tu primera racha.`;
            }
            return "Perdiste tu racha, ¡pero hoy la recuperas! Haz 10 preguntas para encenderla de nuevo 🔥";
        }

        // 4. Achievement highlights (Fallback if something fails)
        if (stats.streak >= 7) return "¡Nivel: Constancia Pura! Estás en el top de regularidad esta semana 🔥";
        if (stats.mistakes > 10) return "Tienes varios errores pendientes. ¡A repasarlos para limpiar tu historial! 🧠";

        return "El éxito es la suma de pequeños esfuerzos diarios. ¡Vamos por esos puntos!";
    }

    const bestEje = ejes.length > 0 ? [...ejes].sort((a, b) => b.progress - a.progress)[0] : null
    const hasActivity = ejes.some((e: any) => e.progress > 0) || stats.habilidades.some((h: any) => (h.total_attempts ?? 0) > 0)
    const goalDone = stats.dailyProgress >= stats.dailyTarget
    const noLives = stats.tier === "free" && stats.lives === 0
    const steps = buildDashboardSteps(subject, setSubject)

    return (
        <div className="mx-auto max-w-7xl space-y-6 p-4 md:p-6">
            <AchievementNotification
                achievement={unlockedAchievement}
                onClose={() => setUnlockedAchievement(null)}
            />

            {/* Saludo + cuenta regresiva PAES */}
            <div className="grid gap-4 lg:grid-cols-3">
                <section className="flex flex-col gap-6 rounded-[1.75rem] border border-slate-200 bg-white p-6 shadow-sm md:flex-row md:items-center md:p-8 lg:col-span-2">
                    <Mascot
                        mood={noLives ? "sad" : goalDone ? "celebrate" : "idle"}
                        message={false}
                        bubbleSide="top"
                        size={112}
                        priority
                        className="self-center"
                    />
                    <div className="min-w-0 flex-1 text-center md:text-left">
                        <h1 className="text-3xl font-black leading-tight tracking-tight text-slate-900 md:text-4xl">
                            ¡Hola, <span className="text-blue-600">{stats.userName}</span>!
                        </h1>
                        <p className="mt-2 max-w-xl text-base font-medium leading-relaxed text-slate-600 md:text-lg">
                            {getStatusMessage()}
                        </p>
                        <div className="mt-4 flex flex-wrap items-center justify-center gap-2 md:justify-start">
                            <span className="inline-flex items-center gap-1.5 rounded-full bg-orange-50 px-3 py-1.5 text-sm font-bold text-orange-700" title="Días seguidos cumpliendo la meta">
                                <Flame size={16} className="fill-orange-500 text-orange-500" aria-hidden />
                                {stats.streak} {stats.streak === 1 ? "día" : "días"} de racha
                            </span>
                            {bestEje && bestEje.progress > 0 && (
                                <span className="inline-flex items-center gap-1.5 rounded-full bg-emerald-50 px-3 py-1.5 text-sm font-bold text-emerald-700">
                                    <Star size={16} className="fill-emerald-500 text-emerald-500" aria-hidden />
                                    Tu mejor eje: {bestEje.name}
                                </span>
                            )}
                        </div>
                        <div className="mt-6 flex flex-col gap-3 sm:flex-row sm:flex-wrap sm:justify-center md:justify-start">
                            {noLives ? (
                                <Link href="/app/practice?mode=retry" className="w-full sm:w-auto">
                                    <Button size="lg" variant="outline" className="h-14 w-full whitespace-nowrap rounded-2xl px-8 text-lg font-bold sm:w-auto">
                                        Repasar mientras recargas
                                    </Button>
                                </Link>
                            ) : (
                                <Link href="/app/practice" id="tour-practice" className="w-full sm:w-auto">
                                    <Button size="lg" className="h-14 w-full whitespace-nowrap rounded-2xl border-b-4 border-blue-800 bg-blue-600 px-8 text-lg font-black text-white shadow-[0_8px_20px_-6px_rgba(37,99,235,0.6)] transition-transform hover:bg-blue-700 active:translate-y-0.5 active:border-b-2 sm:w-auto">
                                        <Zap className="mr-2 h-5 w-5 fill-current" aria-hidden />
                                        {goalDone ? "Seguir entrenando" : "Entrenar ahora"}
                                    </Button>
                                </Link>
                            )}
                            <Link href="/app/temas" className="w-full sm:w-auto">
                                <Button size="lg" variant="ghost" className="h-14 w-full whitespace-nowrap rounded-2xl px-6 text-base font-bold text-slate-700 hover:bg-slate-100 sm:w-auto">
                                    <Target className="mr-2 h-5 w-5" aria-hidden />
                                    Practicar por tema
                                </Button>
                            </Link>
                        </div>
                    </div>
                </section>

                <PaesCountdown className="lg:col-span-1" />
            </div>

            <div className="grid grid-cols-2 gap-3 md:gap-4 lg:grid-cols-4">
                {/* Vidas */}
                <Link href="/app/pricing" className="group rounded-2xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600" id="tour-lives">
                    <div className="flex h-full min-h-36 flex-col justify-between rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition-colors group-hover:border-blue-300 md:p-5">
                        <div className="flex items-start justify-between gap-2">
                            <div>
                                <h3 className="text-sm font-semibold text-slate-500">Vidas</h3>
                                {stats.tier !== "free" ? (
                                    <p className="mt-1 text-4xl font-black text-amber-500" aria-label="Vidas ilimitadas">∞</p>
                                ) : (
                                    <p className="mt-1 text-3xl font-black text-slate-900 tabular-nums">{stats.lives ?? 0}<span className="text-base font-bold text-slate-400">/10</span></p>
                                )}
                            </div>
                            <div className={cn("flex h-10 w-10 items-center justify-center rounded-xl",
                                stats.tier !== "free" ? "bg-amber-50 text-amber-500" : stats.lives === 0 ? "bg-red-50 text-red-500" : "bg-rose-50 text-rose-500")}>
                                {stats.tier !== "free" ? <Zap size={20} className="fill-amber-500" /> : <Heart size={20} className="fill-current" />}
                            </div>
                        </div>
                        <div>
                            <p className="mb-2 text-xs font-semibold text-slate-500 tabular-nums">
                                {stats.tier !== "free" ? "Ilimitadas con Pro" : stats.lives !== null && stats.lives < 10 && timeLeft ? `+1 vida en ${timeLeft}` : "Vidas completas"}
                            </p>
                            <div className="h-2 w-full overflow-hidden rounded-full bg-slate-100">
                                <div className={cn("h-full rounded-full transition-[width] duration-700",
                                    stats.tier !== "free" ? "bg-amber-400" : (stats.lives ?? 0) > 5 ? "bg-rose-500" : (stats.lives ?? 0) > 2 ? "bg-orange-500" : "bg-red-500")}
                                    style={{ width: stats.tier !== "free" ? "100%" : `${(stats.lives || 0) * 10}%` }} />
                            </div>
                        </div>
                    </div>
                </Link>

                {/* Meta diaria */}
                <div className="flex min-h-36 flex-col justify-between rounded-2xl border border-slate-200 bg-white p-4 shadow-sm md:p-5" id="tour-target">
                    <div className="flex items-start justify-between gap-2">
                        <div>
                            <h3 className="text-sm font-semibold text-slate-500">Meta diaria</h3>
                            <p className="mt-1 text-3xl font-black text-slate-900 tabular-nums">{stats.dailyProgress}<span className="text-base font-bold text-slate-400">/{stats.dailyTarget}</span></p>
                        </div>
                        <div className={cn("flex h-10 w-10 items-center justify-center rounded-xl", goalDone ? "bg-emerald-50 text-emerald-600" : "bg-blue-50 text-blue-600")}>
                            <Target size={20} aria-hidden />
                        </div>
                    </div>
                    <div>
                        <p className={cn("mb-2 text-xs font-semibold", goalDone ? "text-emerald-700" : "text-slate-500")}>
                            {goalDone ? "¡Meta cumplida!" : `Faltan ${stats.dailyTarget - stats.dailyProgress}`}
                        </p>
                        <div className="h-2 w-full overflow-hidden rounded-full bg-slate-100">
                            <div className={cn("h-full rounded-full transition-[width] duration-700", goalDone ? "bg-emerald-500" : "bg-blue-600")}
                                style={{ width: `${Math.min((stats.dailyProgress / stats.dailyTarget) * 100, 100)}%` }} />
                        </div>
                    </div>
                </div>

                {/* Ranking */}
                <Link href="/app/leaderboard" id="tour-ranking" className="group rounded-2xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600">
                    <div className="flex h-full min-h-36 flex-col justify-between rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition-colors group-hover:border-amber-300 md:p-5">
                        <div className="flex items-start justify-between gap-2">
                            <div>
                                <h3 className="text-sm font-semibold text-slate-500">Tu ranking</h3>
                                <p className="mt-1 text-3xl font-black text-slate-900 tabular-nums">{stats.rank ? `#${stats.rank}` : "—"}</p>
                            </div>
                            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-amber-50 text-amber-600">
                                <Trophy size={20} className="fill-amber-500" aria-hidden />
                            </div>
                        </div>
                        <p className="text-xs font-semibold text-slate-500 tabular-nums">{stats.score} pts · {stats.rank ? "sigue sumando" : "responde para entrar"}</p>
                    </div>
                </Link>

                {/* Banco de errores */}
                <Link href="/app/practice?mode=retry" id="tour-mistakes" className="group rounded-2xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600">
                    <div className="flex h-full min-h-36 flex-col justify-between rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition-colors group-hover:border-red-300 md:p-5">
                        <div className="flex items-start justify-between gap-2">
                            <div>
                                <h3 className="text-sm font-semibold text-slate-500">Errores por repasar</h3>
                                <p className="mt-1 text-3xl font-black text-slate-900 tabular-nums">{stats.mistakes}</p>
                            </div>
                            <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-red-50 text-red-500">
                                <AlertCircle size={20} aria-hidden />
                            </div>
                        </div>
                        <p className="text-xs font-semibold text-slate-500">{stats.mistakes > 0 ? "Toca para repasarlos" : "¡Todo limpio!"}</p>
                    </div>
                </Link>
            </div>

            {/* Progreso por eje y habilidad */}
            <section className="space-y-4" aria-labelledby="ejes-title">
                <div className="flex items-end justify-between gap-4">
                    <h2 id="ejes-title" className="text-xl font-black text-slate-900">Tu dominio por eje</h2>
                    <Link href="/app/temas" className="flex items-center gap-1 text-sm font-bold text-blue-700 hover:text-blue-800">
                        Ver por tema <ArrowRight size={14} aria-hidden />
                    </Link>
                </div>

                {!hasActivity && (
                    <div className="flex flex-col items-start gap-3 rounded-2xl border border-dashed border-slate-300 bg-slate-50 p-5 sm:flex-row sm:items-center sm:justify-between">
                        <div className="flex items-center gap-3">
                            <Sparkles className="shrink-0 text-blue-600" size={22} aria-hidden />
                            <p className="text-sm font-medium text-slate-700">
                                Aquí verás qué tan bien dominas cada eje y habilidad de la PAES. Se llena a medida que respondes.
                            </p>
                        </div>
                        <Link href="/app/practice" className="shrink-0 text-sm font-black text-blue-700 hover:text-blue-800">
                            Responder ahora →
                        </Link>
                    </div>
                )}

                <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-4" id="tour-ejes">
                    {ejes.map((eje) => (
                        <Link href={`/app/temas#eje-${eje.id}`} key={eje.id} className="group rounded-2xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600">
                            <div className="rounded-2xl border border-slate-200 bg-white p-4 shadow-sm transition-colors group-hover:border-blue-300">
                                <div className="mb-3 flex items-center justify-between">
                                    <div className="flex h-10 w-10 items-center justify-center rounded-xl bg-slate-50 text-slate-500 transition-colors group-hover:bg-blue-50 group-hover:text-blue-600">
                                        {getEjeIcon(eje.name)}
                                    </div>
                                    <span className="text-lg font-black text-slate-900 tabular-nums">{eje.progress}%</span>
                                </div>
                                <h3 className="line-clamp-1 text-sm font-bold text-slate-900">{eje.name}</h3>
                                <div className="mt-3 h-1.5 w-full overflow-hidden rounded-full bg-slate-100">
                                    <div className={cn("h-full rounded-full transition-[width] duration-700",
                                        eje.progress >= 70 ? "bg-emerald-500" : eje.progress >= 40 ? "bg-blue-600" : "bg-slate-300")}
                                        style={{ width: `${eje.progress}%` }} />
                                </div>
                            </div>
                        </Link>
                    ))}
                </div>

                <div className="pt-2" id="tour-habilidades">
                    <h2 className="mb-3 text-xl font-black text-slate-900">Tu dominio por habilidad</h2>
                    <div className="grid grid-cols-2 gap-3 md:grid-cols-4">
                        {stats.habilidades.map((hab: any) => (
                            <div key={hab.name} className="flex flex-col items-center rounded-2xl border border-slate-200 bg-white p-4 text-center shadow-sm">
                                <div className={cn("mb-3 flex h-12 w-12 items-center justify-center rounded-2xl",
                                    hab.progress >= 70 ? "bg-emerald-50 text-emerald-600" : hab.progress >= 40 ? "bg-indigo-50 text-indigo-600" : "bg-slate-50 text-slate-500")}>
                                    {getHabilidadIcon(hab.name)}
                                </div>
                                <h3 className="text-sm font-bold text-slate-700">{getHabilidadLabel(hab.name)}</h3>
                                <p className="text-xl font-black text-slate-900 tabular-nums">{hab.progress}%</p>
                                <p className="mt-0.5 text-xs text-slate-500 tabular-nums">{hab.total_attempts} {hab.total_attempts === 1 ? "respuesta" : "respuestas"}</p>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            {showOnboarding && (
                <OnboardingTour
                    steps={steps}
                    onComplete={async (reason) => {
                        setShowOnboarding(false)
                        const user = await getSessionUser(supabase)
                        if (user) await supabase.rpc("complete_onboarding", { p_user_id: user.id })
                        if (reason === "done") router.push("/app/practice")
                    }}
                />
            )}
        </div>
    )
}
