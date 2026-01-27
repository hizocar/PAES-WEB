"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { QuestionCard } from "@/components/practice/QuestionCard"
import { Button } from "@/components/ui/button"
import { Loader2 } from "lucide-react"

export default function PracticePage() {
    const [question, setQuestion] = useState<any>(null)
    const [loading, setLoading] = useState(true)
    const supabase = createClient()

    const [debugMsg, setDebugMsg] = useState("")

    const fetchQuestion = async () => {
        setLoading(true)
        setDebugMsg("")
        try {
            // Fetch with topics relation and parent eje
            // Using deep select syntax for Supabase
            const { data, error } = await supabase
                .from('questions')
                .select(`
                    *,
                    question_topics (
                        topics (
                            name,
                            ejes (name)
                        )
                    )
                `)
                .limit(10)

            if (error) {
                setDebugMsg(`Error: ${error.message} (Code: ${error.code})`)
            } else if (!data || data.length === 0) {
                setDebugMsg("Success but found 0 questions. Did the seed script run?")
            } else {
                const randomQRaw: any = data[Math.floor(Math.random() * data.length)]

                // transform for frontend
                // Extract the first topic if available
                const topicData = randomQRaw.question_topics && randomQRaw.question_topics.length > 0
                    ? randomQRaw.question_topics[0].topics
                    : null

                const randomQ = {
                    ...randomQRaw,
                    topic: topicData?.name || 'General',
                    eje: topicData?.ejes?.name || 'General'
                }

                setQuestion(randomQ)
            }
        } catch (e: any) {
            setDebugMsg(`Exception: ${e.message}`)
        } finally {
            setLoading(false)
        }
    }

    useEffect(() => {
        fetchQuestion()
    }, [])

    if (loading) {
        return (
            <div className="flex h-[80vh] items-center justify-center flex-col gap-4">
                <Loader2 className="animate-spin text-blue-600" size={40} />
                <p className="text-slate-500 font-medium">Cargando ejercicio...</p>
            </div>
        )
    }

    if (!question) {
        return (
            <div className="flex h-[80vh] items-center justify-center flex-col gap-4">
                <p className="text-slate-500 font-medium">No hay preguntas disponibles.</p>
                {debugMsg && (
                    <div className="p-4 bg-red-50 text-red-600 rounded-lg text-sm font-mono max-w-lg text-center border border-red-200">
                        {debugMsg}
                    </div>
                )}
                <Button onClick={() => fetchQuestion()}>Reintentar</Button>
            </div>
        )
    }

    return (
        <div className="min-h-screen bg-slate-50 pb-20 pt-8 px-4">
            {/* Progress Header */}
            <div className="max-w-3xl mx-auto mb-8 flex items-center justify-between text-sm text-slate-500 font-medium font-mono">
                <span>MODO PRÁCTICA</span>
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
