# Product

<!-- impeccable:product-schema 1 -->

## Platform

web (Next.js App Router, desplegado en Vercel; uso principal en celular y notebook)

## Users

Estudiantes chilenos de 4° medio y egresados que preparan la PAES de Matemática para el Proceso de
Admisión 2027. Estudian solos, en sesiones cortas (en el celular, en recreos o en la noche) y con
poca constancia. Su trabajo es subir el puntaje en M1 (obligatoria para todos) y M2 (electiva,
requerida en carreras científicas y de ingeniería).

Audiencia secundaria: el administrador o dueño del contenido, que usa el panel `/admin` para
gestionar preguntas, alumnos y métricas.

## Product Purpose

Práctica diaria de preguntas tipo PAES M1 y M2 con corrección inmediata, explicación paso a paso,
ensayos con puntaje en escala PAES (100–1000) y seguimiento del progreso por eje y habilidad.
Hay éxito cuando el alumno vuelve todos los días y su acierto mejora en los tópicos donde estaba
más débil.

## Positioning

"La plataforma más adictiva para preparar la PAES": el estudio se siente como un juego, con vidas,
rachas, ranking, logros y una mascota, al estilo Duolingo. La gamificación es la propuesta central
(confirmado por el dueño, 2026-11-07). Por debajo hay rigor real:
- un banco de preguntas originales calibrado con el temario oficial DEMRE 2027 y con la proporción
  real de ejes y tópicos de las pruebas oficiales;
- analítica por respuesta (tiempo, intento, sesión) para recomendaciones y modelos futuros.

M1 y M2 tienen el mismo peso en el producto (confirmado por el dueño).

## Capabilities

- Práctica por materia (M1/M2) con selección inteligente de preguntas y modo repaso de errores.
- Vidas que se recargan con el tiempo, rachas, ranking, logros y onboarding guiado.
- Explicaciones (texto y video opcional) con créditos para el plan gratis.
- Ensayo M1 de 60 preguntas con la proporción oficial de ejes y puntaje PAES.
- Progreso por eje y habilidad; historial de puntajes.
- Plan gratis y planes de pago con MercadoPago (la monetización está pausada por decisión del dueño, 2026-11-08).
- Panel admin: preguntas, alumnos, analítica.

## Constraints

- Contenido 100% original. El material DEMRE solo se usa como referencia interna, nunca se
  reproduce (sus términos prohíben el uso comercial).
- La información de fechas PAES debe salir del calendario oficial DEMRE vigente
  (`src/lib/paes-calendar.ts`) y no quedar escrita en los componentes.
- Idioma: español de Chile, tuteo, cercano y motivador.
- Fórmulas con KaTeX, a través de `src/components/ui/latex-renderer.tsx`.

## Voice

Cercano, energético y motivador, como un compañero que te empuja a seguir ("¡Sube de nivel!",
"¡Empieza tu aventura!"). Usa emoji con moderación. Las fechas y los datos oficiales se dicen sin
exageración.
