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
        <section className="relative overflow-hidden pt-12 pb-20 md:pt-20 md:pb-32">
          {/* Animated Background Gradients - Reduced on mobile for performance/overflow */}
          <div className="absolute top-0 left-1/2 -translate-x-1/2 w-[600px] h-[400px] md:w-[1000px] md:h-[600px] bg-gradient-to-tr from-blue-200/40 via-purple-200/40 to-pink-200/40 rounded-full blur-3xl opacity-50 md:opacity-70 pointer-events-none animate-pulse-slow" />
          <div className="hidden md:block absolute bottom-0 right-1/4 w-[800px] h-[500px] bg-gradient-to-bl from-emerald-100/40 to-cyan-100/40 rounded-full blur-3xl opacity-50 pointer-events-none" />

          <div className="container mx-auto px-6 relative z-10 text-center max-w-5xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-blue-50/80 backdrop-blur-sm text-blue-700 text-xs md:text-sm font-bold mb-6 md:mb-8 border border-blue-100 shadow-sm hover:scale-105 transition-transform cursor-default">
              <span className="relative flex h-2 w-2">
                <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-blue-400 opacity-75"></span>
                <span className="relative inline-flex rounded-full h-2 w-2 bg-blue-500"></span>
              </span>
              Nueva admisión 2027
            </div>

            <h1 className="text-4xl md:text-7xl font-extrabold tracking-tight text-slate-900 mb-6 md:mb-8 leading-[1.1]">
              Domina la PAES con <span className="text-transparent bg-clip-text bg-gradient-to-r from-blue-600 via-indigo-600 to-violet-600 block md:inline">Inteligencia y Diversión</span> 🚀
            </h1>

            <p className="text-lg md:text-xl text-slate-600 mb-8 md:mb-10 max-w-2xl mx-auto leading-relaxed px-4 md:px-0">
              La plataforma más adictiva para preparar la <span className="font-bold text-slate-900">PAES M1 y M2</span>. Sube de nivel, gana rachas y asegura tu puntaje soñado.
            </p>

            <div className="flex flex-col items-center justify-center gap-6 md:gap-8">
              <Link href="/login" className="w-full md:w-auto">
                <Button size="lg" className="h-14 md:h-16 w-full md:w-auto px-8 md:px-12 text-lg md:text-xl rounded-2xl shadow-xl shadow-blue-600/30 hover:scale-105 hover:shadow-2xl transition-all duration-300 font-bold bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 border-b-4 border-blue-800 active:border-b-0 active:translate-y-1">
                  ¡Empieza tu Aventura! 🎮
                </Button>
              </Link>
              <p className="text-sm text-slate-500 font-medium animate-bounce">
                👆 ¡Es gratis comenzar!
              </p>

              {/* Exam Status Cards */}
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 md:gap-6 w-full text-left mt-8 md:mt-12">
                {/* M2 Card - Active */}
                <Link href="/login" className="bg-white/80 backdrop-blur-md p-5 md:p-6 rounded-2xl border-2 border-blue-100 shadow-lg hover:shadow-xl transition-all hover:border-blue-500 hover:-translate-y-1 group relative overflow-hidden block cursor-pointer">
                  <div className="absolute inset-0 bg-gradient-to-br from-blue-50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                  <div className="absolute top-0 right-0 bg-blue-500 text-white text-[10px] uppercase font-bold px-3 py-1 rounded-bl-xl shadow-sm z-10">
                    Disponible
                  </div>
                  <div className="relative z-10">
                    <div className="flex items-center gap-3 mb-3">
                      <div className="w-10 h-10 rounded-xl bg-blue-100 flex items-center justify-center text-blue-600 font-black text-lg shadow-sm group-hover:scale-110 transition-transform">M2</div>
                      <h3 className="font-bold text-slate-900 text-lg">Matemática 2</h3>
                    </div>
                    <p className="text-xs font-semibold text-blue-600 uppercase tracking-wide mb-2">Electiva / Requisito</p>
                    <p className="text-sm text-slate-600 leading-snug">
                      Desafíos de alta complejidad para ingenierías y ciencias.
                    </p>
                  </div>
                </Link>

                {/* M1 Card - Now Active! */}
                <Link href="/login" className="bg-white/80 backdrop-blur-md p-5 md:p-6 rounded-2xl border-2 border-indigo-100 shadow-lg hover:shadow-xl transition-all hover:border-indigo-500 hover:-translate-y-1 group relative overflow-hidden block cursor-pointer">
                  <div className="absolute inset-0 bg-gradient-to-br from-indigo-50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity" />
                  <div className="absolute top-0 right-0 bg-indigo-500 text-white text-[10px] uppercase font-bold px-3 py-1 rounded-bl-xl shadow-sm z-10">
                    Disponible
                  </div>
                  <div className="relative z-10">
                    <div className="flex items-center gap-3 mb-3">
                      <div className="w-10 h-10 rounded-xl bg-indigo-100 flex items-center justify-center text-indigo-600 font-black text-lg shadow-sm group-hover:scale-110 transition-transform">M1</div>
                      <h3 className="font-bold text-slate-900 text-lg">Matemática 1</h3>
                    </div>
                    <p className="text-xs font-semibold text-indigo-600 uppercase tracking-wide mb-2">Obligatoria</p>
                    <p className="text-sm text-slate-600 leading-snug">
                      Domina los fundamentos esenciales para tu puntaje base.
                    </p>
                  </div>
                </Link>

                {/* Lectora Card - Coming Soon */}
                <div className="bg-slate-50/50 p-5 md:p-6 rounded-2xl border border-slate-200 relative overflow-hidden hover:bg-slate-50 transition-colors cursor-default">
                  <div className="absolute top-0 right-0 bg-slate-200 text-slate-500 text-[10px] uppercase font-bold px-3 py-1 rounded-bl-xl">
                    Pronto
                  </div>
                  <div className="opacity-60">
                    <div className="flex items-center gap-3 mb-3">
                      <div className="w-10 h-10 rounded-xl bg-slate-200 flex items-center justify-center text-slate-500 font-black text-lg">CL</div>
                      <h3 className="font-bold text-slate-700 text-lg">Comp. Lectora</h3>
                    </div>
                    <p className="text-xs font-bold text-slate-400 uppercase tracking-wide mb-2">Obligatoria</p>
                    <p className="text-sm text-slate-500 leading-snug">
                      Potencia tu velocidad y comprensión de textos.
                    </p>
                  </div>
                </div>
              </div>
            </div>

            {/* Stats */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-8 mt-12 md:mt-24 pt-8 md:pt-12 border-t border-slate-200/60 relative">
              <div className="hover:-translate-y-1 transition-transform cursor-default">
                <div className="text-3xl md:text-4xl font-black text-transparent bg-clip-text bg-gradient-to-br from-blue-600 to-indigo-600 mb-1">15k+</div>
                <div className="text-xs md:text-sm text-slate-600 font-bold uppercase tracking-wider">Estudiantes</div>
              </div>
              <div className="hover:-translate-y-1 transition-transform cursor-default">
                <div className="text-3xl md:text-4xl font-black text-transparent bg-clip-text bg-gradient-to-br from-purple-600 to-pink-600 mb-1">2.5M</div>
                <div className="text-xs md:text-sm text-slate-600 font-bold uppercase tracking-wider">Ejercicios</div>
              </div>
              <div className="hover:-translate-y-1 transition-transform cursor-default">
                <div className="text-3xl md:text-4xl font-black text-transparent bg-clip-text bg-gradient-to-br from-emerald-600 to-teal-600 mb-1">850+</div>
                <div className="text-xs md:text-sm text-slate-600 font-bold uppercase tracking-wider">Puntaje Prom.</div>
              </div>
              <div className="hover:-translate-y-1 transition-transform cursor-default">
                <div className="text-3xl md:text-4xl font-black text-slate-800 mb-1 flex items-center justify-center gap-2">
                  <span>∞</span>
                </div>
                <div className="text-xs md:text-sm text-slate-600 font-bold uppercase tracking-wider">Vidas Recargables</div>
              </div>
            </div>
          </div>
        </section>

        {/* Features Preview */}
        {/* Features Preview */}
        <section id="features" className="py-12 md:py-24 bg-slate-50">
          <div className="container mx-auto px-6">
            <div className="text-center mb-10 md:mb-16 max-w-3xl mx-auto">
              <h2 className="text-2xl md:text-3xl font-bold text-slate-900 mb-4">Todo lo que necesitas para tu puntaje</h2>
              <p className="text-sm md:text-base text-slate-600">PAES Lab no es solo un banco de preguntas. Es un entrenador inteligente diseñado para maximizar tu rendimiento en menos tiempo.</p>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 md:gap-8">
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
