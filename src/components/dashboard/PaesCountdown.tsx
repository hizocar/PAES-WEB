"use client"

import { useEffect, useState } from "react"
import { motion } from "framer-motion"
import { Clock } from "lucide-react"

export function PaesCountdown() {
    const calculateTimeLeft = () => {
        const targetDate = new Date("2026-06-15T08:00:00").getTime()
        const now = new Date().getTime()
        const difference = targetDate - now

        if (difference > 0) {
            return {
                days: Math.floor(difference / (1000 * 60 * 60 * 24)),
                hours: Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
                minutes: Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60)),
                seconds: Math.floor((difference % (1000 * 60)) / 1000)
            }
        }
        return { days: 0, hours: 0, minutes: 0, seconds: 0 }
    }

    const [timeLeft, setTimeLeft] = useState(calculateTimeLeft())

    useEffect(() => {
        const interval = setInterval(() => {
            setTimeLeft(calculateTimeLeft())
        }, 1000)

        return () => clearInterval(interval)
    }, [])

    const TimeBlock = ({ value, label, color }: { value: number, label: string, color: string }) => (
        <div className="flex flex-col items-center">
            <div className={`
                relative bg-white/90 backdrop-blur-sm rounded-lg p-2 min-w-[3rem] sm:min-w-[3.5rem] h-10 sm:h-12 
                flex items-center justify-center shadow-lg border-b-4 
                ${color}
            `}>
                <span suppressHydrationWarning className="text-xl sm:text-2xl font-black text-slate-800 font-mono tracking-tight">
                    {value.toString().padStart(2, '0')}
                </span>
            </div>
            <span className="text-[10px] font-bold text-slate-500 uppercase mt-1 tracking-wider">{label}</span>
        </div>
    )

    return (
        <motion.div
            initial={{ opacity: 0, y: -10 }}
            animate={{ opacity: 1, y: 0 }}
            className="flex flex-col items-center md:items-start space-y-3 bg-white/50 p-4 rounded-2xl border border-white/60 backdrop-blur-md shadow-sm"
        >
            <div className="flex items-center gap-2 text-indigo-900 font-bold text-sm bg-indigo-100/50 px-3 py-1 rounded-full w-fit">
                <Clock size={14} className="text-indigo-600" />
                <span>PAES Invierno 2026</span>
            </div>

            <div className="flex gap-2 sm:gap-3">
                <TimeBlock value={timeLeft.days} label="Días" color="border-blue-400/30" />
                <span className="text-2xl font-black text-slate-300 -translate-y-2">:</span>
                <TimeBlock value={timeLeft.hours} label="Hrs" color="border-indigo-400/30" />
                <span className="text-2xl font-black text-slate-300 -translate-y-2">:</span>
                <TimeBlock value={timeLeft.minutes} label="Min" color="border-purple-400/30" />
                <span className="text-2xl font-black text-slate-300 -translate-y-2">:</span>
                <TimeBlock value={timeLeft.seconds} label="Seg" color="border-pink-400/30" />
            </div>
        </motion.div>
    )
}
