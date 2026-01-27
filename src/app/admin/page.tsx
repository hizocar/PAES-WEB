"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Users, FileQuestion, CreditCard, Loader2 } from "lucide-react"

export default function AdminDashboard() {
    const supabase = createClient()
    const [counts, setCounts] = useState({
        questions: 0,
        users: 0,
        subscriptions: 0
    })
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const fetchCounts = async () => {
            setLoading(true)

            // Fetch questions count
            const { count: questionsCount } = await supabase
                .from('questions')
                .select('*', { count: 'exact', head: true })

            // Fetch users count (profiles)
            const { count: usersCount } = await supabase
                .from('profiles')
                .select('*', { count: 'exact', head: true })

            // Fetch subscriptions count (active)
            const { count: subsCount } = await supabase
                .from('subscriptions')
                .select('*', { count: 'exact', head: true })
                .eq('status', 'active')

            setCounts({
                questions: questionsCount || 0,
                users: usersCount || 0,
                subscriptions: subsCount || 0
            })
            setLoading(false)
        }

        fetchCounts()
    }, [])

    return (
        <div className="space-y-8">
            <div>
                <h2 className="text-2xl font-bold text-slate-900">Dashboard</h2>
                <p className="text-slate-500">Resumen general de la plataforma</p>
            </div>

            <div className="grid md:grid-cols-3 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm border border-slate-200 relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-4 opacity-5">
                        <FileQuestion size={100} />
                    </div>
                    <div className="relative z-10 flex items-center justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">Total Preguntas</h3>
                            {loading ? (
                                <Loader2 className="h-8 w-8 animate-spin text-slate-300 mt-2" />
                            ) : (
                                <div className="text-4xl font-bold text-slate-900 mt-2">{counts.questions}</div>
                            )}
                        </div>
                        <div className="bg-blue-50 p-3 rounded-lg text-blue-600">
                            <FileQuestion size={24} />
                        </div>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm border border-slate-200 relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-4 opacity-5">
                        <Users size={100} />
                    </div>
                    <div className="relative z-10 flex items-center justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">Usuarios Registrados</h3>
                            {loading ? (
                                <Loader2 className="h-8 w-8 animate-spin text-slate-300 mt-2" />
                            ) : (
                                <div className="text-4xl font-bold text-slate-900 mt-2">{counts.users}</div>
                            )}
                        </div>
                        <div className="bg-green-50 p-3 rounded-lg text-green-600">
                            <Users size={24} />
                        </div>
                    </div>
                </div>

                <div className="bg-white p-6 rounded-xl shadow-sm border border-slate-200 relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-4 opacity-5">
                        <CreditCard size={100} />
                    </div>
                    <div className="relative z-10 flex items-center justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">Suscripciones Activas</h3>
                            {loading ? (
                                <Loader2 className="h-8 w-8 animate-spin text-slate-300 mt-2" />
                            ) : (
                                <div className="text-4xl font-bold text-slate-900 mt-2">{counts.subscriptions}</div>
                            )}
                        </div>
                        <div className="bg-purple-50 p-3 rounded-lg text-purple-600">
                            <CreditCard size={24} />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}
