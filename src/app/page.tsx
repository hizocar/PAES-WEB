import { Button } from "@/components/ui/button"
import Link from "next/link"
import { createClient } from "@/lib/supabase/server"
import { redirect } from "next/navigation"

export default async function Home() {
  const supabase = createClient()
  const { data: { user } } = await (await supabase).auth.getUser()

  if (user) {
    redirect("/app")
  }

  return (
    <div className="flex min-h-screen flex-col">
      <header className="px-6 py-4 flex items-center justify-between border-b border-slate-100 bg-white/50 backdrop-blur-md sticky top-0 z-50">
        <div className="font-bold text-xl text-blue-600 flex items-center gap-2">
          <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
            <span className="text-white text-lg">M2</span>
          </div>
          PAES Trainer
        </div>
        <nav className="hidden md:flex items-center gap-6 text-sm font-medium text-slate-600">
          <a href="#features" className="hover:text-blue-600 transition-colors">Características</a>
          <a href="#pricing" className="hover:text-blue-600 transition-colors">Planes</a>
          <a href="#faq" className="hover:text-blue-600 transition-colors">Preguntas</a>
        </nav>
        <div className="flex items-center gap-3">
          <Link href="/login">
            <Button variant="ghost" className="font-semibold">Ingresar</Button>
          </Link>
          <Link href="/login">
            <Button className="shadow-lg shadow-blue-500/20">Comenzar Gratis</Button>
          </Link>
        </div>
      </header>

      <main className="flex-1 bg-white">
        {/* Hero Section */}
        <section className="relative overflow-hidden pt-20 pb-32">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[1000px] h-[600px] bg-gradient-to-tr from-blue-100 to-purple-100 rounded-full blur-3xl opacity-50 pointer-events-none" />
          <div className="container mx-auto px-6 relative z-10 text-center max-w-4xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-sm font-medium mb-6 border border-blue-100">
              <span className="w-2 h-2 rounded-full bg-blue-600 animate-pulse" />
              Nueva admisión 2025
            </div>
            <h1 className="text-5xl md:text-7xl font-extrabold tracking-tight text-slate-900 mb-8 leading-[1.1]">
              Domina la PAES M2 con <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-violet-600">Inteligencia y Práctica</span>
            </h1>
            <p className="text-xl text-slate-600 mb-10 max-w-2xl mx-auto leading-relaxed">
              La plataforma definitiva para puntajes nacionales. Práctica adaptativa, seguimiento en tiempo real y explicaciones detalladas.
            </p>
            <div className="flex flex-col sm:flex-row items-center justify-center gap-4">
              <Link href="/login">
                <Button size="lg" className="h-14 px-8 text-lg rounded-2xl shadow-xl shadow-blue-600/20 hover:scale-105 transition-transform">
                  Empezar a Practicar
                </Button>
              </Link>
              <Link href="#demo">
                <Button variant="outline" size="lg" className="h-14 px-8 text-lg rounded-2xl border-2 hover:bg-slate-50">
                  Ver Demo
                </Button>
              </Link>
            </div>

            {/* Stats */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-8 mt-20 pt-10 border-t border-slate-100">
              <div>
                <div className="text-3xl font-bold text-slate-900">15k+</div>
                <div className="text-sm text-slate-500 font-medium">Estudiantes</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-slate-900">2.5M</div>
                <div className="text-sm text-slate-500 font-medium">Ejercicios resueltos</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-slate-900">850+</div>
                <div className="text-sm text-slate-500 font-medium">Puntaje Promedio</div>
              </div>
              <div>
                <div className="text-3xl font-bold text-slate-900">24/7</div>
                <div className="text-sm text-slate-500 font-medium">Disponibilidad</div>
              </div>
            </div>
          </div>
        </section>

        {/* Features Preview */}
        <section className="py-24 bg-slate-50">
          <div className="container mx-auto px-6">
            <div className="grid md:grid-cols-3 gap-12">
              <div className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md transition-shadow">
                <div className="w-12 h-12 bg-blue-100 rounded-2xl flex items-center justify-center text-blue-600 mb-6">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Práctica Adaptativa</h3>
                <p className="text-slate-600 leading-relaxed">
                  Nuestro algoritmo identifica tus debilidades y te presenta ejercicios diseñados para mejorarlas.
                </p>
              </div>
              <div className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md transition-shadow">
                <div className="w-12 h-12 bg-purple-100 rounded-2xl flex items-center justify-center text-purple-600 mb-6">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" /></svg>
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Seguimiento Real</h3>
                <p className="text-slate-600 leading-relaxed">
                  Monitorea tu progreso por eje temático, tiempo de estudio y precisión en tus respuestas.
                </p>
              </div>
              <div className="bg-white p-8 rounded-3xl shadow-sm border border-slate-100 hover:shadow-md transition-shadow">
                <div className="w-12 h-12 bg-green-100 rounded-2xl flex items-center justify-center text-green-600 mb-6">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" /></svg>
                </div>
                <h3 className="text-xl font-bold text-slate-900 mb-3">Explicaciones en Video</h3>
                <p className="text-slate-600 leading-relaxed">
                  No te quedes con dudas. Accede a explicaciones detalladas en texto y video para cada ejercicio.
                </p>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer className="bg-slate-900 py-12 text-slate-400 text-sm">
        <div className="container mx-auto px-6 text-center">
          <p>© 2025 PAES M2 Trainer. Todos los derechos reservados.</p>
        </div>
      </footer>
    </div>
  )
}
