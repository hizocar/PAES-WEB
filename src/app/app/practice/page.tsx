"use client"

import { useEffect, useState, Suspense, useRef } from "react"
import { createClient } from "@/lib/supabase/client"
import { QuestionCard } from "@/components/practice/QuestionCard"
import { Button } from "@/components/ui/button"
import { Loader2, Trophy, RotateCcw, AlertCircle, HeartCrack } from "lucide-react"
import { LivesCounter } from "@/components/practice/LivesCounter"
import Link from "next/link"
import { useSubject } from "@/components/providers/SubjectContext"
import { useSearchParams } from 'next/navigation'

function PracticeContent() {
    const { subject } = useSubject()
    const searchParams = useSearchParams()
    const modeParam = searchParams.get('mode')

    // React to URL changes
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

    // Initialize Lives & Tier
    useEffect(() => {
        const initPractice = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            const [livesResult, profileResult] = await Promise.all([
                supabase.rpc('check_and_replenish_lives', { p_user_id: user.id, p_subject: subject }),
                supabase.from('profiles').select('subscription_tier').eq('id', user.id).single()
            ])

            if (livesResult.data && livesResult.data.length > 0) {
                setLives(livesResult.data[0].current_lives)
                setReplenishAt(livesResult.data[0].replenish_at)
            }

            if (profileResult.data) {
                setTier(profileResult.data.subscription_tier || 'free')
            }
        }
        initPractice()
    }, [subject])

    const fetchQuestion = async () => {
        // Increment Request ID
        const currentReqId = ++reqIdRef.current

        setLoading(true)
        setDebugMsg("")
        try {
            const { data: { user } } = await supabase.auth.getUser()

            if (!user) {
                setDebugMsg("Usuario no autenticado")
                return
            }

            const { data, error } = await supabase
                .rpc('get_smart_question', {
                    p_user_id: user.id,
                    p_retry_mode: retryMode,
                    p_subject: subject
                })

            // Race Condition Check
            if (currentReqId !== reqIdRef.current) return

            if (error) {
                setDebugMsg(`Error al obtener pregunta: ${error.message}`)
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
                setQuestion(qFormatted)
                setCompleted(false)
            }
        } catch (e: any) {
            setDebugMsg(`Excepción: ${e.message}`)
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
    }, [retryMode, subject])

    // Fetch Question if missing (and we have lives or are premium)
    useEffect(() => {
        if ((lives > 0 || tier !== 'free') && !question && !completed) {
            fetchQuestion()
        }
    }, [lives, question, completed, tier])

    const handleWrongAnswer = async () => {
        const { data: { user } } = await supabase.auth.getUser()
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
            <div className="flex h-[80vh] items-center justify-center flex-col gap-4">
                <Loader2 className="animate-spin text-blue-600" size={40} />
                <p className="text-slate-500 font-medium">
                    {retryMode ? "Buscando preguntas para repasar..." : "Cargando siguiente desafío..."}
                </p>
            </div>
        )
    }

    // Cooldown / No Lives Screen (Only for free users)
    if (tier === 'free' && lives === 0 && replenishAt) {
        return (
            <div className="flex h-[80vh] items-center justify-center flex-col gap-8 px-4 text-center max-w-md mx-auto animate-in fade-in zoom-in duration-300">
                <div className="relative">
                    <div className="absolute inset-0 bg-red-100 rounded-full animate-ping opacity-20"></div>
                    <div className="w-32 h-32 bg-red-50 rounded-full flex items-center justify-center relative border-4 border-white shadow-xl">
                        <HeartCrack className="text-red-500" size={64} />
                    </div>
                </div>

                <div className="space-y-2">
                    <h2 className="text-3xl font-bold text-slate-900">¡Te quedaste sin vidas!</h2>
                    <p className="text-slate-500 text-lg">
                        Necesitas descansar un poco. Tus vidas se recargarán en:
                    </p>
                </div>

                <div className="bg-slate-900 text-white text-3xl font-mono py-4 px-8 rounded-2xl shadow-lg border-b-4 border-slate-700">
                    <LivesCounter lives={0} replenishAt={replenishAt} />
                </div>

                <div className="pt-8">
                    <Link href="/app">
                        <Button size="lg" variant="outline" className="h-12 px-8 text-lg">
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
                <div className="w-24 h-24 bg-yellow-100 rounded-full flex items-center justify-center mb-4">
                    <Trophy className="text-yellow-600" size={48} />
                </div>

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
                        <h2 className="text-2xl font-bold text-slate-800">¡Repaso Completado!</h2>
                        <p className="text-slate-500">
                            Ya no tienes errores pendientes por corregir.
                            ¡Tu historial está impecable!
                        </p>
                        <div className="pt-4">
                            <Button
                                onClick={() => setRetryMode(false)}
                                variant="outline"
                            >
                                Volver al modo normal
                            </Button>
                        </div>
                    </>
                )}
            </div>
        )
    }

    return (
        <div className="min-h-screen bg-slate-50 pb-20 pt-8 px-4">
            {/* Header: Progress & Lives */}
            <div className="max-w-3xl mx-auto mb-8 flex items-center justify-between">
                <div className="flex items-center gap-2 text-sm text-slate-500 font-medium font-mono">
                    <span className={retryMode ? "text-orange-600 font-bold" : ""}>
                        {retryMode ? "MODO REPASO" : "MODO PRÁCTICA"}
                    </span>
                    {retryMode && <AlertCircle size={14} className="text-orange-500" />}
                </div>

                <LivesCounter lives={lives} replenishAt={replenishAt} tier={tier} />
            </div>

            {debugMsg && (
                <div className="max-w-3xl mx-auto mb-4 p-4 bg-yellow-50 text-yellow-800 text-xs font-mono whitespace-pre-wrap border border-yellow-200">
                    {debugMsg}
                </div>
            )}

            {question && (
                <QuestionCard
                    question={question}
                    onNext={fetchQuestion}
                    onWrongAnswer={handleWrongAnswer}
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
