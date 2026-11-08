"use client"

import 'katex/dist/katex.min.css'
import katex from 'katex'

export default function LatexRenderer({ children }: { children: string }) {
    if (!children) return null
    if (typeof children !== 'string') return <span>{children}</span>

    const parts = children.split(/(\$[^\$]*\$)/g)

    // La puntuación que sigue a una fórmula ("$20\%$.") queda pegada a ella: así el
    // navegador no corta la línea entre la fórmula y el punto.
    const PUNCT = /^[.,;:!?)\]»”]+/
    const nodes: React.ReactNode[] = []
    for (let i = 0; i < parts.length; i++) {
        const part = parts[i]
        if (part.startsWith('$') && part.endsWith('$') && part.length > 1) {
            const content = part.slice(1, -1)
            if (!content) continue
            const isDisplayMode = content.trim().startsWith('\\displaystyle')
            let html: string | null = null
            try {
                html = katex.renderToString(content, { throwOnError: false, displayMode: isDisplayMode })
            } catch {
                html = null
            }
            const next = parts[i + 1] ?? ''
            const trailing = !isDisplayMode ? (next.match(PUNCT)?.[0] ?? '') : ''
            if (trailing) parts[i + 1] = next.slice(trailing.length)
            nodes.push(
                html === null ? (
                    <span key={i} className="text-red-500 font-mono text-xs">{part}</span>
                ) : (
                    <span key={i} className={isDisplayMode ? "block [&_.katex-display]:text-left [&_.katex-display]:my-1" : trailing ? "whitespace-nowrap" : undefined}>
                        <span dangerouslySetInnerHTML={{ __html: html }} />
                        {trailing}
                    </span>
                )
            )
        } else if (part) {
            nodes.push(<span key={i}>{part}</span>)
        }
    }

    return <span className="whitespace-pre-wrap">{nodes}</span>
}