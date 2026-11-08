"use client"

import { useEffect, useState, Suspense, useRef } from "react"
import { createClient, getSessionUser } from "@/lib/supabase/client"
import { QuestionCard } from "@/components/practice/QuestionCard"
import { Button } from "@/components/ui/button"
import { Loader2, Trophy, RotateCcw, AlertCircle, HeartCrack, Crown, ArrowLeft } from "lucide-react"
import { LivesCounter } from "@/components/practice/LivesCounter"
import { Mascot } from "@/components/mascot/Mascot"
import Link from "next/link"
import { useSubject } from "@/components/providers/SubjectContext"
import { useSearchParams } from 'next/navigation'

import { OnboardingTour, OnboardingStep } from "@/components/onboarding/OnboardingTour"
import { Clock, Heart, Lightbulb, Star } from "lucide-react"

const PRACTICE_STEPS: OnboardingStep[] = [
    {
        targetId: "tour-timer",
        title: "Tienes 2:30 por pregunta",
        description: "Es el ritmo real de la PAES. Si se acaba el tiempo, cuenta como error, así que no te quedes pegado: si no sabes, marca \"No sé\" y aprende de la explicación.",
        icon: <Clock className="text-orange-500" size={22} />,
        position: "bottom",
    },
    {
        targetId: "tour-lives-practice",
        title: "Cada error gasta una vida",
        description: "Tienes 10 vidas por materia y se recargan solas con el tiempo. Después de responder verás la explicación paso a paso. ¡A jugar!",
        icon: <Heart className="text-red-500 fill-red-500" size={22} />,
        position: "bottom",
        primaryLabel: "¡A jugar!",
    },
]

