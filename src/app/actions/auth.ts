"use server"

import { createClient } from "@/lib/supabase/server"

export async function exchangeAuthCode(code: string) {
    const supabase = createClient()
    try {
        const { error } = await (await supabase).auth.exchangeCodeForSession(code)
        if (error) {
            return { error: error.message }
        }
        return { success: true }
    } catch (error) {
        console.error("Error exchanging auth code:", error)
        return { error: "An unexpected error occurred" }
    }
}
