"use client"

import { createContext, useContext, useEffect, useMemo, useRef, useState, type ReactNode } from "react"
import { motion, useReducedMotion, useScroll, useTransform } from "framer-motion"
import { Flag } from "lucide-react"
import { cn } from "@/lib/utils"
import {
    countdownTo,
    examFor,
    formatDay,
    formatShortDay,
    formatTime,
    upcomingEvents,
    type PaesSubject,
} from "@/lib/paes-calendar"

/* ─────────────────────────── Materia elegida (compartida) ─────────────────────────── */

const SubjectCtx = createContext<{ subject: PaesSubject; setSubject: (s: PaesSubject) => void; now: Date | null }>({
    subject: "m1",
    setSubject: () => {},
    now: null,
})

export function CountdownProvider({ children }: { children: ReactNode }) {
    const [subject, setSubjectState] = useState<PaesSubject>("m1")
    const [now, setNow] = useState<Date | null>(null)

    useEffect(() => {
        setNow(new Date())
        try {
            const saved = localStorage.getItem("paes_subject")
            if (saved === "m1" || saved === "m2") setSubjectState(saved)
        } catch {}
        const id = setInterval(() => setNow(new Date()), 60_000)
        return () => clearInterval(id)
    }, [])

    // La misma clave que usa la app: lo que elijas aquí queda preseleccionado al entrar
    const setSubject = (s: PaesSubject) => {
        setSubjectState(s)
        try {
            localStorage.setItem("paes_subject", s)
        } catch {}
    }

    return <SubjectCtx.Provider value={{ subject, setSubject, now }}>{children}</SubjectCtx.Provider>
}

const useCountdown = () => useContext(SubjectCtx)

/* ─────────────────────────── Selector M1 / M2 ─────────────────────────── */

export function SubjectToggle() {
    const { subject, setSubject } = useCountdown()
    return (
        <div role="radiogroup" aria-label="¿Qué prueba rindes?" className="inline-flex rounded-2xl bg-slate-100 p-1">
            {(["m1", "m2"] as const).map((s) => (
                <button
                    key={s}
                    type="button"
                    role="radio"
                    aria-checked={subject === s}
                    onClick={() => setSubject(s)}
                    className={cn(
                        "relative rounded-xl px-4 py-2 text-sm font-black transition-colors duration-150",
                        subject === s ? "text-slate-900" : "text-slate-500 hover:text-slate-800"
                    )}
                >
                    {subject === s && (
                        <motion.span
                            layoutId="subject-pill"
                            className="absolute inset-0 rounded-xl bg-white shadow-[0_1px_2px_rgba(15,23,42,0.12),0_2px_8px_-2px_rgba(15,23,42,0.12)]"
                            transition={{ type: "spring", duration: 0.35, bounce: 0.15 }}
                        />
                    )}
                    <span className="relative">{s === "m1" ? "M1" : "M2"}</span>
                </button>
            ))}
        </div>
    )
}

/* ─────────────────────────── Odómetro de días ─────────────────────────── */

const EASE_OUT = "cubic-bezier(0.23, 1, 0.32, 1)"

/** Una ficha con un dígito que rueda hasta su valor (columna 0–9 desplazada con transform). */
function DigitTile({ digit, index, ready, inverse = false }: { digit: number; index: number; ready: boolean; inverse?: boolean }) {
    const reduce = useReducedMotion()
    const shown = ready ? digit : 0
    return (
        <span
            className={cn(
                "relative inline-flex h-[1.15em] w-[0.78em] items-start justify-center overflow-hidden rounded-[0.16em]",
                inverse
                    ? "bg-white text-blue-700 shadow-[inset_0_-0.06em_0_rgba(30,64,175,0.25),0_0.08em_0.2em_-0.04em_rgba(15,23,42,0.35)]"
                    : "bg-blue-600 text-white shadow-[inset_0_-0.06em_0_rgba(0,0,0,0.22),inset_0_0.05em_0_rgba(255,255,255,0.28),0_0.08em_0.2em_-0.04em_rgba(30,64,175,0.5)]"
            )}
            aria-hidden
        >
            <span
                className="flex flex-col items-center leading-[1.15em]"
                style={{
                    transform: `translateY(${-shown * 10}%)`,
                    transition: reduce || !ready ? "none" : `transform 900ms ${EASE_OUT} ${index * 60}ms`,
                }}
            >
                {Array.from({ length: 10 }, (_, n) => (
                    <span key={n} className="tabular-nums">
                        {n}
                    </span>
                ))}
            </span>
        </span>
    )
}