function PracticeContent() {
    const { subject } = useSubject()
    const searchParams = useSearchParams()
    const modeParam = searchParams.get('mode')
    const topicId = searchParams.get('topic')
    const [topicName, setTopicName] = useState<string | null>(null)

    // Onboarding State
    const [showOnboarding, setShowOnboarding] = useState(false)

    // React to URL changes
    useEffect(() => {
        const newMode = modeParam === 'retry'
        if (newMode !== retryMode) {
            setRetryMode(newMode)
            setQuestion(null) // Force re-fetch
        }
    }, [modeParam])

    const [question, setQuestion] = useState<any>(null)
    const [loading, setLoading] = useState(true)
    const [retryMode, setRetryMode] = useState(modeParam === 'retry')
    const [completed, setCompleted] = useState(false)
    const [debugMsg, setDebugMsg] = useState("")

    // Request Tracking for Race Conditions
    const reqIdRef = useRef(0)

    // Lives System State
    const [lives, setLives] = useState(10)
    const [replenishAt, setReplenishAt] = useState<string | null>(null)
    const [tier, setTier] = useState<string>('free')

    const supabase = createClient()

    // Initialize Lives, Tier & Onboarding
    useEffect(() => {
        const initPractice = async () => {
            try {
                const user = await getSessionUser(supabase)
                if (!user) return

                const [livesResult, profileResult] = await Promise.all([
                    supabase.rpc('check_and_replenish_lives', { p_user_id: user.id, p_subject: subject }),
                    supabase.from('profiles').select('subscription_tier, practice_onboarding_completed').eq('id', user.id).single()
                ])

                if (livesResult.data && livesResult.data.length > 0) {
                    setLives(livesResult.data[0].current_lives)
                    setReplenishAt(livesResult.data[0].replenish_at)
                }

                if (profileResult.data) {
                    setTier(profileResult.data.subscription_tier || 'free')
                    const practiceOnboardingCompleted = (profileResult.data as any)?.practice_onboarding_completed || false
                    if (!practiceOnboardingCompleted) {
                        setShowOnboarding(true)
                    }
                }
            } catch (e) {
                console.error("Error initializing practice:", e)
            } finally {
                setLoading(false)
            }
        }
        initPractice()
    }, [subject])

    // Track First Practice Event (Meta Pixel)
    const trackedFirstPractice = useRef(false)

    const fetchQuestion = async () => {
        if (loading) return

        // Safety Guard: Don't fetch if out of lives (Free Tier)
        if (tier === 'free' && lives <= 0) return

        // Increment Request ID
        const currentReqId = ++reqIdRef.current

        setLoading(true)
        setQuestion(null) // Clear current question to show loader
        setDebugMsg("")
        try {
            const user = await getSessionUser(supabase)

            if (!user) {
                setDebugMsg("error")
                return
            }

            const { data, error } = topicId
                ? await supabase.rpc('get_topic_question', { p_user_id: user.id, p_topic_id: topicId })
                : await supabase.rpc('get_smart_question', {
                    p_user_id: user.id,
                    p_retry_mode: retryMode,
                    p_subject: subject
                })

            // Race Condition Check
            if (currentReqId !== reqIdRef.current) return

            if (error) {
                console.error("get_smart_question:", error.message)
                setDebugMsg("error")
            } else if (!data || data.length === 0) {
                setQuestion(null)
                setCompleted(true)
            } else {
                const qRaw = data[0]
                const qFormatted = {
                    ...qRaw,
                    topic: qRaw.topic_name || 'General',
                    eje: qRaw.eje_name || 'General'
                }
                if (topicId) setTopicName(qRaw.topic_name ?? null)

                // Tracking Meta Pixel: First Practice
                if (!trackedFirstPractice.current && (window as any).fbq) {
                    (window as any).fbq("trackCustom", "FirstPractice")
                    trackedFirstPractice.current = true
                }

                setQuestion(qFormatted)
                setCompleted(false)
            }
        } catch (e: any) {
            console.error("fetchQuestion:", e)
            setDebugMsg("error")
        } finally {
            if (currentReqId === reqIdRef.current) {
                setLoading(false)
            }
        }
    }

    // Reset Question when Subject or Mode changes
    useEffect(() => {
        setQuestion(null)
        setCompleted(false)
    }, [retryMode, subject, topicId])

    // Fetch Question if missing (and we have lives or are premium)
    useEffect(() => {
        if ((lives > 0 || tier !== 'free') && !question && !completed && !loading) {
            fetchQuestion()
        }
    }, [lives, question, completed, tier, loading])

    const handleWrongAnswer = async () => {
        const user = await getSessionUser(supabase)
        if (!user) return

        // Deduct life in DB
        const { data } = await supabase.rpc('deduct_life', { p_user_id: user.id, p_subject: subject })

        // Update local state
        if (data && data.length > 0) {
            setLives(data[0].new_lives)
            setReplenishAt(data[0].replenish_at)
        }
    }


    if (loading && !question && (lives > 0 || tier !== 'free')) {
        return (
            <div className="flex h-[70vh] items-center justify-center" aria-busy="true">
                <Mascot
                    mood="thinking"
                    bubbleSide="top"
                    interactive={false}
                    message={retryMode ? "Buscando tus errores para repasar…" : "Buscando tu próximo desafío…"}
                    size={96}
                />
            </div>
        )
    }

    // Cooldown / No Lives Screen (Only for free users)
    // Modified to show even if replenishAt is still calculating (to avoid empty screen)
    if (tier === 'free' && lives <= 0) {
        return (
            <div className="flex min-h-[85dvh] items-center justify-center flex-col gap-8 px-4 text-center max-w-md mx-auto animate-in fade-in zoom-in duration-300">
                <Mascot mood="sad" bubbleSide="top" message="¡Uf! Me quedé sin energía…" size={128} />

                <div className="space-y-2">
                    <h2 className="text-3xl font-bold text-slate-900">¡Te quedaste sin vidas!</h2>
                    <p className="text-slate-500 text-lg">
                        Necesitas descansar un poco. Tus vidas se recargarán en:
                    </p>
                </div>

                <div className="bg-slate-900 text-white text-3xl font-mono py-4 px-8 rounded-2xl shadow-lg border-b-4 border-slate-700 min-h-[80px] flex items-center justify-center">
                    {replenishAt ? (
                        <LivesCounter lives={0} replenishAt={replenishAt} />
                    ) : (
                        <div className="flex items-center gap-2">
                            <Loader2 className="animate-spin text-slate-400" size={20} />
                            <span className="text-sm text-slate-400">Calculando...</span>
                        </div>
                    )}
                </div>

                <div className="pt-8 flex flex-col gap-3 w-full">
                    <Link href="/app/pricing" className="w-full">
                        <Button size="lg" className="w-full h-14 text-xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 shadow-xl shadow-blue-200 border-b-4 border-blue-800 active:border-b-0 active:translate-y-1">
                            <Crown className="mr-2 fill-yellow-400 text-yellow-400" size={24} />
                            Obtener Vidas Ilimitadas
                        </Button>
                    </Link>
                    <Link href="/app" className="w-full">
                        <Button size="lg" variant="ghost" className="w-full h-12 text-slate-500 hover:text-slate-900 font-semibold">
                            Volver al Inicio
                        </Button>
                    </Link>
                </div>
            </div>
        )
    }

    // Completion State (Success)
    if (completed) {
        return (
            <div className="flex h-[80vh] items-center justify-center flex-col gap-6 px-4 text-center max-w-md mx-auto">
                <Mascot mood={retryMode ? "happy" : "celebrate"} message={false} size={112} />

                {!retryMode ? (
                    <>
                        <h2 className="text-2xl font-bold text-slate-800">¡Felicidades!</h2>
                        <p className="text-slate-500">
                            Has respondido correctamente todas las preguntas disponibles.
                            ¡Eres un experto en {subject.toUpperCase()}!
                        </p>
                        <div className="pt-4 space-y-3 w-full">
                            <Button
                                onClick={() => setRetryMode(true)}
                                className="w-full h-12 text-lg bg-blue-600 hover:bg-blue-700"
                            >
                                <RotateCcw className="mr-2" size={20} />
                                Repasar mis errores
                            </Button>
                        </div>
                    </>
                ) : (
                    <>
                        <h2 className="text-2xl font-bold text-slate-800">No tienes errores por repasar</h2>
                        <p className="text-slate-500">
                            Cuando falles una pregunta, quedará guardada aquí para que la vuelvas a intentar hasta dominarla.
                        </p>
                        <div className="pt-4">
                            <Button
                                onClick={() => setRetryMode(false)}
                                variant="outline"
                            >
                                Ir a practicar
                            </Button>
                        </div>
                    </>
                )}
            </div>
        )
    }

    return (
        <div className="pb-6 pt-4 md:pt-8 px-4">
            {/* Mobile Back Button */}
            <div className="max-w-3xl mx-auto mb-4 md:hidden">
                <Link href="/app" className="inline-flex items-center gap-2 text-slate-500 font-medium hover:text-blue-600 transition-colors">
                    <ArrowLeft size={20} />
                    <span>Volver al Inicio</span>
                </Link>
            </div>

            {/* Header: Progress & Lives */}
            <div className="max-w-3xl mx-auto mb-8 flex items-center justify-between">
                <div className="flex items-center gap-2 text-sm text-slate-500 font-medium font-mono">
                    {topicId ? (
                        <Link href="/app/temas" className="font-sans font-bold text-blue-700 hover:text-blue-800">
                            Tema: {topicName ?? "…"} <span className="font-semibold text-slate-500">· cambiar</span>
                        </Link>
                    ) : (
                        <span className={retryMode ? "text-orange-600 font-bold" : ""}>
                            {retryMode ? "MODO REPASO" : "MODO PRÁCTICA"}
                        </span>
                    )}
                    {retryMode && <AlertCircle size={14} className="text-orange-500" />}
                </div>

                <div id="tour-lives-practice">
                    <LivesCounter lives={lives} replenishAt={replenishAt} tier={tier} />
                </div>
            </div>

            {debugMsg && (
                <div role="alert" className="max-w-3xl mx-auto mb-4 flex flex-col items-start gap-3 rounded-2xl border border-red-100 bg-red-50 p-4 sm:flex-row sm:items-center sm:justify-between">
                    <p className="text-sm font-medium text-red-800">
                        No pudimos cargar la pregunta. Revisa tu conexión e inténtalo de nuevo.
                    </p>
                    <Button size="sm" variant="outline" onClick={() => fetchQuestion()} className="shrink-0 border-red-200 bg-white text-red-700 hover:bg-red-100">
                        <RotateCcw className="mr-1.5" size={14} /> Reintentar
                    </Button>
                </div>
            )}

            {question && (
                <QuestionCard
                    question={question}
                    onNext={fetchQuestion}
                    onWrongAnswer={handleWrongAnswer}
                    mode={retryMode ? 'review' : 'practice'}
                    paused={showOnboarding}
                />
            )}

            {showOnboarding && (
                <OnboardingTour
                    steps={PRACTICE_STEPS}
                    onComplete={async () => {
                        const user = await getSessionUser(supabase)
                        if (user) {
                            await supabase.rpc('complete_practice_onboarding', { p_user_id: user.id })
                        }
                        setShowOnboarding(false)
                    }}
                />
            )}
        </div>
    )
}

export default function PracticePage() {
    return (
        <Suspense fallback={<div className="flex h-screen items-center justify-center"><Loader2 className="animate-spin text-blue-600" /></div>}>
            <PracticeContent />
        </Suspense>
    )
}
