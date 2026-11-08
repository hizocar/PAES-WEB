import Link from "next/link"
import { redirect } from "next/navigation"
import { Clock, Flame, Lightbulb, Trophy } from "lucide-react"
import { createClient } from "@/lib/supabase/server"
import { PricingSection } from "@/components/landing/PricingSection"
import { CountdownProvider, DayCounter, DaysLeftText, StudyPlan, SubjectToggle } from "@/components/landing/countdown"
import { PlayableQuestion, type DemoQuestion } from "@/components/landing/PlayableQuestion"
import { Mascot } from "@/components/mascot/Mascot"
import { DEMRE_CALENDAR_URL } from "@/lib/paes-calendar"
import numeros from "../../content/questions/m1-numeros.json"

// Pregunta real del banco para la demo jugable (bencina en Los Ángeles, porcentaje)
const demo = (numeros as any[]).find((q) => q.key === "m1-numeros-039")!
const DEMO: DemoQuestion = {
  content: demo.content,
  alternatives: demo.alternatives,
  correct: demo.correct,
  explanation: demo.explanation,
  topic: "Porcentaje",
}

const ctaPrimary =
  "inline-flex items-center justify-center rounded-2xl border-b-4 border-blue-800 bg-blue-600 font-black text-white shadow-[0_10px_24px_-10px_rgba(37,99,235,0.7)] transition-[background-color,transform] duration-150 hover:bg-blue-700 active:translate-y-0.5 active:border-b-2 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"

