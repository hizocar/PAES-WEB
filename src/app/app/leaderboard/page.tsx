"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Trophy, Medal, Crown } from "lucide-react"

type LeaderboardUser = {
    user_id: string
    full_name: string
    avatar_url: string
    score: number
    rank: number
}

import { useSubject } from "@/components/providers/SubjectContext"

export default function LeaderboardPage() {
    const { subject } = useSubject()
    const [users, setUsers] = useState<LeaderboardUser[]>([])
    const [currentUser, setCurrentUser] = useState<string | null>(null)
    const [loading, setLoading] = useState(true)

    const supabase = createClient()

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true)
            const { data: { user } } = await supabase.auth.getUser()
            if (user) setCurrentUser(user.id)

            const { data, error } = await supabase.rpc('get_leaderboard', { p_subject: subject })
            if (error) {
                console.error("Error fetching leaderboard:", error)
            } else {
                setUsers(data || [])
            }
            setLoading(false)
        }
        fetchData()
    }, [subject])

    if (loading) {
        return (
            <div className="flex h-screen items-center justify-center">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-yellow-500"></div>
            </div>
        )
    }

    const top3 = users.slice(0, 3)
    const rest = users.slice(3)

    return (
        <div className="min-h-screen bg-slate-50 pb-20">
            {/* Header */}
            <div className="bg-white border-b border-slate-200 p-6 shadow-sm sticky top-0 z-10">
                <div className="max-w-2xl mx-auto flex items-center justify-between">
                    <h1 className="text-2xl font-bold text-slate-900 flex items-center gap-2">
                        <Trophy className="text-yellow-500" /> Ranking
                    </h1>
                </div>
            </div>

            <div className="max-w-2xl mx-auto p-4 space-y-8 mt-6">

                {/* Podium */}
                {top3.length > 0 && (
                    <div className="flex items-end justify-center gap-4 mb-12 min-h-[260px]">
                        {/* 2nd Place */}
                        {top3[1] && (
                            <div className="flex flex-col items-center">
                                <div className="mb-2 relative">
                                    <Avatar className="w-20 h-20 border-4 border-slate-300 shadow-lg">
                                        <AvatarImage src={top3[1].avatar_url} />
                                        <AvatarFallback className="text-xl bg-slate-200">{top3[1].full_name?.charAt(0)}</AvatarFallback>
                                    </Avatar>
                                    <div className="absolute -bottom-3 left-1/2 -translate-x-1/2 bg-slate-400 text-white text-xs font-bold px-2 py-0.5 rounded-full shadow-sm">
                                        #2
                                    </div>
                                </div>
                                <div className="text-center mb-2">
                                    <div className="font-bold text-slate-700 text-sm truncate w-24">{top3[1].full_name?.split(' ')[0]}</div>
                                    <div className="text-slate-500 text-xs font-mono">{top3[1].score} pts</div>
                                </div>
                                <div className="w-24 bg-slate-300 rounded-t-lg h-32 shadow-inner flex items-end justify-center pb-4 opacity-90">
                                    <span className="text-4xl font-black text-slate-400/50">2</span>
                                </div>
                            </div>
                        )}

                        {/* 1st Place */}
                        {top3[0] && (
                            <div className="flex flex-col items-center z-10 -mx-2">
                                <div className="mb-4 relative">
                                    <Crown className="absolute -top-10 left-1/2 -translate-x-1/2 text-yellow-500 fill-yellow-500 animate-bounce" size={40} />
                                    <Avatar className="w-28 h-28 border-4 border-yellow-400 shadow-xl ring-4 ring-yellow-100">
                                        <AvatarImage src={top3[0].avatar_url} />
                                        <AvatarFallback className="text-3xl bg-yellow-100 text-yellow-700">{top3[0].full_name?.charAt(0)}</AvatarFallback>
                                    </Avatar>
                                    <div className="absolute -bottom-4 left-1/2 -translate-x-1/2 bg-yellow-500 text-white text-sm font-bold px-3 py-1 rounded-full shadow-md">
                                        #1
                                    </div>
                                </div>
                                <div className="text-center mb-2">
                                    <div className="font-bold text-slate-900 text-lg truncate w-32">{top3[0].full_name?.split(' ')[0]}</div>
                                    <div className="text-yellow-600 font-bold text-sm bg-yellow-50 px-2 rounded-full">{top3[0].score} pts</div>
                                </div>
                                <div className="w-32 bg-yellow-400 rounded-t-xl h-44 shadow-lg flex items-end justify-center pb-4 relative overflow-hidden">
                                    <div className="absolute inset-0 bg-yellow-300/30 bg-[url('/noise.png')]"></div>
                                    <span className="text-6xl font-black text-yellow-600/30 relative">1</span>
                                </div>
                            </div>
                        )}

                        {/* 3rd Place */}
                        {top3[2] && (
                            <div className="flex flex-col items-center">
                                <div className="mb-2 relative">
                                    <Avatar className="w-20 h-20 border-4 border-orange-300 shadow-lg">
                                        <AvatarImage src={top3[2].avatar_url} />
                                        <AvatarFallback className="text-xl bg-orange-100 text-orange-700">{top3[2].full_name?.charAt(0)}</AvatarFallback>
                                    </Avatar>
                                    <div className="absolute -bottom-3 left-1/2 -translate-x-1/2 bg-orange-400 text-white text-xs font-bold px-2 py-0.5 rounded-full shadow-sm">
                                        #3
                                    </div>
                                </div>
                                <div className="text-center mb-2">
                                    <div className="font-bold text-slate-700 text-sm truncate w-24">{top3[2].full_name?.split(' ')[0]}</div>
                                    <div className="text-slate-500 text-xs font-mono">{top3[2].score} pts</div>
                                </div>
                                <div className="w-24 bg-orange-300 rounded-t-lg h-24 shadow-inner flex items-end justify-center pb-4 opacity-90">
                                    <span className="text-4xl font-black text-orange-800/20">3</span>
                                </div>
                            </div>
                        )}
                    </div>
                )}

                {/* List */}
                <div className="space-y-3">
                    {rest.map((user) => (
                        <div
                            key={user.user_id}
                            className={`flex items-center gap-4 p-4 rounded-xl border transition-all hover:scale-[1.01] ${user.user_id === currentUser
                                ? 'bg-blue-50 border-blue-200 ring-1 ring-blue-200 shadow-sm'
                                : 'bg-white border-slate-100 shadow-sm hover:shadow-md'
                                }`}
                        >
                            <div className="w-8 font-bold text-slate-400 text-center font-mono">
                                {user.rank}
                            </div>
                            <Avatar className="w-12 h-12 border border-slate-100">
                                <AvatarImage src={user.avatar_url} />
                                <AvatarFallback>{user.full_name?.charAt(0)}</AvatarFallback>
                            </Avatar>
                            <div className="flex-1">
                                <p className={`font-bold ${user.user_id === currentUser ? 'text-blue-700' : 'text-slate-700'}`}>
                                    {user.full_name}
                                </p>
                                {user.user_id === currentUser && (
                                    <span className="text-[10px] uppercase font-bold tracking-wider text-blue-400">Tú</span>
                                )}
                            </div>
                            <div className="font-bold text-slate-900 bg-slate-50 px-3 py-1 rounded-lg border border-slate-100 font-mono">
                                {user.score} pts
                            </div>
                        </div>
                    ))}

                    {users.length === 0 && (
                        <div className="text-center py-12 text-slate-500">
                            Aún no hay competidores. ¡Sé el primero!
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}
