"use client"

import { useState } from "react"
import Link from "next/link"
import { AnimatePresence, motion, useReducedMotion } from "framer-motion"
import { Check, X } from "lucide-react"
import Latex from "@/components/ui/latex-renderer"
import { Mascot, pickLine, type MascotMood } from "@/components/mascot/Mascot"
import { cn } from "@/lib/utils"
import { parseExplanation } from "@/components/practice/StructuredExplanation"

export type DemoQuestion = {
    content: string
    alternatives: Record<string, string>
    correct: string
    explanation: string
    topic: string
}

/** Pregunta real del banco, jugable sin cuenta: es la demostración del producto. */
export function PlayableQuestion({ q }: { q: DemoQuestion }) {
    const [picked, setPicked] = useState<string | null>(null)
    const [line, setLine] = useState<string | null>(null)
    const reduce = useReducedMotion()
    const answered = picked !== null
    const right = picked === q.correct
    const mood: MascotMood = !answered ? "idle" : right ? "celebrate" : "sad"

    const choose = (k: string) => {
        if (answered) return
        setPicked(k)
        setLine(k === q.correct ? pickLine("celebrate") : "¡Casi! Mira por qué 👇")
    }

    // La explicación completa es larga para una portada: mostramos la idea clave, los pasos
    // y, si se equivocó, el error frecuente de la alternativa que eligió.
    const parsed = parseExplanation(q.explanation)
    const [legacySolution, ...legacyWhy] = q.explanation.split("\n")
    const pickedError = parsed?.errors.find((e) => e.letter === picked)

    return (
        <div className="relative">
            {/* El gato se asoma sobre la tarjeta */}
            <div className="absolute -top-[4.6rem] right-6 z-10 sm:right-10">
                <Mascot mood={mood} size={104} message={line ?? (answered ? false : "¿Te atreves?")} bubbleSide="top" />
            </div>

            <div className="rounded-[1.75rem] border-2 border-slate-200 bg-white p-5 shadow-[0_24px_48px_-24px_rgba(15,23,42,0.28)] sm:p-7">
                <div className="mb-4 flex items-center gap-2 text-xs font-bold">
                    <span className="rounded-full bg-blue-50 px-2.5 py-1 text-blue-700">Pregunta tipo PAES · M1</span>
                    <span className="rounded-full bg-slate-100 px-2.5 py-1 text-slate-600">{q.topic}</span>
                </div>

                <p className="text-[1.05rem] font-semibold leading-relaxed text-slate-900">
                    <Latex>{q.content}</Latex>
                </p>

                <div className="mt-5 grid gap-2.5" role="group" aria-label="Alternativas">
                    {Object.entries(q.alternatives).map(([k, v]) => {
                        const isRight = answered && k === q.correct
                        const isWrong = answered && k === picked && !right
                        return (
                            <button
                                key={k}
                                type="button"
                                onClick={() => choose(k)}
                                disabled={answered}
                                aria-pressed={picked === k}
                                className={cn(
                                    "group flex min-h-12 items-center gap-3 rounded-2xl border-2 border-b-4 px-4 py-2.5 text-left font-semibold transition-[background-color,border-color,transform] duration-150",
                                    !answered && "border-slate-200 text-slate-800 hover:border-blue-300 hover:bg-blue-50/60 active:translate-y-0.5 active:border-b-2",
                                    isRight && "border-emerald-500 bg-emerald-50 text-emerald-900",
                                    isWrong && "border-red-400 bg-red-50 text-red-900",
                                    answered && !isRight && !isWrong && "border-slate-200 text-slate-400"
                                )}
                            >
                                <span
                                    className={cn(
                                        "flex h-7 w-7 shrink-0 items-center justify-center rounded-lg text-sm font-black",
                                        isRight ? "bg-emerald-500 text-white" : isWrong ? "bg-red-500 text-white" : "bg-slate-100 text-slate-600 group-hover:bg-white"
                                    )}
                                >
                                    {isRight ? <Check size={16} strokeWidth={3} /> : isWrong ? <X size={16} strokeWidth={3} /> : k}
                                </span>
                                <span><Latex>{v}</Latex></span>
                            </button>
                        )
                    })}
                </div>

                <AnimatePresence initial={false}>
                    {answered && (
                        <motion.div
                            initial={reduce ? { opacity: 0 } : { opacity: 0, transform: "translateY(8px)" }}
                            animate={reduce ? { opacity: 1 } : { opacity: 1, transform: "translateY(0px)" }}
                            transition={{ duration: 0.25, ease: [0.23, 1, 0.32, 1] }}
                            className="mt-5 rounded-2xl bg-slate-50 p-4"
                            role="status"
                        >
                            <p className={cn("font-black", right ? "text-emerald-700" : "text-red-700")}>
                                {right ? "¡Correcto! Así se resuelve:" : `La correcta es la ${q.correct}. Así se resuelve:`}
                            </p>
                            {parsed ? (
                                <>
                                    {parsed.idea && (
                                        <p className="mt-1 text-sm font-semibold leading-relaxed text-slate-800"><Latex>{parsed.idea}</Latex></p>
                                    )}
                                    <ol className="mt-2 space-y-1.5 text-sm leading-relaxed text-slate-700">
                                        {parsed.steps.map((s, i) => (
                                            <li key={i} className="flex gap-2">
                                                <span className="font-black text-slate-500 tabular-nums">{i + 1}.</span>
                                                <span><Latex>{s}</Latex></span>
                                            </li>
                                        ))}
                                    </ol>
                                    {!right && pickedError && (
                                        <p className="mt-2 text-sm leading-relaxed text-slate-600">
                                            <span className="font-bold text-red-700">Tu alternativa ({picked}): </span>
                                            <Latex>{pickedError.text}</Latex>
                                        </p>
                                    )}
                                </>
                            ) : (
                                <>
                                    <p className="mt-1 text-sm leading-relaxed text-slate-700">
                                        <Latex>{legacySolution}</Latex>
                                    </p>
                                    {!right && picked && legacyWhy.length > 0 && (
                                        <p className="mt-2 text-sm leading-relaxed text-slate-600">
                                            <Latex>{(legacyWhy.find((l) => l.startsWith(picked)) ?? legacyWhy[0]).replace(/^([A-D]) /, "La alternativa $1 ")}</Latex>
                                        </p>
                                    )}
                                </>
                            )}
                            <div className="mt-4 flex flex-col gap-2 sm:flex-row sm:items-center">
                                <Link
                                    href="/register"
                                    className="inline-flex h-11 items-center justify-center rounded-xl border-b-4 border-blue-800 bg-blue-600 px-5 text-sm font-black text-white transition-[background-color,transform] duration-150 hover:bg-blue-700 active:translate-y-0.5 active:border-b-2"
                                >
                                    Seguir con 590 más, gratis
                                </Link>
                                <button
                                    type="button"
                                    onClick={() => {
                                        setPicked(null)
                                        setLine(null)
                                    }}
                                    className="h-11 rounded-xl px-4 text-sm font-bold text-slate-600 hover:bg-white hover:text-slate-900"
                                >
                                    Intentar de nuevo
                                </button>
                            </div>
                        </motion.div>
                    )}
                </AnimatePresence>
            </div>
        </div>
    )
}
