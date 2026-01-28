import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { BarChart3, Clock, Home, LogOut, Settings, Trophy } from 'lucide-react'
import { StudyTrackerProvider } from '@/context/study-tracker'
import { UserProfile } from '@/components/ui/user-profile'
import { MobileNav } from '@/components/mobile-nav'

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
    const userWithProfile = {
        ...user,
        user_metadata: {
            ...user.user_metadata,
            full_name: profile?.full_name || user.user_metadata.full_name,
            avatar_url: profile?.avatar_url || user.user_metadata.avatar_url
        }
    }

    return (
        <div className="flex h-screen bg-slate-50 flex-col md:flex-row">
            {/* Mobile Navigation */}
            <MobileNav user={userWithProfile} />

            {/* Sidebar (Desktop) */}
            <aside className="w-64 bg-white border-r border-slate-200 hidden md:flex flex-col">
                <div className="p-6 border-b border-slate-100">
                    <Link href="/app" className="font-bold text-xl text-blue-600 flex items-center gap-2 hover:opacity-80 transition-opacity">
                        PAES Lab
                    </Link>
                </div>

                <nav className="flex-1 p-4 space-y-1 overflow-y-auto">
                    <Link href="/app">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <Home size={18} />
                            Inicio
                        </Button>
                    </Link>
                    <Link href="/app/practice">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-10 text-sm font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <div className="relative">
                                <span className="absolute -top-0.5 -right-0.5 w-2 h-2 bg-red-400 rounded-full animate-pulse shadow-sm" />
                                <Clock size={18} />
                            </div>
                            Practicar
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
                </nav>

                <div className="p-4 border-t border-slate-100 space-y-2">
                    <UserProfile user={userWithProfile} />

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
            <main className="flex-1 overflow-y-auto">
                <StudyTrackerProvider>
                    {children}
                </StudyTrackerProvider>
            </main>
        </div>
    )
}
