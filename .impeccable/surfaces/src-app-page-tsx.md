---
version: 1
slug: "src-app-page-tsx"
primary_target: "src/app/page.tsx"
related_targets: []
---

# Portada pública (src/app/page.tsx)

Modo: Persuade. Visitante: estudiante chileno de 4° medio o egresado que rinde la PAES Regular (M1 y/o M2) y llega desde el celular. Acción: crear cuenta gratis ("Empieza gratis"). Prueba: una pregunta PAES real del banco, jugable en la portada, con el gato reaccionando. Restricciones: identidad establecida (blanco y slate, azul #2563eb, Inter, botones 3D, gato SVG), cifras solo verificables y fechas desde src/lib/paes-calendar.ts.

## Direction contract

THESIS: La portada es una cuenta regresiva a TU PAES, no un folleto. Rechaza el hero centrado con titular, subtítulo, botón y fila de tarjetas.

OWN-WORLD: Fondo blanco con regiones slate-50. Azul #2563eb comprometido en las fichas de dígitos y en la banda final. Inter black para titulares y numerales tabulares. Fichas de dígito con profundidad física (inspiración: tubo nixie). Botón 3D con borde inferior y gato naranjo SVG como personaje.

STORY: El visitante ve cuántos días le quedan para su prueba (elige M1 o M2) y responde una pregunta real: el gato le reacciona y le explica. Ve su plan semana a semana hasta la PAES y crea su cuenta.

FIRST VIEWPORT: A la izquierda, las fichas de días (enormes, alrededor del 40% del alto), el selector M1/M2 y el gancho de una línea con "Empieza gratis". A la derecha, la tarjeta de pregunta jugable con el gato sobre su esquina. En celular se apila: días, acción y pregunta.

FORM: Cuenta regresiva y plan; posición 3 de 7 en mi lista (dealt lead). Firma: odómetro de días, pregunta jugable con reacción del gato y línea del plan que se dibuja con el scroll. Raise (de signals-instruments-nixie-laboratory-counter): los dígitos son objetos con profundidad y cada cambio es un evento físico, no texto plano. seed: none (unavailable)

FINISH: unreviewed and undocumented is unfinished; this build ends with the finish review, the verdict, DESIGN.md, and every shipping raster carrying its provenance
