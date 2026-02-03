"use server"

import { resend } from "@/lib/resend"
import { StartPracticeTemplate } from "@/components/emails/StartPracticeTemplate"

export async function sendStartPracticeEmail(email: string, userName: string) {
    try {
        if (!process.env.RESEND_API_KEY || process.env.RESEND_API_KEY.startsWith('re_123')) {
            return { error: "Falta configurar la RESEND_API_KEY en el servidor." }
        }

        const data = await resend.emails.send({
            from: 'PAES Lab <hola@paeslab.cl>',
            to: [email],
            subject: 'Tu puntaje nacional te está esperando 🚀',
            react: StartPracticeTemplate({
                userName: userName,
                actionUrl: `${process.env.NEXT_PUBLIC_SITE_URL}/login`
            }) as any,
        })

        if (data.error) {
            console.error("Resend Error:", data.error)
            return { error: "Error al enviar el correo: " + data.error.message }
        }

        return { success: true, id: data.data?.id }

    } catch (error) {
        console.error("Server Action Error:", error)
        return { error: "Error interno al procesar el envío." }
    }
}