export function DayCounter({ inverse = false, compact = false }: { inverse?: boolean; compact?: boolean }) {
    const { subject, now } = useCountdown()
    const [ready, setReady] = useState(false)

    const exam = examFor(subject)
    const cd = now ? countdownTo(exam.at, now) : null
    const next = now ? upcomingEvents(now)[0] : null
    const examPassed = cd?.isPast ?? false
    const target = examPassed && next ? next : exam
    const days = now ? countdownTo(target.at, now).days : 0

    // Arranca el rodado en el siguiente frame (y otra vez al cambiar de materia)
    useEffect(() => {
        if (!now) return
        setReady(false)
        const id = requestAnimationFrame(() => requestAnimationFrame(() => setReady(true)))
        return () => cancelAnimationFrame(id)
    }, [now === null, subject])

    const digits = String(Math.max(0, days)).padStart(2, "0").split("").map(Number)
    const label = subject === "m1" ? "M1" : "M2"

    return (
        <div>
            <p className="sr-only" aria-live="polite">
                {examPassed ? `${days} días para: ${target.title}` : `Faltan ${days} días para tu PAES ${label}`}
            </p>
            <div
                className={cn(
                    "flex gap-[0.08em] font-black leading-none tracking-tight",
                    compact ? "text-[clamp(4rem,12vw,6.5rem)]" : "text-[clamp(8rem,34vw,18.5rem)]"
                )}
            >
                {digits.map((d, i) => (
                    <DigitTile key={`${subject}-${i}-${digits.length}`} digit={d} index={i} ready={ready} inverse={inverse} />
                ))}
            </div>
            {!compact && (
                <p className="mt-4 text-lg font-black leading-snug text-slate-900 sm:text-xl">
                    {days === 1 ? "día" : "días"} {examPassed ? "para los resultados" : <>para tu PAES {label}</>}
                    <span className="block text-base font-semibold text-slate-600 first-letter:uppercase">
                        {formatDay(target.at)} · {formatTime(target.at)} hrs
                    </span>
                </p>
            )}
        </div>
    )
}

/* ─────────────────────────── Plan semana a semana ─────────────────────────── */

type Week = { start: Date; end: Date; focus: string; detail: string; final?: boolean }

function buildPlan(now: Date, examIso: string, subject: PaesSubject): Week[] {
    const exam = new Date(examIso)
    const msWeek = 7 * 86_400_000
    const total = Math.max(1, Math.ceil((exam.getTime() - now.getTime()) / msWeek))
    const n = Math.min(total, 6)
    const blocks =
        subject === "m1"
            ? [
                  { focus: "Números", detail: "Enteros, porcentaje, potencias y raíces" },
                  { focus: "Álgebra y funciones", detail: "Ecuaciones, proporcionalidad y funciones" },
                  { focus: "Geometría", detail: "Áreas, volúmenes y transformaciones" },
                  { focus: "Probabilidad y estadística", detail: "Tablas, gráficos y probabilidades" },
              ]
            : [
                  { focus: "Álgebra y funciones", detail: "Cuadrática, exponencial, logaritmos" },
                  { focus: "Números", detail: "Reales, logaritmos y matemática financiera" },
                  { focus: "Geometría", detail: "Homotecia, trigonometría y semejanza" },
                  { focus: "Probabilidad y estadística", detail: "Condicional, combinatoria y dispersión" },
              ]
    const weeks: Week[] = []
    for (let i = 0; i < n; i++) {
        const start = new Date(now.getTime() + i * msWeek)
        const end = i === n - 1 ? exam : new Date(start.getTime() + msWeek - 86_400_000)
        if (i === n - 1) {
            weeks.push({ start, end, focus: "Ensayos y repaso", detail: "Ensayo completo con puntaje PAES y tu banco de errores", final: true })
        } else {
            // Reparte los 4 ejes en las semanas de estudio, sin repetir ni dejar semanas vacías
            // (con 3 semanas: Números | Álgebra | Geometría + Probabilidad)
            const study = n - 1
            const from = Math.floor((i * blocks.length) / study)
            const to = Math.max(from + 1, Math.floor(((i + 1) * blocks.length) / study))
            const b = study > blocks.length ? [blocks[i % blocks.length]] : blocks.slice(from, to)
            weeks.push({ start, end, focus: b.map((x) => x.focus).join(" + "), detail: b.map((x) => x.detail).join(" · ") })
        }
    }
    return weeks
}

