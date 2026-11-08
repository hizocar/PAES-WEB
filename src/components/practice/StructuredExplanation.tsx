import Latex from "@/components/ui/latex-renderer"
import { cn } from "@/lib/utils"

/**
 * Explicación con la estructura del banco (content/SPEC.md):
 * "Idea clave: …\nPaso 1: …\nRespuesta: …\nErrores frecuentes: …".
 * Si el texto no sigue esa estructura, se muestra tal cual.
 */
export type ParsedExplanation = {
    idea?: string
    steps: string[]
    answer?: string
    errors: { letter: string | null; text: string }[]
}

const LABEL = /^(Idea clave|Paso \d+|Respuesta|Errores frecuentes):\s*(.*)$/

export function parseExplanation(text: string): ParsedExplanation | null {
    const lines = text.split("\n").map((l) => l.trim()).filter(Boolean)
    if (!lines[0] || !lines[0].startsWith("Idea clave:")) return null
    const out: ParsedExplanation = { steps: [], errors: [] }
    let last: "idea" | "step" | "answer" | "errors" | null = null
    for (const line of lines) {
        const m = line.match(LABEL)
        if (!m) {
            // Línea suelta: se agrega al bloque anterior
            if (last === "step" && out.steps.length) out.steps[out.steps.length - 1] += " " + line
            else if (last === "errors") out.errors.push({ letter: null, text: line })
            continue
        }
        const [, label, body] = m
        if (label === "Idea clave") { out.idea = body; last = "idea" }
        else if (label.startsWith("Paso")) { out.steps.push(body); last = "step" }
        else if (label === "Respuesta") { out.answer = body; last = "answer" }
        else {
            last = "errors"
            // Una viñeta por distractor: separa en cada oración que empieza con "La X"
            for (const part of body.split(/(?<=[.)])\s+(?=La [A-F]\b)/)) {
                const lm = part.match(/^La ([A-F])\b\s*/)
                out.errors.push({ letter: lm ? lm[1] : null, text: lm ? part.slice(lm[0].length) : part })
            }
        }
    }
    return out
}

export function StructuredExplanation({ text, compact = false }: { text: string; compact?: boolean }) {
    const p = parseExplanation(text)
    if (!p) return <Latex>{text}</Latex>

    return (
        <div className={cn("space-y-4 text-slate-700", compact && "space-y-3 text-sm")}>
            {p.idea && (
                <div className="rounded-xl bg-blue-50 px-4 py-3">
                    <p className="text-xs font-black uppercase tracking-wide text-blue-700">Idea clave</p>
                    <p className="mt-1 font-semibold leading-relaxed text-slate-900"><Latex>{p.idea}</Latex></p>
                </div>
            )}

            {p.steps.length > 0 && (
                <ol className="space-y-2.5">
                    {p.steps.map((s, i) => (
                        <li key={i} className="flex gap-3">
                            <span className="mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-slate-100 text-xs font-black text-slate-600 tabular-nums">
                                {i + 1}
                            </span>
                            <span className="leading-relaxed"><Latex>{s}</Latex></span>
                        </li>
                    ))}
                </ol>
            )}

            {p.answer && (
                <p className="rounded-xl border-2 border-emerald-200 bg-emerald-50 px-4 py-2.5 font-bold leading-relaxed text-emerald-900">
                    <Latex>{p.answer}</Latex>
                </p>
            )}

            {p.errors.length > 0 && (
                <div>
                    <p className="text-xs font-black uppercase tracking-wide text-slate-500">Errores frecuentes</p>
                    <ul className="mt-2 space-y-2">
                        {p.errors.map((e, i) => (
                            <li key={i} className="flex gap-2.5 leading-relaxed">
                                {e.letter ? (
                                    <span className="mt-0.5 flex h-6 w-6 shrink-0 items-center justify-center rounded-lg bg-red-50 text-xs font-black text-red-700">
                                        {e.letter}
                                    </span>
                                ) : (
                                    <span className="mt-2.5 h-1.5 w-1.5 shrink-0 rounded-full bg-slate-300" aria-hidden />
                                )}
                                <span><Latex>{e.text}</Latex></span>
                            </li>
                        ))}
                    </ul>
                </div>
            )}
        </div>
    )
}
