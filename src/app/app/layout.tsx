import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { BarChart3, Clock, Home, LogOut, Settings, Trophy, RotateCcw, Award } from 'lucide-react'
import { StudyTrackerProvider } from '@/context/study-tracker'
import { UserProfile } from '@/components/ui/user-profile'
import { MobileNav } from '@/components/mobile-nav'

import { SubjectProvider } from '@/components/providers/SubjectContext'
import { SubjectSwitcher } from '@/components/SubjectSwitcher'
import { SubscriptionBadge } from '@/components/subscription-badge'


export default async function AppLayout({
    children,
}: {
    children: React.ReactNode
}) {
    const supabase = createClient()
    const { data: { user }, error } = await (await supabase).auth.getUser()

    if (error || !user) {
        redirect('/login')
    }

    // Get user profile
    const { data: profile } = await (await supabase)
        .from('profiles')
        .select('*')
        .eq('id', user.id)
        .single()

    // Combine for display
    // Combine for display
    const userWithProfile = {
        ...user,
        user_metadata: {
            ...user.user_metadata,
            full_name: profile?.full_name || user.user_metadata.full_name,
            avatar_url: profile?.avatar_url || user.user_metadata.avatar_url
        },
        subscription_tier: (profile as any)?.subscription_tier || 'free'
    }

    return (
        <SubjectProvider>
            <div className="flex flex-col md:flex-row min-h-[100dvh] md:h-screen bg-slate-50 md:overflow-hidden">
                {/* Mobile Navigation */}
                <MobileNav user={userWithProfile} />

                {/* Sidebar (Desktop) */}
                <aside className="w-64 bg-white border-r border-slate-200 hidden md:flex flex-col">
                    <div className="p-6 border-b border-slate-100">
                        <Link href="/app" className="font-bold text-xl text-blue-600 flex items-center gap-2 hover:opacity-80 transition-opacity">
                            PAES Lab
                        </Link>
                    </div>

                    <div className="pt-4" id="tour-switcher">
                        <SubjectSwitcher />
                    </div>

                    <nav className="flex-1 px-4 pb-4 space-y-1 overflow-y-auto">
                        <Link href="/app">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                                <Home size={18} />
                                Inicio
                            </Button>
                        </Link>
                        <Link href="/app/practice" id="tour-practice">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                                <div className="relative">
                                    <span className="absolute -top-0.5 -right-0.5 w-2 h-2 bg-red-400 rounded-full animate-pulse shadow-sm" />
                                    <Clock size={18} />
                                </div>
                                Practicar
                            </Button>
                        </Link>
                        <Link href="/app/practice?mode=retry" id="tour-mistakes">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-orange-600 hover:bg-orange-50">
                                <RotateCcw size={18} />
                                Modo Repaso
                            </Button>
                        </Link>
                        <Link href="/app/progress">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                                <BarChart3 size={18} />
                                Mi Progreso
                            </Button>
                        </Link>
                        <Link href="/app/leaderboard">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                                <Trophy size={18} />
                                Ranking
                            </Button>
                        </Link>
                        <Link href="/app/achievements">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-yellow-600 hover:bg-yellow-50">
                                <Award size={18} />
                                Logros
                            </Button>
                        </Link>
                    </nav>

                    <div className="mt-auto p-3 border-t border-slate-100 bg-slate-50/50 flex flex-col gap-1.5">
                        <div className="bg-white p-3 rounded-xl border border-slate-100 shadow-sm flex flex-col gap-2 mb-1" id="tour-profile">
                            <UserProfile user={userWithProfile} />
                            <div className="flex items-center justify-between px-1 pt-1.5 border-t border-slate-50">
                                <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Estado</span>
                                <Link href="/app/pricing" className="hover:opacity-80 transition-opacity">
                                    <SubscriptionBadge tier={userWithProfile?.subscription_tier} />
                                </Link>
                            </div>
                        </div>

                        <Link href="/app/settings">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-500 hover:text-blue-600 hover:bg-blue-50">
                                <Settings size={18} />
                                Configuración
                            </Button>
                        </Link>
                        <form action="/auth/signout" method="post">
                            <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-red-500 hover:text-red-600 hover:bg-red-50">
                                <LogOut size={18} />
                                Cerrar sesión
                            </Button>
                        </form>
                    </div>
                </aside>

                {/* Main Content */}
                <main className="flex-1 md:overflow-y-auto">
                    <StudyTrackerProvider>
                        {children}
                    </StudyTrackerProvider>
                </main>
            </div >
        </SubjectProvider >
    )
}
