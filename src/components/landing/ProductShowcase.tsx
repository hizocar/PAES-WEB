"use client"

import { useState, useEffect } from "react"
import { cn } from "@/lib/utils"
import {
    BrainCircuit,
    Trophy,
    Target,
    Zap,
    BarChart3,
    Play,
    CheckCircle2,
    XCircle
} from "lucide-react"

const features = [
    {
        id: "ia",
        title: "IA Personalizada",
        description: "Nuestro algoritmo detecta tus vacíos y te bombardea con ejercicios clave hasta que los domines.",
        icon: BrainCircuit,
        color: "bg-blue-100 text-blue-600",
        mockupContent: (
            <div className="h-full w-full bg-slate-50 flex flex-col relative overflow-hidden">
                <div className="p-4 bg-white border-b border-slate-100 flex items-center justify-between">
                    <div className="flex items-center gap-2">
                        <div className="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center">
                            <BrainCircuit size={16} className="text-blue-600" />
                        </div>
                        <div>
                            <div className="text-xs font-bold text-slate-800">Coach IA</div>
                            <div className="text-[10px] text-green-500 font-medium">En línea</div>
                        </div>
                    </div>
                </div>
                <div className="p-4 space-y-3">
                    <div className="bg-white p-3 rounded-t-xl rounded-br-xl shadow-sm border border-slate-100 max-w-[90%] self-start">
                        <p className="text-xs text-slate-700">Noté que te cuesta <strong>Álgebra</strong>. Aquí tienes 5 ejercicios para reforzar.</p>
                    </div>
                    <div className="bg-blue-600 p-3 rounded-t-xl rounded-bl-xl shadow-sm max-w-[90%] self-end ml-auto text-white">
                        <p className="text-xs">¡Dale! Los hago ahora.</p>
                    </div>
                    <div className="bg-white p-3 rounded-xl shadow-sm border border-blue-100 mt-4">
                        <div className="flex items-center justify-between mb-2">
                            <span className="text-[10px] font-bold text-blue-600 uppercase">Ejercicio Recomendado</span>
                            <span className="text-[10px] bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full">Difícil</span>
                        </div>
                        <div className="h-20 bg-slate-100 rounded-lg mb-2 relative overflow-hidden">
                            <div className="absolute inset-0 flex items-center justify-center opacity-10">
                                <span className="text-4xl">∑</span>
                            </div>
                        </div>
                        <div className="grid grid-cols-2 gap-2">
                            <div className="h-8 bg-slate-50 border border-slate-200 rounded-lg"></div>
                            <div className="h-8 bg-slate-50 border border-slate-200 rounded-lg"></div>
                        </div>
                    </div>
                </div>
            </div>
        )
    },
    {
        id: "lives",
        title: "Vidas y Rachas",
        description: "La práctica debe doler (un poco). Tienes vidas diarias. Si fallas, pierdes. Si aciertas, subes.",
        icon: Target,
        color: "bg-red-100 text-red-600",
        mockupContent: (
            <div className="h-full w-full bg-slate-900 flex flex-col relative overflow-hidden text-white">
                <div className="absolute top-0 left-0 w-full h-full bg-[radial-gradient(ellipse_at_top,_var(--tw-gradient-stops))] from-red-900/40 via-slate-900 to-slate-900" />
                <div className="relative z-10 p-6 flex flex-col items-center justify-center h-full text-center space-y-6">
                    <div className="space-y-2">
                        <div className="text-5xl font-black text-transparent bg-clip-text bg-gradient-to-br from-red-400 to-orange-500 animate-pulse">
                            3
                        </div>
                        <div className="text-sm font-bold text-red-200 uppercase tracking-widest">Vidas Restantes</div>
                    </div>

                    <div className="w-full bg-white/10 rounded-2xl p-4 backdrop-blur-md border border-white/10">
                        <div className="flex justify-center gap-2 mb-4">
                            <div className="w-8 h-8 text-red-500 fill-current"><Target /></div>
                            <div className="w-8 h-8 text-red-500 fill-current"><Target /></div>
                            <div className="w-8 h-8 text-red-500 fill-current"><Target /></div>
                            <div className="w-8 h-8 text-slate-700"><Target /></div>
                            <div className="w-8 h-8 text-slate-700"><Target /></div>
                        </div>
                        <p className="text-xs text-slate-300">Responde correctamente para mantener tu racha de <span className="text-white font-bold">12 días</span>.</p>
                    </div>

                    <div className="w-full bg-red-600 hover:bg-red-500 text-white font-bold py-3 rounded-xl shadow-lg shadow-red-600/20 transition-all cursor-default">
                        Recuperar Vidas
                    </div>
                </div>
            </div>
        )
    },
    {
        id: "feedback",
        title: "Feedback Total",
        description: "¿Te equivocaste? No pasa nada. Accede a explicaciones detalladas y videos paso a paso.",
        icon: Zap,
        color: "bg-amber-100 text-amber-600",
        mockupContent: (
            <div className="h-full w-full bg-white flex flex-col relative overflow-hidden">
                <div className="bg-red-50 p-6 border-b border-red-100">
                    <div className="flex items-center gap-3 text-red-600 mb-2">
                        <XCircle size={24} />
                        <span className="font-bold text-lg">Incorrecto</span>
                    </div>
                    <p className="text-xs text-red-800">La respuesta correcta era la <strong>B</strong>.</p>
                </div>
                <div className="flex-1 p-6 overflow-hidden relative">
                    <div className="absolute top-0 right-0 w-32 h-32 bg-amber-100/50 rounded-full blur-3xl -translate-y-16 translate-x-16" />
                    <h4 className="text-sm font-bold text-slate-900 mb-3 flex items-center gap-2">
                        <Zap size={14} className="text-amber-500 fill-current" />
                        Explicación
                    </h4>
                    <div className="space-y-3 text-xs text-slate-600 leading-relaxed">
                        <p>Para resolver este problema, primero debemos despejar la variable <code className="bg-slate-100 px-1 rounded">x</code> de la ecuación cuadrática.</p>
                        <div className="bg-slate-50 p-3 rounded-lg border border-slate-100 my-2 font-mono text-[10px] text-slate-700">
                            2x² + 5x - 3 = 0<br />
                            (2x - 1)(x + 3) = 0
                        </div>
                        <p>Por lo tanto, las soluciones posibles son x = 1/2 y x = -3.</p>
                    </div>

                    <div className="mt-6 bg-slate-900 rounded-xl p-3 flex items-center gap-3 text-white shadow-lg cursor-default hover:scale-105 transition-transform">
                        <div className="w-8 h-8 rounded-full bg-white/20 flex items-center justify-center">
                            <Play size={12} className="fill-current" />
                        </div>
                        <div>
                            <div className="text-xs font-bold">Ver Video Solución</div>
                            <div className="text-[10px] text-slate-400">Profe Alex • 2:30 min</div>
                        </div>
                    </div>
                </div>
            </div>
        )
    },
    {
        id: "ranking",
        title: "Ranking Nacional",
        description: "Compite con estudiantes de todo Chile. Sube de liga, gana medallas y mide tu preparación.",
        icon: BarChart3,
        color: "bg-purple-100 text-purple-600",
        mockupContent: (
            <div className="h-full w-full bg-slate-50 flex flex-col relative overflow-hidden">
                <div className="bg-purple-600 p-6 text-white text-center pb-12">
                    <h3 className="font-bold text-lg mb-1">Liga Diamante 💎</h3>
                    <p className="text-xs text-purple-200">Termina en el Top 3 para ascender</p>
                </div>
                <div className="flex-1 px-4 -mt-8 space-y-2 overflow-hidden">
                    {[
                        { name: "Tú", score: "850 pts", avatar: "bg-blue-500", rank: 1 },
                        { name: "Sofía M.", score: "845 pts", avatar: "bg-pink-500", rank: 2 },
                        { name: "Lucas R.", score: "820 pts", avatar: "bg-green-500", rank: 3 },
                        { name: "Martina", score: "790 pts", avatar: "bg-yellow-500", rank: 4 },
                    ].map((user, i) => (
                        <div key={i} className={cn(
                            "p-3 rounded-xl flex items-center justify-between shadow-sm border",
                            user.name === "Tú" ? "bg-white border-purple-200 ring-2 ring-purple-100 z-10 scale-105" : "bg-white/60 border-slate-100"
                        )}>
                            <div className="flex items-center gap-3">
                                <div className={cn("w-6 h-6 rounded-full text-[10px] font-bold flex items-center justify-center text-white", i < 3 ? "bg-amber-400" : "bg-slate-300")}>
                                    {user.rank}
                                </div>
                                <div className={cn("w-8 h-8 rounded-full", user.avatar)} />
                                <span className={cn("text-xs font-bold", user.name === "Tú" ? "text-slate-900" : "text-slate-600")}>{user.name}</span>
                            </div>
                            <span className="text-xs font-bold text-slate-900">{user.score}</span>
                        </div>
                    ))}
                </div>
            </div>
        )
    }
]

export default function ProductShowcase() {
    const [activeFeature, setActiveFeature] = useState(0)
    const [progress, setProgress] = useState(0)

    // Optional: Auto-rotate features if user is inactive? 
    // For now, let's keep it manual or simple interval if requested.

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

                            {/* Dynamic Content */}
                            <div className="w-full h-full bg-white transition-opacity duration-300">
                                {features[activeFeature].mockupContent}
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
                                    onClick={() => setActiveFeature(index)}
                                    className={cn(
                                        "group p-6 rounded-3xl cursor-pointer transition-all duration-300 border-2",
                                        isActive
                                            ? "bg-white border-blue-100 shadow-xl scale-100 md:scale-105"
                                            : "bg-transparent border-transparent hover:bg-white/50 hover:border-slate-100"
                                    )}
                                >
                                    <div className="flex items-start gap-6">
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
