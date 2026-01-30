"use server"

import { createClient } from "@/lib/supabase/server"
import { revalidatePath } from "next/cache"

export async function updatePlanPrice(tier: string, price: number) {
    const supabase = createClient()

    // Check if user is admin
    const { data: { user } } = await (await supabase).auth.getUser()
    if (!user) return { error: "Unauthorized" }

    const { data: profile } = await (await supabase)
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single()

    if (profile?.role !== 'admin') {
        return { error: "Unauthorized" }
    }

    try {
        const { error } = await (await supabase)
            .from('plans')
            .update({ price_clp: price })
            .eq('tier', tier)

        if (error) throw error

        revalidatePath('/app/pricing')
        revalidatePath('/admin/pricing')
        return { success: true }
    } catch (error) {
        console.error("Error updating price:", error)
        return { error: "Failed to update price" }
    }
}
