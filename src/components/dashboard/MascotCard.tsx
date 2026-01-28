"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import Image from "next/image"
import { Heart, Clock } from "lucide-react"

export function MascotCard() {
    const [lives, setLives] = useState<number | null>(null)
    const [replenishAt, setReplenishAt] = useState<string | null>(null)
    const [timeLeft, setTimeLeft] = useState<string>("")
    const [loading, setLoading] = useState(true)

    const supabase = createClient()

    useEffect(() => {
        const fetchLives = async () => {
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) return

            const { data } = await supabase.rpc('check_and_replenish_lives', { p_user_id: user.id })

            if (data && data.length > 0) {
                setLives(data[0].current_lives)
                setReplenishAt(data[0].replenish_at)
            }
            setLoading(false)
        }
        fetchLives()
    }, [])

    useEffect(() => {
        if (lives === null || (lives > 0) || !replenishAt) return

        const updateTimer = () => {
            const now = new Date()
            const end = new Date(replenishAt)
            const diff = end.getTime() - now.getTime()

            if (diff <= 0) {
                setTimeLeft("00:00:00")
                return
            }

            const hrs = Math.floor(diff / (1000 * 60 * 60))
            const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))
            const secs = Math.floor((diff % (1000 * 60)) / 1000)

            setTimeLeft(
                `${hrs.toString().padStart(2, '0')}:${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`
            )
        }

        updateTimer()
        const interval = setInterval(updateTimer, 1000)
        return () => clearInterval(interval)
    }, [lives, replenishAt])

    const isSad = lives === 0

    if (loading || lives === null) {
        return (
            <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 flex items-center justify-between h-56 animate-pulse">
                <div className="w-2/3 h-full flex flex-col justify-between">
                    <div className="h-6 w-20 bg-slate-200 rounded"></div>
                    <div className="h-10 w-32 bg-slate-200 rounded mt-2"></div>
                    <div className="h-12 w-full bg-slate-200 rounded mt-4"></div>
                </div>
            </div>
        )
    }

    return (
        <div className={`
            bg-white p-6 rounded-2xl shadow-sm border border-slate-100 flex items-center justify-between overflow-hidden relative h-56
            ${isSad ? 'bg-slate-50' : 'bg-gradient-to-br from-white to-blue-50'}
        `}>
            {/* Content Left */}
            <div className="z-10 flex flex-col justify-between h-full w-2/3 pr-2">
                <div>
                    <h3 className="text-slate-500 font-semibold text-lg">Vidas</h3>
                    {lives > 0 ? (
                        <div className="text-4xl font-bold text-slate-900 mt-1 flex items-center gap-2">
                            {lives} <Heart className="text-red-500 fill-red-500 animate-pulse" size={28} />
                        </div>
                    ) : (
                        <div className="text-2xl font-bold text-slate-800 mt-1 font-mono flex items-center gap-2">
                            <Clock size={20} className="text-red-500" />
                            <span className="text-xl">{timeLeft}</span>
                        </div>
                    )}
                </div>

                <div className="bg-white/90 p-3 rounded-lg border border-slate-100 backdrop-blur-sm shadow-sm">
                    <p className="text-sm font-medium text-slate-600 italic leading-snug">
                        "{isSad
                            ? "¡Oh no! Me quedé sin energía."
                            : lives <= 3
                                ? "¡Cuidado! Pocas oportunidades."
                                : "¡Vamos con todo!"}"
                    </p>
                </div>
            </div>

            {/* Mascot Image Right */}
            <div className="absolute -right-4 -bottom-4 w-40 h-40">
                <Image
                    src={isSad ? "/mascot/sad.png" : "/mascot/happy.png"}
                    alt="Mascota Colo Colo"
                    width={160}
                    height={160}
                    className="object-contain w-full h-full drop-shadow-lg"
                    priority
                />
            </div>
        </div>
    )
}
