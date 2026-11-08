"use client"

import Link from "next/link"
import { usePathname, useSearchParams } from "next/navigation"
import { Award, BarChart3, FileText, Home, RotateCcw, Target, Trophy, Zap, type LucideIcon } from "lucide-react"
import { cn } from "@/lib/utils"

type NavItem = { href: string; label: string; icon: LucideIcon; match: (path: string, mode: string | null) => boolean }

export const NAV_ITEMS: NavItem[] = [
    { href: "/app", label: "Inicio", icon: Home, match: (p) => p === "/app" },
    { href: "/app/practice", label: "Practicar", icon: Zap, match: (p, m) => p === "/app/practice" && m !== "retry" },
    { href: "/app/temas", label: "Por tema", icon: Target, match: (p) => p.startsWith("/app/temas") },
    { href: "/app/practice?mode=retry", label: "Repasar errores", icon: RotateCcw, match: (p, m) => p === "/app/practice" && m === "retry" },
    { href: "/app/ensayos", label: "Ensayos", icon: FileText, match: (p) => p.startsWith("/app/ensayos") },
    { href: "/app/progress", label: "Mi progreso", icon: BarChart3, match: (p) => p.startsWith("/app/progress") },
    { href: "/app/leaderboard", label: "Ranking", icon: Trophy, match: (p) => p.startsWith("/app/leaderboard") },
    { href: "/app/achievements", label: "Logros", icon: Award, match: (p) => p.startsWith("/app/achievements") },
]

const TAB_HREFS = ["/app", "/app/practice", "/app/temas", "/app/ensayos"]

function useActive() {
    const pathname = usePathname()
    const mode = useSearchParams().get("mode")
    return (item: NavItem) => item.match(pathname, mode)
}

/** Lista de navegación para el menú lateral (escritorio) y el panel del celular */
export function AppNavLinks({ size = "md", onNavigate }: { size?: "md" | "lg"; onNavigate?: () => void }) {
    const isActive = useActive()
    return (
        <ul className="space-y-1">
            {NAV_ITEMS.map((item) => {
                const active = isActive(item)
                const Icon = item.icon
                return (
                    <li key={item.href}>
                        <Link
                            href={item.href}
                            onClick={onNavigate}
                            aria-current={active ? "page" : undefined}
                            className={cn(
                                "flex items-center gap-3 rounded-xl px-3 font-semibold transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600",
                                size === "lg" ? "h-12 text-base" : "h-10 text-sm",
                                active ? "bg-blue-50 text-blue-700" : "text-slate-600 hover:bg-slate-100 hover:text-slate-900"
                            )}
                        >
                            <Icon size={size === "lg" ? 20 : 18} className={active ? "text-blue-600" : "text-slate-400"} aria-hidden />
                            {item.label}
                        </Link>
                    </li>
                )
            })}
        </ul>
    )
}

/** Barra inferior de pestañas (solo celular) */
export function MobileTabBar() {
    const isActive = useActive()
    const pathname = usePathname()
    // Modo concentración: sin barra durante una práctica o un ensayo en curso
    if (pathname.startsWith("/app/practice") || /^\/app\/ensayos\/[^/]+$/.test(pathname)) return null
    const tabs = NAV_ITEMS.filter((i) => TAB_HREFS.includes(i.href))
    return (
        <nav
            aria-label="Navegación principal"
            className="fixed inset-x-0 bottom-0 z-40 border-t border-slate-200 bg-white/95 pb-[env(safe-area-inset-bottom)] backdrop-blur md:hidden"
        >
            <ul className="grid grid-cols-4">
                {tabs.map((item) => {
                    const active = isActive(item)
                    const Icon = item.icon
                    return (
                        <li key={item.href}>
                            <Link
                                href={item.href}
                                aria-current={active ? "page" : undefined}
                                className={cn(
                                    "flex h-16 flex-col items-center justify-center gap-1 text-[11px] font-bold transition-colors",
                                    active ? "text-blue-700" : "text-slate-500"
                                )}
                            >
                                <Icon size={22} className={active ? "fill-blue-100" : ""} aria-hidden />
                                {item.label}
                            </Link>
                        </li>
                    )
                })}
            </ul>
        </nav>
    )
}
