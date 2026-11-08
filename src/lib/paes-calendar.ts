/**
 * Calendario oficial del Proceso de Admisión 2027 (DEMRE).
 *
 * Fuente: https://demre.cl/calendario/calendario-proceso-2027
 *         https://demre.cl/paes/regular/rendicion/los-dias-de-la-prueba/fechas-horarios
 * Verificado: 2026-11-07.
 *
 * Es la ÚNICA fuente de fechas PAES de la app: los componentes no deben escribir fechas a mano.
 * Para el próximo proceso, actualizar este archivo (y `VERIFIED_AT`).
 *
 * Horas en Chile continental. En noviembre–enero Chile está en horario de verano (UTC−3).
 */

export const ADMISSION_PROCESS = "Admisión 2027"
export const VERIFIED_AT = "2026-11-07"
export const DEMRE_CALENDAR_URL = "https://demre.cl/calendario/calendario-proceso-2027"

export type PaesSubject = "m1" | "m2"

export type PaesEvent = {
    id: string
    /** ISO 8601 con zona horaria de Chile */
    at: string
    title: string
    detail?: string
    kind: "exam" | "milestone"
    subject?: PaesSubject
}

export const PAES_EVENTS: PaesEvent[] = [
    { id: "beneficios", at: "2026-11-19T09:00:00-03:00", kind: "milestone", title: "Publicación de Servicios y Beneficios Universitarios" },
    { id: "reconocimiento", at: "2026-11-30T12:00:00-03:00", kind: "milestone", title: "Reconocimiento de salas", detail: "12:00 a 13:00 hrs" },
    { id: "m2", at: "2026-11-30T15:00:00-03:00", kind: "exam", subject: "m2", title: "PAES Competencia Matemática 2 (M2)", detail: "55 preguntas · 2 h 20 min" },
    { id: "lectora", at: "2026-12-01T09:00:00-03:00", kind: "exam", title: "PAES Competencia Lectora", detail: "65 preguntas · 2 h 30 min" },
    { id: "ciencias", at: "2026-12-01T15:00:00-03:00", kind: "exam", title: "PAES electiva de Ciencias", detail: "80 preguntas · 2 h 40 min" },
    { id: "m1", at: "2026-12-02T09:00:00-03:00", kind: "exam", subject: "m1", title: "PAES Competencia Matemática 1 (M1)", detail: "65 preguntas · 2 h 20 min" },
    { id: "historia", at: "2026-12-02T15:00:00-03:00", kind: "exam", title: "PAES electiva de Historia y Ciencias Sociales", detail: "65 preguntas · 2 h" },
    { id: "resultados", at: "2027-01-04T08:00:00-03:00", kind: "milestone", title: "Resultados de puntajes PAES" },
    { id: "postulacion", at: "2027-01-04T09:00:00-03:00", kind: "milestone", title: "Inicio de postulaciones", detail: "Hasta el jueves 7 de enero, 13:00 hrs" },
    { id: "seleccion", at: "2027-01-18T12:00:00-03:00", kind: "milestone", title: "Resultados del proceso de selección" },
    { id: "matricula", at: "2027-01-19T09:00:00-03:00", kind: "milestone", title: "Matrícula", detail: "1ª etapa 19–21 ene · 2ª etapa 22–28 ene" },
]

/** Prueba de matemática que rinde el alumno según la materia activa. */
export function examFor(subject: PaesSubject): PaesEvent {
    return PAES_EVENTS.find((e) => e.id === subject)!
}

/** Eventos que aún no ocurren (con una hora de gracia mientras se rinde la prueba). */
export function upcomingEvents(now: Date = new Date()): PaesEvent[] {
    const grace = 3 * 60 * 60 * 1000
    return PAES_EVENTS.filter((e) => new Date(e.at).getTime() + grace > now.getTime())
}

export type Countdown = { days: number; hours: number; minutes: number; isPast: boolean; isToday: boolean }

export function countdownTo(iso: string, now: Date = new Date()): Countdown {
    const diff = new Date(iso).getTime() - now.getTime()
    if (diff <= 0) return { days: 0, hours: 0, minutes: 0, isPast: true, isToday: false }
    const days = Math.floor(diff / 86_400_000)
    const hours = Math.floor((diff % 86_400_000) / 3_600_000)
    const minutes = Math.floor((diff % 3_600_000) / 60_000)
    const sameDay = formatDay(iso) === formatDay(now.toISOString())
    return { days, hours, minutes, isPast: false, isToday: sameDay }
}

const TZ = "America/Santiago"

/** "lunes 30 de noviembre" */
export function formatDay(iso: string): string {
    return new Intl.DateTimeFormat("es-CL", { weekday: "long", day: "numeric", month: "long", timeZone: TZ }).format(new Date(iso))
}

/** "lun 30 nov" */
export function formatShortDay(iso: string): string {
    return new Intl.DateTimeFormat("es-CL", { weekday: "short", day: "numeric", month: "short", timeZone: TZ })
        .format(new Date(iso))
        .replace(/\./g, "")
}

/** "15:00" */
export function formatTime(iso: string): string {
    return new Intl.DateTimeFormat("es-CL", { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: TZ }).format(new Date(iso))
}
