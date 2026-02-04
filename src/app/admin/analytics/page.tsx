"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, LineChart, Line, AreaChart, Area } from "recharts"
import { Loader2, Users, Activity } from "lucide-react"

export default function AdminAnalyticsPage() {
    const [data, setData] = useState<{ new_users: any[], active_users: any[] } | null>(null)
    const [loading, setLoading] = useState(true)
    const supabase = createClient()

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true)
            const { data, error } = await supabase.rpc('get_admin_analytics')

            if (error) {
                console.error("Error fetching analytics:", error)
            } else {
                setData(data)
            }
            setLoading(false)
        }

        fetchData()
    }, [])

    if (loading) {
        return (
            <div className="flex items-center justify-center h-[50vh]">
                <Loader2 className="h-8 w-8 animate-spin text-slate-300" />
            </div>
        )
    }

    if (!data) return <div>Error loading data</div>

    return (
        <div className="space-y-8 pb-20">
            <div>
                <h2 className="text-2xl font-bold text-slate-900">Analítica</h2>
                <p className="text-slate-500">Métricas de crecimiento y actividad de los últimos 30 días</p>
            </div>

            <div className="grid lg:grid-cols-2 gap-6">
                {/* Daily Active Users Chart */}
                <Card className="shadow-sm border-slate-200">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Activity className="text-blue-500" />
                            Usuarios Activos Diarios (DAU)
                        </CardTitle>
                        <CardDescription>
                            Usuarios únicos que realizaron al menos 1 ejercicio
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="h-[350px] w-full">
                            <ResponsiveContainer width="100%" height="100%">
                                <AreaChart data={data.active_users} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                                    <defs>
                                        <linearGradient id="colorActive" x1="0" y1="0" x2="0" y2="1">
                                            <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.1} />
                                            <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                                        </linearGradient>
                                    </defs>
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#f1f5f9" />
                                    <XAxis
                                        dataKey="date"
                                        fontSize={12}
                                        tickLine={false}
                                        axisLine={false}
                                        stroke="#94a3b8"
                                        minTickGap={30}
                                    />
                                    <YAxis
                                        fontSize={12}
                                        tickLine={false}
                                        axisLine={false}
                                        stroke="#94a3b8"
                                    />
                                    <Tooltip
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 10px 15px -3px rgb(0 0 0 / 0.1)' }}
                                    />
                                    <Area
                                        type="monotone"
                                        dataKey="count"
                                        stroke="#3b82f6"
                                        strokeWidth={3}
                                        fillOpacity={1}
                                        fill="url(#colorActive)"
                                        name="Usuarios Activos"
                                    />
                                </AreaChart>
                            </ResponsiveContainer>
                        </div>
                    </CardContent>
                </Card>

                {/* New Users Chart */}
                <Card className="shadow-sm border-slate-200">
                    <CardHeader>
                        <CardTitle className="flex items-center gap-2">
                            <Users className="text-green-500" />
                            Nuevos Usuarios
                        </CardTitle>
                        <CardDescription>
                            Registros diarios en la plataforma
                        </CardDescription>
                    </CardHeader>
                    <CardContent>
                        <div className="h-[350px] w-full">
                            <ResponsiveContainer width="100%" height="100%">
                                <BarChart data={data.new_users} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
                                    <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#f1f5f9" />
                                    <XAxis
                                        dataKey="date"
                                        fontSize={12}
                                        tickLine={false}
                                        axisLine={false}
                                        stroke="#94a3b8"
                                        minTickGap={30}
                                    />
                                    <YAxis
                                        fontSize={12}
                                        tickLine={false}
                                        axisLine={false}
                                        stroke="#94a3b8"
                                        allowDecimals={false}
                                    />
                                    <Tooltip
                                        contentStyle={{ borderRadius: '12px', border: 'none', boxShadow: '0 10px 15px -3px rgb(0 0 0 / 0.1)' }}
                                        cursor={{ fill: '#f1f5f9' }}
                                    />
                                    <Bar
                                        dataKey="count"
                                        fill="#22c55e"
                                        radius={[4, 4, 0, 0]}
                                        name="Nuevos Usuarios"
                                        barSize={20}
                                    />
                                </BarChart>
                            </ResponsiveContainer>
                        </div>
                    </CardContent>
                </Card>
            </div>
        </div>
    )
}
