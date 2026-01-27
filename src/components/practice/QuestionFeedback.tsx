"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { ThumbsUp, ThumbsDown, MessageSquare } from "lucide-react"
import { submitQuestionFeedback } from "@/app/actions/feedback"

interface QuestionFeedbackProps {
    questionId: string
}

export function QuestionFeedback({ questionId }: QuestionFeedbackProps) {
    const [vote, setVote] = useState<'up' | 'down' | null>(null)
    const [loading, setLoading] = useState(false)

    const handleVote = async (value: 'up' | 'down') => {
        setLoading(true)
        const res = await submitQuestionFeedback(questionId, value)
        setLoading(false)
        if (res?.success) {
            setVote(value)
        }
    }

    if (vote) {
        return (
            <div className="flex items-center gap-2 text-sm text-green-600 font-medium bg-green-50 px-4 py-2 rounded-lg animate-in fade-in zoom-in duration-300">
                <span>¡Gracias por tu feedback!</span>
                {vote === 'up' ? <ThumbsUp size={16} /> : <ThumbsDown size={16} />}
            </div>
        )
    }

    return (
        <div className="flex items-center gap-4 bg-slate-50 p-4 rounded-xl border border-slate-100">
            <div className="flex items-center gap-2 text-slate-500 text-sm font-medium">
                <MessageSquare size={16} />
                <span>¿Qué te pareció esta pregunta?</span>
            </div>
            <div className="flex gap-2">
                <Button
                    variant="outline"
                    size="sm"
                    className="h-8 w-8 p-0 rounded-full hover:bg-green-50 hover:text-green-600 hover:border-green-200"
                    onClick={() => handleVote('up')}
                    disabled={loading}
                >
                    <ThumbsUp size={14} />
                </Button>
                <Button
                    variant="outline"
                    size="sm"
                    className="h-8 w-8 p-0 rounded-full hover:bg-red-50 hover:text-red-600 hover:border-red-200"
                    onClick={() => handleVote('down')}
                    disabled={loading}
                >
                    <ThumbsDown size={14} />
                </Button>
            </div>
        </div>
    )
}
