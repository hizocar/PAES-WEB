"use client"

import { useEffect, useState } from "react"
import { CalendarDays, ChevronDown, ExternalLink } from "lucide-react"
import { cn } from "@/lib/utils"
import { useSubject } from "@/components/providers/SubjectContext"
import {
    ADMISSION_PROCESS,
    DEMRE_CALENDAR_URL,
    countdownTo,
    examFor,
    formatDay,
    formatShortDay,
    formatTime,
    upcomingEvents,
    type PaesEvent,
} from "@/lib/paes-calendar"

/**
 * Cuenta regresiva a la PAES de la materia activa (M1 o M2) y calendario oficial desplegable.
 * Todas las fechas salen de src/lib/paes-calendar.ts.
 */
export function PaesCountdown({ className }: { className?: string }) {
    const { subject } = useSubject()
    const [now, setNow] = useState<Date | null>(null)
    const [open, setOpen] = useState(false)

    useEffect(() => {
        setNow(new Date())
        const id = setInterval(() => setNow(new Date()), 60_000)
        return () => clearInterval(id)
    }, [])

    const exam = examFor(subject)
    const upcoming = now ? upcomingEvents(now) : []
    // Si la prueba de la materia ya pasó, apuntamos al siguiente hito del proceso
    const target: PaesEvent = now && countdownTo(exam.at, now).isPast ? (upcoming[0] ?? exam) : exam
    const cd = now ? countdownTo(target.at, now) : null
    const isExam = target.kind === "exam"
    const label = subject.toUpperCase()

    return (
        <section
            className={cn("rounded-2xl border border-slate-200 bg-white p-5 shadow-sm", className)}
            aria-labelledby="paes-countdown-title"
        >
            <div className="flex items-start justify-between gap-4">
                <div className="min-w-0">
                    <h2 id="paes-countdown-title" className="text-sm font-bold text-slate-900">
                        {isExam ? `Tu PAES ${label}` : target.title}
                    </h2>
                    <p className="mt-0.5 text-sm text-slate-500 first-letter:uppercase">
                        {formatDay(target.at)} · {formatTime(target.at)} hrs
                    </p>
                </div>
                <span className="shrink-0 rounded-full bg-blue-50 px-2.5 py-1 text-xs font-bold text-blue-700">
                    {ADMISSION_PROCESS}
                </span>
            </div>

            <div className="mt-4 flex items-end gap-5" aria-live="polite">
                {cd === null ? (
                    <div className="h-12 w-40 animate-pulse rounded-lg bg-slate-100" />
                ) : cd.isToday ? (
                    <p className="text-3xl font-black text-blue-600">¡Es hoy! 💪</p>
                ) : (
                    <>
                        <div>
                            <span className="text-5xl font-black leading-none tracking-tight text-slate-900 tabular-nums">
                                {cd.days}
                            </span>
                            <span className="ml-1.5 text-sm font-bold text-slate-500">{cd.days === 1 ? "día" : "días"}</span>
                        </div>
                        <div className="pb-1 text-sm font-semibold text-slate-500 tabular-nums">
                            {cd.hours} h {cd.minutes} min
                        </div>
                    </>
                )}
            </div>

            {isExam && target.detail && <p className="mt-2 text-xs font-medium text-slate-500">{target.detail}</p>}

            <button
                type="button"
                onClick={() => setOpen((v) => !v)}
                aria-expanded={open}
                aria-controls="paes-calendar-list"
                className="mt-4 flex w-full items-center justify-between rounded-xl px-3 py-2 text-sm font-bold text-slate-700 transition-colors hover:bg-slate-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
            >
                <span className="flex items-center gap-2">
                    <CalendarDays size={16} className="text-blue-600" aria-hidden />
                    Calendario oficial
                </span>
                <ChevronDown size={16} className={cn("text-slate-400 transition-transform duration-200", open && "rotate-180")} aria-hidden />
            </button>

            {open && (
                <div id="paes-calendar-list" className="mt-2 border-t border-slate-100 pt-3">
                    <ol className="space-y-2.5">
                        {upcoming.map((e) => {
                            const mine = e.subject === subject
                            return (
                                <li key={e.id} className="flex gap-3 text-sm">
                                    <span className={cn("w-[5.5rem] shrink-0 font-semibold tabular-nums", mine ? "text-blue-700" : "text-slate-500")}>
                                        {formatShortDay(e.at)}
                                    </span>
                                    <span className={cn("min-w-0", mine ? "font-bold text-slate-900" : "text-slate-700")}>
                                        {e.title}
                                        <span className="block text-xs font-normal text-slate-500">
                                            {formatTime(e.at)} hrs{e.detail ? ` · ${e.detail}` : ""}
                                        </span>
                                    </span>
                                </li>
                            )
                        })}
                    </ol>
                    <a
                        href={DEMRE_CALENDAR_URL}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="mt-3 inline-flex items-center gap-1 text-xs font-semibold text-blue-700 underline-offset-2 hover:underline"
                    >
                        Fuente: calendario DEMRE <ExternalLink size={12} aria-hidden />
                    </a>
                </div>
            )}
        </section>
    )
}
