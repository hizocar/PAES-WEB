"use client"

import { AchievementsGrid } from "@/components/achievements/AchievementsGrid"

export default function AchievementsPage() {
    return (
        <div className="p-6 max-w-7xl mx-auto space-y-8">
            <div className="space-y-2">
                <h1 className="text-3xl font-bold text-slate-900">Tus Logros 🏆</h1>
                <p className="text-slate-500">Colecciona medallas completando desafíos y manteniendo tu racha.</p>
            </div>

            <div className="bg-white p-8 rounded-2xl shadow-sm border border-slate-100">
                <AchievementsGrid />
            </div>
        </div>
    )
}
