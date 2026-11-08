"use client"

import { useEffect, useRef, useState } from "react"
import { AnimatePresence, motion, useReducedMotion, useSpring } from "framer-motion"
import type { MascotMood } from "./Mascot"

/**
 * Gato de PAES Lab dibujado como SVG articulado (no imagen), para animarlo con fluidez:
 * parpadeo, respiración, orejas, mirada que sigue el cursor y expresiones por estado.
 * Fiel al diseño original: gato naranjo, mancha blanca, orejas rosadas y cintillo de estudio.
 */

const INK = "#3A1D10"
const FUR = "#F59A2C"
const FUR_SHADE = "#E07B16"
const WHITE = "#FFFFFF"
const PINK = "#F6A0A8"
const NOSE = "#F07C8C"
const MOUTH = "#5B1A12"
const TONGUE = "#F27D8C"
const TEAR = "#7CC8F2"

type Props = { mood: MascotMood; size: number; bounceKey?: number }

export function CatRig({ mood, size, bounceKey = 0 }: Props) {
    const reduce = useReducedMotion()
    const [blink, setBlink] = useState(false)
    const [earTwitch, setEarTwitch] = useState(0)
    const rootRef = useRef<SVGSVGElement>(null)
    const lookX = useSpring(0, { stiffness: 180, damping: 18 })
    const lookY = useSpring(0, { stiffness: 180, damping: 18 })

    // Parpadeo a intervalos irregulares (más natural que un ritmo fijo)
    useEffect(() => {
        if (reduce) return
        let t: number
        const loop = () => {
            t = window.setTimeout(() => {
                setBlink(true)
                window.setTimeout(() => setBlink(false), 140)
                loop()
            }, 2200 + Math.random() * 3200)
        }
        loop()
        return () => clearTimeout(t)
    }, [reduce])

    // Orejas: un movimiento ocasional
    useEffect(() => {
        if (reduce) return
        const id = window.setInterval(() => setEarTwitch((n) => n + 1), 5200 + Math.random() * 2000)
        return () => clearInterval(id)
    }, [reduce])

    // Mirada que sigue al cursor (solo con puntero fino)
    useEffect(() => {
        if (reduce || !window.matchMedia("(pointer: fine)").matches) return
        let frame = 0
        const onMove = (e: PointerEvent) => {
            cancelAnimationFrame(frame)
            frame = requestAnimationFrame(() => {
                const r = rootRef.current?.getBoundingClientRect()
                if (!r) return
                const dx = e.clientX - (r.left + r.width / 2)
                const dy = e.clientY - (r.top + r.height / 2)
                const d = Math.hypot(dx, dy) || 1
                const k = Math.min(1, d / 300)
                lookX.set((dx / d) * 4.5 * k)
                lookY.set((dy / d) * 3.5 * k)
            })
        }
        window.addEventListener("pointermove", onMove)
        return () => {
            cancelAnimationFrame(frame)
            window.removeEventListener("pointermove", onMove)
        }
    }, [reduce, lookX, lookY])

    // Mirada fija según el ánimo
    useEffect(() => {
        if (mood === "thinking") {
            lookX.set(4)
            lookY.set(-4)
        } else if (mood === "sad") {
            lookX.set(0)
            lookY.set(3)
        }
    }, [mood, lookX, lookY])

    const sad = mood === "sad"
    const think = mood === "thinking"
    const joyful = mood === "happy" || mood === "celebrate"

    // Postura del cuerpo por ánimo
    const pose = reduce
        ? {}
        : mood === "celebrate"
            ? { y: [0, -26, 0, -10, 0], rotate: [0, -8, 360 - 8, 360, 360], scaleY: [1, 1.08, 0.9, 1.04, 1], scaleX: [1, 0.94, 1.08, 0.98, 1] }
            : mood === "happy"
                ? { y: [0, -16, 0, -4, 0], scaleY: [1, 1.06, 0.92, 1.02, 1], scaleX: [1, 0.96, 1.06, 0.99, 1], rotate: 0 }
                : sad
                    ? { y: 5, rotate: -4, scaleY: 0.97, scaleX: 1.02 }
                    : think
                        ? { rotate: 7, y: 0, scaleX: 1, scaleY: 1 }
                        : { y: 0, rotate: 0, scaleX: 1, scaleY: 1 }

    return (
        <motion.svg
            ref={rootRef}
            viewBox="0 0 200 200"
            width={size}
            height={size}
            aria-hidden
            className="overflow-visible"
        >
            {/* Sombra: se queda en el suelo y se achica cuando el gato salta */}
            <motion.ellipse
                cx="100" cy="188" rx="52" ry="6" fill={INK} opacity="0.12"
                style={{ originX: 0.5, originY: 0.5 }}
                animate={reduce ? undefined : mood === "celebrate" || mood === "happy" ? { scaleX: [1, 0.7, 1, 0.9, 1] } : { scaleX: 1 }}
                transition={{ duration: mood === "celebrate" ? 1.05 : 0.75, ease: [0.22, 1, 0.36, 1] }}
            />
            {/* Respiración: bucle muy sutil */}
            <motion.g
                animate={reduce ? undefined : { y: [0, -2.5, 0] }}
                transition={{ duration: 3.2, repeat: Infinity, ease: "easeInOut" }}
            >
                <motion.g
                    key={`${mood}-${bounceKey}`}
                    style={{ originX: 0.5, originY: 0.92 }}
                    animate={pose}
                    transition={
                        mood === "celebrate"
                            ? { duration: 1.05, ease: [0.22, 1, 0.36, 1] }
                            : mood === "happy"
                                ? { duration: 0.75, ease: [0.22, 1, 0.36, 1] }
                                : { type: "spring", stiffness: 160, damping: 14 }
                    }
                >
                    {/* Orejas */}
                    <Ear side="left" sad={sad} twitch={earTwitch} reduce={!!reduce} />
                    <Ear side="right" sad={sad} twitch={0} reduce={!!reduce} />

                    {/* Cabeza */}
                    <path
                        d="M28 112 C28 66 60 50 100 50 C140 50 172 66 172 112 C172 152 142 176 100 176 C58 176 28 152 28 112 Z"
                        fill={FUR}
                        stroke={INK}
                        strokeWidth="5"
                        strokeLinejoin="round"
                    />
                    {/* Mancha blanca */}
                    <path
                        d="M100 74 C92 86 88 98 86 110 C66 112 52 124 52 140 C56 162 76 172 100 172 C124 172 144 162 148 140 C148 124 134 112 114 110 C112 98 108 86 100 74 Z"
                        fill={WHITE}
                    />
                    {/* Mejillas con pelo (detalle lateral) */}
                    <path d="M30 120 L18 126 L31 130" fill="none" stroke={INK} strokeWidth="4" strokeLinecap="round" strokeLinejoin="round" />
                    <path d="M170 120 L182 126 L169 130" fill="none" stroke={INK} strokeWidth="4" strokeLinecap="round" strokeLinejoin="round" />
                    {/* Rubor */}
                    <motion.ellipse cx="60" cy="140" rx="11" ry="6" fill={PINK} animate={{ opacity: joyful ? 0.85 : 0.45 }} />
                    <motion.ellipse cx="140" cy="140" rx="11" ry="6" fill={PINK} animate={{ opacity: joyful ? 0.85 : 0.45 }} />

                    {/* Cintillo de estudio */}
                    <path d="M37 78 C72 58 128 58 163 78 L160 96 C126 78 74 78 40 96 Z" fill={WHITE} stroke={INK} strokeWidth="4.5" strokeLinejoin="round" />
                    <path d="M64 79 C86 71 114 71 136 79" fill="none" stroke={INK} strokeWidth="3" strokeLinecap="round" />
                    {[70, 84, 100, 116, 130].map((x, i) => (
                        <line key={x} x1={x} x2={x} y1={i === 2 ? 67 : 70} y2={i === 2 ? 81 : 84} stroke={INK} strokeWidth="3" strokeLinecap="round" />
                    ))}

                    {/* Cejas */}
                    <motion.path
                        d="M62 108 Q74 102 86 106"
                        fill="none"
                        stroke={INK}
                        strokeWidth="3.5"
                        strokeLinecap="round"
                        animate={{ rotate: sad ? -14 : think ? 8 : 0, y: sad ? 0 : joyful ? -3 : 0 }}
                        style={{ originX: 0.5, originY: 0.5 }}
                    />
                    <motion.path
                        d="M114 106 Q126 102 138 108"
                        fill="none"
                        stroke={INK}
                        strokeWidth="3.5"
                        strokeLinecap="round"
                        animate={{ rotate: sad ? 14 : think ? -14 : 0, y: think ? -4 : joyful ? -3 : 0 }}
                        style={{ originX: 0.5, originY: 0.5 }}
                    />

                    {/* Ojos */}
                    <Eye cx={76} cy={124} blink={blink} lookX={lookX} lookY={lookY} happy={mood === "celebrate"} />
                    <Eye cx={124} cy={124} blink={blink} lookX={lookX} lookY={lookY} happy={mood === "celebrate"} />

                    {/* Lágrimas */}
                    <AnimatePresence>
                        {sad && !reduce && (
                            <>
                                <Tear x={68} delay={0} />
                                <Tear x={132} delay={0.5} />
                            </>
                        )}
                    </AnimatePresence>

                    {/* Nariz */}
                    <path d="M92 142 C96 138 104 138 108 142 C106 148 102 150 100 150 C98 150 94 148 92 142 Z" fill={NOSE} stroke={INK} strokeWidth="2.5" strokeLinejoin="round" />

                    {/* Boca por ánimo */}
                    <AnimatePresence mode="wait" initial={false}>
                        <motion.g
                            key={joyful ? "open" : sad ? "sad" : think ? "think" : "smile"}
                            initial={{ opacity: 0, scale: 0.6 }}
                            animate={{ opacity: 1, scale: 1 }}
                            exit={{ opacity: 0, scale: 0.6 }}
                            transition={{ duration: 0.16 }}
                            style={{ originX: 0.5, originY: 0.2 }}
                        >
                            {joyful ? (
                                <>
                                    <path d="M82 152 C88 152 94 154 100 154 C106 154 112 152 118 152 C118 168 110 176 100 176 C90 176 82 168 82 152 Z" fill={MOUTH} stroke={INK} strokeWidth="3" strokeLinejoin="round" />
                                    <path d="M90 168 C94 162 106 162 110 168 C108 174 92 174 90 168 Z" fill={TONGUE} />
                                </>
                            ) : sad ? (
                                <path d="M86 166 C92 156 108 156 114 166" fill="none" stroke={INK} strokeWidth="3.5" strokeLinecap="round" />
                            ) : think ? (
                                <path d="M92 160 Q100 157 110 161" fill="none" stroke={INK} strokeWidth="3.5" strokeLinecap="round" />
                            ) : (
                                <path d="M84 154 C88 162 96 162 100 154 C104 162 112 162 116 154" fill="none" stroke={INK} strokeWidth="3.5" strokeLinecap="round" strokeLinejoin="round" />
                            )}
                        </motion.g>
                    </AnimatePresence>
                </motion.g>
            </motion.g>

            {/* Pensando: puntos suspensivos */}
            <AnimatePresence>
                {think && (
                    <motion.g initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}>
                        {[0, 1, 2].map((i) => (
                            <motion.circle
                                key={i}
                                cx={176 + i * 9}
                                cy={78 - i * 14}
                                r={4 + i * 1.5}
                                fill={WHITE}
                                stroke={INK}
                                strokeWidth="2.5"
                                animate={reduce ? undefined : { opacity: [0.25, 1, 0.25], y: [0, -3, 0] }}
                                transition={{ duration: 1.2, repeat: Infinity, delay: i * 0.2, ease: "easeInOut" }}
                            />
                        ))}
                    </motion.g>
                )}
            </AnimatePresence>
        </motion.svg>
    )
}

