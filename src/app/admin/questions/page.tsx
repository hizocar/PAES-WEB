"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import Link from "next/link"
import { Plus, Trash, Edit, ThumbsUp, ThumbsDown } from "lucide-react"
// @ts-ignore
import Latex from '@/components/ui/latex-renderer'
import 'katex/dist/katex.min.css'

export default function AdminQuestionsPage() {
    const [questions, setQuestions] = useState<any[]>([])
    const [filteredQuestions, setFilteredQuestions] = useState<any[]>([])
    const [ejes, setEjes] = useState<any[]>([])
    const [topics, setTopics] = useState<any[]>([])

    // Filters
    const [filterEje, setFilterEje] = useState("all")
    const [filterTopic, setFilterTopic] = useState("all")
    const [filterDifficulty, setFilterDifficulty] = useState("all")

    const supabase = createClient()

    useEffect(() => {
        fetchData()
    }, [])

    useEffect(() => {
        let res = questions

        if (filterEje !== "all") {
            res = res.filter(q => q.eje_id === filterEje)
        }

        if (filterTopic !== "all") {
            // Need to reverse check from question -> topic
            // q.topic_name is available, but let's use the ID map we constructed
            // Actually, wait, q object currently only has topic_name. 
            // Better to match by name or add topic_id to q object in fetch
            const selectedTopic = topics.find(t => t.id === filterTopic)
            if (selectedTopic) {
                res = res.filter(q => q.topic_name === selectedTopic.name)
            }
        }

        if (filterDifficulty !== "all") {
            res = res.filter(q => q.difficulty === filterDifficulty)
        }

        setFilteredQuestions(res)
    }, [questions, filterEje, filterTopic, filterDifficulty, topics])

    const fetchData = async () => {
        // 1. Fetch Ejes and Topics
        const { data: axes } = await supabase.from('ejes').select('*')
        if (axes) setEjes(axes)

        const { data: allTopics } = await supabase.from('topics').select('*')
        if (allTopics) setTopics(allTopics)

        // 2. Fetch Questions
        const { data: qData } = await supabase
            .from('questions')
            .select('*')
            .order('created_at', { ascending: false })

        if (!qData) return

        // 3. Fetch Topics/Ejes mapping for questions
        const qIds = qData.map(q => q.id)
        const { data: qtData } = await supabase
            .from('question_topics')
            .select('question_id, topics(name, eje_id)')
            .in('question_id', qIds)

        const mapEje: Record<string, string> = {}
        const mapTopic: Record<string, string> = {}

        qtData?.forEach((item: any) => {
            if (item.topics) {
                mapEje[item.question_id] = item.topics.eje_id
                mapTopic[item.question_id] = item.topics.name
            }
        })

        // 4. Fetch Feedback
        const { data: feedbackData } = await supabase
            .from('question_feedback')
            .select('question_id, vote') // Assuming table has 'vote' column with 'up'/'down'
            .in('question_id', qIds)

        const mapFeedback: Record<string, { up: number, down: number }> = {}

        // Initialize map
        qIds.forEach(id => {
            mapFeedback[id] = { up: 0, down: 0 }
        })

        feedbackData?.forEach((item: any) => {
            if (mapFeedback[item.question_id]) {
                if (item.vote === 'up') mapFeedback[item.question_id].up++
                if (item.vote === 'down') mapFeedback[item.question_id].down++
            }
        })

        const questionsWithMeta = qData.map(q => ({
            ...q,
            eje_id: mapEje[q.id],
            topic_name: mapTopic[q.id],
            votes: mapFeedback[q.id] || { up: 0, down: 0 }
        }))

        setQuestions(questionsWithMeta)
        setFilteredQuestions(questionsWithMeta)
    }

    const handleDelete = async (id: string) => {
        if (!confirm("¿Estás seguro de eliminar esta pregunta?")) return
        const { error } = await supabase.from('questions').delete().eq('id', id)
        if (!error) {
            fetchData()
        } else {
            alert("Error al eliminar: " + error.message)
        }
    }

    const getDifficultyLabel = (d: string) => {
        switch (d) {
            case 'easy': return '🟢 Principiante'
            case 'medium': return '🟡 Intermedio'
            case 'hard': return '🔴 Avanzado'
            default: return d
        }
    }

    return (
        <div className="space-y-6 pb-20">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                <div>
                    <h2 className="text-2xl font-bold text-slate-900">Gestión de Preguntas</h2>
                    <p className="text-slate-500 text-sm">Administra el banco de ejercicios</p>
                </div>
                <Link href="/admin/questions/new">
                    <Button>
                        <Plus className="mr-2" size={18} />
                        Nueva Pregunta
                    </Button>
                </Link>
            </div>

            {/* Filters */}
            <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm flex flex-col md:flex-row gap-4">
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Eje</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterEje}
                        onChange={e => {
                            setFilterEje(e.target.value)
                            setFilterTopic("all")
                        }}
                    >
                        <option value="all">Todos los Ejes</option>
                        {ejes.map(e => (
                            <option key={e.id} value={e.id}>{e.name}</option>
                        ))}
                    </select>
                </div>
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Tema</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterTopic}
                        onChange={e => setFilterTopic(e.target.value)}
                        disabled={filterEje === "all"}
                    >
                        <option value="all">Todos los Temas</option>
                        {topics
                            .filter(t => filterEje === "all" || t.eje_id === filterEje)
                            .map(t => (
                                <option key={t.id} value={t.id}>{t.name}</option>
                            ))}
                    </select>
                </div>
                <div className="flex-1">
                    <label className="text-xs font-bold text-slate-500 uppercase mb-1 block">Filtrar por Dificultad</label>
                    <select
                        className="w-full p-2 border rounded-md text-sm"
                        value={filterDifficulty}
                        onChange={e => setFilterDifficulty(e.target.value)}
                    >
                        <option value="all">Todas</option>
                        <option value="easy">Principiante</option>
                        <option value="medium">Intermedio</option>
                        <option value="hard">Avanzado</option>
                    </select>
                </div>
            </div>

            <div className="grid gap-4">
                {filteredQuestions.map((q) => (
                    <div key={q.id} className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm hover:border-blue-300 transition-colors">

                        {/* Header: Badges and Actions */}
                        <div className="flex flex-wrap items-start justify-between gap-4 mb-4">
                            <div className="flex flex-wrap items-center gap-2">
                                <span className={`px-2 py-0.5 rounded textxs font-bold uppercase tracking-wider text-[10px] bg-slate-100 text-slate-600`}>
                                    {ejes.find(e => e.id === q.eje_id)?.name || 'Sin Eje'}
                                </span>
                                {q.topic_name && (
                                    <span className="px-2 py-0.5 rounded textxs font-bold uppercase tracking-wider text-[10px] bg-purple-100 text-purple-600">
                                        {q.topic_name}
                                    </span>
                                )}
                                <span className="text-xs text-slate-400 font-mono">ID: {q.id.slice(0, 8)}</span>
                            </div>

                            <div className="flex items-center gap-4">
                                {/* Success Ratio */}
                                <div className="flex flex-col items-end">
                                    <span className="text-[10px] uppercase font-bold text-slate-400">Tasa de Éxito</span>
                                    <span className={`text-xs font-bold ${!q.total_attempts ? 'text-slate-400' :
                                        (q.correct_attempts / q.total_attempts) >= 0.7 ? 'text-green-600' :
                                            (q.correct_attempts / q.total_attempts) >= 0.4 ? 'text-yellow-600' :
                                                'text-red-600'
                                        }`}>
                                        {q.total_attempts
                                            ? `${Math.round((q.correct_attempts / q.total_attempts) * 100)}% (${q.correct_attempts}/${q.total_attempts})`
                                            : 'Sin datos'
                                        }
                                    </span>
                                </div>

                                {/* Feedback Stats */}
                                <div className="flex flex-col items-end">
                                    <span className="text-[10px] uppercase font-bold text-slate-400">Feedback</span>
                                    <div className="flex items-center gap-3">
                                        <div className="flex items-center gap-1 text-xs font-bold text-green-600">
                                            <ThumbsUp size={14} />
                                            <span>{q.votes?.up || 0}</span>
                                        </div>
                                        <div className="flex items-center gap-1 text-xs font-bold text-red-500">
                                            <ThumbsDown size={14} />
                                            <span>{q.votes?.down || 0}</span>
                                        </div>
                                    </div>
                                </div>

                                {/* Actions */}
                                <div className="flex gap-2">
                                    <Link href={`/admin/questions/${q.id}`}>
                                        <Button size="sm" variant="outline" className="h-8 text-slate-600">
                                            <Edit size={14} className="mr-2" />
                                            Editar
                                        </Button>
                                    </Link>
                                    <Button
                                        size="sm"
                                        variant="ghost"
                                        className="h-8 text-red-500 hover:text-red-700 hover:bg-red-50"
                                        onClick={() => handleDelete(q.id)}
                                    >
                                        <Trash size={14} />
                                    </Button>
                                </div>
                            </div>
                        </div>

                        {/* Question Content */}
                        <div className="text-slate-900 text-lg font-medium leading-relaxed mb-4 break-words">
                            <Latex>{q.content}</Latex>
                        </div>

                        {/* Footer */}
                        <div className="flex items-center gap-4 text-sm text-slate-500 border-t border-slate-100 pt-4">
                            <span className="flex items-center gap-1 font-medium">
                                Respuesta: <span className="text-slate-900 font-bold">{q.correct_answer}</span>
                            </span>
                            <span className="w-1 h-1 rounded-full bg-slate-300"></span>
                            <span>{getDifficultyLabel(q.difficulty)}</span>
                        </div>
                    </div>
                ))
                }
                {
                    filteredQuestions.length === 0 && (
                        <div className="text-center py-12 bg-slate-50 rounded-xl border border-dashed border-slate-300">
                            <p className="text-slate-500">No se encontraron preguntas con estos filtros.</p>
                        </div>
                    )
                }
            </div >
        </div >
    )
}
