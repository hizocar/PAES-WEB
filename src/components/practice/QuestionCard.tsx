"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import 'katex/dist/katex.min.css'
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import { Button } from "@/components/ui/button"
import { motion, AnimatePresence } from "framer-motion"
import { CheckCircle2, XCircle, History, TrendingUp } from "lucide-react"
import { QuestionTimer } from "./QuestionTimer"

import { ExplanationView } from "./ExplanationView"
import { QuestionFeedback } from "./QuestionFeedback"
import { AchievementNotification } from "@/components/achievements/AchievementNotification"

type Question = {
    id: string
    content: string
    alternatives: { id: string; content: string }[]
    correct_answer: string
    explanation?: string
    difficulty?: 'easy' | 'medium' | 'hard'
    topic?: string
    eje?: string
    explanation_video_path?: string
}

type QuestionCardProps = {
    question: Question
    onNext: () => void
    onWrongAnswer?: () => void
}

import { useSubject } from "@/components/providers/SubjectContext"

export function QuestionCard({ question, onNext, onWrongAnswer }: QuestionCardProps) {
    const { subject } = useSubject()
    const [selected, setSelected] = useState<string | null>(null)
    const [submitted, setSubmitted] = useState(false)
    const [stats, setStats] = useState<{ attempts: number, correct: number }>({ attempts: 0, correct: 0 })
    const [unlockedAchievement, setUnlockedAchievement] = useState<any>(null)

    const supabase = createClient()

    useEffect(() => {
        const fetchStats = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return
            const { data } = await supabase
                .from('attempts')
                .select('is_correct')
                .eq('user_id', user.id)
                .eq('question_id', question.id)

            if (data) {
                setStats({
                    attempts: data.length,
                    correct: data.filter(a => a.is_correct).length
                })
            }
        }

        // Reset state for new question
        setSelected(null)
        setSubmitted(false)
        fetchStats()
    }, [question.id])

    const isCorrect = selected === question.correct_answer

    const handleSubmit = async () => {
        if (!selected) return
        setSubmitted(true)

        const isAnswerCorrect = selected === question.correct_answer

        // Trigger wrong answer callback if needed
        if (!isAnswerCorrect && onWrongAnswer) {
            onWrongAnswer()
        }

        // Save attempt to DB
        const { data: { user } } = await supabase.auth.getUser()

        if (user) {
            await supabase.from('attempts').insert({
                user_id: user.id,
                question_id: question.id,
                selected_answer: selected,
                is_correct: isAnswerCorrect
            })

            // Update local stats
            setStats(prev => ({
                attempts: prev.attempts + 1,
                correct: prev.correct + (isAnswerCorrect ? 1 : 0)
            }))

            // Check for achievements if correct
            if (isAnswerCorrect) {
                const { data: newAchievements } = await supabase
                    .rpc('check_and_unlock_achievement', {
                        p_user_id: user.id,
                        p_trigger_type: 'ANSWER',
                        p_subject: subject
                    })

                if (newAchievements && newAchievements.length > 0) {
                    setUnlockedAchievement(newAchievements[0]) // Show the first one
                }
            }
        }
    }

    const handleTimeout = async () => {
        if (submitted) return // Don't double submit

        // Mark as submitted so timer stops (effectively, though we pass isActive=false)
        setSubmitted(true)

        // 1. Trigger Wrong Answer Effect (Lost Life)
        if (onWrongAnswer) {
            onWrongAnswer()
        }

        // 2. Insert TIMEOUT attempt
        const { data: { user } } = await supabase.auth.getUser()
        if (user) {
            await supabase.from('attempts').insert({
                user_id: user.id,
                question_id: question.id,
                selected_answer: "TIMEOUT", // distinct marker
                is_correct: false
            })
        }

        // 3. Move to next question immediately
        onNext()
    }

    const handleNext = () => {
        setSelected(null)
        setSubmitted(false)
        onNext()
    }

    return (
        <div className="w-full max-w-3xl mx-auto space-y-8">
            <AchievementNotification
                achievement={unlockedAchievement}
                onClose={() => setUnlockedAchievement(null)}
            />
            {/* Timer & Metadata */}
            <div className="space-y-4 px-2">
                <QuestionTimer
                    key={question.id} // Reset timer when question changes
                    duration={150} // 2:30 minutes
                    isActive={!submitted}
                    onTimeout={handleTimeout}
                />

                <div className="flex items-center justify-between">
                    <div className="flex gap-2">
                        <span className={`px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider ${question.difficulty === 'easy' ? 'bg-green-100 text-green-700' :
                            question.difficulty === 'medium' ? 'bg-yellow-100 text-yellow-700' :
                                'bg-red-100 text-red-700'
                            }`}>
                            {question.difficulty === 'easy' ? 'Principiante' :
                                question.difficulty === 'medium' ? 'Intermedio' : 'Avanzado'}
                        </span>

                        {question.eje && (
                            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-blue-100 text-blue-600">
                                {question.eje}
                            </span>
                        )}

                        {question.topic && (
                            <span className="px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider bg-slate-100 text-slate-600">
                                {question.topic}
                            </span>
                        )}
                    </div>
                </div>
            </div>

            {/* Question Content */}
            <div className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100">
                <div className="text-lg md:text-xl font-medium text-slate-800 leading-relaxed">
                    <Latex>{question.content}</Latex>
                </div>
            </div>

            {/* Alternatives */}
            <div className="space-y-3">
                {question.alternatives.map((alt) => {
                    const isSelected = selected === alt.id
                    let variant = "outline"
                    let className = "w-full justify-start p-6 h-auto text-lg border-2"

                    if (submitted) {
                        if (alt.id === question.correct_answer) {
                            className += " border-green-500 bg-green-50 text-green-700 hover:bg-green-50"
                        } else if (isSelected && !isCorrect) {
                            className += " border-red-500 bg-red-50 text-red-700 hover:bg-red-50"
                        } else {
                            className += " opacity-50"
                        }
                    } else {
                        if (isSelected) {
                            className += " border-blue-600 bg-blue-50 text-blue-700 ring-1 ring-blue-600"
                        } else {
                            className += " hover:border-slate-300 hover:bg-slate-50"
                        }
                    }

                    return (
                        <Button
                            key={alt.id}
                            variant="ghost"
                            className={className}
                            onClick={() => !submitted && setSelected(alt.id)}
                            disabled={submitted}
                        >
                            <span className="w-8 h-8 rounded-full border-2 border-current flex items-center justify-center mr-4 text-sm font-bold shrink-0">
                                {alt.id}
                            </span>
                            <span className="flex-1 text-left">
                                <Latex>{alt.content}</Latex>
                            </span>
                            {submitted && alt.id === question.correct_answer && (
                                <CheckCircle2 className="text-green-600 ml-4 shrink-0" />
                            )}
                            {submitted && isSelected && !isCorrect && (
                                <XCircle className="text-red-600 ml-4 shrink-0" />
                            )}
                        </Button>
                    )
                })}
            </div>

            {/* Inline Check Button - Only if NOT submitted */}
            {!submitted && (
                <div className="mt-8 flex justify-end">
                    <Button
                        size="lg"
                        className="w-full md:w-auto px-8 h-12 text-lg font-bold tracking-wide uppercase shadow-md hover:shadow-lg transition-all transform hover:-translate-y-0.5"
                        disabled={!selected}
                        onClick={handleSubmit}
                    >
                        Comprobar
                    </Button>
                </div>
            )}

            {/* User History Stats */}
            {stats.attempts > 0 && (
                <div className="flex items-center gap-6 px-4 py-2 bg-slate-50/50 rounded-lg border border-slate-100 mx-2 animate-in fade-in slide-in-from-top-2 mt-6">
                    <div className="flex items-center gap-2 text-xs text-slate-500 font-medium uppercase tracking-wider">
                        <History size={14} />
                        <span>Intento #{stats.attempts + (submitted ? 0 : 1)}</span>
                    </div>
                    <div className="flex items-center gap-2 text-xs text-slate-500 font-medium uppercase tracking-wider">
                        <TrendingUp size={14} />
                        <span>
                            Tasa de éxito: {Math.round((stats.correct / stats.attempts) * 100)}%
                            <span className="ml-1 text-slate-400 normal-case">({stats.correct}/{stats.attempts})</span>
                        </span>
                    </div>
                </div>
            )}

            {/* Footer / Feedback (Only applied when submitted) */}
            <AnimatePresence>
                {submitted && (
                    <motion.div
                        initial={{ y: 100, opacity: 0 }}
                        animate={{ y: 0, opacity: 1 }}
                        exit={{ y: 100, opacity: 0 }}
                        className="fixed bottom-0 right-0 left-0 md:left-72 bg-white border-t border-slate-200 p-4 md:p-6 z-20 shadow-[0_-4px_6px_-1px_rgba(0,0,0,0.1)]"
                    >
                        <div className="max-w-3xl mx-auto flex items-center justify-between">
                            <div className="flex items-center gap-4 w-full">
                                <div className={`p-3 rounded-full ${isCorrect ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'}`}>
                                    {isCorrect ? <CheckCircle2 size={24} /> : <XCircle size={24} />}
                                </div>
                                <div className="flex-1">
                                    <h3 className={`font-bold text-lg ${isCorrect ? 'text-green-800' : 'text-red-800'}`}>
                                        {isCorrect ? '¡Correcto!' : 'Incorrecto'}
                                    </h3>
                                    <p className="text-sm text-slate-500">
                                        {isCorrect ? 'Gran trabajo.' : 'No te preocupes, revisa la explicación.'}
                                    </p>
                                </div>
                                <Button onClick={handleNext} size="lg" className={`px-8 h-12 text-lg ${isCorrect ? 'bg-green-600 hover:bg-green-700' : 'bg-red-600 hover:bg-red-700'}`}>
                                    Continuar
                                </Button>
                            </div>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>

            {/* Explanation Section */}
            {submitted && (
                <div className="pb-32 animate-in fade-in slide-in-from-bottom-8 duration-700 delay-150 space-y-8">
                    {/* Feedback UI */}
                    <div className="relative z-10">
                        <QuestionFeedback questionId={question.id} />
                    </div>

                    <ExplanationView
                        questionId={question.id}
                        explanationText={question.explanation}
                        videoPath={question.explanation_video_path}
                    />
                </div>
            )}

            {/* Spacer for fixed footer - only when submitted */}
            {submitted && <div className="h-32" />}
        </div>
    )
}
