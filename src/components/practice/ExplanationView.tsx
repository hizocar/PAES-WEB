"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import { Lock, PlayCircle, Crown, Lightbulb, Clock } from "lucide-react"
import Link from "next/link"

type ExplanationProps = {
    questionId: string
    explanationText?: string
    videoPath?: string
}

export function ExplanationView({ questionId, explanationText, videoPath }: ExplanationProps) {
    const [isRevealed, setIsRevealed] = useState(false)
    const [loading, setLoading] = useState(true)
    const [credits, setCredits] = useState<number | null>(null)
    const [replenishAt, setReplenishAt] = useState<string | null>(null)
    const [tier, setTier] = useState<string>('free')
    const [videoSignedUrl, setVideoSignedUrl] = useState<string | null>(null)
    const [timeRemaining, setTimeRemaining] = useState<string>("")

    const supabase = createClient()

    useEffect(() => {
        setIsRevealed(false)
        setVideoSignedUrl(null)
        checkCredits(true) // Initial load for this question
    }, [questionId])

    useEffect(() => {
        let interval: NodeJS.Timeout
        if (credits !== null && credits <= 0 && replenishAt) {
            const updateTimer = () => {
                const now = new Date().getTime()
                const end = new Date(replenishAt).getTime()
                const distance = end - now

                if (distance <= 0) {
                    // Clock skew or just expired. 
                    // Show a message and wait a few seconds before checking.
                    setTimeRemaining("Recargando...")

                    // We use a longer delay and an exponential backoff or simple long wait
                    // to ensure the server-side 'now()' has definitely passed 'replenishAt'.
                    const timeout = setTimeout(() => {
                        checkCredits(false)
                    }, 5000) // 5 seconds wait to be very safe about clock skew

                    return () => clearTimeout(timeout)
                }

                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60))
                const seconds = Math.floor((distance % (1000 * 60)) / 1000)

                setTimeRemaining(`${hours}h ${minutes}m ${seconds}s`)
            }

            updateTimer()
            interval = setInterval(updateTimer, 1000)
        } else if (credits !== null && credits > 0) {
            setTimeRemaining("")
        }
        return () => clearInterval(interval)
    }, [credits, replenishAt])

    const checkCredits = async (showLoading = false) => {
        if (showLoading) setLoading(true)

        const { data: { user } } = await supabase.auth.getUser()
        if (!user) {
            setLoading(false)
            return
        }

        try {
            // Check credits & Tier
            const [rpcResult, profileResult] = await Promise.all([
                supabase.rpc('check_explanation_replenishment', { p_user_id: user.id }),
                supabase.from('profiles').select('subscription_tier').eq('id', user.id).single()
            ])

            if (rpcResult.data) {
                setCredits(rpcResult.data.credits)
                setReplenishAt(rpcResult.data.replenish_at)
            }

            if (profileResult.data) {
                setTier(profileResult.data.subscription_tier || 'free')
            }
        } catch (error) {
            console.error("Error checking credits:", error)
        } finally {
            setLoading(false)
        }
    }

    const handleReveal = async () => {
        if (tier === 'free' && (credits === null || credits <= 0)) return

        const { data: { user } } = await supabase.auth.getUser()
        if (!user) return

        const { data: success, error } = await supabase.rpc('deduct_explanation', {
            p_user_id: user.id
        })

        if (success) {
            setCredits(prev => (prev !== null ? prev - 1 : 0))
            setIsRevealed(true)

            if (videoPath) {
                const { data } = await supabase.storage
                    .from('explanation-videos')
                    .createSignedUrl(videoPath, 3600)
                if (data?.signedUrl) setVideoSignedUrl(data.signedUrl)
            }
        }
    }

    if (loading && !isRevealed) return <div className="p-4 animate-pulse bg-slate-100 rounded-xl h-32" />

    // Content is revealed
    if (isRevealed) {
        return (
            <div className="space-y-6 animate-in fade-in slide-in-from-bottom-4 bg-blue-50/50 p-6 rounded-2xl border border-blue-100">
                <h3 className="font-bold text-slate-900 flex items-center gap-2">
                    <div className="w-8 h-8 rounded-full bg-blue-100 text-blue-600 flex items-center justify-center">
                        <Lightbulb size={18} />
                    </div>
                    Explicación
                    <span className="text-xs font-bold bg-blue-100 text-blue-700 px-3 py-1 rounded-full uppercase tracking-wider">
                        {tier !== 'free' ? "ILIMITADAS" : `${credits} restantes hoy`}
                    </span>
                </h3>

                {videoSignedUrl && (
                    <div className="rounded-lg overflow-hidden bg-black aspect-video relative shadow-md">
                        <video
                            className="w-full h-full"
                            controls
                            src={videoSignedUrl}
                            controlsList="nodownload"
                        />
                    </div>
                )}

                {explanationText && (
                    <div className="prose prose-slate max-w-none text-slate-700 bg-white p-4 rounded-xl border border-blue-100 shadow-sm">
                        <Latex>{explanationText}</Latex>
                    </div>
                )}
            </div>
        )
    }

    // Credits exhausted
    if (tier === 'free' && credits !== null && credits <= 0) {
        return (
            <div className="bg-slate-50 rounded-xl p-8 text-center border border-slate-200">
                <div className="w-12 h-12 bg-slate-200 rounded-full flex items-center justify-center mx-auto mb-4 text-slate-400">
                    <Lock size={24} />
                </div>
                <h3 className="text-lg font-bold text-slate-900 mb-2">Explicaciones Agotadas</h3>
                <p className="text-slate-500 mb-6 max-w-sm mx-auto text-sm">
                    Has usado tus 5 explicaciones gratuitas de hoy. Vuelven en:
                </p>
                <div className="inline-flex items-center gap-2 bg-slate-900 text-white px-5 py-3 rounded-2xl font-mono font-bold text-xl mb-6 shadow-xl border-b-4 border-slate-700">
                    <Clock size={20} className="text-blue-400" />
                    {timeRemaining || (loading ? "Sincronizando..." : "Calculando...")}
                </div>
                {!loading && (
                    <button
                        onClick={() => checkCredits(true)}
                        className="block mx-auto text-xs text-blue-600 hover:underline mb-6"
                    >
                        ¿Ya pasó el tiempo? Haz clic para actualizar
                    </button>
                )}
                <Link href="/app/pricing" className="w-full max-w-xs">
                    <Button className="w-full bg-gradient-to-r from-yellow-500 to-yellow-600 hover:from-yellow-400 hover:to-yellow-500 text-slate-900 font-bold border-0 shadow-lg shadow-yellow-500/20">
                        <Crown size={18} className="mr-2" />
                        Obtener Ilimitado
                    </Button>
                </Link>
            </div>
        )
    }

    // Default state: Hidden with Reveal button
    return (
        <div className="bg-gradient-to-b from-blue-50 to-white rounded-xl p-8 text-center border border-blue-100 shadow-sm">
            <div className="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4 text-blue-600 animate-pulse">
                <Lightbulb size={24} />
            </div>
            <h3 className="text-lg font-bold text-slate-900 mb-2">¿Quieres ver la explicación?</h3>
            <p className="text-slate-500 mb-6 max-w-sm mx-auto text-sm">
                {tier !== 'free' ? (
                    "Tienes acceso ilimitado a todas las explicaciones por ser Premium."
                ) : (
                    <>Te quedan <span className="font-bold text-blue-600">{credits} explicaciones</span> gratuitas hoy.</>
                )}
            </p>
            <Button
                onClick={handleReveal}
                className="bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-6 h-auto text-lg shadow-blue-200 shadow-xl transition-all hover:scale-105"
            >
                Revelar Explicación
                {tier === 'free' && (
                    <span className="ml-2 text-xs bg-blue-700/50 px-2 py-0.5 rounded text-blue-100 border border-blue-500/30">
                        -1 crédito
                    </span>
                )}
            </Button>
        </div>
    )
}
