"use client"

import { useEffect, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { Loader2, Lock, Flame, Zap, Award, Footprints, GraduationCap, Crosshair } from "lucide-react"
import { motion } from "framer-motion"

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
    code: string
    name: string
    description: string
    icon_name: string
    unlocked_at?: string // If present, it's unlocked
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

            // 1. Get all definitions
            const { data: allAch } = await supabase.from('achievements').select('*').order('xp_reward', { ascending: true })

            // 2. Get user unlocks (FILTERED BY SUBJECT)
            const { data: unlocked } = await supabase.from('user_achievements')
                .select('achievement_id, unlocked_at')
                .eq('user_id', user.id)
                .eq('subject', subject) // Essential filter

            // 3. Merge
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

    if (loading) return <Loader2 className="animate-spin text-slate-400" />

    return (
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
            {achievements.map((ach) => {
                const isUnlocked = !!ach.unlocked_at
                const Icon = IconMap[ach.icon_name] || Award

                return (
                    <motion.div
                        key={ach.id}
                        initial={{ opacity: 0, scale: 0.9 }}
                        animate={{ opacity: 1, scale: 1 }}
                        className={`relative p-4 rounded-xl border flex flex-col items-center text-center gap-3 transition-all
                            ${isUnlocked
                                ? 'bg-white border-yellow-200 shadow-sm hover:shadow-md hover:border-yellow-300'
                                : 'bg-slate-50 border-slate-100 opacity-70 grayscale hover:opacity-100 hover:grayscale-0'
                            }`}
                    >
                        <div className={`w-14 h-14 rounded-full flex items-center justify-center border-4 
                            ${isUnlocked
                                ? 'bg-yellow-50 border-yellow-400 text-yellow-600'
                                : 'bg-slate-200 border-slate-300 text-slate-400'
                            }`}>
                            {isUnlocked ? <Icon size={28} /> : <Lock size={20} />}
                        </div>

                        <div>
                            <h4 className={`font-bold text-sm ${isUnlocked ? 'text-slate-800' : 'text-slate-500'}`}>
                                {ach.name}
                            </h4>
                            <p className="text-xs text-slate-400 mt-1 line-clamp-2">
                                {ach.description}
                            </p>
                        </div>

                        {isUnlocked && (
                            <div className="absolute top-2 right-2 text-yellow-500">
                                <Award size={14} />
                            </div>
                        )}
                    </motion.div>
                )
            })}
        </div>
    )
}
