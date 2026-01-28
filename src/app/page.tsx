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

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    "name": "PAES Lab",
    "applicationCategory": "EducationalApplication",
    "operatingSystem": "Web",
    "offers": {
      "@type": "Offer",
      "price": "0",
      "priceCurrency": "CLP"
    },
    "description": "Plataforma de preparación para la PAES M2 con Inteligencia Artificial. Ejercicios adaptativos y seguimiento en tiempo real.",
    "aggregateRating": {
      "@type": "AggregateRating",
      "ratingValue": "4.8",
      "ratingCount": "1250"
    }
  }

  return (
    <div className="flex min-h-screen flex-col">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
      />
      <header className="px-6 py-4 flex items-center justify-between border-b border-slate-100 bg-white/50 backdrop-blur-md sticky top-0 z-50">
        <div className="font-bold text-xl text-blue-600 flex items-center gap-2">
          PAES Lab
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
        </div>
      </header>

      <main className="flex-1 bg-white">
        {/* Hero Section */}
        <section className="relative overflow-hidden pt-20 pb-32">
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[1000px] h-[600px] bg-gradient-to-tr from-blue-100 to-purple-100 rounded-full blur-3xl opacity-50 pointer-events-none" />
          <div className="container mx-auto px-6 relative z-10 text-center max-w-5xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-sm font-medium mb-6 border border-blue-100">
              <span className="w-2 h-2 rounded-full bg-blue-600 animate-pulse" />
              Nueva admisión 2027
            </div>
            <h1 className="text-5xl md:text-7xl font-extrabold tracking-tight text-slate-900 mb-8 leading-[1.1]">
              Domina la PAES con <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-violet-600">Inteligencia y Práctica</span>
            </h1>
            <p className="text-xl text-slate-600 mb-12 max-w-2xl mx-auto leading-relaxed">
              La única plataforma enfocada 100% en la <span className="font-bold text-slate-800">PAES M2</span>. Entrena con ejercicios de alta dificultad y explicaciones detalladas.
            </p>

            <div className="flex flex-col items-center justify-center gap-8">
              <Link href="/login">
                <Button size="lg" className="h-16 px-10 text-xl rounded-2xl shadow-xl shadow-blue-600/20 hover:scale-105 transition-transform font-bold bg-blue-600 hover:bg-blue-700">
                  Comenzar a practicar M2
                </Button>
              </Link>

              {/* Exam Status Cards */}
              <div className="grid md:grid-cols-3 gap-4 w-full text-left mt-8">
                {/* M2 Card - Active */}
                <div className="bg-white p-5 rounded-xl border-2 border-blue-500 shadow-lg relative overflow-hidden group hover:border-blue-600 transition-colors">
                  <div className="absolute top-0 right-0 bg-blue-500 text-white text-[10px] uppercase font-bold px-2 py-1 rounded-bl-lg">
                    Disponible
                  </div>
                  <div className="flex items-center gap-2 mb-2">
                    <span className="w-8 h-8 rounded-lg bg-blue-100 flex items-center justify-center text-blue-600 font-bold">M2</span>
                    <h3 className="font-bold text-slate-900 leading-tight">Matemática 2</h3>
                  </div>
                  <p className="text-xs text-slate-500 mb-2">Electiva / Requisito</p>
                  <p className="text-sm text-slate-600 leading-snug">
                    Evalúa competencias específicas para carreras científicas.
                  </p>
                </div>

                {/* M1 Card - Coming Soon */}
                <div className="bg-slate-50 p-5 rounded-xl border border-slate-200 relative overflow-hidden opacity-75 hover:opacity-100 transition-opacity">
                  <div className="absolute top-0 right-0 bg-slate-200 text-slate-500 text-[10px] uppercase font-bold px-2 py-1 rounded-bl-lg">
                    Pronto
                  </div>
                  <div className="flex items-center gap-2 mb-2">
                    <span className="w-8 h-8 rounded-lg bg-slate-200 flex items-center justify-center text-slate-500 font-bold">M1</span>
                    <h3 className="font-bold text-slate-700 leading-tight">Matemática 1</h3>
                  </div>
                  <p className="text-xs text-slate-400 mb-2">Obligatoria</p>
                  <p className="text-sm text-slate-500 leading-snug">
                    Mide conocimientos generales ajustados para la mayoría de carreras.
                  </p>
                </div>

                {/* Lectora Card - Coming Soon */}
                <div className="bg-slate-50 p-5 rounded-xl border border-slate-200 relative overflow-hidden opacity-75 hover:opacity-100 transition-opacity">
                  <div className="absolute top-0 right-0 bg-slate-200 text-slate-500 text-[10px] uppercase font-bold px-2 py-1 rounded-bl-lg">
                    Pronto
                  </div>
                  <div className="flex items-center gap-2 mb-2">
                    <span className="w-8 h-8 rounded-lg bg-slate-200 flex items-center justify-center text-slate-500 font-bold">CL</span>
                    <h3 className="font-bold text-slate-700 leading-tight">Comp. Lectora</h3>
                  </div>
                  <p className="text-xs text-slate-400 mb-2">Obligatoria</p>
                  <p className="text-sm text-slate-500 leading-snug">
                    Evalúa habilidades de lectura esenciales.
                  </p>
                </div>
              </div>
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
        {/* Features Preview */}
        <section id="features" className="py-24 bg-slate-50">
          <div className="container mx-auto px-6">
            <div className="text-center mb-16 max-w-3xl mx-auto">
              <h2 className="text-3xl font-bold text-slate-900 mb-4">Todo lo que necesitas para tu puntaje</h2>
              <p className="text-slate-600">PAES Lab no es solo un banco de preguntas. Es un entrenador inteligente diseñado para maximizar tu rendimiento en menos tiempo.</p>
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
              {/* Feature 1 */}
              <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 hover:shadow-md transition-all hover:-translate-y-1">
                <div className="w-12 h-12 bg-blue-100 rounded-xl flex items-center justify-center text-blue-600 mb-4">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 10V3L4 14h7v7l9-11h-7z" /></svg>
                </div>
                <h3 className="text-lg font-bold text-slate-900 mb-2">IA Personalizada</h3>
                <p className="text-sm text-slate-600 leading-relaxed">
                  Olvídate del azar. Nuestro algoritmo detecta tus vacíos y te bombardea con ejercicios clave hasta que los domines.
                </p>
              </div>

              {/* Feature 2 */}
              <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 hover:shadow-md transition-all hover:-translate-y-1">
                <div className="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center text-red-600 mb-4">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" /></svg>
                </div>
                <h3 className="text-lg font-bold text-slate-900 mb-2">Vidas y Rachas</h3>
                <p className="text-sm text-slate-600 leading-relaxed">
                  La práctica debe doler (un poco). Tienes 10 vidas diarias. Si fallas, pierdes. Si aciertas, subes en el ranking.
                </p>
              </div>

              {/* Feature 3 */}
              <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 hover:shadow-md transition-all hover:-translate-y-1">
                <div className="w-12 h-12 bg-emerald-100 rounded-xl flex items-center justify-center text-emerald-600 mb-4">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                </div>
                <h3 className="text-lg font-bold text-slate-900 mb-2">Feedback Total</h3>
                <p className="text-sm text-slate-600 leading-relaxed">
                  ¿Te equivocaste? No pasa nada. Accede a explicaciones detalladas y videos paso a paso de inmediato.
                </p>
              </div>

              {/* Feature 4 */}
              <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 hover:shadow-md transition-all hover:-translate-y-1">
                <div className="w-12 h-12 bg-purple-100 rounded-xl flex items-center justify-center text-purple-600 mb-4">
                  <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M16 8v8m-4-5v5m-4-2v2m-2 4h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" /></svg>
                </div>
                <h3 className="text-lg font-bold text-slate-900 mb-2">Ranking Nacional</h3>
                <p className="text-sm text-slate-600 leading-relaxed">
                  Compite con estudiantes de todo Chile. Sube de liga, gana medallas y mide tu preparación real.
                </p>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer className="bg-slate-900 py-12 text-slate-400 text-sm">
        <div className="container mx-auto px-6 text-center">
          <p>© 2027 PAES Lab. Todos los derechos reservados.</p>
        </div>
      </footer>
    </div>
  )
}
