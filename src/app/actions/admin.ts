"use server"

import { createClient } from "@/lib/supabase/server"
import { createClient as createSupabaseClient } from "@supabase/supabase-js"

export async function adminDeleteUser(userId: string) {
    const supabase = await createClient()

    // 1. Verify if user is admin (security)
    const { data: { session } } = await supabase.auth.getSession()
    if (!session) return { error: "No autorizado" }

    const { data: adminProfile } = await supabase
        .from("profiles")
        .select("is_admin")
        .eq("id", session.user.id)
        .single()

    if (!adminProfile?.is_admin) {
        return { error: "No tienes permisos de administrador" }
    }

    try {
        // 2. Delete public data via RPC
        const { error: rpcError } = await supabase.rpc('admin_delete_user_data', {
            p_user_id: userId
        })

        if (rpcError) throw rpcError

        // 3. Optional: Delete from Auth if Service Role Key is available
        const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY
        if (serviceRoleKey) {
            const adminSupabase = createSupabaseClient(
                process.env.NEXT_PUBLIC_SUPABASE_URL!,
                serviceRoleKey,
                {
                    auth: {
                        autoRefreshToken: false,
                        persistSession: false
                    }
                }
            )
            const { error: authError } = await adminSupabase.auth.admin.deleteUser(userId)
            if (authError) {
                console.warn("[Admin User Deletion] Could not delete from Auth, but public data is gone:", authError)
            }
        } else {
            console.warn("[Admin User Deletion] SUPABASE_SERVICE_ROLE_KEY missing. User removed from list but technically exists in Auth.")
        }

        return { success: true }
    } catch (error: any) {
        console.error("[Admin User Deletion] Error:", error)
        return { error: `Error al eliminar: ${error.message}` }
    }
}
