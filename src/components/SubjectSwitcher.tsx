"use client"

import { useSubject } from "@/components/providers/SubjectContext"
import { Button } from "@/components/ui/button"
import { Check } from "lucide-react"

export function SubjectSwitcher() {
    const { subject, setSubject } = useSubject()

    return (
        <div className="mx-4 mb-4 p-1 bg-slate-100 rounded-lg flex gap-1">
            <Button
                variant="ghost"
                size="sm"
                onClick={() => setSubject('m1')}
                className={`flex-1 text-xs font-bold ${subject === 'm1' ? 'bg-white text-blue-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
            >
                M1
            </Button>
            <Button
                variant="ghost"
                size="sm"
                onClick={() => setSubject('m2')}
                className={`flex-1 text-xs font-bold ${subject === 'm2' ? 'bg-white text-blue-600 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}
            >
                M2
            </Button>
        </div>
    )
}
