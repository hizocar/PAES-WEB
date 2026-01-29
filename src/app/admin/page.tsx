"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Users, FileQuestion, CreditCard, Loader2 } from "lucide-react"

export default function AdminDashboard() {
    const supabase = createClient()
    const [subject, setSubject] = useState<'m1' | 'm2'>('m2')
    const [counts, setCounts] = useState({
        questions: 0,
        users: 0,
        subscriptions: 0
    })
    const [loading, setLoading] = useState(true)

    useEffect(() => {
        const fetchCounts = async () => {
            setLoading(true)

            // Call the new Subject-Aware RPC
            const { data, error } = await supabase.rpc('get_admin_dashboard_stats', {
                p_subject: subject
            })

            if (data) {
                setCounts({
                    questions: data.total_questions || 0,
                    users: data.active_users || 0,
                    subscriptions: data.active_subscriptions || 0
                })
            }

            setLoading(false)
        }

        fetchCounts()
    }, [subject])

    return (
        <div className="space-y-8">
            <div className="flex items-center justify-between">
                <div>
                    <h2 className="text-2xl font-bold text-slate-900">Dashboard</h2>
                    <p className="text-slate-500">Resumen general de la plataforma</p>
                </div>

                {/* Admin Subject Switcher */}
                <div className="bg-slate-100 p-1 rounded-lg flex items-center gap-1">
                    <button
                        onClick={() => setSubject('m1')}
                        className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm1'
                                ? 'bg-white text-slate-900 shadow-sm'
                                : 'text-slate-500 hover:text-slate-700'
                            }`}
                    >
                        M1 Matemática
                    </button>
                    <button
                        onClick={() => setSubject('m2')}
                        className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm2'
                                ? 'bg-white text-slate-900 shadow-sm'
                                : 'text-slate-500 hover:text-slate-700'
                            }`}
                    >
                        M2 Matemática
                    </button>
                </div>
            </div>

            <div className="grid md:grid-cols-3 gap-6">
                <div className="bg-white p-6 rounded-xl shadow-sm border border-slate-200 relative overflow-hidden">
                    <div className="absolute top-0 right-0 p-4 opacity-5">
                        <FileQuestion size={100} />
                    </div>
                    <div className="relative z-10 flex items-center justify-between">
                        <div>
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">
                                Preguntas {subject.toUpperCase()}
                            </h3>
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
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">
                                Usuarios Activos {subject.toUpperCase()}
                            </h3>
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
                            <h3 className="text-slate-500 font-medium text-sm uppercase tracking-wide">
                                Subs. Activas {subject.toUpperCase()}
                            </h3>
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
