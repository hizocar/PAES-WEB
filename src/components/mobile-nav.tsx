"use client"

import { useState } from "react"
import Link from "next/link"
import { usePathname } from "next/navigation"
import { Button } from "@/components/ui/button"
import { BarChart3, Clock, Home, LogOut, Menu, Settings, Trophy, X, RotateCcw, Award } from "lucide-react"
import { UserProfile } from "@/components/ui/user-profile"

export function MobileNav({ user }: { user: any }) {
    const [open, setOpen] = useState(false)
    const pathname = usePathname()

    return (
        <div className="md:hidden flex flex-col border-b border-slate-200 bg-white sticky top-0 z-50">
            <div className="flex items-center justify-between p-4">
                <Link href="/app" className="font-bold text-xl text-blue-600 flex items-center gap-2">
                    PAES Lab
                </Link>
                <Button variant="ghost" size="sm" onClick={() => setOpen(true)}>
                    <Menu className="h-6 w-6 text-slate-700" />
                </Button>
            </div>

            {/* Mobile Menu Overlay */}
            {open && (
                <div className="fixed inset-0 z-50 bg-black/50 backdrop-blur-sm" onClick={() => setOpen(false)}>
                    <div
                        className="absolute right-0 top-0 h-full w-[80%] max-w-[300px] bg-white shadow-2xl p-6 flex flex-col animate-in slide-in-from-right duration-200"
                        onClick={(e) => e.stopPropagation()}
                    >
                        <div className="flex items-center justify-between mb-8">
                            <div className="font-bold text-xl text-blue-600">Menú</div>
                            <Button variant="ghost" size="sm" onClick={() => setOpen(false)}>
                                <X className="h-6 w-6 text-slate-500" />
                            </Button>
                        </div>

                        <nav className="flex-1 space-y-2">
                            <Link href="/app" onClick={() => setOpen(false)}>
                                <Button variant={pathname === "/app" ? "secondary" : "ghost"} className="w-full justify-start gap-3 h-12 text-base font-medium">
                                    <Home size={20} />
                                    Inicio
                                </Button>
                            </Link>
                            <Link href="/app/practice" onClick={() => setOpen(false)}>
                                <Button variant={pathname === "/app/practice" ? "secondary" : "ghost"} className="w-full justify-start gap-3 h-12 text-base font-medium">
                                    <Clock size={20} />
                                    Practicar
                                </Button>
                            </Link>
                            <Link href="/app/practice?mode=retry" onClick={() => setOpen(false)}>
                                <Button variant="ghost" className="w-full justify-start gap-3 h-12 text-base font-medium text-orange-600 hover:bg-orange-50 hover:text-orange-700">
                                    <RotateCcw size={20} />
                                    Modo Repaso
                                </Button>
                            </Link>
                            <Link href="/app/progress" onClick={() => setOpen(false)}>
                                <Button variant={pathname === "/app/progress" ? "secondary" : "ghost"} className="w-full justify-start gap-3 h-12 text-base font-medium">
                                    <BarChart3 size={20} />
                                    Mi Progreso
                                </Button>
                            </Link>
                            <Link href="/app/leaderboard" onClick={() => setOpen(false)}>
                                <Button variant={pathname === "/app/leaderboard" ? "secondary" : "ghost"} className="w-full justify-start gap-3 h-12 text-base font-medium">
                                    <Trophy size={20} />
                                    Ranking
                                </Button>
                            </Link>
                            <Link href="/app/achievements" onClick={() => setOpen(false)}>
                                <Button variant={pathname === "/app/achievements" ? "secondary" : "ghost"} className="w-full justify-start gap-3 h-12 text-base font-medium text-yellow-600 hover:bg-yellow-50 hover:text-yellow-700">
                                    <Award size={20} />
                                    Logros
                                </Button>
                            </Link>
                        </nav>

                        <div className="pt-6 border-t border-slate-100 space-y-3 mt-auto">
                            <UserProfile user={user} />

                            <Link href="/app/settings" onClick={() => setOpen(false)}>
                                <Button variant="ghost" className="w-full justify-start gap-3 h-12 text-sm font-medium text-slate-500">
                                    <Settings size={18} />
                                    Configuración
                                </Button>
                            </Link>
                            <form action="/auth/signout" method="post">
                                <Button variant="ghost" className="w-full justify-start gap-3 h-12 text-sm font-medium text-red-500 hover:text-red-600 hover:bg-red-50">
                                    <LogOut size={18} />
                                    Cerrar sesión
                                </Button>
                            </form>
                        </div>
                    </div>
                </div>
            )}
        </div>
    )
}
