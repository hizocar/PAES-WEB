"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { QuestionCard } from "@/components/practice/QuestionCard"
import { Button } from "@/components/ui/button"
import { Loader2, Trophy, RotateCcw, AlertCircle } from "lucide-react"

export default function PracticePage() {
    const [question, setQuestion] = useState<any>(null)
    const [loading, setLoading] = useState(true)
    const [retryMode, setRetryMode] = useState(false)
    const [completed, setCompleted] = useState(false)
    const [debugMsg, setDebugMsg] = useState("")

    const supabase = createClient()

    const fetchQuestion = async () => {
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
                    p_retry_mode: retryMode
                })

            if (error) {
                setDebugMsg(`Error al obtener pregunta: ${error.message}`)
            } else if (!data || data.length === 0) {
                // No questions returned
                setQuestion(null)
                setCompleted(true)
            } else {
                // RPC returns an array (function returns table), take the first item
                const qRaw = data[0]

                // transform for frontend (the RPC returns flatted topic_name/eje_name)
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
            setLoading(false)
        }
    }

    useEffect(() => {
        fetchQuestion()
    }, [retryMode]) // Re-fetch when retryMode changes

    if (loading) {
        return (
            <div className="flex h-[80vh] items-center justify-center flex-col gap-4">
                <Loader2 className="animate-spin text-blue-600" size={40} />
                <p className="text-slate-500 font-medium">
                    {retryMode ? "Buscando preguntas para repasar..." : "Cargando siguiente desafío..."}
                </p>
            </div>
        )
    }

    // Completion / Empty State
    if (completed || !question) {
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
                            ¡Eres un experto en M2!
                        </p>
                        <div className="pt-4 space-y-3 w-full">
                            <Button
                                onClick={() => setRetryMode(true)}
                                className="w-full h-12 text-lg bg-blue-600 hover:bg-blue-700"
                            >
                                <RotateCcw className="mr-2" size={20} />
                                Repasar mis errores
                            </Button>
                            <p className="text-xs text-slate-400">
                                Volverás a ver las preguntas en las que fallaste anteriormente.
                            </p>
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

                {debugMsg && (
                    <div className="mt-8 p-4 bg-red-50 text-red-600 rounded-lg text-xs font-mono border border-red-200">
                        debug: {debugMsg}
                    </div>
                )}
            </div>
        )
    }

    return (
        <div className="min-h-screen bg-slate-50 pb-20 pt-8 px-4">
            {/* Progress Header */}
            <div className="max-w-3xl mx-auto mb-8 flex items-center justify-between text-sm text-slate-500 font-medium font-mono">
                <div className="flex items-center gap-2">
                    <span className={retryMode ? "text-orange-600 font-bold" : ""}>
                        {retryMode ? "MODO REPASO" : "MODO PRÁCTICA"}
                    </span>
                    {retryMode && <AlertCircle size={14} className="text-orange-500" />}
                </div>
                <span>ALEATORIO</span>
            </div>

            {debugMsg && (
                <div className="max-w-3xl mx-auto mb-4 p-4 bg-yellow-50 text-yellow-800 text-xs font-mono whitespace-pre-wrap border border-yellow-200">
                    {debugMsg}
                </div>
            )}

            <QuestionCard
                question={question}
                onNext={fetchQuestion}
            />
        </div>
    )
}
