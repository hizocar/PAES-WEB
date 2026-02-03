"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Loader2, Lock, Flame, Zap, Award, Footprints, GraduationCap, Crosshair, Sun, Moon, Calendar, Calculator, Shapes, PieChart, SquareFunction } from "lucide-react"
import { motion } from "framer-motion"
import { cn } from "@/lib/utils"

const IconMap: Record<string, any> = {
    'Footprints': Footprints,
    'Flame': Flame,
    'Zap': Zap,
    'Crosshair': Crosshair,
    'GraduationCap': GraduationCap,
    'Award': Award,
    'Sun': Sun,
    'Moon': Moon,
    'Calendar': Calendar,
    'Calculator': Calculator,
    'Shapes': Shapes,
    'PieChart': PieChart,
    'FunctionSquare': SquareFunction
}

type Achievement = {
    id: string
    code: string
    name: string
    description: string
    icon_name: string
    xp_reward: number
    unlocked_at?: string
}

import { useSubject } from "@/components/providers/SubjectContext"

export function AchievementsGrid() {
    const { subject } = useSubject()
    const [achievements, setAchievements] = useState<Achievement[]>([])
    const [loading, setLoading] = useState(true)
    const supabase = createClient()

    useEffect(() => {
        const fetchAchievements = async () => {
            setLoading(true)
            const { data: { user } } = await supabase.auth.getUser()
            if (!user) {
                setLoading(false)
                return
            }

            const { data: allAch } = await supabase.from('achievements').select('*').order('xp_reward', { ascending: true })

            const { data: unlocked } = await supabase.from('user_achievements')
                .select('achievement_id, unlocked_at')
                .eq('user_id', user.id)
                .eq('subject', subject)

            const unlockedMap = new Set(unlocked?.map(u => u.achievement_id))
            const merged = allAch?.map(a => ({
                ...a,
                unlocked_at: unlockedMap.has(a.id) ? (unlocked?.find(u => u.achievement_id === a.id)?.unlocked_at) : undefined
            })) || []

            setAchievements(merged)
            setLoading(false)
        }
        fetchAchievements()
    }, [subject])

    const getTierStyles = (xp: number, isUnlocked: boolean) => {
        if (!isUnlocked) return "bg-slate-50 border-slate-100 opacity-60 grayscale hover:opacity-100 hover:grayscale transition-all duration-300"

        if (xp >= 500) return "bg-gradient-to-br from-yellow-50 to-amber-100 border-amber-200 shadow-amber-100" // Gold/Legendary
        if (xp >= 200) return "bg-gradient-to-br from-slate-50 to-slate-200 border-slate-300 shadow-slate-100" // Silver
        return "bg-gradient-to-br from-orange-50 to-orange-100 border-orange-200 shadow-orange-100" // Bronze
    }

    const getIconStyles = (xp: number, isUnlocked: boolean) => {
        if (!isUnlocked) return "bg-slate-200 border-slate-300 text-slate-400"

        if (xp >= 500) return "bg-yellow-400 border-yellow-500 text-white shadow-lg shadow-yellow-200"
        if (xp >= 200) return "bg-slate-400 border-slate-500 text-white shadow-lg shadow-slate-200"
        return "bg-orange-400 border-orange-500 text-white shadow-lg shadow-orange-200"
    }

    if (loading) return (
        <div className="flex justify-center py-12">
            <Loader2 className="animate-spin text-blue-500 w-8 h-8" />
        </div>
    )

    return (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
            {achievements.map((ach) => {
                const isUnlocked = !!ach.unlocked_at
                const Icon = IconMap[ach.icon_name] || Award
                const tierClass = getTierStyles(ach.xp_reward, isUnlocked)
                const iconClass = getIconStyles(ach.xp_reward, isUnlocked)

                return (
                    <motion.div
                        key={ach.id}
                        initial={{ opacity: 0, y: 10 }}
                        animate={{ opacity: 1, y: 0 }}
                        whileHover={{ y: -4 }}
                        className={cn(
                            "relative p-5 rounded-2xl border flex flex-col items-center text-center gap-4 transition-all shadow-sm hover:shadow-lg",
                            tierClass
                        )}
                    >
                        <div className={cn(
                            "w-16 h-16 rounded-2xl flex items-center justify-center border-2 transform rotate-3 transition-transform group-hover:rotate-6",
                            iconClass
                        )}>
                            {isUnlocked ? <Icon size={32} strokeWidth={2.5} /> : <Lock size={24} />}
                        </div>

                        <div className="space-y-1">
                            <h4 className={cn(
                                "font-bold text-base leading-tight",
                                isUnlocked ? "text-slate-900" : "text-slate-500"
                            )}>
                                {ach.name}
                            </h4>
                            <p className="text-xs text-slate-500 leading-snug line-clamp-2">
                                {ach.description}
                            </p>
                        </div>

                        {isUnlocked && (
                            <div className="absolute top-3 right-3">
                                <span className="text-[10px] font-black bg-white/50 px-2 py-0.5 rounded-full text-slate-600 border border-black/5">
                                    +{ach.xp_reward} XP
                                </span>
                            </div>
                        )}
                    </motion.div>
                )
            })}
        </div>
    )
}
