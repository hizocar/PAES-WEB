"use client"

import { useEffect, useState } from "react"
import { Heart, Clock, Zap } from "lucide-react"
import { cn } from "@/lib/utils"

type LivesCounterProps = {
    lives: number
    replenishAt: string | null // ISO string
    tier?: string
}

export function LivesCounter({ lives, replenishAt, tier = 'free' }: LivesCounterProps) {
    const [timeLeft, setTimeLeft] = useState<string>("")

    useEffect(() => {
        if (tier !== 'free' || lives > 0 || !replenishAt) return

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
    }, [lives, replenishAt, tier])

    if (tier !== 'free') {
        return (
            <div className="flex items-center gap-1.5 bg-amber-50 text-amber-600 px-3 py-1.5 rounded-full border border-amber-100 shadow-sm">
                <Zap size={18} className="fill-amber-500 text-amber-500" />
                <span className="text-lg font-black tracking-tighter">∞</span>
            </div>
        )
    }

    if (lives === 0 && replenishAt) {
        return (
            <div className="flex items-center gap-2 bg-slate-900 text-white px-4 py-2 rounded-full font-mono text-sm font-bold shadow-lg animate-pulse">
                <Clock size={16} className="text-red-400" />
                <span>{timeLeft}</span>
            </div>
        )
    }

    return (
        <div className="flex items-center gap-1">
            <Heart
                size={28}
                className={cn(
                    "transition-all duration-300",
                    lives <= 3 ? "text-red-500 fill-red-500 animate-pulse" : "text-red-500 fill-red-500"
                )}
            />
            <span className={cn(
                "text-xl font-bold transition-colors",
                lives <= 3 ? "text-red-600" : "text-slate-700"
            )}>
                {lives}
            </span>
        </div>
    )
}
