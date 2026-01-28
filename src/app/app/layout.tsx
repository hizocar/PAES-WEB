import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { BarChart3, Clock, Home, LogOut, Settings, Trophy } from 'lucide-react'
import { StudyTrackerProvider } from '@/context/study-tracker'
import { UserProfile } from '@/components/ui/user-profile'

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
        <div className="flex h-screen bg-slate-50">
            {/* Sidebar */}
            <aside className="w-72 bg-white border-r border-slate-200 hidden md:flex flex-col">
                <div className="p-8 border-b border-slate-100">
                    <div className="font-bold text-2xl text-blue-600 flex items-center gap-3">
                        <div className="w-10 h-10 bg-blue-600 rounded-xl flex items-center justify-center shadow-lg shadow-blue-200">
                            <span className="text-white text-xl">M2</span>
                        </div>
                        PAES
                    </div>
                </div>

                <nav className="flex-1 p-6 space-y-3 overflow-y-auto">
                    <Link href="/app">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-16 text-xl font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <Home size={28} />
                            Inicio
                        </Button>
                    </Link>
                    <Link href="/app/practice">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-16 text-xl font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <div className="relative">
                                <span className="absolute -top-1 -right-1 w-3 h-3 bg-red-400 rounded-full animate-pulse shadow-sm" />
                                <Clock size={28} />
                            </div>
                            Practicar
                        </Button>
                    </Link>
                    <Link href="/app/progress">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-16 text-xl font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <BarChart3 size={28} />
                            Mi Progreso
                        </Button>
                    </Link>
                    <Link href="/app/leaderboard">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-16 text-xl font-medium text-slate-600 hover:text-blue-600 hover:bg-blue-50">
                            <Trophy size={28} />
                            Ranking
                        </Button>
                    </Link>
                </nav>

                <div className="p-6 border-t border-slate-100 space-y-4">
                    <UserProfile user={userWithProfile} />

                    <Link href="/app/settings">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-14 text-lg font-medium text-slate-500 hover:text-blue-600 hover:bg-blue-50">
                            <Settings size={24} />
                            Configuración
                        </Button>
                    </Link>
                    <form action="/auth/signout" method="post">
                        <Button variant="ghost" className="w-full justify-start gap-4 h-14 text-lg font-medium text-red-500 hover:text-red-600 hover:bg-red-50">
                            <LogOut size={24} />
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
