"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { ArrowLeft, Save, Upload, X, Wand2, ImageIcon } from "lucide-react"
import Link from "next/link"
import { processQuestionImage } from "@/app/actions/process-image"
import { useRouter } from "next/navigation"
import 'katex/dist/katex.min.css'
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import Image from "next/image"

export default function NewQuestionPage() {
    const supabase = createClient()
    const router = useRouter()
    const [loading, setLoading] = useState(false)
    const [uploading, setUploading] = useState(false)
    const [processing, setProcessing] = useState(false)
    const [isDragging, setIsDragging] = useState(false)
    const [ejes, setEjes] = useState<any[]>([])
    const [topics, setTopics] = useState<any[]>([])
    const [filteredTopics, setFilteredTopics] = useState<any[]>([])

    const [subject, setSubject] = useState<'m1' | 'm2'>('m2')

    const [formData, setFormData] = useState({
        content: "",
        alternatives: [
            { id: "A", content: "" },
            { id: "B", content: "" },
            { id: "C", content: "" },
            { id: "D", content: "" },
            { id: "E", content: "" }
        ],
        correct_answer: "A",
        explanation: "",
        difficulty: "medium",
        eje_id: "",
        topic_id: "",
        image_url: "",
        explanation_video_path: ""
    })

    useEffect(() => {
        fetchMetadata()
    }, [])

    useEffect(() => {
        setFormData(prev => ({ ...prev, eje_id: "", topic_id: "" }))
    }, [subject])

    useEffect(() => {
        if (formData.eje_id) {
            const filtered = topics.filter(t => t.eje_id === formData.eje_id)
            setFilteredTopics(filtered)
        } else {
            setFilteredTopics([])
        }
    }, [formData.eje_id, topics])

    const fetchMetadata = async () => {
        const { data: ejesData } = await supabase.from('ejes').select('*')
        const { data: topicsData } = await supabase.from('topics').select('*')
        if (ejesData) setEjes(ejesData)
        if (topicsData) setTopics(topicsData)
    }

    const handleAltChange = (idx: number, val: string) => {
        const newAlts = [...formData.alternatives]
        newAlts[idx].content = val
        setFormData({ ...formData, alternatives: newAlts })
    }

    const [isDraggingImage, setIsDraggingImage] = useState(false)

    const uploadImageFile = async (file: File) => {
        setUploading(true)
        const fileExt = file.name.split('.').pop()
        const fileName = `${Math.random()}.${fileExt}`
        const filePath = `${fileName}`

        try {
            const { error: uploadError } = await supabase.storage
                .from('question-images')
                .upload(filePath, file)

            if (uploadError) throw uploadError

            const { data: { publicUrl } } = supabase.storage
                .from('question-images')
                .getPublicUrl(filePath)

            setFormData(prev => ({ ...prev, image_url: publicUrl }))

        } catch (error: any) {
            alert("Error uploading image: " + error.message)
        } finally {
            setUploading(false)
        }
    }

    const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        if (!e.target.files || e.target.files.length === 0) return
        await uploadImageFile(e.target.files[0])
    }

    const handleImageDragOver = (e: React.DragEvent) => {
        e.preventDefault()
        e.stopPropagation()
        setIsDraggingImage(true)
    }

    const handleImageDragLeave = (e: React.DragEvent) => {
        e.preventDefault()
        e.stopPropagation()
        setIsDraggingImage(false)
    }

    const handleImageDrop = async (e: React.DragEvent) => {
        e.preventDefault()
        e.stopPropagation()
        setIsDraggingImage(false)

        if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
            const file = e.dataTransfer.files[0]
            if (file.type.startsWith('image/')) {
                await uploadImageFile(file)
            } else {
                alert("Por favor sube solo archivos de imagen.")
            }
        }
    }

    const handleVideoUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
        if (!e.target.files || e.target.files.length === 0) return

        setUploading(true)
        const file = e.target.files[0]
        const fileExt = file.name.split('.').pop()
        const fileName = `${Math.random()}.${fileExt}`
        const filePath = `${fileName}`

        try {
            const { data, error: uploadError } = await supabase.storage
                .from('explanation-videos')
                .upload(filePath, file)

            if (uploadError) throw uploadError

            setFormData({ ...formData, explanation_video_path: data.path })
        } catch (error: any) {
            alert("Error uploading video: " + error.message)
        } finally {
            setUploading(false)
        }
    }

    const processFile = async (file: File) => {
        setProcessing(true)
        const formDataPayload = new FormData()
        formDataPayload.append('image', file)

        try {
            const result = await processQuestionImage(formDataPayload)

            // Map AI result to form data
            const newAlternatives = formData.alternatives.map(alt => {
                if (alt.id === 'E') return { ...alt, content: "No sé responder esta pregunta" }
                const found = result.alternatives.find((a: any) => a.id === alt.id)
                return found ? { ...alt, content: found.content } : alt
            })

            setFormData(prev => ({
                ...prev,
                content: result.content || prev.content,
                alternatives: newAlternatives,
                correct_answer: result.correct_answer || prev.correct_answer,
                difficulty: result.difficulty || prev.difficulty,
                explanation: result.explanation || prev.explanation,
            }))

            alert("¡Pregunta procesada con éxito! Revisa los campos.")

        } catch (error: any) {
            console.error(error)
            alert("Error al procesar la imagen: " + error.message)
        } finally {
            setProcessing(false)
        }
    }

    const handleMagicFill = async (e: React.ChangeEvent<HTMLInputElement>) => {
        if (!e.target.files || e.target.files.length === 0) return
        await processFile(e.target.files[0])
        e.target.value = ''
    }

    const handleDragOver = (e: React.DragEvent) => {
        e.preventDefault()
        setIsDragging(true)
    }

    const handleDragLeave = (e: React.DragEvent) => {
        e.preventDefault()
        setIsDragging(false)
    }

    const handleDrop = async (e: React.DragEvent) => {
        e.preventDefault()
        setIsDragging(false)

        if (e.dataTransfer.files && e.dataTransfer.files.length > 0) {
            const file = e.dataTransfer.files[0]
            if (file.type.startsWith('image/')) {
                await processFile(file)
            } else {
                alert("Por favor sube solo archivos de imagen.")
            }
        }
    }

    const removeImage = () => {
        setFormData({ ...formData, image_url: "" })
    }

    const removeVideo = () => {
        // Optional: Delete from storage if you want to clean up
        setFormData({ ...formData, explanation_video_path: "" })
    }

    const handleSubmit = async () => {
        if (!formData.topic_id) {
            alert("Selecciona un tema")
            return
        }
        setLoading(true)

        try {
            // 1. Create Question
            const { data: qData, error: qError } = await supabase
                .from('questions')
                .insert({
                    content: formData.content,
                    alternatives: formData.alternatives,
                    correct_answer: formData.correct_answer,
                    explanation: formData.explanation,
                    difficulty: formData.difficulty,
                    image_url: formData.image_url,
                    explanation_video_path: formData.explanation_video_path,
                    is_active: true,
                    subject: subject // Add Subject
                })
                .select()
                .single()

            if (qError) throw qError

            // 2. Link Topic
            const { error: tError } = await supabase
                .from('question_topics')
                .insert({
                    question_id: qData.id,
                    topic_id: formData.topic_id
                })

            if (tError) throw tError

            router.push('/admin/questions')
            router.refresh()

        } catch (error: any) {
            alert("Error: " + error.message)
        } finally {
            setLoading(false)
        }
    }

    return (
        <div className="max-w-4xl mx-auto space-y-8 pb-20">
            <div className="flex items-center justify-between">
                <div className="flex items-center gap-4">
                    <Link href="/admin/questions">
                        <Button variant="ghost" size="sm">
                            <ArrowLeft size={20} />
                        </Button>
                    </Link>
                    <h1 className="text-2xl font-bold text-slate-900">Nueva Pregunta</h1>
                </div>
                {/* Subject Switcher */}
                <div className="bg-slate-100 p-1 rounded-lg flex items-center gap-1">
                    <button
                        onClick={() => setSubject('m1')}
                        className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm1'
                            ? 'bg-white text-slate-900 shadow-sm'
                            : 'text-slate-500 hover:text-slate-700'
                            }`}
                    >
                        M1
                    </button>
                    <button
                        onClick={() => setSubject('m2')}
                        className={`px-4 py-2 rounded-md text-sm font-bold transition-all ${subject === 'm2'
                            ? 'bg-white text-slate-900 shadow-sm'
                            : 'text-slate-500 hover:text-slate-700'
                            }`}
                    >
                        M2
                    </button>
                </div>
            </div>

            <div className="grid md:grid-cols-3 gap-6">
                {/* Main Form */}
                <div className="md:col-span-2 space-y-6">
                    {/* Magic Fill Banner */}
                    <div
                        onDragOver={handleDragOver}
                        onDragLeave={handleDragLeave}
                        onDrop={handleDrop}
                        className={`p-6 rounded-xl border transition-all duration-200 ${isDragging
                            ? "bg-purple-100 border-purple-400 scale-[1.02] shadow-lg"
                            : "bg-gradient-to-r from-purple-100 to-indigo-100 border-purple-200"
                            }`}
                    >
                        <div className="flex items-start gap-4">
                            <div className="bg-white p-3 rounded-lg shadow-sm text-purple-600">
                                <Wand2 size={24} />
                            </div>
                            <div className="flex-1">
                                <h3 className="font-bold text-slate-800">IA Magic Fill</h3>
                                <p className="text-sm text-slate-600 mb-3">
                                    {isDragging ? "¡Suelta la imagen aquí!" : "Arrastra y suelta una captura o haz clic para subir."}
                                </p>
                                <label className="inline-flex items-center gap-2 bg-purple-600 hover:bg-purple-700 text-white px-4 py-2 rounded-lg font-medium text-sm transition-colors cursor-pointer disabled:opacity-50 disabled:cursor-not-allowed">
                                    {processing ? (
                                        <>
                                            <div className="animate-spin rounded-full h-4 w-4 border-2 border-white border-t-transparent" />
                                            Procesando...
                                        </>
                                    ) : (
                                        <>
                                            <Upload size={16} />
                                            Subir Captura
                                        </>
                                    )}
                                    <input
                                        type="file"
                                        className="hidden"
                                        accept="image/*"
                                        onChange={handleMagicFill}
                                        disabled={processing}
                                    />
                                </label>
                            </div>
                        </div>
                    </div>

                    {/* Content */}
                    <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm">
                        <label className="block text-sm font-semibold text-slate-700 mb-2">Enunciado</label>
                        <textarea
                            className="w-full p-3 border rounded-lg font-mono text-sm bg-white text-slate-900 min-h-[150px] focus:ring-2 focus:ring-blue-500 focus:outline-none"
                            value={formData.content}
                            onChange={e => setFormData({ ...formData, content: e.target.value })}
                            placeholder="Escribe el enunciado aquí (usa $...$ para matemáticas)"
                        />

                        {/* Image Upload Row */}
                        <div className="mt-4 border-t pt-4">
                            <label className="block text-sm font-semibold text-slate-700 mb-2">Imagen (Opcional)</label>

                            {!formData.image_url ? (
                                <div
                                    onDragOver={handleImageDragOver}
                                    onDragLeave={handleImageDragLeave}
                                    onDrop={handleImageDrop}
                                    className={`flex flex-col items-center justify-center p-8 border-2 border-dashed rounded-lg transition-all ${isDraggingImage
                                            ? "border-blue-500 bg-blue-50"
                                            : "border-slate-300 bg-slate-50 hover:bg-slate-100"
                                        }`}
                                >
                                    <label className="cursor-pointer flex flex-col items-center gap-2 group">
                                        <div className={`p-3 rounded-full ${isDraggingImage ? 'bg-blue-100 text-blue-600' : 'bg-white text-slate-500 group-hover:text-blue-600 group-hover:bg-blue-50 transition-colors'}`}>
                                            <Upload size={24} />
                                        </div>
                                        <div className="text-center">
                                            <span className="text-sm font-medium text-slate-700 block">
                                                {uploading ? "Subiendo..." : isDraggingImage ? "¡Suelta la imagen!" : "Haz clic o arrastra una imagen aquí"}
                                            </span>
                                            <span className="text-xs text-slate-400 mt-1 block">PNG, JPG, WEBP (Max 2MB)</span>
                                        </div>
                                        <input
                                            type="file"
                                            className="hidden"
                                            accept="image/*"
                                            onChange={handleImageUpload}
                                            disabled={uploading}
                                        />
                                    </label>
                                </div>
                            ) : (
                                <div className="relative inline-block border rounded-lg overflow-hidden group">
                                    {/* eslint-disable-next-line @next/next/no-img-element */}
                                    <img
                                        src={formData.image_url}
                                        alt="Question Preview"
                                        className="max-h-64 h-auto w-auto object-contain bg-slate-50"
                                    />
                                    <button
                                        onClick={removeImage}
                                        className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                                    >
                                        <X size={14} />
                                    </button>
                                </div>
                            )}
                        </div>

                        <div className="mt-4 p-4 bg-slate-50 rounded-lg border border-slate-100">
                            <p className="text-xs text-slate-400 font-bold uppercase mb-2">Vista Previa</p>
                            <div className="prose prose-sm max-w-none text-slate-800">
                                {formData.image_url && (
                                    // eslint-disable-next-line @next/next/no-img-element
                                    <img src={formData.image_url} className="max-h-64 mb-4 rounded-lg" alt="Preview" />
                                )}
                                <Latex>{formData.content}</Latex>
                            </div>
                        </div>
                    </div>

                    {/* Alternatives */}
                    <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm space-y-4">
                        <label className="block text-sm font-semibold text-slate-700">Alternativas</label>
                        {formData.alternatives.map((alt, idx) => (
                            <div key={alt.id} className="flex gap-4 items-start">
                                <div className={`w-10 h-10 rounded-full flex items-center justify-center font-bold shrink-0 ${formData.correct_answer === alt.id ? 'bg-green-100 text-green-700 border-2 border-green-500' : 'bg-slate-100 text-slate-500 border border-slate-200'}`}>
                                    {alt.id}
                                </div>
                                <div className="flex-1 space-y-2">
                                    <input
                                        className="w-full p-2 border rounded-md font-mono text-sm bg-white text-slate-900 focus:ring-2 focus:ring-blue-500 focus:outline-none"
                                        value={alt.content}
                                        onChange={e => handleAltChange(idx, e.target.value)}
                                        placeholder={`Alternativa ${alt.id}`}
                                    />
                                    {alt.content && (
                                        <div className="text-sm text-slate-600 pl-2">
                                            <Latex>{alt.content}</Latex>
                                        </div>
                                    )}
                                </div>
                                <input
                                    type="radio"
                                    name="correct"
                                    checked={formData.correct_answer === alt.id}
                                    onChange={() => setFormData({ ...formData, correct_answer: alt.id })}
                                    className="mt-3 w-4 h-4 text-green-600 focus:ring-green-500 cursor-pointer"
                                />
                            </div>
                        ))}
                    </div>

                    {/* Explanation */}
                    <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm">
                        <label className="block text-sm font-semibold text-slate-700 mb-2">Explicación</label>
                        <textarea
                            className="w-full p-3 border rounded-lg font-mono text-sm bg-white text-slate-900 min-h-[100px] focus:ring-2 focus:ring-blue-500 focus:outline-none"
                            value={formData.explanation}
                            onChange={e => setFormData({ ...formData, explanation: e.target.value })}
                            placeholder="Explica paso a paso la solución..."
                        />
                        {formData.explanation && (
                            <div className="mt-4 p-4 bg-slate-50 rounded-lg border border-slate-100">
                                <div className="prose prose-sm text-slate-800">
                                    <Latex>{formData.explanation}</Latex>
                                </div>
                            </div>
                        )}

                        <div className="mt-4 pt-4 border-t border-slate-100">
                            <label className="block text-sm font-semibold text-slate-700 mb-2">Video Explicativo</label>

                            {!formData.explanation_video_path ? (
                                <div className="flex items-center gap-4">
                                    <label className="cursor-pointer flex items-center gap-2 px-4 py-2 border border-slate-300 rounded-lg bg-slate-50 hover:bg-slate-100 transition-colors text-sm font-medium text-slate-700">
                                        <Upload size={16} />
                                        {uploading ? "Subiendo..." : "Subir Video"}
                                        <input
                                            type="file"
                                            className="hidden"
                                            accept="video/mp4,video/webm"
                                            onChange={handleVideoUpload}
                                            disabled={uploading}
                                        />
                                    </label>
                                    <span className="text-xs text-slate-400">MP4, WEBM (Max 50MB)</span>
                                </div>
                            ) : (
                                <div className="flex items-center gap-3 bg-green-50 text-green-700 p-3 rounded-lg border border-green-200">
                                    <span className="text-sm font-mono truncate max-w-[200px]">{formData.explanation_video_path}</span>
                                    <button onClick={removeVideo} className="text-red-500 hover:text-red-700 font-bold ml-auto">
                                        <X size={16} />
                                    </button>
                                </div>
                            )}
                            <p className="text-xs text-slate-500 mt-1">El video se subirá de forma segura y solo será accesible usuarios autorizados.</p>
                        </div>
                    </div>
                </div>

                {/* Sidebar Settings */}
                <div className="space-y-6">
                    <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm space-y-4 sticky top-6">
                        <h3 className="font-bold text-slate-900 border-b pb-2">Configuración</h3>

                        <div>
                            <label className="block text-xs font-bold text-slate-500 uppercase mb-1">Eje Temático ({subject.toUpperCase()})</label>
                            <select
                                className="w-full p-2 border rounded-md text-sm bg-white text-slate-900"
                                value={formData.eje_id}
                                onChange={e => setFormData({ ...formData, eje_id: e.target.value, topic_id: "" })}
                            >
                                <option value="">Selecciona Eje</option>
                                {ejes.filter(e => e.subject === subject).map(e => (
                                    <option key={e.id} value={e.id}>{e.name}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="block text-xs font-bold text-slate-500 uppercase mb-1">Tema Específico</label>
                            <select
                                className="w-full p-2 border rounded-md text-sm bg-white text-slate-900"
                                value={formData.topic_id}
                                onChange={e => setFormData({ ...formData, topic_id: e.target.value })}
                                disabled={!formData.eje_id}
                            >
                                <option value="">Selecciona Tema</option>
                                {filteredTopics.map(t => (
                                    <option key={t.id} value={t.id}>{t.name}</option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="block text-xs font-bold text-slate-500 uppercase mb-1">Dificultad</label>
                            <select
                                className="w-full p-2 border rounded-md text-sm bg-white text-slate-900"
                                value={formData.difficulty}
                                onChange={e => setFormData({ ...formData, difficulty: e.target.value })}
                            >
                                <option value="easy">Principiante</option>
                                <option value="medium">Intermedio</option>
                                <option value="hard">Avanzado</option>
                            </select>
                        </div>

                        <Button onClick={handleSubmit} disabled={loading} className="w-full bg-blue-600 hover:bg-blue-700">
                            <Save className="mr-2" size={18} />
                            {loading ? "Guardando..." : "Guardar Pregunta"}
                        </Button>
                    </div>
                </div>
            </div>
        </div>
    )
}
