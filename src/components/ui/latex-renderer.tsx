"use client"

import 'katex/dist/katex.min.css'
// @ts-ignore
import { InlineMath } from 'react-katex'

export default function LatexRenderer({ children }: { children: string }) {
    if (!children) return null
    if (typeof children !== 'string') return <span>{children}</span>

    // Split by $...$ (non-greedy)
    // The capturing group () ensures the delimiter is included in the result array
    const parts = children.split(/(\$[^\$]*\$)/g)

    return (
        <span className="whitespace-pre-wrap">
            {parts.map((part, i) => {
                if (part.startsWith('$') && part.endsWith('$')) {
                    // Strip $ delimiters
                    const content = part.slice(1, -1)
                    // If empty (e.g. $$), ignore or render empty
                    if (!content) return null
                    return <InlineMath key={i} math={content} />
                }
                return <span key={i}>{part}</span>
            })}
        </span>
    )
}
