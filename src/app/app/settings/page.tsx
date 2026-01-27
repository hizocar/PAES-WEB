"use client"

import { useState, useEffect, useRef } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
// @ts-ignore
import { Input } from "@/components/ui/input"
// @ts-ignore
import { Label } from "@/components/ui/label"
import { Loader2, Save, Upload, Camera } from "lucide-react"
import {
    Avatar,
    AvatarFallback,
    AvatarImage,
} from "@/components/ui/avatar"

export default function SettingsPage() {
    const [user, setUser] = useState<any>(null)
    const [loading, setLoading] = useState(true)
    const [saving, setSaving] = useState(false)
    const [uploading, setUploading] = useState(false)
    const [fullName, setFullName] = useState("")
    const [message, setMessage] = useState<{ text: string, type: 'success' | 'error' } | null>(null)

    const fileInputRef = useRef<HTMLInputElement>(null)
    const supabase = createClient()

    useEffect(() => {
        const getUser = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (user) {
                setUser(user)
                // Fetch profile data
                const { data: profile } = await supabase
                    .from('profiles')
                    .select('*')
                    .eq('id', user.id)
                    .single()

                if (profile) {
                    setFullName(profile.full_name || "")
                    // Merge profile data into user object for display if needed
                    setUser({ ...user, profile })
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

            // 1. Upload to Supabase Storage
            const { error: uploadError } = await supabase.storage
                .from('avatars')
                .upload(filePath, file)

            if (uploadError) throw uploadError

            // 2. Get Public URL
            const { data: { publicUrl } } = supabase.storage
                .from('avatars')
                .getPublicUrl(filePath)

            // 3. Update Profile Table
            const { error: updateError } = await supabase
                .from('profiles')
                .update({ avatar_url: publicUrl })
                .eq('id', user.id)

            if (updateError) throw updateError

            // Optional: Update auth metadata too for backup
            await supabase.auth.updateUser({
                data: { avatar_url: publicUrl }
            })

            setMessage({ text: "Foto de perfil actualizada", type: 'success' })

            // Update local state
            setUser({
                ...user,
                profile: { ...user.profile, avatar_url: publicUrl }
            })

            // Refresh
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
            // Update Profile Table
            const { error } = await supabase
                .from('profiles')
                .update({ full_name: fullName })
                .eq('id', user.id)

            if (error) throw error

            // Optional: Update auth metadata
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

    if (loading) {
        return (
            <div className="flex h-[50vh] items-center justify-center">
                <Loader2 className="animate-spin text-slate-400" size={32} />
            </div>
        )
    }

    return (
        <div className="max-w-4xl mx-auto py-12 px-6">
            <div className="mb-10">
                <h1 className="text-3xl font-bold text-slate-900 tracking-tight">Configuración</h1>
                <p className="text-slate-500 mt-2">Gestiona tu información personal y preferencias.</p>
            </div>

            <div className="grid gap-8 md:grid-cols-[300px_1fr]">
                {/* Profile Card */}
                <div className="space-y-6">
                    <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 text-center">
                        <div className="relative inline-block group cursor-pointer" onClick={handleAvatarClick}>
                            <div className="scale-150 mb-4 transition-opacity group-hover:opacity-75">
                                <Avatar className="w-16 h-16 border border-slate-200">
                                    <AvatarImage
                                        src={user?.profile?.avatar_url || user?.user_metadata?.avatar_url}
                                        alt={fullName || "User"}
                                    />
                                    <AvatarFallback className="bg-slate-100 text-slate-600 font-bold">
                                        {(fullName || user?.email || "?")
                                            .split(" ").map((n: any) => n[0]).join("").substring(0, 2).toUpperCase()}
                                    </AvatarFallback>
                                </Avatar>
                            </div>
                            <div className="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                                <div className="bg-black/50 text-white p-1 rounded-full">
                                    <Camera size={16} />
                                </div>
                            </div>
                        </div>

                        <input
                            type="file"
                            ref={fileInputRef}
                            className="hidden"
                            accept="image/*"
                            onChange={handleFileChange}
                        />

                        <h3 className="font-bold text-slate-900">{fullName || user?.email}</h3>
                        <p className="text-xs text-slate-500 truncate mt-1">{user?.email}</p>

                        <div className="mt-4">
                            <Button
                                variant="outline"
                                size="sm"
                                className="w-full"
                                disabled={uploading}
                                onClick={handleAvatarClick}
                            >
                                {uploading ? <Loader2 className="animate-spin mr-2 h-3 w-3" /> : <Upload className="mr-2 h-3 w-3" />}
                                Cambiar Foto
                            </Button>
                        </div>
                    </div>
                </div>

                {/* Form */}
                <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-100 h-fit">
                    <h2 className="text-xl font-bold text-slate-900 mb-6">Información Básica</h2>

                    <form onSubmit={handleUpdate} className="space-y-6">
                        <div className="grid gap-2">
                            <Label htmlFor="fullName" className="text-slate-900 font-semibold">Alias</Label>
                            <Input
                                id="fullName"
                                value={fullName}
                                onChange={(e: any) => setFullName(e.target.value)}
                                className="max-w-md text-slate-900 font-medium"
                            />
                            <p className="text-xs text-slate-500">Este es el alias que se mostrará en tu perfil y ranking.</p>
                        </div>

                        <div className="grid gap-2">
                            <Label htmlFor="email" className="text-slate-900 font-semibold">Email</Label>
                            <Input
                                id="email"
                                value={user?.email}
                                disabled
                                className="bg-slate-50 max-w-md text-slate-900 font-medium disabled:opacity-100"
                            />
                        </div>

                        {message && (
                            <div className={`p-4 rounded-lg text-sm font-medium ${message.type === 'success' ? 'bg-green-50 text-green-700 border border-green-200' : 'bg-red-50 text-red-700 border border-red-200'}`}>
                                {message.text}
                            </div>
                        )}

                        <div className="pt-4 border-t border-slate-100">
                            <Button type="submit" disabled={saving}>
                                {saving ? (
                                    <>
                                        <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                                        Guardando...
                                    </>
                                ) : (
                                    "Guardar Cambios"
                                )}
                            </Button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    )
}
