"use client"

import { useState, useEffect } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Plus, Trash, Edit, Save, X, BookOpen, Layers } from "lucide-react"

export default function AdminTopicsPage() {
    const supabase = createClient()
    const [loading, setLoading] = useState(false)
    const [ejes, setEjes] = useState<any[]>([])
    const [topics, setTopics] = useState<any[]>([])

    // Eje Form State
    const [isEditingEje, setIsEditingEje] = useState(false)
    const [ejeForm, setEjeForm] = useState({ id: "", name: "", slug: "" })

    // Topic Form State
    const [isEditingTopic, setIsEditingTopic] = useState(false)
    const [topicForm, setTopicForm] = useState({ id: "", name: "", slug: "", eje_id: "" })

    useEffect(() => {
        fetchData()
    }, [])

    const fetchData = async () => {
        setLoading(true)
        const { data: axes } = await supabase.from('ejes').select('*').order('name')
        // Fetch topics with their related Axis name AND the count of linked questions
        const { data: tops } = await supabase.from('topics').select('*, ejes(name), question_topics(count)').order('name')

        if (tops) {
            // Flatten the count for easier display
            const formattedTopics = tops.map((t: any) => ({
                ...t,
                question_count: t.question_topics?.[0]?.count || 0
            }))

            setTopics(formattedTopics)

            // Calculate questions per Eje
            if (axes) {
                const axesWithCounts = axes.map((axis: any) => {
                    const axisTopics = formattedTopics.filter((t: any) => t.eje_id === axis.id)
                    const totalQuestions = axisTopics.reduce((sum: number, t: any) => sum + t.question_count, 0)
                    return { ...axis, question_count: totalQuestions }
                })
                setEjes(axesWithCounts)
            }
        }
        setLoading(false)
    }

    // --- EJES ACTIONS ---

    const handleSaveEje = async () => {
        if (!ejeForm.name || !ejeForm.slug) return alert("Completa todos los campos")

        setLoading(true)
        try {
            if (ejeForm.id) {
                // Update
                const { error } = await supabase.from('ejes').update({ name: ejeForm.name, slug: ejeForm.slug }).eq('id', ejeForm.id)
                if (error) throw error
            } else {
                // Insert
                const { error } = await supabase.from('ejes').insert({ name: ejeForm.name, slug: ejeForm.slug })
                if (error) throw error
            }
            fetchData()
            setEjeForm({ id: "", name: "", slug: "" })
            setIsEditingEje(false)
        } catch (error: any) {
            alert("Error: " + error.message)
        } finally {
            setLoading(false)
        }
    }

    const handleDeleteEje = async (id: string) => {
        if (!confirm("¿Eliminar este eje? También se eliminarán sus temas de forma automática.")) return
        setLoading(true)
        const { error } = await supabase.from('ejes').delete().eq('id', id)
        if (error) alert("Error: " + error.message)
        fetchData()
        setLoading(false)
    }

    const editEje = (eje: any) => {
        setEjeForm(eje)
        setIsEditingEje(true)
    }

    // --- TOPICS ACTIONS ---

    const handleSaveTopic = async () => {
        if (!topicForm.name || !topicForm.slug || !topicForm.eje_id) return alert("Completa todos los campos")

        setLoading(true)
        try {
            if (topicForm.id) {
                // Update
                const { error } = await supabase.from('topics').update({
                    name: topicForm.name,
                    slug: topicForm.slug,
                    eje_id: topicForm.eje_id
                }).eq('id', topicForm.id)
                if (error) throw error
            } else {
                // Insert
                const { error } = await supabase.from('topics').insert({
                    name: topicForm.name,
                    slug: topicForm.slug,
                    eje_id: topicForm.eje_id
                })
                if (error) throw error
            }
            fetchData()
            setTopicForm({ id: "", name: "", slug: "", eje_id: "" })
            setIsEditingTopic(false)
        } catch (error: any) {
            alert("Error: " + error.message)
        } finally {
            setLoading(false)
        }
    }

    const handleDeleteTopic = async (id: string) => {
        if (!confirm("¿Eliminar este tema específico?")) return
        setLoading(true)
        const { error } = await supabase.from('topics').delete().eq('id', id)
        if (error) alert("Error: " + error.message)
        fetchData()
        setLoading(false)
    }

    const editTopic = (topic: any) => {
        setTopicForm(topic)
        setIsEditingTopic(true)
    }

    return (
        <div className="space-y-12 pb-20">
            <div>
                <h2 className="text-2xl font-bold text-slate-900">Gestión de Temario</h2>
                <p className="text-slate-500 text-sm">Administra los Ejes Temáticos y sus Temas Específicos.</p>
            </div>

            {/* SECCION EJES */}
            <div className="space-y-4">
                <div className="flex items-center justify-between">
                    <h3 className="text-lg font-bold text-slate-800 flex items-center gap-2">
                        <Layers className="text-blue-600" size={20} />
                        Ejes Temáticos
                    </h3>
                    {!isEditingEje && (
                        <Button size="sm" onClick={() => setIsEditingEje(true)}>
                            <Plus size={16} className="mr-2" /> Nuevo Eje
                        </Button>
                    )}
                </div>

                {isEditingEje && (
                    <div className="bg-blue-50 p-4 rounded-xl border border-blue-200 flex flex-wrap gap-4 items-end">
                        <div className="flex-1 min-w-[200px]">
                            <label className="text-xs font-bold text-slate-500 uppercase">Nombre</label>
                            <input
                                className="w-full p-2 border rounded-md text-sm"
                                placeholder="Ej: Álgebra y Propiedades"
                                value={ejeForm.name}
                                onChange={e => setEjeForm({ ...ejeForm, name: e.target.value })}
                            />
                        </div>
                        <div className="flex-1 min-w-[200px]">
                            <label className="text-xs font-bold text-slate-500 uppercase">Slug (URL)</label>
                            <input
                                className="w-full p-2 border rounded-md text-sm font-mono text-slate-600"
                                placeholder="Ej: algebra-y-propiedades"
                                value={ejeForm.slug}
                                onChange={e => setEjeForm({ ...ejeForm, slug: e.target.value })}
                            />
                        </div>
                        <div className="flex gap-2">
                            <Button size="sm" onClick={handleSaveEje} disabled={loading}>
                                <Save size={16} className="mr-2" /> Guardar
                            </Button>
                            <Button size="sm" variant="ghost" onClick={() => { setIsEditingEje(false); setEjeForm({ id: "", name: "", slug: "" }) }}>
                                <X size={16} /> Cancelar
                            </Button>
                        </div>
                    </div>
                )}

                <div className="bg-white rounded-xl border border-slate-200 overflow-hidden shadow-sm">
                    <table className="w-full text-sm text-left">
                        <thead className="bg-slate-50 text-slate-500 font-bold border-b">
                            <tr>
                                <th className="p-4">Nombre</th>
                                <th className="p-4">Preguntas (aprox)</th>
                                <th className="p-4">Slug</th>
                                <th className="p-4 text-right">Acciones</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {ejes.map((eje) => (
                                <tr key={eje.id} className="hover:bg-slate-50">
                                    <td className="p-4 font-medium text-slate-900">{eje.name}</td>
                                    <td className="p-4">
                                        <span className={`px-2 py-1 rounded text-xs font-bold ${eje.question_count > 0 ? 'bg-blue-100 text-blue-700' : 'bg-slate-100 text-slate-400'}`}>
                                            {eje.question_count || 0}
                                        </span>
                                    </td>
                                    <td className="p-4 text-slate-500 font-mono text-xs">{eje.slug}</td>
                                    <td className="p-4 flex gap-2 justify-end">
                                        <button onClick={() => editEje(eje)} className="p-1 hover:bg-blue-100 text-blue-600 rounded">
                                            <Edit size={16} />
                                        </button>
                                        <button onClick={() => handleDeleteEje(eje.id)} className="p-1 hover:bg-red-100 text-red-600 rounded">
                                            <Trash size={16} />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            {ejes.length === 0 && (
                                <tr>
                                    <td colSpan={3} className="p-8 text-center text-slate-400">No hay ejes creados</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>

            <hr className="border-slate-200" />

            {/* SECCION TEMAS */}
            <div className="space-y-4">
                <div className="flex items-center justify-between">
                    <h3 className="text-lg font-bold text-slate-800 flex items-center gap-2">
                        <BookOpen className="text-purple-600" size={20} />
                        Temas Específicos
                    </h3>
                    {!isEditingTopic && (
                        <Button size="sm" onClick={() => setIsEditingTopic(true)}>
                            <Plus size={16} className="mr-2" /> Nuevo Tema
                        </Button>
                    )}
                </div>

                {isEditingTopic && (
                    <div className="bg-purple-50 p-4 rounded-xl border border-purple-200 grid gap-4">
                        <div className="grid md:grid-cols-3 gap-4">
                            <div>
                                <label className="text-xs font-bold text-slate-500 uppercase">Eje Temático</label>
                                <select
                                    className="w-full p-2 border rounded-md text-sm bg-white"
                                    value={topicForm.eje_id}
                                    onChange={e => setTopicForm({ ...topicForm, eje_id: e.target.value })}
                                >
                                    <option value="">Selecciona Eje</option>
                                    {ejes.map(e => (
                                        <option key={e.id} value={e.id}>{e.name}</option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="text-xs font-bold text-slate-500 uppercase">Nombre</label>
                                <input
                                    className="w-full p-2 border rounded-md text-sm"
                                    placeholder="Ej: Ecuación Cuadrática"
                                    value={topicForm.name}
                                    onChange={e => setTopicForm({ ...topicForm, name: e.target.value })}
                                />
                            </div>
                            <div>
                                <label className="text-xs font-bold text-slate-500 uppercase">Slug (URL)</label>
                                <input
                                    className="w-full p-2 border rounded-md text-sm font-mono text-slate-600"
                                    placeholder="Ej: ecuacion-cuadratica"
                                    value={topicForm.slug}
                                    onChange={e => setTopicForm({ ...topicForm, slug: e.target.value })}
                                />
                            </div>
                        </div>
                        <div className="flex gap-2 justify-end">
                            <Button size="sm" onClick={handleSaveTopic} disabled={loading}>
                                <Save size={16} className="mr-2" /> Guardar Tema
                            </Button>
                            <Button size="sm" variant="ghost" onClick={() => { setIsEditingTopic(false); setTopicForm({ id: "", name: "", slug: "", eje_id: "" }) }}>
                                <X size={16} /> Cancelar
                            </Button>
                        </div>
                    </div>
                )}

                <div className="bg-white rounded-xl border border-slate-200 overflow-hidden shadow-sm">
                    <table className="w-full text-sm text-left">
                        <thead className="bg-slate-50 text-slate-500 font-bold border-b">
                            <tr>
                                <th className="p-4">Tema Específico</th>
                                <th className="p-4">Eje Pertenece</th>
                                <th className="p-4">Preguntas</th>
                                <th className="p-4">Slug</th>
                                <th className="p-4 text-right">Acciones</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                            {topics.map((topic) => (
                                <tr key={topic.id} className="hover:bg-slate-50">
                                    <td className="p-4 font-medium text-slate-900">{topic.name}</td>
                                    <td className="p-4">
                                        <span className="bg-slate-100 text-slate-600 px-2 py-1 rounded text-xs font-bold">
                                            {topic.ejes?.name || '---'}
                                        </span>
                                    </td>
                                    <td className="p-4">
                                        <span className={`px-2 py-1 rounded text-xs font-bold ${topic.question_count > 0 ? 'bg-blue-100 text-blue-700' : 'bg-slate-100 text-slate-400'}`}>
                                            {topic.question_count}
                                        </span>
                                    </td>
                                    <td className="p-4 text-slate-500 font-mono text-xs">{topic.slug}</td>
                                    <td className="p-4 flex gap-2 justify-end">
                                        <button onClick={() => editTopic(topic)} className="p-1 hover:bg-purple-100 text-purple-600 rounded">
                                            <Edit size={16} />
                                        </button>
                                        <button onClick={() => handleDeleteTopic(topic.id)} className="p-1 hover:bg-red-100 text-red-600 rounded">
                                            <Trash size={16} />
                                        </button>
                                    </td>
                                </tr>
                            ))}
                            {topics.length === 0 && (
                                <tr>
                                    <td colSpan={4} className="p-8 text-center text-slate-400">No hay temas creados</td>
                                </tr>
                            )}
                        </tbody>
                    </table>
                </div>
            </div>
        </div >
    )
}
