"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { BarChart3, ChevronRight, LineChart as LineChartIcon, RotateCcw, Search, Trash2, X, Clock, PieChart as PieChartIcon, Send } from "lucide-react"
import { adminUpdateUserTier } from "@/app/actions/subscription"
import { adminDeleteUser } from "@/app/actions/admin"
import { SubscriptionBadge } from "@/components/subscription-badge"
import { cn } from "@/lib/utils"
import { BarChart, Bar, XAxis, Tooltip, ResponsiveContainer, Cell, LineChart, Line } from "recharts"
import { sendCampaignEmail } from "@/app/actions/campaigns"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"

type UserStat = {
    user_id: string
    email: string
    full_name: string
    avatar_url: string
    created_at: string
    last_sign_in_at: string
    total_attempts: number
    correct_attempts: number
    last_activity: string
    lives: number
    replenish_at: string | null
    explanation_credits: number
    subscription_tier: string
}


export default function AdminUsersPage() {
    const [users, setUsers] = useState<UserStat[]>([])
    const [filteredUsers, setFilteredUsers] = useState<UserStat[]>([])
    const [search, setSearch] = useState("")
    const [loading, setLoading] = useState(true)
    const [subject, setSubject] = useState<'m1' | 'm2'>('m2')
    const [updatingTier, setUpdatingTier] = useState<string | null>(null)
    const [isDeleting, setIsDeleting] = useState<string | null>(null)
    const [selectedUser, setSelectedUser] = useState<UserStat | null>(null)
    const [statsLoading, setStatsLoading] = useState(false)
    const [studentStats, setStudentStats] = useState<any>(null)

    // Live Countdown Timer
    useEffect(() => {
        const interval = setInterval(() => {
            setUsers(prevUsers => prevUsers.map(u => ({ ...u }))) // Trigger re-render
        }, 1000)
        return () => clearInterval(interval)
    }, [])

    // Helper to calculate time remaining in MM:SS
    const getTimeRemaining = (dateStr: string | null) => {
        if (!dateStr) return null
        const diff = new Date(dateStr).getTime() - new Date().getTime()
        if (diff <= 0) return "00:00"

        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
        const seconds = Math.floor((diff % (1000 * 60)) / 1000)

        return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`
    }

    // Campaign State
    const [campaignModalOpen, setCampaignModalOpen] = useState(false)
    const [campaignUser, setCampaignUser] = useState<{ id: string, email: string, name: string } | null>(null)
    const [selectedTemplate, setSelectedTemplate] = useState<'start-practice' | 'reminder' | 'new-features'>('start-practice')
    const [sendingEmail, setSendingEmail] = useState(false)

    // Customization State
    const [customSubject, setCustomSubject] = useState("")
    const [customMessage, setCustomMessage] = useState("")

    const supabase = createClient()

    const fetchUsers = async () => {
        setLoading(true)
        const { data, error } = await supabase.rpc('get_admin_users_stats_v2', { p_subject: subject })

        if (error) {
            console.error("Error fetching users:", error)
            // Show detailed error to help debugging
            alert(`Error al cargar usuarios: ${error.message || JSON.stringify(error)}`)
        } else {
            setUsers(data || [])
            setFilteredUsers(data || [])
        }
        setLoading(false)
    }

    const [activeTab, setActiveTab] = useState("all")

    useEffect(() => {
        fetchUsers()
    }, [subject])

    useEffect(() => {
        let filtered = users

        // 1. Tab Filter
        const now = new Date()
        const oneDayMs = 24 * 60 * 60 * 1000

        switch (activeTab) {
            case "active_24h":
                filtered = users.filter(u => {
                    if (!u.last_activity && !u.last_sign_in_at) return false
                    const lastAct = u.last_activity ? new Date(u.last_activity).getTime() : 0
                    const lastLogin = u.last_sign_in_at ? new Date(u.last_sign_in_at).getTime() : 0
                    const mostRecent = Math.max(lastAct, lastLogin)
                    return (now.getTime() - mostRecent) < oneDayMs
                })
                break
            case "history":
                filtered = users.filter(u => {
                    // Has attempted at least once, but NOT in the last 24h
                    if (u.total_attempts === 0) return false

                    const lastAct = u.last_activity ? new Date(u.last_activity).getTime() : 0
                    const lastLogin = u.last_sign_in_at ? new Date(u.last_sign_in_at).getTime() : 0
                    const mostRecent = Math.max(lastAct, lastLogin)
                    return (now.getTime() - mostRecent) >= oneDayMs
                })
                break
            case "inactive":
                filtered = users.filter(u => u.total_attempts === 0)
                break
            case "all":
            default:
                // Show all
                break
        }

        // 2. Search Filter (Refinement)
        if (search.trim()) {
            const lowerSearch = search.toLowerCase()
            filtered = filtered.filter(u =>
                u.email?.toLowerCase().includes(lowerSearch) ||
                u.full_name?.toLowerCase().includes(lowerSearch)
            )
        }

        setFilteredUsers(filtered)
    }, [search, users, activeTab])

    useEffect(() => {
        // Reset customization when template changes
        let defaultSubject = ""
        let defaultMessage = ""

        switch (selectedTemplate) {
            case 'start-practice':
                defaultSubject = 'Tu puntaje nacional te está esperando 🚀'
                defaultMessage = `Vemos que ya creaste tu cuenta, pero aún no has realizado tu primer entrenamiento. ¿Sabías que la única forma de mejorar en la PAES es practicando?

En PAES Lab tienes acceso a:
✅ Ejercicios DEMRE reales y actualizados.
✅ Detección automática de tus puntos débiles.
✅ Explicaciones detalladas paso a paso.
✅ Todo 100% Gratis.`
                break
            case 'reminder':
                defaultSubject = '🔥 No pierdas tu racha en PAES Lab'
                defaultMessage = `La constancia es la clave para un puntaje nacional. Notamos que hace unos días no entras a practicar y tu racha podría estar en peligro.

Recuerda que solo 10 minutos al día pueden hacer una gran diferencia en tu resultado final.`
                break
            case 'new-features':
                defaultSubject = '✨ Descubre lo nuevo en PAES Lab'
                defaultMessage = `Hemos estado trabajando duro para mejorar tu experiencia de estudio. Acabamos de lanzar nuevas funcionalidades que te ayudarán a prepararte mejor.

🆕 Modo Repaso: Vuelve a intentar solo los ejercicios en los que te equivocaste.
📊 Estadísticas Mejoradas: Ahora puedes ver tu progreso por eje temático con más detalle.
🚀 Interfaz Más Rápida: Optimizamos todo para que pierdas menos tiempo esperando.`
                break
        }
        setCustomSubject(defaultSubject)
        setCustomMessage(defaultMessage)
    }, [selectedTemplate, campaignModalOpen])

    const [scoreHistory, setScoreHistory] = useState<any[]>([])

    const fetchStudentStats = async (user: UserStat) => {
        setStatsLoading(true)
        setSelectedUser(user)

        // Parallel fetching for performance
        const [statsRes, historyRes] = await Promise.all([
            supabase.rpc('get_admin_student_performance', {
                p_user_id: user.user_id,
                p_subject: subject
            }),
            supabase.rpc('get_student_score_history', {
                p_user_id: user.user_id,
                p_subject: subject
            })
        ])

        if (statsRes.error) {
            console.error("Error fetching student stats:", statsRes.error)
            setStudentStats(null)
        } else {
            setStudentStats(statsRes.data)
        }

        if (historyRes.error) {
            console.error("Error fetching score history:", historyRes.error)
            setScoreHistory([])
        } else {
            setScoreHistory(historyRes.data || [])
        }

        setStatsLoading(false)
    }

    const handleUpdateTier = async (userId: string, newTier: string, userName: string) => {
        if (!confirm(`¿Cambiar el plan de ${userName} a ${newTier.toUpperCase()}?`)) {
            return
        }

        setUpdatingTier(userId)
        const result = await adminUpdateUserTier(userId, newTier)

        if (result.error) {
            alert("Error: " + result.error)
        } else {
            fetchUsers()
        }
        setUpdatingTier(null)
    }

    const handleDelete = async (userId: string, userName: string) => {
        const confirm1 = confirm(`¿ESTÁS COMPLETAMENTE SEGURO de eliminar a ${userName}?\n\nEsta acción es IRREVERSIBLE y borrará todo su progreso, suscripciones y cuenta.`)
        if (!confirm1) return

        const confirm2 = confirm(`ÚLTIMA ADVERTENCIA: Se perderán todos los datos permanentemente. ¿Proceder?`)
        if (!confirm2) return

        setIsDeleting(userId)
        try {
            const result = await adminDeleteUser(userId)
            if (result.error) {
                alert("Error: " + result.error)
            } else {
                alert("Usuario eliminado correctamente")
                fetchUsers()
            }
        } catch (e) {
            alert("Error inesperado al eliminar")
        } finally {
            setIsDeleting(null)
        }
    }

    const handleReset = async (userId: string, userName: string) => {
        if (!confirm(`¿Estás seguro de resetear EL PROGRESO de ${userName} para ${subject.toUpperCase()}?`)) {
            return
        }
        const { error } = await supabase.rpc('reset_user_progress', { p_user_id: userId })
        if (error) {
            alert("Error: " + error.message)
        } else {
            alert("Progreso reseteado")
            fetchUsers()
        }
    }

    const handleRefillLives = async (userId: string, userName: string) => {
        if (!confirm(`¿Restaurar las 10 vidas para ${userName} en ${subject.toUpperCase()}?`)) {
            return
        }
        const { error } = await supabase.rpc('admin_refill_lives', { p_user_id: userId, p_subject: subject })
        if (error) {
            alert("Error: " + error.message)
        } else {
            fetchUsers()
        }
    }

    const handleGrantCredits = async (userId: string, userName: string) => {
        if (!confirm(`¿Regalar 5 explicaciones extra a ${userName}?`)) {
            return
        }
        const { error } = await supabase.rpc('admin_grant_explanation_credits', { p_user_id: userId })
        if (error) {
            alert("Error: " + error.message)
        } else {
            fetchUsers()
        }
    }

    const openCampaignModal = (user: UserStat) => {
        setCampaignUser({
            id: user.user_id,
            email: user.email,
            name: user.full_name || user.email
        })
        setCampaignModalOpen(true)
    }

    const handleSendCampaign = async () => {
        if (!campaignUser) return

        setSendingEmail(true)
        const result = await sendCampaignEmail(
            campaignUser.email,
            campaignUser.name,
            selectedTemplate,
            customSubject,
            customMessage
        )
        setSendingEmail(false)

        if (result.error) {
            alert("❌ " + result.error)
        } else {
            alert("✅ Correo enviado con éxito")
            setCampaignModalOpen(false)
            setCampaignUser(null)
        }
    }

    // Helper functions
    const getHabilidadLabel = (h: string) => {
        const labels: Record<string, string> = {
            'resolver_problemas': 'Resolver Problemas',
            'modelar': 'Modelar',
            'representar': 'Representar',
            'argumentar': 'Argumentar'
        }
        return labels[h] || h
    }

    const formatDate = (dateString: string) => {
        if (!dateString) return "Nunca"
        return new Date(dateString).toLocaleDateString('es-CL', {
            day: '2-digit', month: 'short', hour: '2-digit', minute: '2-digit'
        })
    }

    const getProgressColor = (progress: number) => {
        if (progress >= 80) return { text: 'text-green-600', bg: 'bg-green-500', bgSoft: 'bg-green-100' }
        if (progress >= 50) return { text: 'text-yellow-600', bg: 'bg-yellow-500', bgSoft: 'bg-yellow-100' }
        return { text: 'text-red-600', bg: 'bg-red-500', bgSoft: 'bg-red-100' }
    }

    const getHourlyUsageData = (usageStats: Record<string, number> = {}) => {
        return Array.from({ length: 24 }, (_, i) => ({
            hour: i,
            count: usageStats[i.toString()] || 0
        }))
    }

    const CustomTooltip = ({ active, payload, label }: any) => {
        if (active && payload && payload.length) {
            return (
                <div className="bg-slate-800 text-white text-xs p-2 rounded-lg shadow-xl">
                    <p className="font-bold mb-1">{`${label}:00 - ${label}:59`}</p>
                    <p className="text-slate-300">{`Ejercicios: ${payload[0].value}`}</p>
                </div>
            )
        }
        return null
    }

    return (
        <div className="space-y-6 pb-20">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h2 className="text-2xl font-bold text-slate-900">Gestión de Usuarios</h2>
                    <p className="text-slate-500 text-sm">Administra los estudiantes y su progreso</p>
                </div>

                <div className="bg-slate-100 p-1 rounded-lg flex items-center gap-1 w-fit">
                    <button onClick={() => setSubject('m1')} className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm1' ? 'bg-white text-slate-900 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>M1</button>
                    <button onClick={() => setSubject('m2')} className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm2' ? 'bg-white text-slate-900 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>M2</button>
                </div>

                <div className="relative w-full md:w-64">
                    <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={16} />
                    <input
                        type="text"
                        placeholder="Buscar por nombre o email..."
                        className="w-full pl-10 pr-4 py-2 border rounded-md text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                        value={search}
                        onChange={e => setSearch(e.target.value)}
                    />
                </div>
            </div>

            <div className="mb-6">
                <Tabs defaultValue="all" value={activeTab} onValueChange={setActiveTab} className="w-full">
                    <TabsList className="grid w-full max-w-[600px] grid-cols-4 bg-slate-100 p-1">
                        <TabsTrigger value="all" className="text-xs data-[state=active]:bg-white data-[state=active]:shadow-sm">Todos</TabsTrigger>
                        <TabsTrigger value="active_24h" className="text-xs data-[state=active]:bg-white data-[state=active]:shadow-sm text-green-700">🟢 Activos Hoy</TabsTrigger>
                        <TabsTrigger value="history" className="text-xs data-[state=active]:bg-white data-[state=active]:shadow-sm text-blue-700">🕒 Históricos</TabsTrigger>
                        <TabsTrigger value="inactive" className="text-xs data-[state=active]:bg-white data-[state=active]:shadow-sm text-slate-500">💤 Sin Actividad</TabsTrigger>
                    </TabsList>
                </Tabs>
            </div>

            <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden overflow-x-auto">
                <table className="w-full text-sm text-left">
                    <thead className="bg-slate-50 border-b border-slate-200 text-xs uppercase text-slate-500 font-semibold">
                        <tr>
                            <th className="px-6 py-4">Usuario</th>
                            <th className="px-6 py-4 text-center">Vidas ({subject.toUpperCase()})</th>
                            <th className="px-6 py-4 text-center">Explicaciones</th>
                            <th className="px-6 py-4 text-center">Plan / Tier</th>
                            <th className="px-6 py-4 text-center">Progreso ({subject.toUpperCase()})</th>
                            <th className="px-6 py-4">Actividad</th>
                            <th className="px-6 py-4 text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-100">
                        {loading ? (
                            <tr><td colSpan={7} className="px-6 py-12 text-center text-slate-500">Cargando usuarios...</td></tr>
                        ) : filteredUsers.length === 0 ? (
                            <tr><td colSpan={7} className="px-6 py-12 text-center text-slate-500">No se encontraron usuarios.</td></tr>
                        ) : (
                            filteredUsers.map((user) => {
                                const successRate = user.total_attempts > 0 ? Math.round((user.correct_attempts / user.total_attempts) * 100) : 0
                                const colors = getProgressColor(successRate)

                                return (
                                    <tr
                                        key={user.user_id}
                                        className="hover:bg-slate-50 transition-colors cursor-pointer group"
                                        onClick={(e) => {
                                            const target = e.target as HTMLElement
                                            if (target.closest('button') || target.closest('select') || target.closest('textarea') || target.closest('input')) return
                                            fetchStudentStats(user)
                                        }}
                                    >
                                        <td className="px-6 py-4">
                                            <div className="flex items-center gap-3">
                                                <Avatar className="w-10 h-10 border border-slate-200">
                                                    <AvatarImage src={user.avatar_url} />
                                                    <AvatarFallback>{user.full_name?.charAt(0) || user.email?.charAt(0)}</AvatarFallback>
                                                </Avatar>
                                                <div>
                                                    <p className="font-bold text-slate-900 truncate max-w-[150px]">{user.full_name || 'Sin Nombre'}</p>
                                                    <p className="text-xs text-slate-500 truncate max-w-[150px]">{user.email}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-center">
                                            <div className="inline-flex items-center gap-1 font-bold text-slate-700 bg-slate-100 px-3 py-1 rounded-full">
                                                {user.subscription_tier !== 'free' ? '∞' : user.lives} <span className="text-red-500">❤️</span>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-center">
                                            <div className="inline-flex items-center gap-1 font-bold text-slate-700 bg-blue-50 px-3 py-1 rounded-full border border-blue-100">
                                                {user.subscription_tier !== 'free' ? '∞' : user.explanation_credits} <span className="text-blue-500">💡</span>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-center">
                                            <div className="flex flex-col items-center gap-2">
                                                <SubscriptionBadge tier={user.subscription_tier} />
                                                <select onClick={(e) => e.stopPropagation()} value={user.subscription_tier} onChange={(e) => handleUpdateTier(user.user_id, e.target.value, user.full_name || user.email)} disabled={updatingTier === user.user_id} className="text-[10px] px-2 py-1 border rounded bg-white font-medium text-slate-600 focus:outline-none focus:ring-1 focus:ring-blue-500 disabled:opacity-50">
                                                    <option value="free">FREE</option>
                                                    <option value="premium">PREMIUM</option>
                                                    <option value="signature">SIGNATURE</option>
                                                </select>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4">
                                            <div className="flex flex-col gap-1 min-w-[100px]">
                                                <div className="flex justify-between text-[10px] font-medium text-slate-600">
                                                    <span className={colors.text}>{successRate}%</span>
                                                    <span>{user.correct_attempts}/{user.total_attempts}</span>
                                                </div>
                                                <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                                                    <div className={`h-full rounded-full ${colors.bg}`} style={{ width: `${successRate}%` }} />
                                                </div>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-slate-500 text-[10px] leading-tight min-w-[140px]">
                                            <p><span className="font-semibold text-slate-400 uppercase">Reg:</span> {formatDate(user.created_at)}</p>
                                            <p><span className="font-semibold text-slate-400 uppercase">Log:</span> {formatDate(user.last_sign_in_at)}</p>
                                        </td>
                                        <td className="px-6 py-4 text-right">
                                            <div className="flex items-center justify-end gap-1.5">
                                                <Button
                                                    size="sm"
                                                    variant="outline"
                                                    className="h-8 w-8 p-0 text-indigo-600 border-indigo-100 hover:bg-indigo-50"
                                                    onClick={(e) => { e.stopPropagation(); openCampaignModal(user); }}
                                                    title="Enviar Campaña / Email"
                                                >
                                                    <Send size={14} />
                                                </Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-blue-600 border-blue-100 hover:bg-blue-50" onClick={(e) => { e.stopPropagation(); handleGrantCredits(user.user_id, user.full_name || user.email); }} title="Regalar +5 Explicaciones">💡</Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-red-600 border-red-100 hover:bg-red-50" onClick={(e) => { e.stopPropagation(); handleRefillLives(user.user_id, user.full_name || user.email); }} disabled={user.lives >= 10 || user.subscription_tier !== 'free'} title="Recargar Vidas">❤️</Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-slate-400 border-slate-100 hover:text-red-700 hover:border-red-100" onClick={(e) => { e.stopPropagation(); handleReset(user.user_id, user.full_name || user.email); }} title="Resetear Progreso"><RotateCcw size={14} /></Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-slate-300 border-slate-100 hover:text-red-600 hover:border-red-200" onClick={(e) => { e.stopPropagation(); handleDelete(user.user_id, user.full_name || user.email); }} disabled={isDeleting === user.user_id} title="ELIMINAR USUARIO"><Trash2 size={14} className={isDeleting === user.user_id ? "animate-pulse" : ""} /></Button>
                                            </div>
                                        </td>
                                    </tr>
                                )
                            })
                        )}
                    </tbody>
                </table>
            </div>

            {/* Campaign Selection Modal */}
            {campaignModalOpen && campaignUser && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
                    <div className="bg-white w-full max-w-lg rounded-2xl shadow-2xl p-6 animate-in zoom-in-95 duration-200 max-h-[90vh] overflow-y-auto">
                        <div className="flex justify-between items-start mb-4">
                            <div>
                                <h3 className="text-lg font-bold text-slate-900">Enviar Correo</h3>
                                <p className="text-sm text-slate-500">Para: {campaignUser.name}</p>
                            </div>
                            <Button variant="ghost" size="sm" className="h-8 w-8 p-0 rounded-full" onClick={() => setCampaignModalOpen(false)}>
                                <X size={18} />
                            </Button>
                        </div>

                        <div className="space-y-4">
                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Selecciona Plantilla</label>
                                <select
                                    className="w-full p-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                                    value={selectedTemplate}
                                    onChange={(e) => setSelectedTemplate(e.target.value as any)}
                                >
                                    <option value="start-practice">🚀 Comienza a Practicar (Onboarding)</option>
                                    <option value="reminder">🔥 Recordatorio de Racha</option>
                                    <option value="new-features">✨ Nuevas Funcionalidades</option>
                                </select>
                            </div>

                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Asunto del Correo</label>
                                <input
                                    type="text"
                                    className="w-full p-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none"
                                    value={customSubject}
                                    onChange={(e) => setCustomSubject(e.target.value)}
                                />
                            </div>

                            <div>
                                <label className="block text-sm font-medium text-slate-700 mb-1">Mensaje (Cuerpo)</label>
                                <textarea
                                    className="w-full p-2 border border-slate-200 rounded-lg text-sm focus:ring-2 focus:ring-blue-500 outline-none min-h-[150px]"
                                    value={customMessage}
                                    onChange={(e) => setCustomMessage(e.target.value)}
                                />
                                <p className="text-xs text-slate-400 mt-1">Este texto reemplazará el contenido principal del correo.</p>
                            </div>

                            <div className="flex gap-2 justify-end mt-6">
                                <Button variant="ghost" onClick={() => setCampaignModalOpen(false)}>Cancelar</Button>
                                <Button
                                    onClick={handleSendCampaign}
                                    disabled={sendingEmail}
                                    className="bg-blue-600 hover:bg-blue-700 text-white"
                                >
                                    {sendingEmail ? "Enviando..." : "Enviar Correo"} <Send size={14} className="ml-2" />
                                </Button>
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {/* Student Detail Modal */}
            {selectedUser && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
                    <div className="bg-white w-full max-w-4xl max-h-[90dvh] rounded-3xl shadow-2xl overflow-hidden flex flex-col animate-in zoom-in-95 duration-200">
                        {/* Header */}
                        <div className="p-6 border-b border-slate-100 flex items-center justify-between bg-slate-50/50">
                            <div className="flex items-center gap-4">
                                <Avatar className="w-12 h-12 border-2 border-white shadow-sm">
                                    <AvatarImage src={selectedUser.avatar_url} />
                                    <AvatarFallback className="bg-blue-600 text-white font-bold">{selectedUser.full_name?.charAt(0)}</AvatarFallback>
                                </Avatar>
                                <div>
                                    <h3 className="text-xl font-bold text-slate-900">{selectedUser.full_name || 'Estudiante'}</h3>
                                    <p className="text-sm text-slate-500 font-medium">{selectedUser.email} • {subject.toUpperCase()}</p>
                                </div>
                            </div>
                            <Button variant="ghost" size="sm" className="rounded-full w-10 h-10 p-0 hover:bg-slate-200" onClick={() => setSelectedUser(null)}>
                                <X size={20} className="text-slate-500" />
                            </Button>
                        </div>

                        {/* Content */}
                        <div className="flex-1 overflow-y-auto p-6 space-y-8">
                            {statsLoading ? (
                                <div className="flex flex-col items-center justify-center py-20 gap-4">
                                    <div className="w-10 h-10 border-4 border-blue-100 border-t-blue-600 rounded-full animate-spin" />
                                    <p className="text-slate-400 font-medium">Calculando estadísticas detalladas...</p>
                                </div>
                            ) : studentStats ? (
                                <>
                                    {/* Main Metrics */}
                                    <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                                        <div className="bg-blue-50/50 p-4 rounded-2xl border border-blue-100">
                                            <p className="text-[10px] uppercase tracking-wider font-bold text-blue-600 mb-1">Intentos Totales</p>
                                            <p className="text-2xl font-black text-slate-900">{selectedUser.total_attempts}</p>
                                        </div>
                                        <div className="bg-green-50/50 p-4 rounded-2xl border border-green-100">
                                            <p className="text-[10px] uppercase tracking-wider font-bold text-green-600 mb-1">Aciertos</p>
                                            <p className="text-2xl font-black text-slate-900">{selectedUser.correct_attempts}</p>
                                        </div>
                                        <div className="bg-indigo-50/50 p-4 rounded-2xl border border-indigo-100">
                                            <p className="text-[10px] uppercase tracking-wider font-bold text-indigo-600 mb-1">Precisión Global</p>
                                            <p className="text-2xl font-black text-slate-900">
                                                {selectedUser.total_attempts > 0 ? Math.round((selectedUser.correct_attempts / selectedUser.total_attempts) * 100) : 0}%
                                            </p>
                                        </div>
                                        <div className="bg-slate-50/50 p-4 rounded-2xl border border-slate-100">
                                            <p className="text-[10px] uppercase tracking-wider font-bold text-slate-500 mb-1">Última Actividad</p>
                                            <p className="text-sm font-bold text-slate-700 mt-1">{formatDate(selectedUser.last_activity)}</p>
                                        </div>
                                    </div>

                                    {/* Estimated Score & Evolution */}
                                    {scoreHistory.length > 0 && (
                                        <div className="mb-6 space-y-4">
                                            <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
                                                <div className="rounded-xl border bg-white text-slate-900 shadow-sm p-6 border-slate-100">
                                                    <div className="flex flex-row items-center justify-between space-y-0 pb-2">
                                                        <h3 className="tracking-tight text-sm font-medium text-slate-500">Puntaje Estimado</h3>
                                                        <LineChartIcon className="h-4 w-4 text-blue-500" />
                                                    </div>
                                                    <div className="text-3xl font-black text-blue-600">
                                                        {scoreHistory[scoreHistory.length - 1].estimated_score}
                                                    </div>
                                                    <p className="text-xs text-slate-400 mt-1">
                                                        Basado en precisión histórica
                                                    </p>
                                                </div>
                                            </div>

                                            <div className="rounded-xl border bg-white text-slate-900 shadow-sm p-6 border-slate-100">
                                                <h3 className="font-bold text-slate-800 mb-4 flex items-center gap-2">
                                                    <LineChartIcon size={18} className="text-blue-500" /> Evolución de Puntaje
                                                </h3>
                                                <div className="h-[250px] w-full">
                                                    <ResponsiveContainer width="100%" height="100%">
                                                        <LineChart data={scoreHistory}>
                                                            <XAxis
                                                                dataKey="date"
                                                                tickFormatter={(date) => new Date(date).toLocaleDateString(undefined, { month: 'short', day: 'numeric' })}
                                                                stroke="#94a3b8"
                                                                fontSize={12}
                                                                tickLine={false}
                                                                axisLine={false}
                                                            />
                                                            <Tooltip
                                                                content={({ active, payload, label }) => {
                                                                    if (active && payload && payload.length && label) {
                                                                        return (
                                                                            <div className="bg-slate-800 text-white text-xs p-2 rounded-lg shadow-xl border border-slate-700">
                                                                                <p className="font-bold mb-1">{new Date(label).toLocaleDateString()}</p>
                                                                                <div className="flex flex-col gap-1">
                                                                                    <span className="text-slate-300">Puntaje: <span className="font-bold text-white">{payload[0].value}</span></span>
                                                                                </div>
                                                                            </div>
                                                                        )
                                                                    }
                                                                    return null
                                                                }}
                                                            />
                                                            <Line
                                                                type="monotone"
                                                                dataKey="estimated_score"
                                                                stroke="#3b82f6"
                                                                strokeWidth={3}
                                                                dot={{ r: 4, fill: "#3b82f6", strokeWidth: 2, stroke: "#fff" }}
                                                                activeDot={{ r: 6, strokeWidth: 0 }}
                                                            />
                                                        </LineChart>
                                                    </ResponsiveContainer>
                                                </div>
                                            </div>
                                        </div>
                                    )}

                                    {/* Usage Chart */}
                                    <div className="bg-white p-4 rounded-2xl border border-slate-100">
                                        <div className="flex items-center gap-2 mb-4">
                                            <Clock className="text-orange-500" size={18} />
                                            <h4 className="font-bold text-slate-800">Horas de Conexión</h4>
                                        </div>
                                        <div className="h-48 w-full">
                                            <ResponsiveContainer width="100%" height="100%">
                                                <BarChart data={getHourlyUsageData(studentStats.usage)}>
                                                    <XAxis
                                                        dataKey="hour"
                                                        fontSize={10}
                                                        tickLine={false}
                                                        axisLine={false}
                                                        tickFormatter={(val) => `${val}h`}
                                                    />
                                                    <Tooltip content={<CustomTooltip />} cursor={{ fill: 'transparent' }} />
                                                    <Bar dataKey="count" radius={[4, 4, 0, 0]}>
                                                        {getHourlyUsageData(studentStats.usage).map((entry, index) => (
                                                            <Cell
                                                                key={`cell-${index}`}
                                                                fill={entry.count > 0 ? (entry.hour >= 5 && entry.hour < 12 ? '#f59e0b' : entry.hour >= 20 || entry.hour < 5 ? '#6366f1' : '#3b82f6') : '#e2e8f0'}
                                                            />
                                                        ))}
                                                    </Bar>
                                                </BarChart>
                                            </ResponsiveContainer>
                                        </div>
                                    </div>

                                    <div className="grid md:grid-cols-2 gap-8">
                                        {/* Ejes Breakdown */}
                                        <div className="space-y-4">
                                            <div className="flex items-center gap-2">
                                                <BarChart3 className="text-blue-600" size={18} />
                                                <h4 className="font-bold text-slate-800">Rendimiento por Eje</h4>
                                            </div>
                                            <div className="space-y-3">
                                                {studentStats.ejes.map((eje: any) => {
                                                    const colors = getProgressColor(eje.progress)
                                                    return (
                                                        <div key={eje.name} className="space-y-1.5">
                                                            <div className="flex justify-between text-xs font-bold text-slate-600 px-1">
                                                                <span>{eje.name}</span>
                                                                <span className={colors.text}>
                                                                    {eje.progress}% ({eje.correct}/{eje.total})
                                                                </span>
                                                            </div>
                                                            <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                                                                <div
                                                                    className={cn("h-full rounded-full transition-all duration-1000", colors.bg)}
                                                                    style={{ width: `${eje.progress}%` }}
                                                                />
                                                            </div>
                                                        </div>
                                                    )
                                                })}
                                            </div>
                                        </div>

                                        {/* Habilidades Breakdown */}
                                        <div className="space-y-4">
                                            <div className="flex items-center gap-2">
                                                <PieChartIcon className="text-indigo-600" size={18} />
                                                <h4 className="font-bold text-slate-800">Habilidades PAES</h4>
                                            </div>
                                            <div className="grid grid-cols-2 gap-3">
                                                {studentStats.habilidades.map((hab: any) => {
                                                    const colors = getProgressColor(hab.progress)
                                                    return (
                                                        <div key={hab.name} className="bg-slate-50/50 p-3 rounded-xl border border-slate-100 flex flex-col items-center text-center">
                                                            <p className="text-[10px] font-black uppercase tracking-tighter text-slate-400 mb-1 leading-tight h-6 flex items-center">
                                                                {getHabilidadLabel(hab.name)}
                                                            </p>
                                                            <p className={cn("text-lg font-black", colors.text)}>
                                                                {hab.progress}%
                                                            </p>
                                                            <p className="text-[10px] text-slate-400 font-medium">
                                                                {hab.total} intentos
                                                            </p>
                                                        </div>
                                                    )
                                                })}
                                            </div>
                                        </div>
                                    </div>

                                    {/* Detailed Topics Table */}
                                    <div className="space-y-4">
                                        <div className="flex items-center gap-2">
                                            <LineChartIcon className="text-blue-600" size={18} />
                                            <h4 className="font-bold text-slate-800">Desglose por Tema</h4>
                                        </div>
                                        <div className="rounded-2xl border border-slate-100 overflow-hidden">
                                            <table className="w-full text-xs text-left">
                                                <thead className="bg-slate-50 text-slate-500 font-bold uppercase tracking-wider">
                                                    <tr>
                                                        <th className="px-4 py-3">Eje / Tema</th>
                                                        <th className="px-4 py-3 text-center">Intentos</th>
                                                        <th className="px-4 py-3 text-center">Éxito</th>
                                                        <th className="px-4 py-3 text-right">Progreso</th>
                                                    </tr>
                                                </thead>
                                                <tbody className="divide-y divide-slate-50">
                                                    {studentStats.topics.map((topic: any) => {
                                                        const colors = getProgressColor(topic.progress)
                                                        return (
                                                            <tr key={topic.name} className="hover:bg-slate-50/50 transition-colors">
                                                                <td className="px-4 py-3">
                                                                    <p className="text-[10px] text-blue-500 font-bold uppercase tracking-tight">{topic.eje_name}</p>
                                                                    <p className="font-bold text-slate-700">{topic.name}</p>
                                                                </td>
                                                                <td className="px-4 py-3 text-center font-medium text-slate-500">{topic.total}</td>
                                                                <td className="px-4 py-3 text-center font-bold text-slate-900">{topic.correct}</td>
                                                                <td className="px-4 py-3 text-right">
                                                                    <span className={cn(
                                                                        "px-2 py-1 rounded-lg font-black",
                                                                        colors.bgSoft,
                                                                        colors.text
                                                                    )}>
                                                                        {topic.progress}%
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        )
                                                    })}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    {/* Matrix View (Combinations) */}
                                    {studentStats.matrix.length > 0 && (
                                        <div className="space-y-4">
                                            <div className="flex items-center gap-2">
                                                <ChevronRight className="text-slate-400 rotate-90" size={18} />
                                                <h4 className="font-bold text-slate-800">Matriz de Rendimiento (Eje + Tema + Habilidad)</h4>
                                            </div>
                                            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
                                                {studentStats.matrix.map((item: any, idx: number) => {
                                                    const colors = getProgressColor(item.progress)
                                                    return (
                                                        <div key={idx} className="p-3 rounded-xl border border-dashed border-slate-200 bg-slate-50 flex flex-col justify-between">
                                                            <div>
                                                                <p className="text-[9px] text-blue-600 font-black uppercase tracking-widest">{item.eje_name}</p>
                                                                <p className="text-xs font-bold text-slate-800 line-clamp-1">{item.topic_name}</p>
                                                                <p className="text-[10px] font-medium text-indigo-500 mt-1">{getHabilidadLabel(item.skill_name)}</p>
                                                            </div>
                                                            <div className="mt-2 flex items-center justify-between">
                                                                <div className="flex gap-1">
                                                                    {[...Array(5)].map((_, i) => (
                                                                        <div key={i} className={cn(
                                                                            "w-3 h-1 rounded-full",
                                                                            i < (item.progress / 20) ? colors.bg : "bg-slate-200"
                                                                        )} />
                                                                    ))}
                                                                </div>
                                                                <span className="text-[10px] font-black text-slate-900">{item.progress}%</span>
                                                            </div>
                                                        </div>
                                                    )
                                                })}
                                            </div>
                                        </div>
                                    )}
                                </>
                            ) : (
                                <div className="text-center py-20 text-slate-400">
                                    No hay datos suficientes para generar un reporte.
                                </div>
                            )}
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}