function Ear({ side, sad, twitch, reduce }: { side: "left" | "right"; sad: boolean; twitch: number; reduce: boolean }) {
    const left = side === "left"
    const outer = left
        ? "M40 92 C36 66 40 36 52 22 C58 16 64 18 70 24 L96 54 Z"
        : "M160 92 C164 66 160 36 148 22 C142 16 136 18 130 24 L104 54 Z"
    const inner = left ? "M50 78 C48 60 50 42 57 33 L84 58 Z" : "M150 78 C152 60 150 42 143 33 L116 58 Z"
    return (
        <motion.g
            style={{ originX: left ? 0.75 : 0.25, originY: 0.95 }}
            animate={{ rotate: sad ? (left ? -28 : 28) : 0 }}
            transition={{ type: "spring", stiffness: 140, damping: 12 }}
        >
            <motion.g
                key={twitch}
                style={{ originX: left ? 0.75 : 0.25, originY: 0.95 }}
                animate={twitch && !reduce ? { rotate: [0, left ? -10 : 10, 0, left ? -6 : 6, 0] } : undefined}
                transition={{ duration: 0.5, ease: "easeOut" }}
            >
                <path d={outer} fill={FUR_SHADE} stroke={INK} strokeWidth="5" strokeLinejoin="round" />
                <path d={inner} fill={PINK} />
            </motion.g>
        </motion.g>
    )
}

