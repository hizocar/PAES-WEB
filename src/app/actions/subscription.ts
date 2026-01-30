"use server"

import { createClient } from "@/lib/supabase/server"
import { MercadoPagoConfig, PreApproval } from "mercadopago"

const accessToken = process.env.MERCADOPAGO_ACCESS_TOKEN

export async function createSubscriptionPreference(planId: string) {
    const supabase = await createClient()

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

    // 4. Create Mercado Pago PreApproval (Subscription)
    if (!accessToken) {
        console.warn("MERCADOPAGO_ACCESS_TOKEN not set, using mock redirect")
        const mockExternalReference = JSON.stringify({
            userId: session.user.id,
            planId: plan.id,
            tier: plan.tier
        })
        return { url: `/app/pricing/success?status=approved&external_reference=${encodeURIComponent(mockExternalReference)}` }
    }

    if (!accessToken) {
        console.error("MERCADOPAGO_ACCESS_TOKEN is missing in environment variables")
        return { error: "El sistema de pagos no está configurado (Falta Token)." }
    }

    try {
        const client = new MercadoPagoConfig({ accessToken })
        const preApproval = new PreApproval(client)

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
                back_url: `${process.env.NEXT_PUBLIC_SITE_URL || 'https://paeslab.cl'}/app/pricing/success`,
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

export async function updateUserSubscription(paymentId: string, status: string, externalReference: string) {
    const isApproved = status === "approved" || status === "authorized"

    if (!isApproved) {
        return { error: `La suscripción no está activa (Estado: ${status})` }
    }

    const supabase = await createClient()

    try {
        let userId, tier

        if (externalReference) {
            const data = JSON.parse(externalReference)
            userId = data.userId
            tier = data.tier
        }

        // 1. If we don't have metadata yet, try to find by preapproval_id in the subscriptions table
        // (This might happen if the webhook arrived first)
        if (!userId && paymentId && paymentId !== 'n/a') {
            const { data: sub } = await supabase
                .from("subscriptions")
                .select("user_id, plan_id")
                .eq("mp_preapproval_id", paymentId)
                .single()

            if (sub) {
                userId = sub.user_id
                // We'd need to fetch the tier from plans if we only have plan_id
                const { data: plan } = await supabase.from("plans").select("tier").eq("id", sub.plan_id).single()
                tier = plan?.tier
            }
        }

        if (!userId) {
            // Still loading? Maybe wait for webhook? 
            // For now, let's assume we need metadata to proceed
            return { error: "No se pudieron verificar los datos de usuario" }
        }

        // Update profile
        const { error: updateError } = await supabase
            .from("profiles")
            .update({ subscription_tier: tier })
            .eq("id", userId)

        if (updateError) throw updateError

        return { success: true, tier }
    } catch (error) {
        console.error("Error updating subscription:", error)
        return { error: "Error al actualizar la suscripción" }
    }
}
