"use client"

import { useCallback, useEffect, useId, useLayoutEffect, useRef, useState, type ReactNode } from "react"
import { AnimatePresence, motion, useReducedMotion } from "framer-motion"
import { ArrowLeft, ArrowRight } from "lucide-react"
import { cn } from "@/lib/utils"

export interface OnboardingStep {
    /** id del elemento a iluminar; sin targetId (o si no está visible) el paso se muestra centrado */
    targetId?: string
    title: string
    description: string
    icon: ReactNode
    /** Preferencia en escritorio; en celular siempre es una hoja inferior o superior */
    position?: "center" | "top" | "bottom" | "left" | "right"
    /** Contenido interactivo opcional bajo la descripción (por ejemplo, elegir materia) */
    content?: ReactNode
    /** Texto del botón principal de este paso */
    primaryLabel?: string
}

interface OnboardingTourProps {
    steps: OnboardingStep[]
    /** reason = "done" al terminar el último paso, "skip" al saltar */
    onComplete: (reason: "done" | "skip") => void
}

type Rect = { top: number; left: number; width: number; height: number }

const PAD = 8
const GAP = 16
const EDGE = 16

function visibleRect(id?: string): Rect | null {
    if (!id) return null
    const el = document.getElementById(id)
    if (!el) return null
    const r = el.getBoundingClientRect()
    if (r.width < 4 || r.height < 4) return null // oculto (display:none o 1px)
    return { top: r.top - PAD, left: r.left - PAD, width: r.width + PAD * 2, height: r.height + PAD * 2 }
}

