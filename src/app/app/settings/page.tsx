"use client"

import { useState, useEffect, useRef } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Loader2, Save, Upload, Camera, CreditCard, Calendar, CheckCircle2 } from "lucide-react"
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"
import { SubscriptionBadge } from "@/components/subscription-badge"

export default function SettingsPage() {
    const [user, setUser] = useState<any>(null)
    const [loading, setLoading] = useState(true)
    const [saving, setSaving] = useState(false)
    const [uploading, setUploading] = useState(false)
    const [fullName, setFullName] = useState("")
    const [subscription, setSubscription] = useState<any>(null)
    const [message, setMessage] = useState<{ text: string, type: 'success' | 'error' } | null>(null)

    const fileInputRef = useRef<HTMLInputElement>(null)
    const supabase = createClient()

    useEffect(() => {
        const getUser = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (user) {
                setUser(user)

                // Fetch profile and subscription data
                const { data: profile } = await supabase
                    .from('profiles')
                    .select('*')
                    .eq('id', user.id)
                    .single()

                if (profile) {
                    setFullName(profile.full_name || "")
                    setUser({ ...user, profile })

                    // Get detailed subscription info if exists
                    const { data: subData } = await supabase
                        .from('subscriptions')
                        .select('*')
                        .eq('user_id', user.id)
                        .single()

                    if (subData) {
                        setSubscription(subData)
                    }
                } else {
                    setFullName(user.user_metadata?.full_name || "")
                }
            }
            setLoading(false)
        }
        getUser()
    }, [])

    const handleAvatarClick = () => {
        fileInputRef.current?.click()
    }

    const handleFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
        if (!e.target.files || e.target.files.length === 0) return

        const file = e.target.files[0]
        setUploading(true)
        setMessage(null)

        try {
            const fileExt = file.name.split('.').pop()
            const filePath = `${user.id}/${Math.random()}.${fileExt}`

            const { error: uploadError } = await supabase.storage
                .from('avatars')
                .upload(filePath, file)

            if (uploadError) throw uploadError

            const { data: { publicUrl } } = supabase.storage
                .from('avatars')
                .getPublicUrl(filePath)

            const { error: updateError } = await supabase
                .from('profiles')
                .update({ avatar_url: publicUrl })
                .eq('id', user.id)

            if (updateError) throw updateError

            await supabase.auth.updateUser({
                data: { avatar_url: publicUrl }
            })

            setMessage({ text: "Foto de perfil actualizada", type: 'success' })
            setUser((curr: any) => ({
                ...curr,
                profile: { ...curr.profile, avatar_url: publicUrl }
            }))

            setTimeout(() => {
                window.location.reload()
            }, 1000)

        } catch (error: any) {
            setMessage({ text: "Error al subir imagen: " + error.message, type: 'error' })
        } finally {
            setUploading(false)
        }
    }

    const handleUpdate = async (e: React.FormEvent) => {
        e.preventDefault()
        setSaving(true)
        setMessage(null)

        try {
            const { count } = await supabase
                .from('profiles')
                .select('*', { count: 'exact', head: true })
                .ilike('full_name', fullName)
                .neq('id', user.id)

            if (count && count > 0) {
                throw new Error("Este Alias ya está en uso. Por favor elige otro.")
            }

            const { error } = await supabase
                .from('profiles')
                .update({ full_name: fullName })
                .eq('id', user.id)

            if (error) throw error

            await supabase.auth.updateUser({
                data: { full_name: fullName }
            })

            setMessage({ text: "Perfil actualizado correctamente", type: 'success' })
            setTimeout(() => {
                window.location.reload()
            }, 1000)

        } catch (error: any) {
            setMessage({ text: error.message, type: 'error' })
        } finally {
            setSaving(false)
        }
    }

    const formatDate = (dateString: string) => {
        if (!dateString) return null
        return new Date(dateString).toLocaleDateString('es-CL', {
            day: 'numeric',
            month: 'long',
            year: 'numeric'
        })
    }

    if (loading) {
        return (
            <div className="flex h-[50vh] items-center justify-center">
                <Loader2 className="animate-spin text-slate-400" size={32} />
            </div>
        )
    }

    const tier = user?.profile?.subscription_tier || 'free'
    const isSubscriber = tier !== 'free'

    return (
        <div className="max-w-4xl mx-auto py-12 px-6">
            <div className="mb-10 text-center md:text-left">
                <h1 className="text-3xl font-bold text-slate-900 tracking-tight">Configuración</h1>
                <p className="text-slate-500 mt-2">Gestiona tu información personal y suscripción.</p>
            </div>

            <div className="grid gap-8 md:grid-cols-[280px_1fr]">
                {/* Profile Card & Bio */}
                <div className="space-y-6">
                    <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 text-center">
                        <div className="relative inline-block group cursor-pointer" onClick={handleAvatarClick}>
                            <div className="mb-4 transition-transform duration-200 group-hover:scale-105">
                                <Avatar className="w-24 h-24 border-2 border-slate-100">
                                    <AvatarImage
                                        src={user?.profile?.avatar_url || user?.user_metadata?.avatar_url}
                                        alt={fullName || "User"}
                                    />
                                    <AvatarFallback className="bg-slate-50 text-slate-400 text-2xl font-bold">
                                        {(fullName || user?.email || "?")
                                            .split(" ").map((n: any) => n[0]).join("").substring(0, 2).toUpperCase()}
                                    </AvatarFallback>
                                </Avatar>
                            </div>
                            <div className="absolute top-0 right-0 bg-blue-600 text-white p-1.5 rounded-full shadow-lg opacity-0 group-hover:opacity-100 transition-opacity">
                                <Camera size={14} />
                            </div>
                        </div>

                        <input
                            type="file"
                            ref={fileInputRef}
                            className="hidden"
                            accept="image/*"
                            onChange={handleFileChange}
                        />

                        <h3 className="font-bold text-slate-900 text-lg leading-tight">{fullName || 'Sin Nombre'}</h3>
                        <p className="text-sm text-slate-500 truncate mb-4">{user?.email}</p>

                        <div className="pt-4 border-t border-slate-50 flex flex-col gap-2">
                            <SubscriptionBadge tier={tier} className="mx-auto scale-125 my-2" />
                        </div>
                    </div>

                    {/* Subscription Status Card */}
                    <div className="bg-slate-900 text-white p-6 rounded-2xl shadow-lg overflow-hidden relative">
                        <div className="absolute top-0 right-0 p-4 opacity-10">
                            <CreditCard size={80} />
                        </div>
                        <h4 className="text-xs font-bold uppercase tracking-widest text-slate-400 mb-4">Suscripción</h4>

                        <div className="space-y-4 relative z-10">
                            <div>
                                <p className="text-xs text-slate-400">Plan actual</p>
                                <p className="font-bold flex items-center gap-2">
                                    {tier.charAt(0).toUpperCase() + tier.slice(1)}
                                    {isSubscriber && <CheckCircle2 size={14} className="text-green-400" />}
                                </p>
                            </div>

                            {isSubscriber && (
                                <div>
                                    <p className="text-xs text-slate-400">Próximo cobro</p>
                                    <p className="font-medium text-sm flex items-center gap-2">
                                        <Calendar size={14} />
                                        {formatDate(subscription?.next_payment_at || subscription?.current_period_end) || 'Pendiente de sincronización'}
                                    </p>
                                </div>
                            )}

                            {!isSubscriber && (
                                <Button variant="secondary" size="sm" className="w-full font-bold bg-white text-slate-900 hover:bg-slate-100 mt-2" onClick={() => window.location.href = '/pricing'}>
                                    Mejorar Plan
                                </Button>
                            )}
                        </div>
                    </div>
                </div>

                {/* Form Section */}
                <div className="space-y-6">
                    <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-100 h-fit">
                        <h2 className="text-xl font-bold text-slate-900 mb-6 flex items-center gap-2">
                            Información Básica
                        </h2>

                        <form onSubmit={handleUpdate} className="grid sm:grid-cols-2 gap-6">
                            <div className="grid gap-2">
                                <Label htmlFor="fullName" className="text-slate-700 text-sm">Alias en la plataforma</Label>
                                <Input
                                    id="fullName"
                                    value={fullName}
                                    placeholder="Ej: Profe Pablo"
                                    onChange={(e: any) => setFullName(e.target.value)}
                                    className="border-slate-200 focus:ring-blue-500"
                                />
                                <p className="text-[10px] text-slate-400">Usado en ranking y perfil.</p>
                            </div>

                            <div className="grid gap-2">
                                <Label htmlFor="email" className="text-slate-700 text-sm">Correo Eléctronico</Label>
                                <Input
                                    id="email"
                                    value={user?.email}
                                    disabled
                                    className="bg-slate-50 text-slate-500 border-slate-100 cursor-not-allowed"
                                />
                            </div>

                            <div className="sm:col-span-2 pt-2">
                                {message && (
                                    <div className={`p-4 rounded-xl text-sm mb-4 animate-in fade-in slide-in-from-top-1 ${message.type === 'success' ? 'bg-green-50 text-green-700 border border-green-100' : 'bg-red-50 text-red-700 border border-red-100'}`}>
                                        {message.text}
                                    </div>
                                )}

                                <Button type="submit" disabled={saving || fullName === user?.profile?.full_name} className="shadow-md">
                                    {saving ? (
                                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                    ) : (
                                        <Save className="mr-2 h-4 w-4" />
                                    )}
                                    Guardar Cambios
                                </Button>
                            </div>
                        </form>
                    </div>

                    {/* Subscription Detail Info (Longer display) */}
                    {isSubscriber && (
                        <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-100">
                            <h2 className="text-xl font-bold text-slate-900 mb-2">Detalles de Facturación</h2>
                            <p className="text-sm text-slate-500 mb-6">Información sobre tu membresía activa gestionada por Mercado Pago.</p>

                            <div className="bg-slate-50 rounded-xl p-6 border border-slate-100 space-y-4">
                                <div className="flex justify-between items-center py-2 border-b border-slate-200">
                                    <span className="text-slate-600 text-sm">Método de pago</span>
                                    <span className="font-bold text-sm flex items-center gap-2">
                                        <CreditCard size={14} className="text-blue-500" /> Tarjeta activa
                                    </span>
                                </div>
                                <div className="flex justify-between items-center py-2 border-b border-slate-200">
                                    <span className="text-slate-600 text-sm">Frecuencia</span>
                                    <span className="font-bold text-sm">Mensual</span>
                                </div>
                                <div className="flex justify-between items-center py-2">
                                    <span className="text-slate-600 text-sm">Próxima facturación</span>
                                    <span className="font-bold text-sm text-blue-600">
                                        {formatDate(subscription?.next_payment_at || subscription?.current_period_end) || 'Sin fecha programada'}
                                    </span>
                                </div>
                            </div>

                            <p className="mt-6 text-xs text-slate-400 leading-relaxed">
                                Tu suscripción se renovará automáticamente. Puedes gestionar tus preferencias de pago directamente desde el correo de confirmación enviado por Mercado Pago o contactando a nuestro soporte.
                            </p>
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
