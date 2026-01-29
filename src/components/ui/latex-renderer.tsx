"use client"

import 'katex/dist/katex.min.css'
import 'katex/dist/katex.min.css'
import katex from 'katex'

export default function LatexRenderer({ children }: { children: string }) {
    if (!children) return null
    if (typeof children !== 'string') return <span>{children}</span>

    const parts = children.split(/(\$[^\$]*\$)/g)

    return (
        <span className="whitespace-pre-wrap">
            {parts.map((part, i) => {
                if (part.startsWith('$') && part.endsWith('$')) {
                    const content = part.slice(1, -1)
                    if (!content) return null

                    try {
                        const html = katex.renderToString(content, {
                            throwOnError: false, // Don't throw, render error in red
                            displayMode: false
                        })
                        return <span key={i} dangerouslySetInnerHTML={{ __html: html }} />
                    } catch (error) {
                        // Fallback in case something really bad happens
                        return <span key={i} className="text-red-500 font-mono text-xs">{part}</span>
                    }
                }
                return <span key={i}>{part}</span>
            })}
        </span>
    )
}
