import { createClient } from "@/lib/supabase/server"
import { MercadoPagoConfig, PreApproval, Payment } from "mercadopago"
import { NextResponse } from "next/server"

const accessToken = process.env.MERCADOPAGO_ACCESS_TOKEN

export async function POST(req: Request) {
    const { searchParams } = new URL(req.url)
    const topic = searchParams.get("topic") || searchParams.get("type")
    const id = searchParams.get("id") || searchParams.get("data.id")

    // Alternative: body notification
    let body: any = {}
    try {
        body = await req.json()
    } catch (e) {
        // body might be empty
    }

    const type = body.type || topic
    const dataId = body.data?.id || id

    console.log(`[MercadoPago Webhook] Type: ${type}, ID: ${dataId}`)

    if (!accessToken) {
        return NextResponse.json({ error: "Access token not configured" }, { status: 500 })
    }

    const client = new MercadoPagoConfig({ accessToken })
    const supabase = await createClient()

    try {
        if (type === "subscription_preapproval" || type === "preapproval") {
            const preApproval = new PreApproval(client)
            const subscription = await preApproval.get({ id: dataId })

            if (subscription.status === "authorized") {
                const externalReference = JSON.parse(subscription.external_reference || "{}")
                const { userId, tier } = externalReference

                if (userId && tier) {
                    await supabase
                        .from("profiles")
                        .update({ subscription_tier: tier.toLowerCase() })
                        .eq("id", userId)

                    await supabase
                        .from("subscriptions")
                        .upsert({
                            user_id: userId,
                            status: "active",
                            mp_preapproval_id: subscription.id,
                            next_payment_at: (subscription.auto_recurring as any)?.next_payment_date,
                        })
                }
            } else if (subscription.status === "cancelled" || subscription.status === "cancelled") {
                const externalReference = JSON.parse(subscription.external_reference || "{}")
                const { userId } = externalReference

                if (userId) {
                    await supabase
                        .from("profiles")
                        .update({ subscription_tier: "free" })
                        .eq("id", userId)

                    await supabase
                        .from("subscriptions")
                        .update({ status: "canceled", canceled_at: new Date().toISOString() })
                        .eq("user_id", userId)
                }
            }
        }

        if (type === "payment") {
            const payment = new Payment(client)
            const paymentData = await payment.get({ id: dataId })

            if (paymentData.status === "approved") {
                // If it's a recurring payment, it usually carries external_reference or metadata
                const externalReference = JSON.parse(paymentData.external_reference || "{}")
                const { userId, tier } = externalReference

                if (userId && tier) {
                    await supabase
                        .from("profiles")
                        .update({ subscription_tier: tier.toLowerCase() })
                        .eq("id", userId)
                }
            }
        }

        return NextResponse.json({ received: true })
    } catch (error) {
        console.error("[MercadoPago Webhook Error]", error)
        return NextResponse.json({ error: "Webhook processing failed" }, { status: 500 })
    }
}