function Eye({ cx, cy, blink, lookX, lookY, happy }: { cx: number; cy: number; blink: boolean; lookX: any; lookY: any; happy: boolean }) {
    if (happy) {
        // Ojos cerrados de alegría (^ ^)
        return <path d={`M${cx - 11} ${cy + 3} Q${cx} ${cy - 10} ${cx + 11} ${cy + 3}`} fill="none" stroke={INK} strokeWidth="4.5" strokeLinecap="round" />
    }
    return (
        <motion.g style={{ originX: 0.5, originY: 0.5 }} animate={{ scaleY: blink ? 0.08 : 1 }} transition={{ duration: 0.07 }}>
            <ellipse cx={cx} cy={cy} rx="13" ry="15" fill={WHITE} stroke={INK} strokeWidth="3.5" />
            <motion.g style={{ x: lookX, y: lookY }}>
                <circle cx={cx} cy={cy + 1} r="8.5" fill={INK} />
                <circle cx={cx - 3} cy={cy - 3} r="3.2" fill={WHITE} />
                <circle cx={cx + 3} cy={cy + 4} r="1.4" fill={WHITE} />
            </motion.g>
        </motion.g>
    )
}

function Tear({ x, delay }: { x: number; delay: number }) {
    return (
        <motion.path
            d={`M${x} 138 C${x - 4} 146 ${x - 4} 152 ${x} 154 C${x + 4} 152 ${x + 4} 146 ${x} 138 Z`}
            fill={TEAR}
            stroke={INK}
            strokeWidth="1.5"
            initial={{ opacity: 0, y: -4 }}
            animate={{ opacity: [0, 1, 1, 0], y: [-4, 0, 14, 22] }}
            exit={{ opacity: 0 }}
            transition={{ duration: 1.6, delay, repeat: Infinity, repeatDelay: 0.4, ease: "easeIn" }}
        />
    )
}
