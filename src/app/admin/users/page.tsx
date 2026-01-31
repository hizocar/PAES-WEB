"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { BarChart3, ChevronRight, LineChart, RotateCcw, Search, Trash2, X } from "lucide-react"
import { adminUpdateUserTier } from "@/app/actions/subscription"
import { adminDeleteUser } from "@/app/actions/admin"
import { SubscriptionBadge } from "@/components/subscription-badge"
import { cn } from "@/lib/utils"

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
    const [studentStats, setStudentStats] = useState<any>(null)
    const [statsLoading, setStatsLoading] = useState(false)

    const supabase = createClient()

    const fetchUsers = async () => {
        setLoading(true)
        const { data, error } = await supabase.rpc('get_admin_users_stats', { p_subject: subject })

        if (error) {
            console.error("Error fetching users:", error)
            alert("Error al cargar usuarios")
        } else {
            setUsers(data || [])
            setFilteredUsers(data || [])
        }
        setLoading(false)
    }

    useEffect(() => {
        fetchUsers()
    }, [subject])

    useEffect(() => {
        if (!search.trim()) {
            setFilteredUsers(users)
        } else {
            const lowerSearch = search.toLowerCase()
            const filtered = users.filter(u =>
                u.email?.toLowerCase().includes(lowerSearch) ||
                u.full_name?.toLowerCase().includes(lowerSearch)
            )
            setFilteredUsers(filtered)
        }
    }, [search, users])

    const fetchStudentStats = async (user: UserStat) => {
        setStatsLoading(true)
        setSelectedUser(user)
        const { data, error } = await supabase.rpc('get_admin_student_performance', {
            p_user_id: user.user_id,
            p_subject: subject
        })

        if (error) {
            console.error("Error fetching student stats:", error)
        } else {
            setStudentStats(data)
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
                                return (
                                    <tr
                                        key={user.user_id}
                                        className="hover:bg-slate-50 transition-colors cursor-pointer group"
                                        onClick={(e) => {
                                            const target = e.target as HTMLElement
                                            if (target.closest('button') || target.closest('select')) return
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
                                                <select value={user.subscription_tier} onChange={(e) => handleUpdateTier(user.user_id, e.target.value, user.full_name || user.email)} disabled={updatingTier === user.user_id} className="text-[10px] px-2 py-1 border rounded bg-white font-medium text-slate-600 focus:outline-none focus:ring-1 focus:ring-blue-500 disabled:opacity-50">
                                                    <option value="free">FREE</option>
                                                    <option value="premium">PREMIUM</option>
                                                    <option value="signature">SIGNATURE</option>
                                                </select>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4">
                                            <div className="flex flex-col gap-1 min-w-[100px]">
                                                <div className="flex justify-between text-[10px] font-medium text-slate-600"><span>{successRate}%</span><span>{user.correct_attempts}/{user.total_attempts}</span></div>
                                                <div className="w-full h-1.5 bg-slate-100 rounded-full overflow-hidden">
                                                    <div className={`h-full rounded-full ${successRate >= 70 ? 'bg-green-500' : successRate >= 40 ? 'bg-yellow-500' : 'bg-red-500'}`} style={{ width: `${successRate}%` }} />
                                                </div>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-slate-500 text-[10px] leading-tight min-w-[140px]">
                                            <p><span className="font-semibold text-slate-400 uppercase">Reg:</span> {formatDate(user.created_at)}</p>
                                            <p><span className="font-semibold text-slate-400 uppercase">Log:</span> {formatDate(user.last_sign_in_at)}</p>
                                        </td>
                                        <td className="px-6 py-4 text-right">
                                            <div className="flex items-center justify-end gap-1.5">
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-blue-600 border-blue-100 hover:bg-blue-50" onClick={() => handleGrantCredits(user.user_id, user.full_name || user.email)} title="Regalar +5 Explicaciones">💡</Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-red-600 border-red-100 hover:bg-red-50" onClick={() => handleRefillLives(user.user_id, user.full_name || user.email)} disabled={user.lives >= 10 || user.subscription_tier !== 'free'} title="Recargar Vidas">❤️</Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-slate-400 border-slate-100 hover:text-red-700 hover:border-red-100" onClick={() => handleReset(user.user_id, user.full_name || user.email)} title="Resetear Progreso"><RotateCcw size={14} /></Button>
                                                <Button size="sm" variant="outline" className="h-8 w-8 p-0 text-slate-300 border-slate-100 hover:text-red-600 hover:border-red-200" onClick={() => handleDelete(user.user_id, user.full_name || user.email)} disabled={isDeleting === user.user_id} title="ELIMINAR USUARIO"><Trash2 size={14} className={isDeleting === user.user_id ? "animate-pulse" : ""} /></Button>
                                            </div>
                                        </td>
                                    </tr>
                                )
                            })
                        )}
                    </tbody>
                </table>
            </div>

            {/* Student Detail Modal */}
            {selectedUser && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-sm animate-in fade-in duration-200">
                    <div className="bg-white w-full max-w-4xl max-h-[90vh] rounded-3xl shadow-2xl overflow-hidden flex flex-col animate-in zoom-in-95 duration-200">
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

                                    <div className="grid md:grid-cols-2 gap-8">
                                        {/* Ejes Breakdown */}
                                        <div className="space-y-4">
                                            <div className="flex items-center gap-2">
                                                <BarChart3 className="text-blue-600" size={18} />
                                                <h4 className="font-bold text-slate-800">Rendimiento por Eje</h4>
                                            </div>
                                            <div className="space-y-3">
                                                {studentStats.ejes.map((eje: any) => (
                                                    <div key={eje.name} className="space-y-1.5">
                                                        <div className="flex justify-between text-xs font-bold text-slate-600 px-1">
                                                            <span>{eje.name}</span>
                                                            <span className={eje.progress >= 70 ? 'text-green-600' : eje.progress >= 40 ? 'text-blue-600' : 'text-slate-400'}>
                                                                {eje.progress}% ({eje.correct}/{eje.total})
                                                            </span>
                                                        </div>
                                                        <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                                                            <div
                                                                className={cn(
                                                                    "h-full rounded-full transition-all duration-1000",
                                                                    eje.progress >= 70 ? 'bg-green-500' : eje.progress >= 40 ? 'bg-blue-500' : 'bg-slate-300'
                                                                )}
                                                                style={{ width: `${eje.progress}%` }}
                                                            />
                                                        </div>
                                                    </div>
                                                ))}
                                            </div>
                                        </div>

                                        {/* Habilidades Breakdown */}
                                        <div className="space-y-4">
                                            <div className="flex items-center gap-2">
                                                <PieChartIcon className="text-indigo-600" size={18} />
                                                <h4 className="font-bold text-slate-800">Habilidades PAES</h4>
                                            </div>
                                            <div className="grid grid-cols-2 gap-3">
                                                {studentStats.habilidades.map((hab: any) => (
                                                    <div key={hab.name} className="bg-slate-50/50 p-3 rounded-xl border border-slate-100 flex flex-col items-center text-center">
                                                        <p className="text-[10px] font-black uppercase tracking-tighter text-slate-400 mb-1 leading-tight h-6 flex items-center">
                                                            {getHabilidadLabel(hab.name)}
                                                        </p>
                                                        <p className={cn(
                                                            "text-lg font-black",
                                                            hab.progress >= 70 ? "text-green-600" : hab.progress >= 40 ? "text-indigo-600" : "text-slate-400"
                                                        )}>
                                                            {hab.progress}%
                                                        </p>
                                                        <p className="text-[10px] text-slate-400 font-medium">
                                                            {hab.total} intentos
                                                        </p>
                                                    </div>
                                                ))}
                                            </div>
                                        </div>
                                    </div>

                                    {/* Detailed Topics Table */}
                                    <div className="space-y-4">
                                        <div className="flex items-center gap-2">
                                            <LineChart className="text-blue-600" size={18} />
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
                                                    {studentStats.topics.map((topic: any) => (
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
                                                                    topic.progress >= 70 ? "bg-green-100 text-green-700" :
                                                                        topic.progress >= 40 ? "bg-blue-100 text-blue-700" : "bg-slate-100 text-slate-500"
                                                                )}>
                                                                    {topic.progress}%
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    ))}
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
                                                {studentStats.matrix.map((item: any, idx: number) => (
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
                                                                        i < (item.progress / 20) ? (item.progress >= 70 ? "bg-green-500" : "bg-blue-500") : "bg-slate-200"
                                                                    )} />
                                                                ))}
                                                            </div>
                                                            <span className="text-[10px] font-black text-slate-900">{item.progress}%</span>
                                                        </div>
                                                    </div>
                                                ))}
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

function PieChartIcon({ size, className }: { size: number, className: string }) {
    return (
        <svg xmlns="http://www.w3.org/2000/svg" width={size} height={size} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className={className}>
            <path d="M21.21 15.89A10 10 0 1 1 8 2.83" />
            <path d="M22 12A10 10 0 0 0 12 2v10z" />
        </svg>
    )
}
