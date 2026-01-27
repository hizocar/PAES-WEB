'use server'

import { createClient } from "@/lib/supabase/server"
import { revalidatePath } from "next/cache"

export async function submitQuestionFeedback(questionId: string, vote: 'up' | 'down') {
    const supabase = createClient()
    const { data: { user } } = await (await supabase).auth.getUser()

    if (!user) {
        return { error: "Debes iniciar sesión" }
    }

    const { error } = await (await supabase)
        .from('question_feedback')
        .upsert({
            user_id: user.id,
            question_id: questionId,
            vote: vote
        })

    if (error) {
        console.error("Error submitting feedback:", error)
        return { error: "Error al enviar feedback" }
    }

    return { success: true }
}
