"use client"

import { useState, useEffect, useRef } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { X, Play, Trophy, Sparkles, Crown, Loader2, PlayCircle } from "lucide-react"
import { Button } from "@/components/ui/button"

type RewardedAdModalProps = {
    isOpen: boolean
    onClose: () => void
    onRewardClaimed: () => void
    rewardType: 'life' | 'explanation'
}

export function RewardedAdModal({ isOpen, onClose, onRewardClaimed, rewardType }: RewardedAdModalProps) {
    const [status, setStatus] = useState<'intro' | 'playing' | 'completed'>('intro')
    const [rewardGranted, setRewardGranted] = useState(false)
    const videoRef = useRef<HTMLVideoElement>(null)

    useEffect(() => {
        if (isOpen) {
            setStatus('intro')
            setRewardGranted(false)
        }
    }, [isOpen])

    const handleStartAd = () => {
        setStatus('playing')
    }

    const handleVideoEnd = () => {
        setRewardGranted(true)
        setStatus('completed')
    }

    if (!isOpen) return null

    return (
        <AnimatePresence>
            <div className="fixed inset-0 z-[100] flex items-center justify-center p-4 bg-slate-900/90 backdrop-blur-sm">
                <motion.div
                    initial={{ opacity: 0, scale: 0.9, y: 20 }}
                    animate={{ opacity: 1, scale: 1, y: 0 }}
                    exit={{ opacity: 0, scale: 0.9, y: 20 }}
                    className="bg-white rounded-3xl w-full max-w-lg overflow-hidden shadow-2xl relative"
                >
                    {/* Header Controls */}
                    <div className="absolute top-4 right-4 z-10">
                        {status !== 'playing' && (
                            <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-full text-slate-400 transition-colors">
                                <X size={20} />
                            </button>
                        )}
                        {status === 'playing' && (
                            <div className="bg-slate-900/50 backdrop-blur-md text-white px-3 py-1 rounded-full text-[10px] font-bold uppercase tracking-wider">
                                Anuncio en curso
                            </div>
                        )}
                    </div>

                    {status === 'intro' && (
                        <div className="p-8 text-center space-y-6">
                            <div className="w-20 h-20 bg-blue-100 rounded-2xl flex items-center justify-center mx-auto text-blue-600">
                                <PlayCircle size={48} fill="currentColor" className="text-blue-600 fill-blue-100" />
                                <Play className="absolute text-blue-600" size={24} fill="currentColor" />
                            </div>
                            <div>
                                <h2 className="text-2xl font-bold text-slate-900">¿Necesitas una ayuda?</h2>
                                <p className="text-slate-500 mt-2 text-lg">
                                    Mira este video sobre <span className="font-bold text-blue-600">PAES Lab Premium</span> y obtén <span className="font-bold text-slate-900">1 {rewardType === 'life' ? 'vida' : 'explicación'} extra</span>.
                                </p>
                            </div>
                            <Button
                                onClick={handleStartAd}
                                className="w-full h-14 text-xl font-bold bg-blue-600 hover:bg-blue-700 rounded-2xl shadow-lg shadow-blue-200"
                            >
                                Ver Video
                            </Button>
                            <p className="text-xs text-slate-400 uppercase font-bold tracking-wider">
                                Disponible una vez al día
                            </p>
                        </div>
                    )}

                    {status === 'playing' && (
                        <div className="relative aspect-video bg-black flex items-center justify-center overflow-hidden">
                            <video
                                ref={videoRef}
                                src="/promo-premium.mp4" // User should place the video here
                                className="w-full h-full object-cover"
                                autoPlay
                                onEnded={handleVideoEnd}
                                controlsList="nodownload nofullscreen"
                            />

                            {/* Overlay if video fails to load or for visual consistency */}
                            {!videoRef.current?.src && (
                                <div className="absolute inset-0 bg-slate-900 flex flex-col items-center justify-center text-white p-8 text-center space-y-4">
                                    <Loader2 className="animate-spin text-blue-400" size={40} />
                                    <p className="text-sm text-slate-400">Cargando video promocional...</p>
                                    <Button
                                        variant="ghost"
                                        size="sm"
                                        className="text-xs text-slate-500 hover:text-white"
                                        onClick={handleVideoEnd}
                                    >
                                        (Simular fin de video para pruebas)
                                    </Button>
                                </div>
                            )}
                        </div>
                    )}

                    {status === 'completed' && (
                        <div className="p-10 text-center space-y-6 bg-gradient-to-b from-green-50 to-white">
                            <motion.div
                                initial={{ scale: 0 }}
                                animate={{ scale: 1 }}
                                transition={{ type: "spring", damping: 10 }}
                                className="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto text-green-600 shadow-inner"
                            >
                                <Trophy size={48} />
                            </motion.div>
                            <div>
                                <div className="flex items-center justify-center gap-2 text-green-600 font-bold text-sm uppercase tracking-widest mb-2">
                                    <Sparkles size={16} />
                                    <span>¡Logrado!</span>
                                    <Sparkles size={16} />
                                </div>
                                <h2 className="text-3xl font-black text-slate-900">Recompensa Lista</h2>
                                <p className="text-slate-500 mt-2 text-lg leading-relaxed">
                                    Has ganado <span className="font-bold text-slate-900">1 {rewardType === 'life' ? 'vida' : 'explicación'}</span> por conocer más sobre Premium.
                                </p>
                            </div>
                            <Button
                                onClick={() => {
                                    onRewardClaimed()
                                    onClose()
                                }}
                                className="w-full h-14 text-xl font-bold bg-green-600 hover:bg-green-700 rounded-2xl shadow-lg shadow-green-100 border-b-4 border-green-800 active:border-b-0 active:translate-y-1 transition-all"
                            >
                                Reclamar Recompensa
                            </Button>
                        </div>
                    )}
                </motion.div>
            </div>
        </AnimatePresence>
    )
}
