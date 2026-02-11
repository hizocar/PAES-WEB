"use client"

import { useEffect, useState, useRef } from "react"
import { createClient } from "@/lib/supabase/client"
import { useParams, useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import {
    Loader2,
    Clock,
    ChevronLeft,
    ChevronRight,
    CheckCircle2,
    AlertTriangle,
    LayoutGrid,
    X
} from "lucide-react"
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import 'katex/dist/katex.min.css'

export default function EnsayoRunnerPage() {
    const { id } = useParams()
    const router = useRouter()
    const supabase = createClient()

    const [loading, setLoading] = useState(true)
    const [submitting, setSubmitting] = useState(false)
    const [questions, setQuestions] = useState<any[]>([])
    const [currentIndex, setCurrentIndex] = useState(0)
    const [answers, setAnswers] = useState<Record<string, string>>({}) // { question_id: "A" }
    const [timeLeft, setTimeLeft] = useState<number>(2 * 60 * 60 + 20 * 60) // 2h 20m in seconds
    const [ensayoStatus, setEnsayoStatus] = useState('in_progress')
    const [showSidebar, setShowSidebar] = useState(false)

    // Fetch Ensayo Data
    useEffect(() => {
        const fetchEnsayo = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            const { data, error } = await supabase
                .from('ensayos')
                .select('*')
                .eq('id', id)
                .single()

            if (error || !data) {
                console.error("Error fetching ensayo:", error)
                router.push('/app/ensayos')
                return
            }

            if (data.status === 'completed') {
                router.push(`/app/ensayos/${id}/results`)
                return
            }

            // Calculate remaining time based on started_at
            const startedAt = new Date(data.started_at).getTime()
            const now = new Date().getTime()
            const elapsedSeconds = Math.floor((now - startedAt) / 1000)
            const totalDuration = 2 * 60 * 60 + 20 * 60 // 8400 seconds
            const remaining = Math.max(0, totalDuration - elapsedSeconds)

            setTimeLeft(remaining)
            setQuestions(data.questions_data || [])

            // Restore previous answers if saved (not yet implemented in create_ensayo, but good practice)
            if (data.answers) {
                setAnswers(data.answers)
            }

            setLoading(false)
        }
        fetchEnsayo()
    }, [id, supabase, router])

    // Timer Logic
    useEffect(() => {
        if (loading || timeLeft <= 0) return

        const timer = setInterval(() => {
            setTimeLeft((prev) => {
                if (prev <= 1) {
                    clearInterval(timer)
                    handleSubmit(true) // Auto-submit
                    return 0
                }
                return prev - 1
            })
        }, 1000)

        return () => clearInterval(timer)
    }, [loading, timeLeft])

    const formatTime = (seconds: number) => {
        const h = Math.floor(seconds / 3600)
        const m = Math.floor((seconds % 3600) / 60)
        const s = seconds % 60
        return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
    }

    const handleAnswer = (optionId: string) => {
        const currentQ = questions[currentIndex]
        if (!currentQ) return
        setAnswers(prev => ({
            ...prev,
            [currentQ.question_id]: optionId
        }))
    }

    const handleSubmit = async (auto = false) => {
        if (submitting) return
        setSubmitting(true)

        try {
            const { data, error } = await supabase.rpc('submit_ensayo', {
                p_ensayo_id: id,
                p_answers: answers
            })

            if (error) throw error

            router.push(`/app/ensayos/${id}/results`)
        } catch (e) {
            console.error("Error submitting:", e)
            setSubmitting(false)
        }
    }

    if (loading) {
        return <div className="flex h-screen items-center justify-center"><Loader2 className="animate-spin" /></div>
    }

    const currentQuestion = questions[currentIndex]

    // Safety check if no questions found or index out of bounds
    if (!currentQuestion) {
        return (
            <div className="flex flex-col h-screen items-center justify-center space-y-4">
                <AlertTriangle className="text-yellow-500 w-12 h-12" />
                <h2 className="text-xl font-bold">No se encontraron preguntas</h2>
                <Button onClick={() => router.push('/app/ensayos')}>Volver</Button>
            </div>
        )
    }

    const answeredCount = Object.keys(answers).length
    const isLastQuestion = currentIndex === questions.length - 1

    return (
        <div className="flex flex-col h-screen bg-slate-50 overflow-hidden">
            {/* Header */}
            <header className="bg-white border-b border-slate-200 h-16 flex items-center justify-between px-4 md:px-8 shrink-0 z-20 relative">
                <div className="flex items-center gap-4">
                    <Button variant="ghost" className="h-10 w-10 p-0 md:hidden" onClick={() => setShowSidebar(!showSidebar)}>
                        <LayoutGrid size={20} />
                    </Button>
                    <div className="font-bold text-slate-700 hidden md:block">
                        Pregunta {currentIndex + 1} <span className="text-slate-400 font-normal">/ {questions.length}</span>
                    </div>
                </div>

                <div className={`
                    flex items-center gap-2 font-mono text-xl font-bold px-4 py-1.5 rounded-lg border
                    ${timeLeft < 300 ? 'bg-red-50 text-red-600 border-red-200 animate-pulse' : 'bg-slate-100 text-slate-700 border-slate-200'}
                `}>
                    <Clock size={16} />
                    {formatTime(timeLeft)}
                </div>

                <div className="flex items-center gap-2">
                    <span className="text-sm text-slate-500 hidden md:inline-block">
                        {answeredCount} de {questions.length} respondidas
                    </span>
                    <Button
                        onClick={() => {
                            const unanswered = questions.length - Object.keys(answers).length
                            if (window.confirm(unanswered > 0 ? `Quedan ${unanswered} preguntas. ¿Finalizar?` : "¿Enviar respuestas?")) {
                                handleSubmit(false)
                            }
                        }}
                        variant={answeredCount === questions.length ? "default" : "secondary"}
                    >
                        Finalizar
                    </Button>
                </div>
            </header>

            <div className="flex flex-1 overflow-hidden relative">
                {/* Sidebar (Navigation) */}
                <aside className={`
                    absolute inset-y-0 left-0 z-10 w-72 bg-white border-r border-slate-200 transform transition-transform duration-300 md:relative md:translate-x-0 overflow-y-auto
                    ${showSidebar ? 'translate-x-0 shadow-2xl' : '-translate-x-full md:shadow-none'}
                `}>
                    <div className="p-4 flex items-center justify-between md:hidden">
                        <span className="font-bold text-slate-700">Navegación</span>
                        <Button variant="ghost" className="h-8 w-8 p-0" onClick={() => setShowSidebar(false)}><X size={20} /></Button>
                    </div>

                    <div className="p-4 grid grid-cols-5 gap-2">
                        {questions.map((q, idx) => {
                            const isAnswered = !!answers[q.question_id]
                            const isCurrent = idx === currentIndex
                            return (
                                <button
                                    key={q.question_id}
                                    onClick={() => {
                                        setCurrentIndex(idx)
                                        setShowSidebar(false)
                                    }}
                                    className={`
                                        h-10 w-10 text-sm font-bold rounded-lg flex items-center justify-center transition-all
                                        ${isCurrent ? 'bg-blue-600 text-white ring-2 ring-blue-300 ring-offset-2' :
                                            isAnswered ? 'bg-blue-100 text-blue-700 border border-blue-200' : 'bg-slate-100 text-slate-500 hover:bg-slate-200'}
                                    `}
                                >
                                    {idx + 1}
                                </button>
                            )
                        })}
                    </div>
                </aside>

                {/* Main Content (Question) */}
                <main className="flex-1 overflow-y-auto p-4 md:p-8 md:pb-24">
                    <div className="max-w-3xl mx-auto space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-300" key={currentQuestion.question_id}>
                        <div className="flex items-center gap-2 mb-4">
                            <span className="bg-slate-100 text-slate-600 text-xs font-bold px-2 py-1 rounded uppercase tracking-wider">
                                {currentQuestion.eje_slug?.replace(/-/g, ' ')}
                            </span>
                        </div>

                        {/* Question Text */}
                        <div className="text-lg md:text-xl font-medium text-slate-800 leading-relaxed">
                            <Latex>{currentQuestion.content}</Latex>
                        </div>

                        {/* Alternatives */}
                        <div className="grid gap-3">
                            {currentQuestion.alternatives.map((alt: any) => {
                                const isSelected = answers[currentQuestion.question_id] === alt.id
                                return (
                                    <div
                                        key={alt.id}
                                        onClick={() => handleAnswer(alt.id)}
                                        className={`
                                             group cursor-pointer p-4 rounded-xl border-2 transition-all flex items-start gap-4 select-none
                                             ${isSelected
                                                ? 'border-blue-600 bg-blue-50/50 shadow-sm'
                                                : 'border-slate-200 hover:border-blue-300 hover:bg-slate-50'}
                                         `}
                                    >
                                        <div className={`
                                             w-8 h-8 rounded-full border-2 flex items-center justify-center font-bold text-sm shrink-0 transition-colors
                                             ${isSelected ? 'bg-blue-600 border-blue-600 text-white' : 'border-slate-300 text-slate-400 group-hover:border-blue-400 group-hover:text-blue-500'}
                                         `}>
                                            {alt.id}
                                        </div>
                                        <div className="pt-0.5 text-slate-700 group-hover:text-slate-900">
                                            <Latex>{alt.content}</Latex>
                                        </div>
                                    </div>
                                )
                            })}
                        </div>
                    </div>
                </main>
            </div>

            {/* Footer Navigation */}
            <div className="bg-white border-t border-slate-200 p-4 shrink-0 flex items-center justify-between max-w-full z-20">
                <Button
                    variant="outline"
                    onClick={() => setCurrentIndex(prev => Math.max(0, prev - 1))}
                    disabled={currentIndex === 0}
                    className="w-32"
                >
                    <ChevronLeft size={16} className="mr-2" />
                    Anterior
                </Button>

                <div className="text-sm font-medium text-slate-500 hidden md:block">
                    {/* Placeholder for progress bar if needed */}
                </div>

                {isLastQuestion ? (
                    <Button
                        className="w-32 bg-green-600 hover:bg-green-700"
                        onClick={() => {
                            if (window.confirm("¿Estás seguro de que quieres terminar el examen?")) {
                                handleSubmit(false)
                            }
                        }}
                    >
                        Finalizar
                    </Button>
                ) : (
                    <Button
                        onClick={() => setCurrentIndex(prev => Math.min(questions.length - 1, prev + 1))}
                        className="w-32"
                    >
                        Siguiente
                        <ChevronRight size={16} className="ml-2" />
                    </Button>
                )}
            </div>
        </div>
    )
}
