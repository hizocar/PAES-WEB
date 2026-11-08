"use client"

import { useState } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { LogOut, Menu, Settings, X } from "lucide-react"
import { AppNavLinks } from "@/components/app-nav"
import { UserProfile } from "@/components/ui/user-profile"
import { useSubject, Subject } from "@/components/providers/SubjectContext"
import { SubscriptionBadge } from "./subscription-badge"

function SubjectButton({ subject, current, setSubject }: { subject: Subject, current: Subject, setSubject: (s: Subject) => void }) {
    const isActive = current === subject
    return (
        <button
            onClick={() => setSubject(subject)}
            className={`flex-1 py-2 rounded-md text-sm font-bold transition-all ${isActive
                ? 'bg-white text-slate-900 shadow-sm'
                : 'text-slate-500 hover:text-slate-700'
                }`}
        >
            {subject.toUpperCase()}
        </button>
    )
}

export function MobileNav({ user }: { user: any }) {
    const [open, setOpen] = useState(false)
    const { subject, setSubject } = useSubject()

    return (
        <div className="md:hidden flex flex-col border-b border-slate-200 bg-white sticky top-0 z-50">
            <div className="flex items-center justify-between p-4">
                <Link href="/app" className="font-bold text-xl text-blue-600 flex items-center gap-2">
                    PAES Lab
                    <span className="text-xs font-extrabold bg-blue-100 text-blue-600 px-2 py-0.5 rounded-full border border-blue-200">
                        {subject.toUpperCase()}
                    </span>
                </Link>
                <Button variant="ghost" size="sm" onClick={() => setOpen(true)} aria-label="Abrir menú" aria-expanded={open}>
                    <Menu className="h-6 w-6 text-slate-700" />
                </Button>
            </div>

            {/* Mobile Menu Overlay */}
            {open && (
                <div className="fixed inset-0 z-50 bg-slate-900/50" onClick={() => setOpen(false)} role="dialog" aria-modal="true" aria-label="Menú">
                    <div
                        className="absolute right-0 top-0 h-full w-[80%] max-w-[300px] bg-white shadow-2xl p-6 flex flex-col animate-in slide-in-from-right duration-200"
                        onClick={(e) => e.stopPropagation()}
                    >
                        <div className="flex items-center justify-between mb-8">
                            <div className="font-bold text-xl text-blue-600">Menú</div>
                            <Button variant="ghost" size="sm" onClick={() => setOpen(false)} aria-label="Cerrar menú">
                                <X className="h-6 w-6 text-slate-500" />
                            </Button>
                        </div>

                        {/* Subject Switcher Mobile */}
                        <div className="bg-slate-100 p-1 rounded-lg flex items-center gap-1 mb-6">
                            <SubjectButton subject="m1" current={subject} setSubject={setSubject} />
                            <SubjectButton subject="m2" current={subject} setSubject={setSubject} />
                        </div>

                        <nav className="flex-1 overflow-y-auto" aria-label="Menú">
                            <AppNavLinks size="lg" onNavigate={() => setOpen(false)} />
                        </nav>

                        <div className="pt-6 border-t border-slate-100 space-y-3 mt-auto">
                            <div className="bg-slate-50 p-3 rounded-xl border border-slate-100 shadow-sm flex flex-col gap-2">
                                <UserProfile user={user} />
                                <div className="flex items-center justify-between px-1 pt-1.5 border-t border-slate-100">
                                    <span className="text-[10px] font-black text-slate-400 uppercase tracking-widest">Estado</span>
                                    <Link href="/app/pricing" onClick={() => setOpen(false)} className="hover:opacity-80 transition-opacity">
                                        <SubscriptionBadge tier={user?.subscription_tier} />
                                    </Link>
                                </div>
                            </div>

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
