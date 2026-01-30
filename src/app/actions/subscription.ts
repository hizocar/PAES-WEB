"use server"

import { createClient } from "@/lib/supabase/server"
import { MercadoPagoConfig, PreApproval } from "mercadopago"

export async function createSubscriptionPreference(planId: string) {
    const accessToken = process.env.MERCADOPAGO_ACCESS_TOKEN
    const supabase = await createClient()

    console.log(`[Subscription Action] Attempting to create preference for plan: ${planId}`)

    if (!accessToken) {
        console.error("[Subscription Action] MERCADOPAGO_ACCESS_TOKEN is missing")
        return { error: "Error de configuración: No se encontró el Token de Mercado Pago." }
    }

    // 1. Get user session
    const { data: { session } } = await supabase.auth.getSession()
    if (!session) {
        return { error: "Debes iniciar sesión para suscribirte" }
    }

    // 2. Get plan details from DB
    const { data: plan, error: planError } = await supabase
        .from("plans")
        .select("*")
        .eq("id", planId)
        .single()

    if (planError || !plan) {
        return { error: "Plan no encontrado" }
    }

    // 3. Check if user already has this plan (except free)
    const { data: profile } = await supabase
        .from("profiles")
        .select("subscription_tier")
        .eq("id", session.user.id)
        .single()

    if (profile?.subscription_tier === plan.tier && plan.tier !== 'free') {
        return { error: "Ya tienes este plan activo" }
    }

    try {
        const client = new MercadoPagoConfig({ accessToken })
        const preApproval = new PreApproval(client)
        const siteUrl = process.env.NEXT_PUBLIC_SITE_URL || 'https://www.paeslab.cl'

        const result = await preApproval.create({
            body: {
                reason: `Suscripción PAES Lab - ${plan.name}`,
                payer_email: session.user.email,
                auto_recurring: {
                    frequency: 1,
                    frequency_type: "months",
                    transaction_amount: plan.price_clp,
                    currency_id: "CLP"
                },
                back_url: `${siteUrl}/app/pricing/success`,
                external_reference: JSON.stringify({
                    userId: session.user.id,
                    planId: plan.id,
                    tier: plan.tier
                })
            }
        })

        if (!result.init_point) {
            throw new Error("No se pudo generar el link de suscripción")
        }

        return { url: result.init_point }
    } catch (error: any) {
        console.error("Error creating MP PreApproval:", error)
        return { error: `Error de Mercado Pago: ${error.message || "Error desconocido"}` }
    }
}

export async function updateUserSubscription(paymentId: string, status: string | null, externalReference: string) {
    const accessToken = process.env.MERCADOPAGO_ACCESS_TOKEN
    const supabase = await createClient()

    console.log(`[Subscription Update] Processing ID: ${paymentId}, Status: ${status}`)

    try {
        let userId, tier, finalStatus: string | null = status
        let nextPaymentAt: string | null = null

        // 1. Fetch real status from MP if we have a token and ID (most reliable)
        if (accessToken && paymentId && paymentId !== 'n/a') {
            try {
                const client = new MercadoPagoConfig({ accessToken })
                const preApproval = new PreApproval(client)
                const subData = await preApproval.get({ id: paymentId })

                finalStatus = subData.status || status
                console.log(`[Subscription Update] Verified Status: ${finalStatus}`)

                // Capture next payment date
                nextPaymentAt = (subData.auto_recurring as any)?.next_payment_date

                // Recover metadata if missing
                if (!userId || !tier) {
                    const mpRef = JSON.parse(subData.external_reference || "{}")
                    userId = userId || mpRef.userId
                    tier = tier || mpRef.tier
                }
            } catch (mpError) {
                console.error("[Subscription Update] MP check failed:", mpError)
            }
        }

        // 2. Fallback: Parse external metadata if present
        if (externalReference && (!userId || !tier)) {
            try {
                const data = JSON.parse(externalReference)
                userId = userId || data.userId
                tier = tier || data.tier
            } catch (e) {
                console.error("[Subscription Update] Metadata parse fail:", e)
            }
        }

        const isApproved = finalStatus === "authorized" || finalStatus === "approved"
        if (!isApproved) {
            return { error: `La suscripción no está activa (Estado: ${finalStatus || 'desconocido'})` }
        }

        if (!userId || !tier) {
            return { error: "No se pudieron verificar los datos de usuario para la suscripción." }
        }

        // 3. Update database
        console.log(`[Subscription Update] Activating ${tier} for ${userId}`)
        const { error: updateError } = await supabase
            .from("profiles")
            .update({ subscription_tier: tier.toLowerCase() })
            .eq("id", userId)

        if (updateError) throw updateError

        // Ensure subscription record exists with the next payment date
        const { error: subError } = await supabase
            .from("subscriptions")
            .upsert({
                user_id: userId,
                status: "active",
                mp_preapproval_id: paymentId !== 'n/a' ? paymentId : null,
                next_payment_at: nextPaymentAt
            }, { onConflict: 'user_id' })

        if (subError) console.error("[Subscription Update] Error saving sub record:", subError)

        return { success: true, tier: tier.charAt(0).toUpperCase() + tier.slice(1) }
    } catch (error: any) {
        console.error("[Subscription Update] Critical Error:", error)
        return { error: `Error: ${error.message || "desconocido"}` }
    }
}

