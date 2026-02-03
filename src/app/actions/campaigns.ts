"use server"

import { resend } from "@/lib/resend"
import { StartPracticeTemplate } from "@/components/emails/StartPracticeTemplate"
import { ReminderTemplate } from "@/components/emails/ReminderTemplate"
import { NewFeaturesTemplate } from "@/components/emails/NewFeaturesTemplate"

export type TemplateId = 'start-practice' | 'reminder' | 'new-features'

export async function sendCampaignEmail(
    email: string,
    userName: string,
    templateId: TemplateId,
    customSubject?: string,
    customMessage?: string
) {
    try {
        console.log(` Attempting to send email [${templateId}] to ${email}...`)

        if (!process.env.RESEND_API_KEY) {
            console.error("❌ RESEND_API_KEY is missing in env variables.")
            return { error: "Falta configurar la RESEND_API_KEY en el servidor." }
        }

        // Security Hardening: Check Admin Permission
        const supabase = await import("@/lib/supabase/server").then(m => m.createClient())
        const { data: { user } } = await supabase.auth.getUser()

        if (!user) return { error: "No autorizado" }

        const { data: profile } = await supabase
            .from('profiles')
            .select('role')
            .eq('id', user.id)
            .single()

        if (profile?.role !== 'admin') {
            console.warn(`🚨 Unauthorized email attempt by user ${user.id}`)
            return { error: "No tienes permisos para realizar esta acción." }
        }

        // Dummy check just for the walkthrough warning, you can remove this if you have a real key format check
        if (process.env.RESEND_API_KEY.startsWith('re_123')) {
            console.warn("⚠️ Using Dummy RESEND_API_KEY. Email will likely fail or be mocked.")
        }

        let subject = customSubject || ""
        let reactElement: React.ReactElement | null = null
        const actionUrl = `${process.env.NEXT_PUBLIC_SITE_URL}/login`

        switch (templateId) {
            case 'start-practice':
                if (!subject) subject = 'Tu puntaje nacional te está esperando 🚀'
                reactElement = StartPracticeTemplate({ userName, actionUrl, customMessage }) as any
                break
            case 'reminder':
                if (!subject) subject = '🔥 No pierdas tu racha en PAES Lab'
                reactElement = ReminderTemplate({ userName, actionUrl, customMessage }) as any
                break
            case 'new-features':
                if (!subject) subject = '✨ Descubre lo nuevo en PAES Lab'
                reactElement = NewFeaturesTemplate({ userName, actionUrl, customMessage }) as any
                break
            default:
                return { error: "Plantilla no válida" }
        }

        const data = await resend.emails.send({
            from: 'PAES Lab <hola@paeslab.cl>',
            to: [email],
            subject: subject,
            react: reactElement,
        })

        if (data.error) {
            console.error("❌ Resend API Error:", data.error)
            // Return more specific info
            return { error: `Error API Resend: ${data.error.message} (${data.error.name})` }
        }

        console.log("✅ Email sent successfully:", data.data?.id)
        return { success: true, id: data.data?.id }

    } catch (error: any) {
        console.error("❌ Server Action Critical Error:", error)
        return { error: `Error Interno: ${error.message || JSON.stringify(error)}` }
    }
}
