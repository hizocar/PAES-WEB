"use client"

import { Crown } from "lucide-react"

type SubscriptionTier = 'free' | 'premium' | 'signature'

interface SubscriptionBadgeProps {
    tier?: SubscriptionTier | string
    className?: string
}

export function SubscriptionBadge({ tier = 'free', className = '' }: SubscriptionBadgeProps) {
    const normalizedTier = (typeof tier === 'string' ? tier.toLowerCase() : 'free') as SubscriptionTier

    if (normalizedTier === 'free') {
        return (
            <div className={`inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-600 border border-slate-200 ${className}`}>
                <span>FREE</span>
            </div>
        )
    }

    if (normalizedTier === 'premium') {
        return (
            <div className={`inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-gradient-to-r from-amber-200 to-yellow-400 text-yellow-900 border border-yellow-400/50 shadow-sm ${className}`}>
                <Crown size={12} className="fill-yellow-600 text-yellow-800" />
                <span>PREMIUM</span>
            </div>
        )
    }

    if (normalizedTier === 'signature') {
        return (
            <div className={`inline-flex items-center gap-1.5 px-2.5 py-0.5 rounded-full text-xs font-medium bg-gradient-to-r from-slate-900 to-slate-700 text-white border border-slate-700 shadow-sm ${className}`}>
                <Crown size={12} className="fill-purple-400 text-purple-200" />
                <span>SIGNATURE</span>
            </div>
        )
    }

    return null
}
