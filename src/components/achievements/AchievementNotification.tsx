"use client"

import { useEffect, useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { PartyPopper, CheckCircle2, TrendingUp, Flame, Zap, Award, Target, Footprints, GraduationCap, Crosshair } from "lucide-react"

// Map icon strings to components
const IconMap: Record<string, any> = {
    'Footprints': Footprints,
    'Flame': Flame,
    'Zap': Zap,
    'Crosshair': Crosshair,
    'GraduationCap': GraduationCap,
    'Award': Award
}

type Achievement = {
    id: string
    name: string
    description: string
    icon_name: string
}

export function AchievementNotification({ achievement, onClose }: { achievement: Achievement | null, onClose: () => void }) {
    useEffect(() => {
        if (achievement) {
            const timer = setTimeout(() => {
                onClose()
            }, 6000) // Show for 6 seconds
            return () => clearTimeout(timer)
        }
    }, [achievement, onClose])

    if (!achievement) return null

    const Icon = IconMap[achievement.icon_name] || Award

    return (
        <AnimatePresence>
            <motion.div
                initial={{ opacity: 0, y: 50, scale: 0.8 }}
                animate={{ opacity: 1, y: 0, scale: 1 }}
                exit={{ opacity: 0, y: -20, scale: 0.8 }}
                className="fixed bottom-8 left-1/2 transform -translate-x-1/2 z-50 flex flex-col items-center pointer-events-none"
            >
                <div className="relative pointer-events-auto">
                    {/* Confetti / Burst Effect Background */}
                    <div className="absolute inset-0 bg-yellow-400 rounded-full blur-xl opacity-20 animate-pulse"></div>

                    <div className="bg-slate-900 text-white p-6 rounded-2xl shadow-2xl border-2 border-yellow-500/50 flex flex-col items-center text-center gap-3 min-w-[300px]">
                        <div className="relative">
                            <div className="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center border-4 border-yellow-500 text-yellow-600 shadow-lg">
                                <Icon size={32} strokeWidth={2.5} />
                            </div>
                            <div className="absolute -top-2 -right-2 bg-red-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full uppercase tracking-wider shadow-sm animate-bounce">
                                ¡Nuevo!
                            </div>
                        </div>

                        <div>
                            <h3 className="text-yellow-400 font-bold text-lg uppercase tracking-wider mb-1">¡Logro Desbloqueado!</h3>
                            <h4 className="text-xl font-bold">{achievement.name}</h4>
                            <p className="text-slate-400 text-sm mt-1 leading-relaxed">
                                {achievement.description}
                            </p>
                        </div>
                    </div>
                </div>
            </motion.div>
        </AnimatePresence>
    )
}
