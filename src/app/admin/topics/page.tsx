"use client"

import { useState, useEffect, useMemo } from "react"
import { createClient } from "@/lib/supabase/client"
import { Button } from "@/components/ui/button"
import { Plus, Trash, Edit, Save, X, BookOpen, Layers, Search, ChevronRight, ChevronDown } from "lucide-react"

export default function AdminTopicsPage() {
    const supabase = createClient()
    const [loading, setLoading] = useState(false)
    const [ejes, setEjes] = useState<any[]>([])
    const [topics, setTopics] = useState<any[]>([])
    const [searchQuery, setSearchQuery] = useState("")

    const [subject, setSubject] = useState<'m1' | 'm2'>('m1')

    // Eje Form State
    const [isEditingEje, setIsEditingEje] = useState(false)
    const [ejeForm, setEjeForm] = useState({ id: "", name: "", slug: "" })

    // Topic Form State
    const [isEditingTopic, setIsEditingTopic] = useState(false)
    const [topicForm, setTopicForm] = useState({ id: "", name: "", slug: "", eje_id: "" })

    useEffect(() => {
        fetchData()
    }, [subject])

    const fetchData = async () => {
        setLoading(true)
        // Fetch Ejes filtered by Subject
        const { data: axes } = await supabase
            .from('ejes')
            .select('*')
            .eq('subject', subject)
            .order('name')

        // Fetch topics filtered by inner joining with filtered Ejes
        const { data: tops } = await supabase
            .from('topics')
            .select('*, ejes!inner(name, subject), question_topics(count)')
            .eq('ejes.subject', subject)
            .order('name')

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

    // --- GROUPED DATA AND FILTERING ---
    const filteredAndGroupedData = useMemo(() => {
        const query = searchQuery.toLowerCase()

        return ejes.map(eje => {
            const ejeTopics = topics.filter(t => t.eje_id === eje.id)
            const filteredTopics = ejeTopics.filter(t =>
                t.name.toLowerCase().includes(query) ||
                eje.name.toLowerCase().includes(query)
            )

            // If Eje matches query but topics don't, we still might want to show Eje
            // or if any topics match, we show Eje.
            const ejeMatches = eje.name.toLowerCase().includes(query)

            if (ejeMatches || filteredTopics.length > 0) {
                return {
                    ...eje,
                    topics: ejeTopics, // All topics for visibility or just filtered? 
                    // Let's show filtered topics if there is a query, else all.
                    filteredTopics: query ? filteredTopics : ejeTopics
                }
            }
            return null
        }).filter(Boolean)
    }, [ejes, topics, searchQuery])

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
                // Insert with Subject
                const { error } = await supabase.from('ejes').insert({
                    name: ejeForm.name,
                    slug: ejeForm.slug,
                    subject: subject // Add current subject
                })
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
        <div className="max-w-6xl mx-auto space-y-8 pb-20">
            <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 pb-6 border-b border-slate-100">
                <div>
                    <h2 className="text-3xl font-extrabold text-slate-900 tracking-tight">Gestión de Temario</h2>
                    <p className="text-slate-500 mt-1">Organiza los ejes y temas de la PAES.</p>
                </div>

                <div className="flex items-center gap-4">
                    {/* Subject Switcher */}
                    <div className="bg-slate-100 p-1 rounded-xl flex items-center shadow-inner">
                        <button
                            onClick={() => setSubject('m1')}
                            className={`px-6 py-2 rounded-lg text-sm font-bold transition-all duration-200 ${subject === 'm1'
                                ? 'bg-white text-blue-600 shadow-md transform scale-105'
                                : 'text-slate-500 hover:text-slate-700'
                                }`}
                        >
                            M1
                        </button>
                        <button
                            onClick={() => setSubject('m2')}
                            className={`px-6 py-2 rounded-lg text-sm font-bold transition-all duration-200 ${subject === 'm2'
                                ? 'bg-white text-indigo-600 shadow-md transform scale-105'
                                : 'text-slate-500 hover:text-slate-700'
                                }`}
                        >
                            M2
                        </button>
                    </div>

                    <Button onClick={() => setIsEditingEje(true)} className="bg-blue-600 hover:bg-blue-700 shadow-lg shadow-blue-200">
                        <Plus size={18} className="mr-2" /> Nuevo Eje
                    </Button>
                </div>
            </div>

            {/* Search and Quick Filters */}
            <div className="relative group">
                <div className="absolute inset-y-0 left-4 flex items-center pointer-events-none text-slate-400 group-focus-within:text-blue-500 transition-colors">
                    <Search size={20} />
                </div>
                <input
                    type="text"
                    placeholder="Buscar eje o tema específico..."
                    className="w-full pl-12 pr-4 py-4 bg-white border border-slate-200 rounded-2xl shadow-sm focus:ring-4 focus:ring-blue-100 focus:border-blue-400 transition-all outline-none text-lg"
                    value={searchQuery}
                    onChange={(e) => setSearchQuery(e.target.value)}
                />
            </div>

            {/* Forms Modals/Sections */}
            {isEditingEje && (
                <div className="bg-gradient-to-br from-blue-50 to-indigo-50 p-6 rounded-2xl border border-blue-100 shadow-inner space-y-4">
                    <div className="flex items-center justify-between">
                        <h4 className="font-bold text-blue-900 flex items-center gap-2">
                            <Layers size={18} />
                            {ejeForm.id ? "Editar Eje Temático" : "Crear Nuevo Eje Temático"}
                        </h4>
                        <button onClick={() => { setIsEditingEje(false); setEjeForm({ id: "", name: "", slug: "" }) }} className="text-blue-400 hover:text-blue-600">
                            <X size={20} />
                        </button>
                    </div>
                    <div className="grid md:grid-cols-2 gap-6 items-end">
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-blue-700 uppercase tracking-wider">Nombre del Eje</label>
                            <input
                                className="w-full p-3 bg-white border border-blue-200 rounded-xl text-sm focus:ring-2 focus:ring-blue-400 outline-none"
                                placeholder="Ej: Álgebra y Propiedades"
                                value={ejeForm.name}
                                onChange={e => setEjeForm({ ...ejeForm, name: e.target.value })}
                            />
                        </div>
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-blue-700 uppercase tracking-wider">Slug (URL)</label>
                            <input
                                className="w-full p-3 bg-white border border-blue-200 rounded-xl text-sm font-mono focus:ring-2 focus:ring-blue-400 outline-none"
                                placeholder="Ej: algebra-y-propiedades"
                                value={ejeForm.slug}
                                onChange={e => setEjeForm({ ...ejeForm, slug: e.target.value })}
                            />
                        </div>
                    </div>
                    <div className="flex justify-end pt-2">
                        <Button onClick={handleSaveEje} disabled={loading} className="px-8">
                            <Save size={18} className="mr-2" /> Guardar en {subject.toUpperCase()}
                        </Button>
                    </div>
                </div>
            )}

            {isEditingTopic && (
                <div className="bg-gradient-to-br from-purple-50 to-pink-50 p-6 rounded-2xl border border-purple-100 shadow-inner space-y-4">
                    <div className="flex items-center justify-between">
                        <h4 className="font-bold text-purple-900 flex items-center gap-2">
                            <BookOpen size={18} />
                            {topicForm.id ? "Editar Tema Específico" : "Crear Nuevo Tema Específico"}
                        </h4>
                        <button onClick={() => { setIsEditingTopic(false); setTopicForm({ id: "", name: "", slug: "", eje_id: "" }) }} className="text-purple-400 hover:text-purple-600">
                            <X size={20} />
                        </button>
                    </div>
                    <div className="grid md:grid-cols-3 gap-6 items-end">
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-purple-700 uppercase tracking-wider">Eje Temático</label>
                            <select
                                className="w-full p-3 bg-white border border-purple-200 rounded-xl text-sm focus:ring-2 focus:ring-purple-400 outline-none"
                                value={topicForm.eje_id}
                                onChange={e => setTopicForm({ ...topicForm, eje_id: e.target.value })}
                            >
                                <option value="">Selecciona Eje</option>
                                {ejes.map(e => (
                                    <option key={e.id} value={e.id}>{e.name}</option>
                                ))}
                            </select>
                        </div>
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-purple-700 uppercase tracking-wider">Nombre del Tema</label>
                            <input
                                className="w-full p-3 bg-white border border-purple-200 rounded-xl text-sm focus:ring-2 focus:ring-purple-400 outline-none"
                                placeholder="Ej: Ecuación Cuadrática"
                                value={topicForm.name}
                                onChange={e => setTopicForm({ ...topicForm, name: e.target.value })}
                            />
                        </div>
                        <div className="space-y-2">
                            <label className="text-xs font-bold text-purple-700 uppercase tracking-wider">Slug (URL)</label>
                            <input
                                className="w-full p-3 bg-white border border-purple-200 rounded-xl text-sm font-mono focus:ring-2 focus:ring-purple-400 outline-none"
                                placeholder="Ej: ecuacion-cuadratica"
                                value={topicForm.slug}
                                onChange={e => setTopicForm({ ...topicForm, slug: e.target.value })}
                            />
                        </div>
                    </div>
                    <div className="flex justify-end pt-2">
                        <Button onClick={handleSaveTopic} disabled={loading} className="bg-purple-600 hover:bg-purple-700 px-8">
                            <Save size={18} className="mr-2" /> Guardar Tema
                        </Button>
                    </div>
                </div>
            )}

            {/* Hierarchical View */}
            <div className="space-y-8">
                {filteredAndGroupedData.map((eje: any) => (
                    <div key={eje.id} className="bg-white rounded-3xl border border-slate-200 overflow-hidden shadow-sm hover:shadow-md transition-shadow">
                        {/* Eje Header */}
                        <div className="bg-slate-50 px-8 py-5 border-b border-slate-200 flex flex-col md:flex-row md:items-center justify-between gap-4">
                            <div className="flex items-center gap-4">
                                <div className="w-12 h-12 rounded-2xl bg-white shadow-sm flex items-center justify-center text-blue-600 border border-slate-100">
                                    <Layers size={24} />
                                </div>
                                <div>
                                    <h3 className="text-xl font-bold text-slate-900 leading-tight">{eje.name}</h3>
                                    <div className="flex items-center gap-3 mt-1 text-xs font-medium uppercase tracking-widest">
                                        <span className="text-slate-400">{eje.slug}</span>
                                        <span className="w-1 h-1 rounded-full bg-slate-300" />
                                        <span className="text-blue-600 bg-blue-50 px-2 py-0.5 rounded-full">{eje.question_count} preguntas</span>
                                    </div>
                                </div>
                            </div>
                            <div className="flex items-center gap-2">
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => editEje(eje)}
                                    className="text-slate-400 hover:text-blue-600 hover:bg-blue-50"
                                >
                                    <Edit size={16} className="mr-2" /> Editar Eje
                                </Button>
                                <Button
                                    variant="ghost"
                                    size="sm"
                                    onClick={() => handleDeleteEje(eje.id)}
                                    className="text-slate-400 hover:text-red-600 hover:bg-red-50"
                                >
                                    <Trash size={16} />
                                </Button>
                                <div className="w-px h-6 bg-slate-200 mx-2" />
                                <Button
                                    size="sm"
                                    onClick={() => {
                                        setTopicForm({ ...topicForm, eje_id: eje.id });
                                        setIsEditingTopic(true);
                                    }}
                                    className="bg-white text-slate-700 border border-slate-200 hover:bg-slate-50 shadow-sm"
                                >
                                    <Plus size={16} className="mr-2" /> Nuevo Tema
                                </Button>
                            </div>
                        </div>

                        {/* Topics List */}
                        <div className="px-8 py-2">
                            {eje.filteredTopics.length > 0 ? (
                                <table className="w-full text-sm">
                                    <thead>
                                        <tr className="text-slate-400 text-[10px] font-black uppercase tracking-widest border-b border-slate-50">
                                            <th className="py-4 text-left font-black">Tema Específico</th>
                                            <th className="py-4 text-center font-black">Preguntas</th>
                                            <th className="py-4 text-left font-black">Slug</th>
                                            <th className="py-4 text-right font-black">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody className="divide-y divide-slate-50">
                                        {eje.filteredTopics.map((topic: any) => (
                                            <tr key={topic.id} className="group hover:bg-slate-50/50 transition-colors">
                                                <td className="py-4">
                                                    <div className="flex items-center gap-3">
                                                        <BookOpen size={14} className="text-slate-300" />
                                                        <span className="font-semibold text-slate-700">{topic.name}</span>
                                                    </div>
                                                </td>
                                                <td className="py-4 text-center">
                                                    <span className={`inline-flex items-center justify-center w-8 h-8 rounded-lg text-xs font-bold ${topic.question_count > 0 ? 'bg-indigo-50 text-indigo-600' : 'bg-slate-50 text-slate-400'}`}>
                                                        {topic.question_count}
                                                    </span>
                                                </td>
                                                <td className="py-4 font-mono text-[10px] text-slate-400">{topic.slug}</td>
                                                <td className="py-4 text-right">
                                                    <div className="flex items-center justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                                        <button
                                                            onClick={() => editTopic(topic)}
                                                            className="p-2 hover:bg-white hover:shadow-sm text-slate-400 hover:text-purple-600 rounded-lg transition-all"
                                                            title="Editar Tema"
                                                        >
                                                            <Edit size={14} />
                                                        </button>
                                                        <button
                                                            onClick={() => handleDeleteTopic(topic.id)}
                                                            className="p-2 hover:bg-white hover:shadow-sm text-slate-400 hover:text-red-600 rounded-lg transition-all"
                                                            title="Eliminar Tema"
                                                        >
                                                            <Trash size={14} />
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            ) : (
                                <div className="py-12 text-center text-slate-400 italic">
                                    {searchQuery ? "No se encontraron temas que coincidan con la búsqueda." : "No hay temas creados en este eje."}
                                </div>
                            )}
                        </div>
                    </div>
                ))}

                {filteredAndGroupedData.length === 0 && (
                    <div className="bg-white rounded-3xl border border-dashed border-slate-300 p-20 text-center">
                        <div className="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-6 text-slate-300">
                            <Search size={40} />
                        </div>
                        <h4 className="text-xl font-bold text-slate-900">No encontramos nada</h4>
                        <p className="text-slate-500 mt-2 max-w-xs mx-auto">Prueba ajustando el término de búsqueda o cambia la prueba (M1/M2).</p>
                        <Button
                            variant="ghost"
                            className="mt-4 text-blue-600 hover:text-blue-700 hover:bg-blue-50"
                            onClick={() => setSearchQuery("")}
                        >
                            Limpiar búsqueda
                        </Button>
                    </div>
                )}
            </div>
        </div>
    )
}
