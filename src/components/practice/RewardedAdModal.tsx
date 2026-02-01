"use client"

import { useState, useEffect, useRef } from "react"
import { motion, AnimatePresence } from "framer-motion"
import { X, Play, Trophy, Sparkles, Crown, Loader2, AlertCircle } from "lucide-react"
import { Button } from "@/components/ui/button"

// Type definition for Google Publisher Tag
declare global {
    interface Window {
        googletag: any
    }
}

type RewardedAdModalProps = {
    isOpen: boolean
    onClose: () => void
    onRewardClaimed: () => void
    rewardType: 'life' | 'explanation'
}

// IMPORTANT: Replace this with your actual Ad Unit ID from Ad Manager
// You can use "/6499/example/rewarded" for testing
const AD_UNIT_ID = process.env.NEXT_PUBLIC_GAM_REWARDED_AD_UNIT_ID || "/6499/example/rewarded"

export function RewardedAdModal({ isOpen, onClose, onRewardClaimed, rewardType }: RewardedAdModalProps) {
    const [status, setStatus] = useState<'intro' | 'loading' | 'playing' | 'completed' | 'error'>('intro')
    const [timeLeft, setTimeLeft] = useState(15)
    const [rewardGranted, setRewardGranted] = useState(false)
    const adSlotRef = useRef<any>(null)

    useEffect(() => {
        if (isOpen) {
            setStatus('intro')
            setRewardGranted(false)
            initGPT()
        }
        return () => destroySlot()
    }, [isOpen])

    const initGPT = () => {
        window.googletag = window.googletag || { cmd: [] }
        window.googletag.cmd.push(() => {
            // Destroy existing slot if any
            destroySlot()

            // Define the rewarded slot
            adSlotRef.current = window.googletag.defineRewardedSlot(AD_UNIT_ID)
                .addService(window.googletag.pubads())

            // Register events
            window.googletag.pubads().addEventListener('rewardedSlotReady', (event: any) => {
                console.log('Rewarded slot ready')
                // We keep it ready, we show the intro first
            })

            window.googletag.pubads().addEventListener('rewardedSlotGranted', (event: any) => {
                console.log('Reward granted!')
                setRewardGranted(true)
                setStatus('completed')
            })

            window.googletag.pubads().addEventListener('rewardedSlotClosed', (event: any) => {
                console.log('Ad closed')
                // If reward was granted, we are already in 'completed'
                // If not, we might want to show an error or just stay in intro/playing
                if (!rewardGranted) {
                    onClose()
                }
            })

            window.googletag.enableServices()
            window.googletag.display(adSlotRef.current)
        })
    }

    const destroySlot = () => {
        if (adSlotRef.current) {
            window.googletag.cmd.push(() => {
                window.googletag.destroySlots([adSlotRef.current])
            })
        }
    }

    const handleStartAd = () => {
        setStatus('loading')

        // Timeout for loading
        const loadTimeout = setTimeout(() => {
            if (status === 'loading') {
                console.warn('Ad load timeout, falling back to internal simulation')
                setStatus('playing') // Fallback to internal simulation
                startInternalTimer()
            }
        }, 5000)

        window.googletag.cmd.push(() => {
            const slot = adSlotRef.current
            if (slot) {
                // Check if ad is ready to be shown
                // Note: display() was already called in initGPT
                // makeRewardedVisible() triggers the actual overlay
                window.googletag.pubads().makeRewardedVisible(slot)

                // If it successfully shows, GPT takes over the UI.
                // We don't change 'status' to 'playing' yet unless GPT doesn't handle it.
                // GPT rewarded ads typically show their own full-screen overlay.
            }
        })
    }

    const startInternalTimer = () => {
        setTimeLeft(15)
        const interval = setInterval(() => {
            setTimeLeft((prev) => {
                if (prev <= 1) {
                    clearInterval(interval)
                    setRewardGranted(true)
                    setStatus('completed')
                    return 0
                }
                return prev - 1
            })
        }, 1000)
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
                    {/* Header */}
                    <div className="absolute top-4 right-4 z-10">
                        {status !== 'playing' && status !== 'loading' && (
                            <button onClick={onClose} className="p-2 hover:bg-slate-100 rounded-full text-slate-400 transition-colors">
                                <X size={20} />
                            </button>
                        )}
                        {status === 'loading' && (
                            <div className="bg-slate-900/50 backdrop-blur-md text-white p-2 rounded-full animate-spin">
                                <Loader2 size={20} />
                            </div>
                        )}
                        {status === 'playing' && (
                            <div className="bg-slate-900/50 backdrop-blur-md text-white px-3 py-1 rounded-full text-sm font-mono font-bold">
                                {timeLeft}s
                            </div>
                        )}
                    </div>

                    {status === 'intro' && (
                        <div className="p-8 text-center space-y-6">
                            <div className="w-20 h-20 bg-blue-100 rounded-2xl flex items-center justify-center mx-auto text-blue-600">
                                <Play size={40} fill="currentColor" />
                            </div>
                            <div>
                                <h2 className="text-2xl font-bold text-slate-900">¿Necesitas una ayuda?</h2>
                                <p className="text-slate-500 mt-2 text-lg">
                                    Mira un anuncio y obtén <span className="font-bold text-slate-900">1 {rewardType === 'life' ? 'vida' : 'explicación'} extra</span>.
                                </p>
                            </div>
                            <Button
                                onClick={handleStartAd}
                                className="w-full h-14 text-xl font-bold bg-blue-600 hover:bg-blue-700 rounded-2xl shadow-lg shadow-blue-200"
                            >
                                Ver Anuncio
                            </Button>
                            <p className="text-xs text-slate-400 uppercase font-bold tracking-wider">
                                Disponible una vez al día
                            </p>
                        </div>
                    )}

                    {status === 'loading' && (
                        <div className="p-20 text-center space-y-4">
                            <Loader2 className="animate-spin mx-auto text-blue-600" size={48} />
                            <p className="text-slate-500 font-medium">Buscando anuncio disponible...</p>
                        </div>
                    )}

                    {status === 'playing' && (
                        <div className="relative aspect-video bg-slate-900 flex items-center justify-center overflow-hidden">
                            {/* Fallback internal ad content */}
                            <div className="absolute inset-0 bg-gradient-to-br from-indigo-600 via-blue-600 to-slate-900 flex flex-col items-center justify-center text-white p-8 text-center space-y-4">
                                <motion.div
                                    animate={{ rotate: [0, 10, -10, 0], scale: [1, 1.1, 1] }}
                                    transition={{ repeat: Infinity, duration: 3 }}
                                >
                                    <Crown size={60} className="text-yellow-400 fill-yellow-400" />
                                </motion.div>
                                <h3 className="text-2xl font-black italic tracking-tighter">PAES LAB PREMIUM</h3>
                                <p className="text-blue-100 font-medium leading-tight">
                                    Vidas ilimitadas, explicaciones en video y práctica personalizada.
                                </p>
                            </div>

                            {/* Progress bar */}
                            <div className="absolute bottom-0 left-0 h-1 bg-white/20 w-full">
                                <motion.div
                                    className="h-full bg-blue-400"
                                    initial={{ width: "0%" }}
                                    animate={{ width: "100%" }}
                                    transition={{ duration: 15, ease: "linear" }}
                                />
                            </div>
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
                                    Has ganado <span className="font-bold text-slate-900">1 {rewardType === 'life' ? 'vida' : 'explicación'}</span> tras ver el anuncio.
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

                    {status === 'error' && (
                        <div className="p-10 text-center space-y-6">
                            <AlertCircle className="w-16 h-16 text-red-500 mx-auto" />
                            <div>
                                <h2 className="text-xl font-bold text-slate-900">Error al cargar el anuncio</h2>
                                <p className="text-slate-500 mt-2">
                                    No pudimos conectar con el servidor de anuncios en este momento. Inténtalo de nuevo más tarde o revisa tu conexión.
                                </p>
                            </div>
                            <Button onClick={onClose} className="w-full">Cerrar</Button>
                        </div>
                    )}
                </motion.div>
            </div>
        </AnimatePresence>
    )
}