export function StudyPlan() {
    const { subject, now } = useCountdown()
    const exam = examFor(subject)
    const plan = useMemo(() => (now ? buildPlan(now, exam.at, subject) : []), [now, exam.at, subject])
    if (!now || countdownTo(exam.at, now).isPast) return null

    const label = subject === "m1" ? "M1" : "M2"

    return (
        <div>
            <div className="flex flex-col gap-3 md:flex-row md:items-end md:justify-between">
                <h2 id="plan-title" className="max-w-xl text-3xl font-black tracking-tight text-slate-900 text-balance md:text-4xl">
                    Tu plan para llegar a la PAES {label}
                </h2>
                <p className="max-w-md text-slate-600">
                    Plan sugerido de {plan.length} {plan.length === 1 ? "semana" : "semanas"}: 10 preguntas al día, un eje por semana y un ensayo al final.
                </p>
            </div>
            <PlanTimeline plan={plan} examAt={exam.at} />
        </div>
    )
}

/** Se monta solo cuando el plan existe: useScroll necesita el elemento ya hidratado. */
function PlanTimeline({ plan, examAt }: { plan: Week[]; examAt: string }) {
    const reduce = useReducedMotion()
    const ref = useRef<HTMLOListElement>(null)
    const { scrollYProgress } = useScroll({ target: ref, offset: ["start 85%", "end 60%"] })
    const lineScale = useTransform(scrollYProgress, [0, 1], [0, 1])

    return (
        <ol ref={ref} className="relative mt-10 grid gap-8 md:grid-cols-[repeat(var(--n),minmax(0,1fr))] md:gap-4" style={{ ["--n" as string]: plan.length }}>
            {/* Riel: se dibuja con el scroll (solo transform) */}
            <span aria-hidden className="absolute left-[1.15rem] top-0 h-full w-1 rounded-full bg-slate-200 md:left-0 md:top-[1.15rem] md:h-1 md:w-full" />
            <motion.span
                aria-hidden
                className="absolute left-[1.15rem] top-0 h-full w-1 origin-top rounded-full bg-blue-600 md:hidden"
                style={reduce ? undefined : { scaleY: lineScale }}
            />
            <motion.span
                aria-hidden
                className="absolute left-0 top-[1.15rem] hidden h-1 w-full origin-left rounded-full bg-blue-600 md:block"
                style={reduce ? undefined : { scaleX: lineScale }}
            />

            {plan.map((w, i) => (
                <li key={i} className="relative pl-14 md:pl-0 md:pt-14">
                    <span
                        className={cn(
                            "absolute left-0 top-0 flex h-10 w-10 items-center justify-center rounded-full border-4 border-slate-50 text-sm font-black tabular-nums shadow-sm",
                            w.final ? "bg-amber-400 text-amber-950" : "bg-blue-600 text-white"
                        )}
                    >
                        {w.final ? <Flag size={16} strokeWidth={3} aria-label="Día de la PAES" /> : i + 1}
                    </span>
                    <h3 className="text-lg font-black leading-snug text-slate-900">{w.focus}</h3>
                    <p className="mt-0.5 text-sm font-semibold text-slate-500 tabular-nums">
                        {i === 0 ? "Desde hoy" : formatShortDay(w.start.toISOString())}
                        {" → "}
                        {w.final ? `${formatShortDay(examAt)}, día de la PAES` : formatShortDay(w.end.toISOString())}
                    </p>
                    <p className="mt-2 text-sm text-slate-600">{w.detail}</p>
                </li>
            ))}
        </ol>
    )
}

/** "Faltan 22 días para tu PAES M1" en texto, para la banda final. */
export function DaysLeftText() {
    const { subject, now } = useCountdown()
    if (!now) return <span>Tu PAES se acerca</span>
    const exam = examFor(subject)
    const cd = countdownTo(exam.at, now)
    if (cd.isPast) return <span>Prepárate desde ya para tu próxima PAES</span>
    if (cd.isToday) return <span>¡Hoy es tu PAES {subject.toUpperCase()}! Mucho éxito</span>
    return (
        <span>
            Faltan <span className="tabular-nums">{cd.days}</span> {cd.days === 1 ? "día" : "días"} para tu PAES {subject.toUpperCase()}
        </span>
    )
}
