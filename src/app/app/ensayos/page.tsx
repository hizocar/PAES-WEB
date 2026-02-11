"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { useRouter } from "next/navigation"
import { Loader2, Play, LayoutGrid, Clock, Trophy, History } from "lucide-react"
import Link from "next/link"

export default function EnsayosDashboard() {
    const [loading, setLoading] = useState(true)
    const [creating, setCreating] = useState(false)
    const [ensayos, setEnsayos] = useState<any[]>([])
    const supabase = createClient()
    const router = useRouter()

    useEffect(() => {
        const fetchEnsayos = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            const { data } = await supabase
                .from('ensayos')
                .select('*')
                .eq('user_id', user.id)
                .order('started_at', { ascending: false })

            if (data) setEnsayos(data)
            setLoading(false)
        }
        fetchEnsayos()
    }, [])

    const handleStartEnsayo = async () => {
        setCreating(true)
        try {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            // Call RPC to create ensayo and get ID
            const { data, error } = await supabase.rpc('create_ensayo_m1', { p_user_id: user.id })

            if (error) throw error

            // Redirect to the new ensayo
            const ensayoId = (data as any).ensayo_id
            router.push(`/app/ensayos/${ensayoId}`)
        } catch (e) {
            console.error("Error creating ensayo:", e)
            setCreating(false)
        }
    }

    if (loading) {
        return <div className="flex h-96 items-center justify-center"><Loader2 className="animate-spin text-blue-600" /></div>
    }

    const lastEnsayo = ensayos[0]
    const history = ensayos.slice(0) // All essays

    return (
        <div className="max-w-5xl mx-auto p-6 space-y-8">
            <header className="mb-8">
                <h1 className="text-3xl font-black text-slate-900">Ensayos M1</h1>
                <p className="text-slate-500 text-lg">Simula la experiencia real de la PAES. 60 preguntas, 2 horas 20 minutos.</p>
            </header>

            {/* Smart Start Card */}
            <div className="bg-gradient-to-br from-blue-600 to-indigo-700 rounded-3xl p-8 md:p-10 text-white shadow-xl relative overflow-hidden group">
                <div className="absolute top-0 right-0 w-64 h-64 bg-white/10 rounded-full blur-3xl -translate-y-12 translate-x-12 opacity-50" />

                <div className="relative z-10 flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
                    <div className="space-y-4 max-w-xl">
                        <div className="flex items-center gap-2 bg-blue-500/30 w-fit px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider border border-white/20">
                            <Clock size={12} />
                            2h 20m Duración
                        </div>
                        <h2 className="text-3xl font-bold">Nuevo Ensayo Completo</h2>
                        <p className="text-blue-100 text-lg leading-relaxed">
                            Ponte a prueba con 60 preguntas seleccionadas aleatoriamente (15 por eje) y obtén tu puntaje en escala PAES real (100-1000).
                        </p>
                        <div className="flex items-center gap-6 pt-2 text-sm font-medium text-blue-200">
                            <span className="flex items-center gap-2"><LayoutGrid size={16} /> 60 Preguntas</span>
                            <span className="flex items-center gap-2"><Trophy size={16} /> Escala Real</span>
                        </div>
                    </div>

                    <Button
                        size="lg"
                        onClick={handleStartEnsayo}
                        disabled={creating}
                        className="h-16 px-8 text-xl font-bold bg-white text-blue-600 hover:bg-blue-50 hover:scale-105 transition-all shadow-lg shrink-0"
                    >
                        {creating ? <Loader2 className="animate-spin mr-2" /> : <Play className="mr-2 fill-current" />}
                        {creating ? "Generando..." : "Comenzar Ensayo"}
                    </Button>
                </div>
            </div>

            {/* History Section */}
            <div className="space-y-4">
                <div className="flex items-center gap-2 text-slate-900 font-bold text-xl">
                    <History className="text-slate-400" />
                    Historial de Ensayos
                </div>

                {history.length === 0 ? (
                    <div className="text-center py-12 bg-slate-50 rounded-2xl border border-dashed border-slate-200">
                        <p className="text-slate-400">Aún no has realizado ningún ensayo. ¡Es hora de empezar!</p>
                    </div>
                ) : (
                    <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                        {history.map((ensayo) => (
                            <Link href={ensayo.status === 'completed' ? `/app/ensayos/${ensayo.id}/results` : `/app/ensayos/${ensayo.id}`} key={ensayo.id}>
                                <div className="bg-white p-5 rounded-xl border border-slate-100 shadow-sm hover:shadow-md hover:border-blue-200 transition-all flex items-center justify-between group">
                                    <div className="space-y-1">
                                        <div className="flex items-center gap-2">
                                            <span className={`w-2.5 h-2.5 rounded-full ${ensayo.status === 'completed' ? 'bg-green-500' : 'bg-orange-500'}`} />
                                            <span className="font-bold text-slate-800">
                                                {new Date(ensayo.started_at).toLocaleDateString('es-CL', { day: 'numeric', month: 'long', hour: '2-digit', minute: '2-digit' })}
                                            </span>
                                        </div>
                                        <div className="text-sm text-slate-500 pl-4">
                                            {ensayo.status === 'completed'
                                                ? `Finalizado • ${ensayo.score} Puntos`
                                                : "En Progreso • Continuar..."}
                                        </div>
                                    </div>
                                    <div className="w-10 h-10 rounded-lg bg-slate-50 flex items-center justify-center text-slate-400 group-hover:bg-blue-50 group-hover:text-blue-600 transition-colors">
                                        {ensayo.status === 'completed' ? <Trophy size={20} /> : <Play size={20} className="ml-1" />}
                                    </div>
                                </div>
                            </Link>
                        ))}
                    </div>
                )}
            </div>
        </div>
    )
}
