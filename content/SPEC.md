# Especificación del banco de preguntas PAES-WEB

Todas las preguntas son **originales**. El material DEMRE (cuadernillos y temarios) se usa solo
como referencia de tipología, estilo y nivel. **Prohibido** copiar, parafrasear de cerca o
reutilizar enunciados, datos numéricos, contextos específicos o alternativas de una pregunta DEMRE.

## Archivo y formato

Un archivo JSON por (prueba, eje): `content/questions/<subject>-<eje>.json`, con un arreglo de preguntas:

```json
{
  "key": "m1-numeros-001",
  "subject": "m1",
  "eje": "numeros",
  "topic": "porcentaje",
  "habilidad": "modelar",
  "difficulty": "medium",
  "format": "standard",
  "content": "Texto del enunciado con $LaTeX$ inline.",
  "alternatives": { "A": "...", "B": "...", "C": "...", "D": "..." },
  "correct": "C",
  "explanation": "Resolución paso a paso.",
  "verify": "const total = 480 * 0.15; return total === 72 ? 'D' : null;"
}
```

- `key`: único y estable, `<subject>-<eje>-NNN`. No se reutiliza nunca.
- `topic`: slug de `content/taxonomy.json` para ese subject y eje.
- `habilidad`: `resolver_problemas` | `modelar` | `representar` | `argumentar`.
- `difficulty`: `easy` | `medium` | `hard`.
- `format`:
  - `standard`: exactamente 4 alternativas A–D (M1 y M2).
  - `suficiencia` (solo M2): alternativas A–E con el texto fijo de abajo; el enunciado
    termina con las afirmaciones `(1)` y `(2)`.
- La app agrega sola la opción "No sé responder esta pregunta" (E en standard, F en suficiencia).
  **No la escribas.**

Alternativas fijas de suficiencia:
- A: `(1) por sí sola`
- B: `(2) por sí sola`
- C: `Ambas juntas, (1) y (2)`
- D: `Cada una por sí sola, (1) ó (2)`
- E: `Se requiere información adicional`

## `verify` (obligatorio)

Cuerpo de una función JavaScript, sin argumentos, que **recalcula** la respuesta desde los datos
del enunciado y devuelve la letra correcta (o `null` si algo no cuadra). El validador exige que
devuelva exactamente `correct`.

- Debe calcular, no solo devolver una letra: `return 'C'` a secas se rechaza.
- Para preguntas de argumentar o de identificar errores, verifica los hechos numéricos
  (qué paso da un valor incorrecto, qué afirmación es falsa, etc.).
- En suficiencia, verifica numéricamente qué combinación de afirmaciones determina la
  incógnita (por ejemplo, probando valores que satisfacen cada afirmación).
- Usa una tolerancia (`Math.abs(a-b) < 1e-9`) al comparar decimales.

## Reglas de renderizado (la app usa un renderizador propio sobre KaTeX)

- Matemática **solo** entre `$...$`. No uses `$$`, `\(` ni `\[`.
- Para fórmulas grandes (fracciones apiladas, tablas): `$\displaystyle ...$`.
- **Nunca** escribas un signo `$` literal para dinero. Usa "pesos": `$12\,500$ pesos`.
- Separador de miles: `\,` dentro de LaTeX (`$12\,500$`). Decimales con coma: `$3{,}5$`.
- No hay Markdown: nada de `**negrita**`, listas `-` ni tablas `|`. Saltos de línea con `\n`.
- Tablas: `$\displaystyle \begin{array}{|c|c|}\hline \text{Mes} & \text{Ventas} \\ \hline \text{Enero} & 120 \\ \hline \end{array}$`
- No hay imágenes. No escribas "en la figura adjunta". Describe todo en texto o en LaTeX
  (coordenadas, medidas, el resumen de cinco números de un diagrama de cajón, etc.).
- En JSON, cada backslash va doble: `"$\\frac{1}{2}$"`.

## Estilo PAES (calibrado con las pruebas oficiales)

- La mayoría de las preguntas **contextualizadas** (compras, deporte, viajes, ciencia, finanzas
  personales, encuestas, etc.) con contexto chileno y nombres diversos. El resto, matemática pura.
- Por habilidad:
  - `resolver_problemas`: cálculo directo o problema con estrategia.
  - `modelar`: se da una fórmula o modelo y se aplica; o se elige la expresión o función que modela la situación;
    o se interpreta un parámetro.
  - `representar`: traducir lenguaje natural a una expresión, leer una tabla, pasar de un registro a otro.
  - `argumentar`: "¿En cuál paso se cometió el error?", "¿cuál afirmación es siempre verdadera?",
    "¿cuál conclusión se puede deducir?".
- Distractores plausibles: cada alternativa incorrecta corresponde a un error típico (signo,
  porcentaje mal aplicado, confundir área con perímetro, etc.). Menciónalos en la explicación.
- Alternativas ordenadas (numéricas de menor a mayor) y homogéneas en formato.
- Distribuye `correct` de forma pareja entre A, B, C y D.
- Dificultad aproximada por eje: 30% `easy`, 45% `medium`, 25% `hard`.
- `explanation`: entre 3 y 8 líneas, con la resolución y por qué los distractores son incorrectos.
