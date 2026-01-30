"use client"

import { createContext, useContext, useEffect, useRef, useState } from "react"
import { createClient } from "@/lib/supabase/client"
import { useAuth } from "./auth-provider"
import { useSubject } from "@/components/providers/SubjectContext"

type StudyTrackerType = {
    isTracking: boolean
    todaySeconds: number
}

const StudyTrackerContext = createContext<StudyTrackerType>({
    isTracking: false,
    todaySeconds: 0,
})

const IDLE_TIMEOUT_MS = 2 * 60 * 1000 // 2 minutes
const PING_INTERVAL_MS = 30 * 1000 // Save every 30s

export function StudyTrackerProvider({ children }: { children: React.ReactNode }) {
    const { user } = useAuth()
    const { subject } = useSubject()
    const supabase = createClient()

    const [isTracking, setIsTracking] = useState(false)
    const [todaySeconds, setTodaySeconds] = useState(0)

    const sessionIdRef = useRef<string | null>(null)
    const startTimeRef = useRef<number | null>(null)
    const lastActiveRef = useRef<number>(Date.now())
    const idleTimerRef = useRef<NodeJS.Timeout | null>(null)

    // Start/Stop session logic
    const startSession = async () => {
        if (sessionIdRef.current || !user) return

        const now = new Date()
        startTimeRef.current = now.getTime()
        setIsTracking(true)

        try {
            const { data, error } = await supabase
                .from('study_sessions')
                .insert({
                    user_id: user.id,
                    started_at: now.toISOString(),
                    subject: subject
                })
                .select('id')
                .single()

            if (data) {
                sessionIdRef.current = data.id
            }
        } catch (e) {
            console.error("Failed to start study session", e)
        }
    }

    const endSession = async () => {
        if (!sessionIdRef.current || !user) return

        const now = new Date()
        const end = now.toISOString()
        const duration = startTimeRef.current
            ? Math.round((now.getTime() - startTimeRef.current) / 1000)
            : 0

        // Update local stats
        setTodaySeconds(prev => prev + duration)

        const sid = sessionIdRef.current
        sessionIdRef.current = null // Preventive null
        startTimeRef.current = null
        setIsTracking(false)

        try {
            await supabase
                .from('study_sessions')
                .update({
                    ended_at: end,
                    duration_seconds: duration
                })
                .eq('id', sid)
        } catch (e) {
            console.error("Failed to end session", e)
        }
    }

    // Handle activity
    const handleActivity = () => {
        lastActiveRef.current = Date.now()
        if (!sessionIdRef.current) {
            startSession()
        }
        if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
        idleTimerRef.current = setTimeout(() => {
            endSession() // Go idle
        }, IDLE_TIMEOUT_MS)
    }

    useEffect(() => {
        if (!user) return

        // Activity listeners
        const events = ['mousedown', 'keydown', 'scroll', 'touchstart']
        const onEvent = () => handleActivity()

        events.forEach(e => window.addEventListener(e, onEvent))
        handleActivity() // Start immediately

        // Visibility
        const onVisibilityChange = () => {
            if (document.hidden) {
                endSession()
            } else {
                handleActivity()
            }
        }
        document.addEventListener('visibilitychange', onVisibilityChange)

        // Unload
        const onBeforeUnload = () => {
            endSession()
        }
        window.addEventListener('beforeunload', onBeforeUnload)

        // Cleanup
        return () => {
            events.forEach(e => window.removeEventListener(e, onEvent))
            document.removeEventListener('visibilitychange', onVisibilityChange)
            window.removeEventListener('beforeunload', onBeforeUnload)
            if (idleTimerRef.current) clearTimeout(idleTimerRef.current)
            endSession()
        }
    }, [user])

    return (
        <StudyTrackerContext.Provider value={{ isTracking, todaySeconds }}>
            {children}
        </StudyTrackerContext.Provider>
    )
}
