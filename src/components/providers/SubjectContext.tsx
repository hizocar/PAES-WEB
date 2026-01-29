"use client"

import { createContext, useContext, useState, useEffect, ReactNode } from "react"

type Subject = 'm1' | 'm2'

interface SubjectContextType {
    subject: Subject
    setSubject: (subject: Subject) => void
}

const SubjectContext = createContext<SubjectContextType | undefined>(undefined)

export function SubjectProvider({ children }: { children: ReactNode }) {
    const [subject, setSubjectState] = useState<Subject>('m2')

    // Load from localStorage on mount
    useEffect(() => {
        const saved = localStorage.getItem('paes_subject') as Subject
        if (saved && (saved === 'm1' || saved === 'm2')) {
            setSubjectState(saved)
        }
    }, [])

    const setSubject = (newSubject: Subject) => {
        setSubjectState(newSubject)
        localStorage.setItem('paes_subject', newSubject)
        // Force reload to ensure all data fetches use new subject
        // Alternatively we can use React Query or context propagation, but reload is safest for now
        // window.location.reload() // Let's try responsive first, if sticky bugs, enable reload
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