export function OnboardingTour({ steps, onComplete }: OnboardingTourProps) {
    const [index, setIndex] = useState(0)
    const [rect, setRect] = useState<Rect | null>(null)
    const [box, setBox] = useState<{ top: number; left: number } | null>(null)
    const [isMobile, setIsMobile] = useState(false)
    const boxRef = useRef<HTMLDivElement>(null)
    const primaryRef = useRef<HTMLButtonElement>(null)
    const reduceMotion = useReducedMotion()
    const titleId = useId()
    const descId = useId()

    const step = steps[index]
    const isLast = index === steps.length - 1
    const centered = !rect || step.position === "center"

    // Medir el objetivo: al cambiar de paso lo traemos a la vista y seguimos scroll/resize
    useEffect(() => {
        const check = () => setIsMobile(window.innerWidth < 768)
        check()
        const el = step.targetId ? document.getElementById(step.targetId) : null
        if (el && step.position !== "center") {
            el.scrollIntoView({ behavior: reduceMotion ? "auto" : "smooth", block: "center" })
        }
        let frame = 0
        const update = () => {
            cancelAnimationFrame(frame)
            frame = requestAnimationFrame(() => {
                check()
                setRect(step.position === "center" ? null : visibleRect(step.targetId))
            })
        }
        update()
        const settle = window.setTimeout(update, 450) // tras el scroll suave
        window.addEventListener("resize", update)
        window.addEventListener("scroll", update, true)
        return () => {
            cancelAnimationFrame(frame)
            clearTimeout(settle)
            window.removeEventListener("resize", update)
            window.removeEventListener("scroll", update, true)
        }
    }, [step, reduceMotion])

    // Posicionar la caja con su tamaño real (escritorio)
    useLayoutEffect(() => {
        if (centered || isMobile || !boxRef.current || !rect) {
            setBox(null)
            return
        }
        const { offsetWidth: w, offsetHeight: h } = boxRef.current
        const vw = window.innerWidth
        const vh = window.innerHeight
        const fits = {
            bottom: rect.top + rect.height + GAP + h <= vh - EDGE,
            top: rect.top - GAP - h >= EDGE,
            right: rect.left + rect.width + GAP + w <= vw - EDGE,
            left: rect.left - GAP - w >= EDGE,
        }
        const order = [step.position ?? "bottom", "bottom", "top", "right", "left"] as const
        const side = order.find((s) => s !== "center" && fits[s as keyof typeof fits]) ?? "bottom"
        let top = 0
        let left = 0
        if (side === "bottom" || side === "top") {
            top = side === "bottom" ? rect.top + rect.height + GAP : rect.top - GAP - h
            left = rect.left + rect.width / 2 - w / 2
        } else {
            top = rect.top + rect.height / 2 - h / 2
            left = side === "right" ? rect.left + rect.width + GAP : rect.left - GAP - w
        }
        setBox({
            top: Math.max(EDGE, Math.min(top, vh - h - EDGE)),
            left: Math.max(EDGE, Math.min(left, vw - w - EDGE)),
        })
    }, [rect, centered, isMobile, step.position, index])

    // Foco en la acción principal en cada paso
    useEffect(() => {
        const t = window.setTimeout(() => primaryRef.current?.focus({ preventScroll: true }), 60)
        return () => clearTimeout(t)
    }, [index])

    const next = useCallback(() => {
        if (isLast) onComplete("done")
        else setIndex((i) => i + 1)
    }, [isLast, onComplete])
    const back = useCallback(() => setIndex((i) => Math.max(0, i - 1)), [])
    const skip = useCallback(() => onComplete("skip"), [onComplete])

    useEffect(() => {
        const onKey = (e: KeyboardEvent) => {
            if (e.key === "Escape") skip()
            if (e.key === "ArrowRight") next()
            if (e.key === "ArrowLeft") back()
        }
        window.addEventListener("keydown", onKey)
        return () => window.removeEventListener("keydown", onKey)
    }, [next, back, skip])

    // En celular: hoja abajo, o arriba si el objetivo está en la mitad inferior
    const mobileAtTop = isMobile && rect !== null && rect.top + rect.height / 2 > window.innerHeight / 2

    const boxPosition = centered
        ? "left-1/2 top-1/2 w-[min(26rem,calc(100vw-2rem))] -translate-x-1/2 -translate-y-1/2"
        : isMobile
            ? cn("inset-x-3", mobileAtTop ? "top-3" : "bottom-3")
            : "w-[24rem]"

    const ease = [0.16, 1, 0.3, 1] as const

    return (
        <div className="fixed inset-0 z-[100]" role="presentation">
            {/* Velo: con objetivo, un recorte por sombra; sin objetivo, velo completo */}
            {rect && !centered ? (
                <motion.div
                    aria-hidden
                    className="pointer-events-none absolute rounded-2xl ring-2 ring-blue-400"
                    initial={false}
                    animate={{ top: rect.top, left: rect.left, width: rect.width, height: rect.height }}
                    transition={reduceMotion ? { duration: 0 } : { duration: 0.35, ease }}
                    style={{ boxShadow: "0 0 0 9999px rgba(15, 23, 42, 0.62)" }}
                />
            ) : (
                <div aria-hidden className="absolute inset-0 bg-slate-900/60" />
            )}
            {/* Capa que bloquea clics en la página durante el tour */}
            <div aria-hidden className="absolute inset-0" onClick={(e) => e.stopPropagation()} />

            <AnimatePresence mode="wait">
                <motion.div
                    key={index}
                    ref={boxRef}
                    role="dialog"
                    aria-modal="true"
                    aria-labelledby={titleId}
                    aria-describedby={descId}
                    className={cn(
                        "absolute rounded-3xl bg-white p-6 shadow-[0_24px_60px_-12px_rgba(15,23,42,0.35)]",
                        boxPosition
                    )}
                    style={!centered && !isMobile ? { top: box?.top ?? -9999, left: box?.left ?? -9999 } : undefined}
                    initial={reduceMotion ? false : { opacity: 0, y: 8 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={reduceMotion ? undefined : { opacity: 0, y: -4 }}
                    transition={{ duration: 0.28, ease }}
                >
                    <div className="mb-4 flex items-center justify-between">
                        <div className="flex h-11 w-11 items-center justify-center rounded-2xl bg-blue-50" aria-hidden>
                            {step.icon}
                        </div>
                        <span className="text-xs font-bold text-slate-500 tabular-nums">
                            Paso {index + 1} de {steps.length}
                        </span>
                    </div>

                    <h2 id={titleId} className="text-xl font-black leading-tight tracking-tight text-slate-900 text-balance">
                        {step.title}
                    </h2>
                    <p id={descId} className="mt-2 text-[15px] leading-relaxed text-slate-600">
                        {step.description}
                    </p>

                    {step.content && <div className="mt-4">{step.content}</div>}

                    <div className="mt-6 flex items-center justify-between gap-3">
                        <button
                            type="button"
                            onClick={skip}
                            className="shrink-0 whitespace-nowrap rounded-lg px-2 py-1.5 text-sm font-semibold text-slate-500 transition-colors hover:text-slate-800 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                        >
                            Saltar tutorial
                        </button>
                        <div className="flex items-center gap-2">
                            {index > 0 && (
                                <button
                                    type="button"
                                    onClick={back}
                                    aria-label="Paso anterior"
                                    className="flex h-10 w-10 items-center justify-center rounded-full text-slate-500 transition-colors hover:bg-slate-100 hover:text-slate-800 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                                >
                                    <ArrowLeft size={18} />
                                </button>
                            )}
                            <button
                                ref={primaryRef}
                                type="button"
                                onClick={next}
                                className="group inline-flex h-11 items-center gap-2 whitespace-nowrap rounded-full bg-blue-600 px-5 text-sm font-black text-white shadow-[0_6px_16px_-4px_rgba(37,99,235,0.55)] transition-[background-color,transform] hover:bg-blue-700 active:translate-y-px focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                            >
                                {step.primaryLabel ?? (isLast ? "¡Listo!" : "Siguiente")}
                                {!isLast && <ArrowRight size={16} className="transition-transform group-hover:translate-x-0.5" aria-hidden />}
                            </button>
                        </div>
                    </div>

                    {/* Progreso */}
                    <div className="mt-5 flex gap-1.5" aria-hidden>
                        {steps.map((_, i) => (
                            <span
                                key={i}
                                className={cn(
                                    "h-1.5 rounded-full transition-all duration-300",
                                    i === index ? "w-6 bg-blue-600" : i < index ? "w-1.5 bg-blue-300" : "w-1.5 bg-slate-200"
                                )}
                            />
                        ))}
                    </div>
                </motion.div>
            </AnimatePresence>
        </div>
    )
}
