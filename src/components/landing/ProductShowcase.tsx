"use client"

import { useState, useEffect, useRef } from "react"
import Image from "next/image"
import { cn } from "@/lib/utils"
import {
    BrainCircuit,
    Zap,
    BarChart3,
    Target
} from "lucide-react"

const features = [
    {
        id: "ia",
        title: "Ensayos con preguntas PAES",
        description: "Nuestro algoritmo detecta tus vacíos y te bombardea con ejercicios clave hasta que los domines.",
        icon: BrainCircuit,
        color: "bg-blue-100 text-blue-600",
        imageSrc: "/features/ia.png"
    },
    {
        id: "lives",
        title: "Vidas y Rachas",
        description: "La práctica debe doler (un poco). Tienes vidas diarias. Si fallas, pierdes. Si aciertas, subes.",
        icon: Target,
        color: "bg-red-100 text-red-600",
        imageSrc: "/features/lives.png"
    },
    {
        id: "feedback",
        title: "Feedback Total",
        description: "¿Te equivocaste? No pasa nada. Accede a explicaciones detalladas y videos paso a paso.",
        icon: Zap,
        color: "bg-amber-100 text-amber-600",
        imageSrc: "/features/feedback.png"
    },
    {
        id: "ranking",
        title: "Ranking Nacional",
        description: "Compite con estudiantes de todo Chile. Sube de liga, gana medallas y mide tu preparación.",
        icon: BarChart3,
        color: "bg-purple-100 text-purple-600",
        imageSrc: "/features/ranking.png"
    }
]

