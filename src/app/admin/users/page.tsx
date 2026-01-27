"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { RotateCcw, Search, Trash2 } from "lucide-react"

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
}

export default function AdminUsersPage() {
    const [users, setUsers] = useState<UserStat[]>([])
    const [filteredUsers, setFilteredUsers] = useState<UserStat[]>([])
    const [search, setSearch] = useState("")
    const [loading, setLoading] = useState(true)

    const supabase = createClient()

    const fetchUsers = async () => {
        setLoading(true)
        const { data, error } = await supabase.rpc('get_admin_users_stats')

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
    }, [])

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

    const handleReset = async (userId: string, userName: string) => {
        if (!confirm(`¿Estás seguro de resetear EL PROGRESO de ${userName}?\n\nEsta acción eliminará todos sus intentos y estadísticas. No se puede deshacer.`)) {
            return
        }

        const { error } = await supabase.rpc('reset_user_progress', { p_user_id: userId })

        if (error) {
            alert("Error al resetear progreso: " + error.message)
        } else {
            alert("Progreso reseteado correctamente")
            fetchUsers() // Refresh list
        }
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

            <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
                <table className="w-full text-sm text-left">
                    <thead className="bg-slate-50 border-b border-slate-200 text-xs uppercase text-slate-500 font-semibold">
                        <tr>
                            <th className="px-6 py-4">Usuario</th>
                            <th className="px-6 py-4 text-center">Progreso</th>
                            <th className="px-6 py-4 text-white">Actividad</th>
                            <th className="px-6 py-4 text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody className="divide-y divide-slate-100">
                        {loading ? (
                            <tr>
                                <td colSpan={4} className="px-6 py-12 text-center text-slate-500">
                                    Cargando usuarios...
                                </td>
                            </tr>
                        ) : filteredUsers.length === 0 ? (
                            <tr>
                                <td colSpan={4} className="px-6 py-12 text-center text-slate-500">
                                    No se encontraron usuarios.
                                </td>
                            </tr>
                        ) : (
                            filteredUsers.map((user) => {
                                const successRate = user.total_attempts > 0
                                    ? Math.round((user.correct_attempts / user.total_attempts) * 100)
                                    : 0

                                return (
                                    <tr key={user.user_id} className="hover:bg-slate-50 transition-colors">
                                        <td className="px-6 py-4">
                                            <div className="flex items-center gap-3">
                                                <Avatar className="w-10 h-10 border border-slate-200">
                                                    <AvatarImage src={user.avatar_url} />
                                                    <AvatarFallback>{user.full_name?.charAt(0) || user.email?.charAt(0)}</AvatarFallback>
                                                </Avatar>
                                                <div>
                                                    <p className="font-bold text-slate-900">{user.full_name || 'Sin Nombre'}</p>
                                                    <p className="text-xs text-slate-500">{user.email}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4">
                                            <div className="flex flex-col gap-1 max-w-[140px] mx-auto">
                                                <div className="flex justify-between text-xs font-medium text-slate-600">
                                                    <span>{successRate}% éxito</span>
                                                    <span>{user.correct_attempts}/{user.total_attempts}</span>
                                                </div>
                                                <div className="w-full h-2 bg-slate-100 rounded-full overflow-hidden">
                                                    <div
                                                        className={`h-full rounded-full ${successRate >= 70 ? 'bg-green-500' :
                                                                successRate >= 40 ? 'bg-yellow-500' : 'bg-red-500'
                                                            }`}
                                                        style={{ width: `${successRate}%` }}
                                                    />
                                                </div>
                                            </div>
                                        </td>
                                        <td className="px-6 py-4 text-slate-500 text-xs">
                                            <p><span className="font-semibold">Registro:</span> {formatDate(user.created_at)}</p>
                                            <p><span className="font-semibold">Último Acceso:</span> {formatDate(user.last_sign_in_at)}</p>
                                            <p><span className="font-semibold">Última Práctica:</span> {formatDate(user.last_activity)}</p>
                                        </td>
                                        <td className="px-6 py-4 text-right">
                                            <Button
                                                size="sm"
                                                variant="outline"
                                                className="text-red-600 hover:text-red-700 hover:bg-red-50 border-red-200"
                                                onClick={() => handleReset(user.user_id, user.full_name || user.email)}
                                            >
                                                <RotateCcw size={14} className="mr-2" />
                                                Resetear
                                            </Button>
                                        </td>
                                    </tr>
                                )
                            })
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    )
}
