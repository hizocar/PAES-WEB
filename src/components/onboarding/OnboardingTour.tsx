"use client"

import { useState, useEffect, useRef } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { Button } from "@/components/ui/button"
import { Zap, Heart, Trophy, Target, ArrowLeft, ArrowRight, X, Star } from "lucide-react"

export interface OnboardingStep {
    targetId?: string
    title: string
    description: string
    icon: React.ReactNode
    position: 'center' | 'top' | 'bottom' | 'left' | 'right'
}

interface OnboardingTourProps {
    steps: OnboardingStep[]
    onComplete: () => void
}

export function OnboardingTour({ steps, onComplete }: OnboardingTourProps) {
    const [currentStep, setCurrentStep] = useState(0)
    const [coords, setCoords] = useState({ top: 0, left: 0, width: 0, height: 0 })
    const [isMobile, setIsMobile] = useState(false)
    const tourBoxRef = useRef<HTMLDivElement>(null)
    const padding = 8

    useEffect(() => {
        const checkMobile = () => setIsMobile(window.innerWidth < 768)
        checkMobile()
        window.addEventListener('resize', checkMobile)
        return () => window.removeEventListener('resize', checkMobile)
    }, [])

    useEffect(() => {
        const updateCoords = () => {
            const step = steps[currentStep]
            let targetId = step.targetId

            // On mobile, point to the menu button for sidebar items
            if (isMobile && targetId && ['tour-switcher', 'tour-practice', 'tour-mistakes', 'tour-profile', 'tour-ranking'].includes(targetId)) {
                targetId = 'tour-mobile-menu'
            }

            if (targetId) {
                const el = document.getElementById(targetId)
                if (el) {
                    const rect = el.getBoundingClientRect()
                    setCoords({
                        top: rect.top - padding,
                        left: rect.left - padding,
                        width: rect.width + (padding * 2),
                        height: rect.height + (padding * 2)
                    })
                    el.scrollIntoView({ behavior: 'smooth', block: 'center' })
                }
            }
        }

        updateCoords()
        window.addEventListener('resize', updateCoords)
        return () => window.removeEventListener('resize', updateCoords)
    }, [currentStep, steps, isMobile])

    const handleNext = () => {
        if (currentStep < steps.length - 1) {
            setCurrentStep(currentStep + 1)
        } else {
            onComplete()
        }
    }

    const handleBack = () => {
        if (currentStep > 0) {
            setCurrentStep(currentStep - 1)
        }
    }

    const currentData = steps[currentStep]

    // Calculate smart positioning for the tour box
    const getBoxStyle = () => {
        if (currentData.position === 'center') {
            return {
                top: '50%',
                left: '50%',
                transform: 'translate(-50%, -50%)',
            }
        }

        let top = 0
        let left = 0
        const boxWidth = 360
        const boxHeight = 240 // heuristic
        const margin = 16

        if (currentData.position === 'bottom') {
            top = coords.top + coords.height + margin
            left = coords.left + (coords.width / 2) - (boxWidth / 2)
        } else if (currentData.position === 'right') {
            top = coords.top + (coords.height / 2) - (boxHeight / 2)
            left = coords.left + coords.width + margin
        } else if (currentData.position === 'left') {
            top = coords.top + (coords.height / 2) - (boxHeight / 2)
            left = coords.left - boxWidth - margin
        } else if (currentData.position === 'top') {
            top = coords.top - boxHeight - margin
            left = coords.left + (coords.width / 2) - (boxWidth / 2)
        }

        // Keep inside viewport
        const viewportWidth = window.innerWidth
        const viewportHeight = window.innerHeight

        // Simple flip logic if it's too close to the edge
        if (currentData.position === 'bottom' && top + boxHeight > viewportHeight - margin) {
            top = coords.top - boxHeight - margin
        } else if (currentData.position === 'top' && top < margin) {
            top = coords.top + coords.height + margin
        }

        left = Math.max(margin, Math.min(left, viewportWidth - boxWidth - margin))
        top = Math.max(margin, Math.min(top, viewportHeight - boxHeight - margin))

        return { top, left }
    }

    const boxStyle = getBoxStyle()

    return (
        <div className="fixed inset-0 z-[100] overflow-hidden pointer-events-none">
            {/* Backdrop with path hole */}
            <motion.div
                className="absolute inset-0 bg-slate-900/70 backdrop-blur-[2px] pointer-events-auto"
                initial={{ opacity: 0 }}
                animate={{ opacity: 1 }}
                style={{
                    clipPath: (currentData.targetId && (!isMobile || (currentData.targetId !== 'tour-switcher' && currentData.targetId !== 'tour-practice' && currentData.targetId !== 'tour-mistakes' && currentData.targetId !== 'tour-profile')) || document.getElementById('tour-mobile-menu'))
                        ? `polygon(0% 0%, 0% 100%, ${coords.left}px 100%, ${coords.left}px ${coords.top}px, ${coords.left + coords.width}px ${coords.top}px, ${coords.left + coords.width}px ${coords.top + coords.height}px, ${coords.left}px ${coords.top + coords.height}px, ${coords.left}px 100%, 100% 100%, 100% 0%)`
                        : 'none'
                }}
            />

            {/* Glowing Border around target */}
            {(currentData.targetId || (isMobile && (currentData.targetId === 'tour-switcher' || currentData.targetId === 'tour-practice' || currentData.targetId === 'tour-mistakes' || currentData.targetId === 'tour-profile'))) && (
                <motion.div
                    initial={{ opacity: 0, scale: 0.8 }}
                    animate={{
                        opacity: 1,
                        scale: 1,
                        top: coords.top,
                        left: coords.left,
                        width: coords.width,
                        height: coords.height
                    }}
                    transition={{ type: "spring", damping: 20, stiffness: 200 }}
                    className="absolute border-2 border-blue-400 rounded-xl shadow-[0_0_15px_rgba(59,130,246,0.5)] z-[102] pointer-events-none"
                />
            )}

            <AnimatePresence mode="wait">
                <motion.div
                    key={currentStep}
                    ref={tourBoxRef}
                    initial={{ opacity: 0, scale: 0.9, y: 20 }}
                    animate={{
                        opacity: 1,
                        scale: 1,
                        y: 0,
                        ...boxStyle
                    }}
                    exit={{ opacity: 0, scale: 0.9, y: 10 }}
                    transition={{ type: "spring", damping: 25, stiffness: 300 }}
                    className="absolute z-[101] w-[320px] md:w-[380px] bg-white rounded-3xl shadow-2xl p-6 pointer-events-auto border border-blue-50"
                >
                    <div className="flex items-start justify-between mb-4">
                        <div className="w-12 h-12 bg-blue-50 rounded-2xl flex items-center justify-center text-2xl shadow-inner">
                            {currentData.icon}
                        </div>
                        <button
                            onClick={onComplete}
                            className="p-1.5 hover:bg-slate-100 rounded-xl text-slate-400 transition-colors"
                        >
                            <X size={18} />
                        </button>
                    </div>

                    <h2 className="text-xl font-black text-slate-900 mb-2 leading-tight tracking-tight">
                        {currentData.title}
                    </h2>
                    <p className="text-slate-600 text-[15px] leading-relaxed mb-8">
                        {isMobile && (currentData.targetId === 'tour-switcher' || currentData.targetId === 'tour-practice' || currentData.targetId === 'tour-mistakes' || currentData.targetId === 'tour-profile')
                            ? `En el menú (esquina superior derecha) ${currentData.description.toLowerCase()}`
                            : currentData.description}
                    </p>

                    <div className="flex items-center justify-between mt-auto">
                        <div className="flex gap-1.5">
                            {steps.map((_, i) => (
                                <div
                                    key={i}
                                    className={`h-1 rounded-full transition-all duration-500 ${i === currentStep ? 'w-8 bg-blue-600' : 'w-1.5 bg-slate-200'}`}
                                />
                            ))}
                        </div>
                        <div className="flex items-center gap-2">
                            {currentStep > 0 && (
                                <button
                                    onClick={handleBack}
                                    className="p-2 text-slate-400 hover:text-slate-600 transition-colors"
                                    title="Atrás"
                                >
                                    <ArrowLeft size={18} />
                                </button>
                            )}
                            <Button
                                size="sm"
                                onClick={handleNext}
                                className="bg-blue-600 hover:bg-blue-700 text-white font-black rounded-full px-6 h-10 shadow-lg shadow-blue-200 group"
                            >
                                {currentStep === steps.length - 1 ? "¡Todo claro!" : "Siguiente"}
                                {currentStep < steps.length - 1 && <ArrowRight size={16} className="ml-2 group-hover:translate-x-1 transition-transform" />}
                            </Button>
                        </div>
                    </div>
                </motion.div>
            </AnimatePresence>
        </div>
    )
}
