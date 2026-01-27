import { useState } from "react"
import { createClient } from "@/lib/supabase/client"
import 'katex/dist/katex.min.css'
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import { Button } from "@/components/ui/button"
import { motion, AnimatePresence } from "framer-motion"
import { CheckCircle2, XCircle } from "lucide-react"
import { ExplanationView } from "./ExplanationView"

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
}

export function QuestionCard({ question, onNext }: QuestionCardProps) {
    const [selected, setSelected] = useState<string | null>(null)
    const [submitted, setSubmitted] = useState(false)

    const isCorrect = selected === question.correct_answer

    const handleSubmit = async () => {
        if (!selected) return
        setSubmitted(true)

        // Save attempt to DB
        const supabase = createClient()
        const { data: { user } } = await supabase.auth.getUser()

        if (user) {
            await supabase.from('attempts').insert({
                user_id: user.id,
                question_id: question.id,
                selected_answer: selected,
                is_correct: selected === question.correct_answer
            })
        }
    }

    const handleNext = () => {
        setSelected(null)
        setSubmitted(false)
        onNext()
    }

    return (
        <div className="w-full max-w-3xl mx-auto space-y-8">
            {/* Metadata Badges */}
            <div className="flex items-center justify-between px-2">
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

            {/* Footer / Feedback */}
            <div className="fixed bottom-0 right-0 left-0 md:left-64 bg-white border-t border-slate-200 p-4 md:p-6 z-20">
                <div className="max-w-3xl mx-auto flex items-center justify-between">
                    {submitted ? (
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
                            <Button onClick={handleNext} size="lg" className={`px-8 ${isCorrect ? 'bg-green-600 hover:bg-green-700' : 'bg-red-600 hover:bg-red-700'}`}>
                                Continuar
                            </Button>
                        </div>
                    ) : (
                        <div className="ml-auto">
                            <Button
                                size="lg"
                                className="px-8 font-bold tracking-wide uppercase"
                                disabled={!selected}
                                onClick={handleSubmit}
                            >
                                Comprobar
                            </Button>
                        </div>
                    )}
                </div>
            </div>

            {/* Explanation Section */}
            {submitted && (
                <div className="pb-32 animate-in fade-in slide-in-from-bottom-8 duration-700 delay-150">
                    <ExplanationView
                        questionId={question.id}
                        explanationText={question.explanation}
                        videoPath={question.explanation_video_path}
                    />
                </div>
            )}

            {/* Spacer for fixed footer */}
            <div className="h-24" />
        </div>
    )
}
