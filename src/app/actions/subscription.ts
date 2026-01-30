"use server"

import { createClient } from "@/lib/supabase/server"
import { MercadoPagoConfig, Preference } from "mercadopago"
import { redirect } from "next/navigation"

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

    if (profile?.subscription_tier === plan.tier) {
        return { error: "Ya tienes este plan activo" }
    }

    // 4. Create Mercado Pago preference
    if (!accessToken) {
        console.warn("MERCADOPAGO_ACCESS_TOKEN not set, using mock redirect")
        // Mock success redirect for testing if no token provided
        const mockExternalReference = JSON.stringify({
            userId: session.user.id,
            planId: plan.id,
            tier: plan.tier
        })
        return { url: `/app/pricing/success?payment_id=mock_123&status=approved&external_reference=${encodeURIComponent(mockExternalReference)}` }
    }

    try {
        const client = new MercadoPagoConfig({ accessToken })
        const preference = new Preference(client)

        const result = await preference.create({
            body: {
                items: [
                    {
                        id: plan.id,
                        title: `Suscripción PAES Lab - ${plan.name}`,
                        unit_price: plan.price_clp,
                        quantity: 1,
                        currency_id: "CLP"
                    }
                ],
                back_urls: {
                    success: `${process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'}/app/pricing/success`,
                    failure: `${process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'}/app/pricing/failure`,
                    pending: `${process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'}/app/pricing/pending`,
                },
                auto_return: "approved",
                external_reference: JSON.stringify({
                    userId: session.user.id,
                    planId: plan.id,
                    tier: plan.tier
                }),
                metadata: {
                    user_id: session.user.id,
                    plan_id: plan.id,
                    tier: plan.tier
                }
            }
        })

        if (!result.init_point) {
            throw new Error("No se pudo generar el punto de inicio de pago")
        }

        return { url: result.init_point }
    } catch (error) {
        console.error("Error creating MP preference:", error)
        return { error: "Error al procesar el pago. Por favor intente más tarde." }
    }
}

export async function updateUserSubscription(paymentId: string, status: string, externalReference: string) {
    if (status !== "approved") {
        return { error: "El pago no ha sido aprobado" }
    }

    const supabase = await createClient()

    try {
        const data = JSON.parse(externalReference)
        const { userId, planId, tier } = data

        // Update profile
        const { error: updateError } = await supabase
            .from("profiles")
            .update({ subscription_tier: tier })
            .eq("id", userId)

        if (updateError) throw updateError

        // Log subscription (if we had a history table, we'd add it here)

        return { success: true, tier }
    } catch (error) {
        console.error("Error updating subscription:", error)
        return { error: "Error al actualizar la suscripción" }
    }
}
