"use client"

import { useEffect, useState } from "react"
import { motion } from "framer-motion"
import { Clock } from "lucide-react"

type QuestionTimerProps = {
    duration: number // in seconds
    onTimeout: () => void
    isActive: boolean
}

export function QuestionTimer({ duration, onTimeout, isActive }: QuestionTimerProps) {
    const [timeLeft, setTimeLeft] = useState(duration)

    // Trigger timeout when timeLeft reaches 0
    useEffect(() => {
        if (timeLeft === 0 && isActive) {
            onTimeout()
        }
    }, [timeLeft, isActive, onTimeout])

    // Timer Countdown
    useEffect(() => {
        if (!isActive) return

        const interval = setInterval(() => {
            setTimeLeft((prev) => {
                if (prev <= 0) {
                    clearInterval(interval)
                    return 0
                }
                return prev - 1
            })
        }, 1000)

        return () => clearInterval(interval)
    }, [isActive]) // Removed duration/onTimeout from deps to prevent resets/re-runs

    // Calculate percentage for progress bar
    const progress = (timeLeft / duration) * 100

    // Determine color
    let colorClass = "bg-green-500"
    if (progress <= 20) colorClass = "bg-red-500"
    else if (progress <= 50) colorClass = "bg-yellow-500"

    // Format time MM:SS
    const minutes = Math.floor(timeLeft / 60)
    const seconds = timeLeft % 60
    const formattedTime = `${minutes}:${seconds.toString().padStart(2, '0')}`

    return (
        <div className="w-full space-y-2">
            <div className="flex items-center justify-between text-sm font-bold text-slate-500 uppercase tracking-wider">
                <div className="flex items-center gap-2">
                    <Clock size={16} className={progress <= 20 ? "text-red-500 animate-pulse" : "text-slate-400"} />
                    <span className={progress <= 20 ? "text-red-500" : ""}>Tiempo Restante</span>
                </div>
                <span className={progress <= 20 ? "text-red-600 font-mono text-base" : "font-mono text-base"}>
                    {formattedTime}
                </span>
            </div>
            <div className="h-2 w-full bg-slate-100 rounded-full overflow-hidden">
                <motion.div
                    className={`h-full ${colorClass}`}
                    initial={{ width: "100%" }}
                    animate={{ width: `${progress}%` }}
                    transition={{ ease: "linear", duration: 1 }}
                />
            </div>
        </div>
    )
}