export default function ProductShowcase() {
    const [activeFeature, setActiveFeature] = useState(0)
    const [isAutoPlaying, setIsAutoPlaying] = useState(true)
    const [progress, setProgress] = useState(0)

    // Auto-rotation logic
    useEffect(() => {
        if (!isAutoPlaying) return

        const duration = 5000 // 5 seconds per slide
        const interval = 50 // Update progress bar every 50ms
        const step = 100 / (duration / interval)

        const timer = setInterval(() => {
            setProgress(prev => {
                if (prev >= 100) {
                    setActiveFeature(current => (current + 1) % features.length)
                    return 0
                }
                return prev + step
            })
        }, interval)

        return () => clearInterval(timer)
    }, [isAutoPlaying, activeFeature])

    // Reset progress when activeFeature changes (either manually or automatically)
    useEffect(() => {
        setProgress(0)
    }, [activeFeature])

    const handleManualSelect = (index: number) => {
        setActiveFeature(index)
        setIsAutoPlaying(false) // Pause auto-play on interaction
        // Optional: restart auto-play after a delay?
        // setTimeout(() => setIsAutoPlaying(true), 10000)
    }

    return (
        <section id="features" className="py-20 md:py-32 bg-slate-50 overflow-hidden relative">
            <div className="container mx-auto px-6">
                <div className="text-center mb-16 md:mb-24 max-w-3xl mx-auto">
                    <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-indigo-50 text-indigo-600 text-xs font-bold uppercase tracking-wider mb-6">
                        <Zap size={14} className="fill-current" />
                        Potencia tu Estudio
                    </div>
                    <h2 className="text-3xl md:text-5xl font-black text-slate-900 mb-6 tracking-tight">
                        Todo lo que necesitas para <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-600">romperla</span>
                    </h2>
                    <p className="text-lg text-slate-600 leading-relaxed">
                        PAES Lab combina tecnología de punta con gamificación para transformar tu preparación en algo que realmente disfrutes.
                    </p>
                </div>

                <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-24 items-center">

                    {/* Left Column: Phone Mockup (Sticky on Desktop) */}
                    <div className="relative order-2 lg:order-1 flex justify-center">
                        <div className="relative w-[300px] h-[600px] bg-slate-900 rounded-[3rem] shadow-2xl border-8 border-slate-900 ring-1 ring-slate-900/10 z-10 overflow-hidden transition-all duration-500 ease-in-out">
                            {/* Notch */}
                            <div className="absolute top-0 left-1/2 -translate-x-1/2 w-32 h-6 bg-slate-900 rounded-b-2xl z-20"></div>

                            {/* Status Bar Mock */}
                            <div className="absolute top-2 w-full px-6 flex justify-between text-[10px] text-white/90 font-medium z-20">
                                <span>9:41</span>
                                <div className="flex gap-1">
                                    <div className="w-4 h-3 bg-white/20 rounded-sm"></div>
                                    <div className="w-4 h-3 bg-white/20 rounded-sm"></div>
                                    <div className="w-4 h-3 bg-white rounded-sm"></div>
                                </div>
                            </div>

                            {/* Dynamic Content - Image */}
                            <div className="w-full h-full bg-slate-100 relative">
                                {features.map((feature, index) => (
                                    <div
                                        key={feature.id}
                                        className={cn(
                                            "absolute inset-0 w-full h-full transition-opacity duration-500 ease-in-out",
                                            activeFeature === index ? "opacity-100 z-10" : "opacity-0 z-0"
                                        )}
                                    >
                                        <Image
                                            src={feature.imageSrc}
                                            alt={feature.title}
                                            fill
                                            className="object-cover"
                                            priority={index === 0} // Load first image immediately
                                        />

                                        {/* Fallback overlay (remove in production if images exist) */}
                                        <div className="absolute inset-0 bg-slate-100 -z-10 flex items-center justify-center text-slate-400 text-xs">
                                            Cargando {feature.title}...
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Decorational Elements behind phone */}
                        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-gradient-to-tr from-blue-200/50 to-purple-200/50 rounded-full blur-3xl -z-10 animate-pulse-slow" />
                        <div className="absolute bottom-10 -right-10 w-24 h-24 bg-yellow-400 rounded-full blur-xl opacity-20 animate-bounce delay-700" />
                    </div>

                    {/* Right Column: Feature List */}
                    <div className="order-1 lg:order-2 space-y-4">
                        {features.map((feature, index) => {
                            const isActive = activeFeature === index
                            const Icon = feature.icon

                            return (
                                <div
                                    key={feature.id}
                                    onClick={() => handleManualSelect(index)}
                                    className={cn(
                                        "group p-6 rounded-3xl cursor-pointer transition-all duration-300 border-2 relative overflow-hidden",
                                        isActive
                                            ? "bg-white border-blue-100 shadow-xl scale-100 md:scale-105"
                                            : "bg-transparent border-transparent hover:bg-white/50 hover:border-slate-100"
                                    )}
                                >
                                    {/* Progress Bar Background for Active Item */}
                                    {isActive && isAutoPlaying && (
                                        <div
                                            className="absolute bottom-0 left-0 h-1 bg-blue-500 transition-all duration-75 ease-linear"
                                            style={{ width: `${progress}%` }}
                                        />
                                    )}

                                    <div className="flex items-start gap-6 relative z-10">
                                        <div className={cn(
                                            "w-12 h-12 rounded-2xl flex items-center justify-center shrink-0 transition-all duration-300",
                                            isActive ? feature.color : "bg-slate-100 text-slate-400 group-hover:bg-white group-hover:text-slate-600"
                                        )}>
                                            <Icon size={24} />
                                        </div>
                                        <div>
                                            <h3 className={cn(
                                                "text-xl font-bold mb-2 transition-colors",
                                                isActive ? "text-slate-900" : "text-slate-500 group-hover:text-slate-700"
                                            )}>
                                                {feature.title}
                                            </h3>
                                            <p className={cn(
                                                "text-sm leading-relaxed transition-colors",
                                                isActive ? "text-slate-600" : "text-slate-400 group-hover:text-slate-500"
                                            )}>
                                                {feature.description}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            )
                        })}
                    </div>
                </div>
            </div>
        </section>
    )
}
