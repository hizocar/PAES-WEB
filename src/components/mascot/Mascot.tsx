"use client"

import { CatRig } from "./CatRig"
import { useEffect, useRef, useState } from "react"
import { AnimatePresence, motion, useReducedMotion } from "framer-motion"
import { cn } from "@/lib/utils"

export type MascotMood = "idle" | "happy" | "celebrate" | "sad" | "thinking"

/** Frases por estado de ánimo (español de Chile, tono cercano). */
export const MASCOT_LINES: Record<MascotMood, string[]> = {
    idle: ["¡Vamos que se puede!", "¿Una pregunta más?", "Hoy sumamos puntos 💪", "La constancia gana la PAES"],
    happy: ["¡Bien ahí!", "¡Eso!", "¡Bacán!", "¡Lo tienes!", "¡Sigue así!"],
    celebrate: ["¡Imparable! 🔥", "¡Racha encendida!", "¡Nivel PAES!", "¡Qué máquina!"],
    sad: ["¡Casi! Mira la explicación", "Del error se aprende", "La próxima sale 💪", "Tranqui, es parte del proceso"],
    thinking: ["Buscando tu próximo desafío…", "Elegí una buena para ti…", "Preparando la siguiente…"],
}

export function pickLine(mood: MascotMood, seed?: number) {
    const lines = MASCOT_LINES[mood]
    const i = seed !== undefined ? Math.abs(seed) % lines.length : Math.floor(Math.random() * lines.length)
    return lines[i]
}

type MascotProps = {
    mood?: MascotMood
    /** Texto del globo; `false` para no mostrar globo */
    message?: string | false
    size?: number
    /** Lado del globo respecto de la mascota */
    bubbleSide?: "right" | "top"
    /** Al tocarla salta y dice una frase */
    interactive?: boolean
    className?: string
    /** Ya no se usa (la mascota es SVG); se mantiene por compatibilidad */
    priority?: boolean
}

export function Mascot({ mood = "idle", message, size = 96, bubbleSide = "right", interactive = true, className }: MascotProps) {
    const reduce = useReducedMotion()
    const [tapLine, setTapLine] = useState<string | null>(null)
    // Al tocarla, salta (reactiva la animación "contenta" del rig) y dice una frase
    const [tapMood, setTapMood] = useState<MascotMood | null>(null)
    const [bounceKey, setBounceKey] = useState(0)
    const tapTimer = useRef<number | undefined>(undefined)

    useEffect(() => () => window.clearTimeout(tapTimer.current), [])

    const onTap = () => {
        if (!interactive) return
        const reaction: MascotMood = mood === "sad" ? "sad" : mood === "thinking" ? "thinking" : Math.random() < 0.3 ? "celebrate" : "happy"
        setTapLine(pickLine(reaction === "celebrate" ? "celebrate" : reaction))
        setTapMood(reaction === "sad" || reaction === "thinking" ? null : reaction)
        setBounceKey((k) => k + 1)
        window.clearTimeout(tapTimer.current)
        tapTimer.current = window.setTimeout(() => {
            setTapLine(null)
            setTapMood(null)
        }, 2200)
    }

    const text = tapLine ?? (message === false ? null : message ?? null)
    const shownMood = tapMood ?? mood

    return (
        <div className={cn("relative inline-flex shrink-0 items-center justify-center", className)}>
            <motion.button
                type="button"
                onClick={onTap}
                whileHover={interactive && !reduce ? { scale: 1.04 } : undefined}
                whileTap={interactive && !reduce ? { scale: 0.93 } : undefined}
                tabIndex={interactive ? 0 : -1}
                aria-label={interactive ? "Mascota de PAES Lab: tócala para que te anime" : undefined}
                aria-hidden={interactive ? undefined : true}
                className={cn("relative rounded-full focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-blue-600", interactive ? "cursor-pointer" : "cursor-default")}
                style={{ width: size, height: size }}
            >
                <CatRig mood={shownMood} size={size} bounceKey={bounceKey} />
                {shownMood === "celebrate" && !reduce && <Sparkles key={bounceKey} />}
            </motion.button>

            <AnimatePresence mode="wait">
                {text && (
                    <motion.p
                        key={text}
                        role="status"
                        initial={reduce ? false : { opacity: 0, scale: 0.85, y: bubbleSide === "top" ? 6 : 0, x: bubbleSide === "right" ? -6 : 0 }}
                        animate={{ opacity: 1, scale: 1, x: 0, y: 0 }}
                        exit={reduce ? undefined : { opacity: 0, scale: 0.9 }}
                        transition={{ type: "spring", stiffness: 420, damping: 26 }}
                        className={cn(
                            // Flotante: no empuja el diseño que rodea a la mascota
                            "absolute z-10 w-max max-w-[14rem] rounded-2xl border-2 border-slate-200 bg-white px-3 py-2 text-sm font-bold leading-snug text-slate-800 shadow-[0_6px_16px_-6px_rgba(15,23,42,0.25)]",
                            bubbleSide === "right" ? "left-full top-1/2 ml-3 -translate-y-1/2 origin-left" : "bottom-full left-1/2 mb-3 -translate-x-1/2 origin-bottom"
                        )}
                    >
                        {text}
                        {/* Pico del globo */}
                        <span
                            aria-hidden
                            className={cn(
                                "absolute h-3 w-3 rotate-45 border-slate-200 bg-white",
                                bubbleSide === "right" ? "-left-[7px] top-1/2 -translate-y-1/2 border-b-2 border-l-2" : "-bottom-[7px] left-1/2 -translate-x-1/2 border-b-2 border-r-2"
                            )}
                        />
                    </motion.p>
                )}
            </AnimatePresence>
        </div>
    )
}

/** Destellos breves alrededor de la mascota al celebrar. */
function Sparkles() {
    const dots = [
        { x: -38, y: -30, c: "bg-amber-400" },
        { x: 40, y: -26, c: "bg-blue-500" },
        { x: -44, y: 18, c: "bg-rose-400" },
        { x: 46, y: 22, c: "bg-emerald-400" },
        { x: 0, y: -46, c: "bg-violet-400" },
    ]
    return (
        <span aria-hidden className="pointer-events-none absolute inset-0">
            {dots.map((d, i) => (
                <motion.span
                    key={i}
                    className={cn("absolute left-1/2 top-1/2 h-2 w-2 rounded-full", d.c)}
                    initial={{ x: 0, y: 0, opacity: 0, scale: 0.4 }}
                    animate={{ x: d.x, y: d.y, opacity: [0, 1, 0], scale: [0.4, 1.1, 0.6] }}
                    transition={{ duration: 0.8, delay: 0.05 * i, ease: "easeOut" }}
                />
            ))}
        </span>
    )
}
