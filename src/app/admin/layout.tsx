import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import Link from 'next/link'
import { Button } from '@/components/ui/button'
import { LayoutDashboard, FileQuestion, BookOpen, LogOut, Users, DollarSign } from 'lucide-react'

export default async function AdminLayout({
    children,
}: {
    children: React.ReactNode
}) {
    const supabase = createClient()
    const { data: { user }, error } = await (await supabase).auth.getUser()

    if (error || !user) {
        redirect('/login')
    }

    // Check role
    const { data: profile } = await (await supabase)
        .from('profiles')
        .select('role')
        .eq('id', user.id)
        .single()

    // Strict Admin check
    if (profile?.role !== 'admin') {
        redirect('/app')
    }

    return (
        <div className="flex flex-col md:flex-row min-h-screen w-full bg-slate-900 md:bg-slate-100 md:overflow-hidden">
            {/* Sidebar */}
            <aside className="w-full md:w-64 bg-slate-900 text-slate-300 border-r border-slate-800 flex flex-col md:h-screen">
                <div className="p-6 border-b border-slate-800">
                    <div className="font-bold text-xl text-white flex items-center gap-2">
                        <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
                            <span className="text-white text-lg font-mono">A</span>
                        </div>
                        Admin Panel
                    </div>
                </div>

                <nav className="flex-1 p-4 space-y-2">
                    <Link href="/admin">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-12 hover:bg-slate-800 hover:text-white">
                            <LayoutDashboard size={20} />
                            Dashboard
                        </Button>
                    </Link>
                    <Link href="/admin/questions">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-12 hover:bg-slate-800 hover:text-white">
                            <FileQuestion size={20} />
                            Preguntas
                        </Button>
                    </Link>
                    <Link href="/admin/topics">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-12 hover:bg-slate-800 hover:text-white">
                            <BookOpen size={20} />
                            Temas
                        </Button>
                    </Link>
                    <Link href="/admin/users">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-12 hover:bg-slate-800 hover:text-white">
                            <Users size={20} />
                            Usuarios
                        </Button>
                    </Link>
                    <Link href="/admin/pricing">
                        <Button variant="ghost" className="w-full justify-start gap-3 h-12 hover:bg-slate-800 hover:text-white">
                            <DollarSign size={20} />
                            Precios
                        </Button>
                    </Link>
                </nav>

                <div className="p-4 border-t border-slate-800">
                    <div className="flex items-center gap-3 mb-4 px-2">
                        <div className="w-10 h-10 rounded-full bg-slate-700 flex items-center justify-center overflow-hidden">
                            <span className="font-bold text-slate-400">AD</span>
                        </div>
                        <div className="flex-1 overflow-hidden">
                            <p className="text-sm font-medium text-white truncate">Administrador</p>
                        </div>
                    </div>

                    <Link href="/app">
                        <Button variant="ghost" size="sm" className="w-full justify-start gap-2 text-slate-500 hover:text-white">
                            → Ir a la App
                        </Button>
                    </Link>
                    <form action="/auth/signout" method="post">
                        <Button variant="ghost" size="sm" className="w-full justify-start gap-2 text-red-400 hover:text-red-300 hover:bg-red-900/20">
                            <LogOut size={16} />
                            Cerrar sesión
                        </Button>
                    </form>
                </div>
            </aside>

            {/* Main Content */}
            <main className="flex-1 md:h-screen md:overflow-y-auto bg-slate-100 flex flex-col">
                <header className="h-16 bg-white border-b border-slate-200 flex items-center px-8 shadow-sm">
                    <h1 className="text-lg font-semibold text-slate-800">Administración</h1>
                </header>
                <div className="p-8">
                    {children}
                </div>
            </main>
        </div>
    )
}
