"use client"

import { useEffect, useState } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { X, Calendar, Edit3, CheckCircle2, AlertTriangle, Snowflake } from "lucide-react"
import { Button } from "@/components/ui/button"

export function PaesInfoModal() {
    const [isOpen, setIsOpen] = useState(false)

    useEffect(() => {
        const checkAndShowModal = () => {
            const lastViewed = localStorage.getItem('lastPaesInfoViewed')
            const today = new Date().toDateString()

            if (lastViewed !== today) {
                setIsOpen(true)
            }
        }

        // Small delay to ensure smooth entry after page load
        const timer = setTimeout(checkAndShowModal, 1000)
        return () => clearTimeout(timer)
    }, [])

    const handleClose = () => {
        setIsOpen(false)
        localStorage.setItem('lastPaesInfoViewed', new Date().toDateString())
    }

    if (!isOpen) return null

    return (
        <AnimatePresence>
            {isOpen && (
                <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm">
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9, y: 20 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        exit={{ opacity: 0, scale: 0.9, y: 20 }}
                        transition={{ type: "spring", duration: 0.5 }}
                        className="bg-white w-full max-w-2xl rounded-3xl shadow-2xl overflow-hidden relative max-h-[90vh] overflow-y-auto border border-blue-100"
                    >
                        {/* Header Background */}
                        <div className="absolute top-0 left-0 right-0 h-40 bg-gradient-to-br from-blue-600 via-indigo-600 to-purple-700">
                            <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20"></div>
                            <div className="absolute top-10 right-10 text-white/10 rotate-12">
                                <Snowflake size={120} />
                            </div>
                        </div>

                        {/* Close Button */}
                        <button
                            onClick={handleClose}
                            className="absolute top-4 right-4 z-10 bg-white/20 hover:bg-white/30 text-white rounded-full p-2 transition-colors backdrop-blur-md"
                        >
                            <X size={20} />
                        </button>

                        <div className="relative pt-12 px-8 pb-8">
                            {/* Main Title Badge */}
                            <div className="flex justify-center mb-6">
                                <div className="bg-white shadow-xl rounded-2xl px-6 py-4 flex flex-col items-center border border-blue-50">
                                    <span className="text-blue-600 font-extrabold tracking-widest text-xs uppercase mb-1">Admisión 2027</span>
                                    <h2 className="text-2xl md:text-3xl font-black text-slate-900 text-center leading-tight">
                                        PAES de Invierno
                                    </h2>
                                </div>
                            </div>

                            <div className="space-y-6 text-slate-600 leading-relaxed">
                                <div className="bg-blue-50/50 p-4 rounded-2xl border border-blue-100 text-sm md:text-base">
                                    <p className="text-center font-medium text-slate-700">
                                        <span className="font-bold text-blue-700">15, 16 y 17 de junio de 2026:</span> Se aplicará la PAES de Invierno. El Ministerio de Educación confirmó que la prueba se rendirá dos veces al año.
                                    </p>
                                </div>

                                <div className="space-y-4">
                                    <h3 className="text-xl font-bold text-slate-900 flex items-center gap-2">
                                        <Calendar className="text-indigo-600" size={24} />
                                        Fechas Clave
                                    </h3>

                                    <div className="grid md:grid-cols-2 gap-4">
                                        <div className="bg-white p-4 rounded-2xl shadow-sm border border-slate-100 group hover:border-indigo-200 transition-colors">
                                            <div className="text-xs font-bold text-indigo-500 uppercase tracking-wider mb-2 flex items-center gap-1">
                                                <Edit3 size={14} /> Inscripción
                                            </div>
                                            <div className="space-y-2">
                                                <div className="flex justify-between items-baseline border-b border-slate-100 pb-1">
                                                    <span className="text-slate-500 text-sm">Inicio:</span>
                                                    <span className="font-bold text-slate-900">Mie 4 Mar, 09:00</span>
                                                </div>
                                                <div className="flex justify-between items-baseline">
                                                    <span className="text-slate-500 text-sm">Fin:</span>
                                                    <span className="font-bold text-slate-900">Mar 17 Mar, 13:00</span>
                                                </div>
                                                <p className="text-[10px] text-red-500 font-medium mt-1">* O hasta agotar 50.000 cupos</p>
                                            </div>
                                        </div>

                                        <div className="bg-white p-4 rounded-2xl shadow-sm border border-slate-100 group hover:border-indigo-200 transition-colors">
                                            <div className="text-xs font-bold text-purple-500 uppercase tracking-wider mb-2 flex items-center gap-1">
                                                <CheckCircle2 size={14} /> Rendición
                                            </div>
                                            <ul className="text-sm font-semibold text-slate-700 space-y-1">
                                                <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 rounded-full bg-purple-400"></div>Lun 15 Jun 2026</li>
                                                <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 rounded-full bg-purple-400"></div>Mar 16 Jun 2026</li>
                                                <li className="flex items-center gap-2"><div className="w-1.5 h-1.5 rounded-full bg-purple-400"></div>Mie 17 Jun 2026</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div className="bg-orange-50 p-5 rounded-2xl border border-orange-100">
                                    <h3 className="text-lg font-bold text-orange-800 mb-3 flex items-center gap-2">
                                        <AlertTriangle size={20} />
                                        Inscripción M1 y M2
                                    </h3>
                                    <div className="space-y-3 text-sm text-orange-900/80">
                                        <div className="flex gap-3 bg-white/60 p-3 rounded-xl border border-orange-200/50">
                                            <span className="text-2xl">🎁</span>
                                            <p>Si inscribes <span className="font-bold">M1</span>, la <span className="font-bold">M2 es gratis</span>. <br />Si inscribes <span className="font-bold">M2</span>, la <span className="font-bold">M1 es gratis</span>.</p>
                                        </div>
                                        <p className="font-bold text-center bg-orange-200/20 py-2 rounded-lg text-orange-700">
                                            DEBES INSCRIBIR AMBAS MANUALMENTE. <br />NO ES AUTOMÁTICO.
                                        </p>
                                        <p className="text-xs text-center opacity-80 decoration-orange-300">
                                            * Si solo decides inscribir M2, deberás pagar por esta prueba.
                                        </p>
                                    </div>
                                </div>

                                <div className="flex justify-center pt-2">
                                    <Button onClick={handleClose} size="lg" className="bg-slate-900 hover:bg-slate-800 text-white rounded-xl px-8 shadow-xl shadow-slate-200">
                                        Entendido, ¡voy a prepararme! 🚀
                                    </Button>
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            )}
        </AnimatePresence>
    )
}
