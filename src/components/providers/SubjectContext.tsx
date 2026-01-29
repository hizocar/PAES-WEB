"use client"

import { createContext, useContext, useState, useEffect, ReactNode } from "react"

type Subject = 'm1' | 'm2'

interface SubjectContextType {
    subject: Subject
    setSubject: (subject: Subject) => void
}

const SubjectContext = createContext<SubjectContextType | undefined>(undefined)

export function SubjectProvider({ children }: { children: ReactNode }) {
    const [subject, setSubjectState] = useState<Subject | null>(null)

    // Load from localStorage on mount
    useEffect(() => {
        const saved = localStorage.getItem('paes_subject') as Subject
        if (saved && (saved === 'm1' || saved === 'm2')) {
            setSubjectState(saved)
        } else {
            setSubjectState('m2') // Default to m2 if nothing saved
        }
    }, [])

    const setSubject = (newSubject: Subject) => {
        setSubjectState(newSubject)
        localStorage.setItem('paes_subject', newSubject)
    }

    // Block rendering until subject is determined to prevent race conditions/flashes
    if (!subject) {
        return null // Or a global loader if preferred, but null is fine for instant hydration check
    }

    return (
        <SubjectContext.Provider value={{ subject, setSubject }}>
            {children}
        </SubjectContext.Provider>
    )
}

export function useSubject() {
    const context = useContext(SubjectContext)
    if (context === undefined) {
        throw new Error("useSubject must be used within a SubjectProvider")
    }
    return context
}