export async function adminUpdateUserTier(userId: string, tier: string) {
    const supabase = await createClient()

    // 1. Verify if user is admin (security)
    const { data: { session } } = await supabase.auth.getSession()
    if (!session) return { error: "No autorizado" }

    const { data: adminProfile } = await supabase
        .from("profiles")
        .select("role")
        .eq("id", session.user.id)
        .single()

    if (adminProfile?.role !== 'admin') {
        return { error: "No tienes permisos de administrador" }
    }

    try {
        const { error } = await supabase.rpc('admin_update_user_tier', {
            p_user_id: userId,
            p_tier: tier.toLowerCase()
        })

        if (error) throw error

        return { success: true }
    } catch (error: any) {
        console.error("[Admin Subscription Update] Error:", error)
        return { error: `Error al actualizar: ${error.message}` }
    }
}

export async function cancelSubscription() {
    const accessToken = process.env.MERCADOPAGO_ACCESS_TOKEN
    const supabase = await createClient()

    // 1. Get user session
    const { data: { session } } = await supabase.auth.getSession()
    if (!session) {
        return { error: "Debes iniciar sesión" }
    }

    try {
        // 2. Find active subscription ID
        const { data: subData } = await supabase
            .from('subscriptions')
            .select('mp_preapproval_id')
            .eq('user_id', session.user.id)
            .single()

        // 3. Cancel in Mercado Pago if ID exists
        if (accessToken && subData?.mp_preapproval_id) {
            try {
                const client = new MercadoPagoConfig({ accessToken })
                const preApproval = new PreApproval(client)
                await preApproval.update({
                    id: subData.mp_preapproval_id,
                    body: { status: 'cancelled' }
                })
                console.log(`[Subscription] Cancelled MP PreApproval: ${subData.mp_preapproval_id}`)
            } catch (mpError: any) {
                console.warn("[Subscription] MP Cancel Error (might already be cancelled):", mpError.message)
            }
        }

        // 4. Update Database (Only the subscription record)
        console.log(`[Subscription] User ${session.user.id} cancelled. Keeping benefits until expiry.`)

        // We DO NOT update public.profiles here. 
        // The user will remain premium until their next_payment_at date.
        // We can use a background worker or a check on login to perform the final downgrade later.

        const { error: subError } = await supabase
            .from('subscriptions')
            .update({
                status: 'canceled',
                canceled_at: new Date().toISOString()
            })
            .eq('user_id', session.user.id)

        if (subError) throw subError

        return { success: true }
    } catch (error: any) {
        console.error("[Subscription] Error canceling:", error)
        return { error: `Error al cancelar: ${error.message || "Error desconocido"}` }
    }
}