export default async function Home() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()
  if (user) redirect("/app")

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "SoftwareApplication",
    name: "PAES Lab",
    applicationCategory: "EducationalApplication",
    operatingSystem: "Web",
    offers: { "@type": "Offer", price: "0", priceCurrency: "CLP" },
    description: "Preparación para la PAES de Matemática M1 y M2 con preguntas originales, explicaciones paso a paso y ensayos con puntaje PAES.",
  }

  return (
    <CountdownProvider>
      <div className="flex min-h-[100dvh] flex-col bg-white">
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />

        <header className="sticky top-0 z-50 border-b border-slate-100 bg-white/90 backdrop-blur">
          <div className="mx-auto flex h-16 max-w-6xl items-center justify-between px-4 sm:px-6">
            <Link href="/" className="text-xl font-black text-blue-600">PAES Lab</Link>
            <nav className="hidden items-center gap-7 text-sm font-semibold text-slate-600 md:flex" aria-label="Secciones">
              <a href="#como" className="hover:text-slate-900">Cómo funciona</a>
              <a href="#plan" className="hover:text-slate-900">Tu plan</a>
              <a href="#pricing" className="hover:text-slate-900">Planes</a>
            </nav>
            <div className="flex items-center gap-2">
              <Link href="/login" className="rounded-xl px-3 py-2 text-sm font-bold text-slate-700 hover:bg-slate-100">Ingresar</Link>
              <Link href="/register" className={`${ctaPrimary} h-10 px-4 text-sm`}>Empieza gratis</Link>
            </div>
          </div>
        </header>

        <main className="flex-1">
          {/* Primera vista: tus días a la PAES + una pregunta real para jugar */}
          <section className="mx-auto grid max-w-6xl items-center gap-x-12 gap-y-36 px-4 lg:gap-y-24 pb-20 pt-10 sm:px-6 md:pt-16 lg:grid-cols-[1.05fr_1fr] lg:pb-28">
            <div>
              <div className="mb-6 flex items-center gap-3">
                <span className="text-sm font-bold text-slate-600">¿Qué prueba rindes?</span>
                <SubjectToggle />
              </div>
              <DayCounter />
              <h1 className="mt-8 max-w-xl text-3xl font-black leading-[1.1] tracking-tight text-slate-900 text-balance sm:text-4xl">
                Entrena la PAES jugando: 10 preguntas al día y un gato que no te deja rendirte.
              </h1>
              <p className="mt-4 max-w-lg text-lg leading-relaxed text-slate-600">
                Preguntas originales tipo PAES de M1 y M2, explicación paso a paso de cada una y ensayos con puntaje en escala PAES. Gratis para empezar.
              </p>
              <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:items-center">
                <Link href="/register" className={`${ctaPrimary} h-14 px-8 text-lg`}>Empieza gratis</Link>
                <Link href="/login" className="inline-flex h-14 items-center justify-center rounded-2xl px-5 font-bold text-slate-700 hover:bg-slate-100">
                  Ya tengo cuenta
                </Link>
              </div>
              <p className="mt-6 text-sm font-semibold text-slate-500">
                360+ preguntas originales · 16 temas del temario oficial 2027 · Ensayos con puntaje 100–1000
              </p>
            </div>

            <div className="mx-auto w-full max-w-lg lg:mx-0">
              <PlayableQuestion q={DEMO} />
            </div>
          </section>

          {/* Cómo funciona: el ciclo de una pregunta, con piezas reales de la app */}
          <section id="como" className="scroll-mt-20 border-t border-slate-100 bg-white py-20 lg:py-28" aria-labelledby="como-title">
            <div className="mx-auto max-w-6xl px-4 sm:px-6">
              <h2 id="como-title" className="max-w-2xl text-3xl font-black tracking-tight text-slate-900 text-balance md:text-4xl">
                Así se entrena en PAES Lab
              </h2>
              <p className="mt-3 max-w-2xl text-lg text-slate-600">
                Cada pregunta es un ciclo corto: respondes contra el reloj, entiendes el error en el momento y sumas para tu racha.
              </p>

              <ol className="mt-12 grid gap-10 lg:grid-cols-3 lg:gap-8">
                <li>
                  <p className="text-sm font-black text-blue-700">1 · Respondes</p>
                  <p className="mt-1 text-xl font-black text-slate-900">Al ritmo real de la PAES</p>
                  <div className="mt-5 rounded-2xl border-2 border-slate-200 p-4">
                    <div className="flex items-center justify-between text-xs font-bold text-slate-500">
                      <span className="inline-flex items-center gap-1.5"><Clock size={14} aria-hidden /> Tiempo restante</span>
                      <span className="tabular-nums text-slate-900">2:14</span>
                    </div>
                    <div className="mt-2 h-2 overflow-hidden rounded-full bg-slate-100"><div className="h-full w-[89%] rounded-full bg-emerald-500" /></div>
                    <div className="mt-4 space-y-2">
                      {["A", "B", "C"].map((k, i) => (
                        <div key={k} className={`flex items-center gap-3 rounded-xl border-2 px-3 py-2 text-sm font-semibold ${i === 1 ? "border-blue-500 bg-blue-50 text-blue-900" : "border-slate-200 text-slate-500"}`}>
                          <span className={`flex h-6 w-6 items-center justify-center rounded-md text-xs font-black ${i === 1 ? "bg-blue-600 text-white" : "bg-slate-100"}`}>{k}</span>
                          <span className="h-2 flex-1 rounded-full bg-current opacity-20" />
                        </div>
                      ))}
                    </div>
                  </div>
                </li>
                <li>
                  <p className="text-sm font-black text-blue-700">2 · Te explica</p>
                  <p className="mt-1 text-xl font-black text-slate-900">Entiendes por qué, al tiro</p>
                  <div className="mt-5 rounded-2xl border-2 border-red-200 bg-red-50 p-4">
                    <div className="flex items-center gap-3">
                      <Mascot mood="sad" size={56} interactive={false} message={false} />
                      <div>
                        <p className="font-black text-red-800">¡Casi!</p>
                        <p className="text-sm font-medium text-red-700">La correcta era la B.</p>
                      </div>
                    </div>
                    <div className="mt-4 rounded-xl bg-white p-3 text-sm text-slate-700">
                      <p className="inline-flex items-center gap-1.5 font-bold text-slate-900"><Lightbulb size={15} className="text-amber-500" aria-hidden /> Explicación paso a paso</p>
                      <p className="mt-1">Calculaste el aumento sobre el precio final. El porcentaje se mide sobre el precio inicial.</p>
                    </div>
                  </div>
                </li>
                <li>
                  <p className="text-sm font-black text-blue-700">3 · Sumas</p>
                  <p className="mt-1 text-xl font-black text-slate-900">Racha, temas dominados y ranking</p>
                  <div className="mt-5 space-y-3 rounded-2xl border-2 border-slate-200 p-4">
                    <div className="flex items-center justify-between rounded-xl bg-orange-50 px-3 py-2.5">
                      <span className="inline-flex items-center gap-2 text-sm font-black text-orange-700"><Flame size={18} className="fill-orange-500 text-orange-500" aria-hidden /> Racha</span>
                      <span className="text-sm font-black text-orange-800 tabular-nums">7 días</span>
                    </div>
                    <div className="rounded-xl bg-slate-50 px-3 py-2.5">
                      <div className="flex items-center justify-between text-sm font-bold text-slate-700"><span>Porcentaje</span><span className="tabular-nums">80%</span></div>
                      <div className="mt-2 h-2 overflow-hidden rounded-full bg-slate-200"><div className="h-full w-4/5 rounded-full bg-amber-400" /></div>
                    </div>
                    <div className="flex items-center justify-between rounded-xl bg-amber-50 px-3 py-2.5">
                      <span className="inline-flex items-center gap-2 text-sm font-black text-amber-800"><Trophy size={17} className="fill-amber-400 text-amber-500" aria-hidden /> Ranking</span>
                      <span className="text-sm font-black text-amber-900">Sube cada día</span>
                    </div>
                    <p className="text-xs font-medium text-slate-500">Ejemplo ilustrativo de la pantalla de progreso.</p>
                  </div>
                </li>
              </ol>
            </div>
          </section>

          {/* Plan semana a semana hasta la prueba */}
          <section id="plan" className="scroll-mt-20 bg-slate-50 py-20 lg:py-28" aria-labelledby="plan-title">
            <div className="mx-auto max-w-6xl px-4 sm:px-6">
              <StudyPlan />
            </div>
          </section>

          <PricingSection />

          {/* Cierre */}
          <section className="bg-blue-600 py-20 text-white" aria-labelledby="cierre-title">
            <div className="mx-auto flex max-w-6xl flex-col items-center gap-8 px-4 text-center sm:px-6 md:flex-row md:text-left">
              <Mascot mood="celebrate" size={150} message={false} />
              <div className="flex-1">
                <h2 id="cierre-title" className="text-3xl font-black tracking-tight text-balance md:text-5xl">
                  <DaysLeftText />
                </h2>
                <p className="mt-3 text-lg font-medium text-blue-100">Cada pregunta de hoy es un punto más en diciembre.</p>
              </div>
              <Link
                href="/register"
                className="inline-flex h-14 shrink-0 items-center justify-center rounded-2xl border-b-4 border-blue-200 bg-white px-8 text-lg font-black text-blue-700 transition-[background-color,transform] duration-150 hover:bg-blue-50 active:translate-y-0.5 active:border-b-2 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-white"
              >
                Empieza gratis
              </Link>
            </div>
          </section>
        </main>

        <footer className="bg-slate-950 py-10 text-sm text-slate-400">
          <div className="mx-auto flex max-w-6xl flex-col gap-3 px-4 sm:flex-row sm:items-center sm:justify-between sm:px-6">
            <p>© {new Date().getFullYear()} PAES Lab · Preguntas originales, no afiliado al DEMRE.</p>
            <p>
              Fechas según el{" "}
              <a href={DEMRE_CALENDAR_URL} target="_blank" rel="noopener noreferrer" className="underline underline-offset-2 hover:text-white">
                calendario oficial DEMRE
              </a>
            </p>
          </div>
        </footer>
      </div>
    </CountdownProvider>
  )
}
