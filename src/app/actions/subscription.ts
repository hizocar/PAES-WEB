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
        let userId, tier, finalStatus = status

        // 1. Fetch real status from MP if we have a token and ID (most reliable)
        if (accessToken && paymentId && paymentId !== 'n/a') {
            try {
                const client = new MercadoPagoConfig({ accessToken })
                const preApproval = new PreApproval(client)
                const subData = await preApproval.get({ id: paymentId })

                finalStatus = subData.status
                console.log(`[Subscription Update] Verified Status: ${finalStatus}`)

                // Recover metadata if missing
                const mpRef = JSON.parse(subData.external_reference || "{}")
                userId = userId || mpRef.userId
                tier = tier || mpRef.tier
            } catch (mpError) {
                console.error("[Subscription Update] MP check failed (using fallback):", mpError)
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

        // 3. Update profile
        console.log(`[Subscription Update] Activating ${tier} for ${userId}`)
        const { error: updateError } = await supabase
            .from("profiles")
            .update({ subscription_tier: tier.toLowerCase() })
            .eq("id", userId)

        if (updateError) throw updateError

        // Ensure subscription record exists
        await supabase
            .from("subscriptions")
            .upsert({
                user_id: userId,
                status: "active",
                mp_preapproval_id: paymentId !== 'n/a' ? paymentId : null,
            })

        return { success: true, tier: tier.charAt(0).toUpperCase() + tier.slice(1) }
    } catch (error: any) {
        console.error("[Subscription Update] Critical Error:", error)
        return { error: `Error: ${error.message || "desconocido"}` }
    }
}
