'use server'

import OpenAI from 'openai'

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
})

export async function processQuestionImage(formData: FormData) {
    const file = formData.get('image') as File

    if (!file) throw new Error('No image provided')
    if (!process.env.OPENAI_API_KEY) throw new Error('OpenAI API Key not configured')

    const buffer = await file.arrayBuffer()
    const base64Image = Buffer.from(buffer).toString('base64')
    const dataUrl = `data:${file.type};base64,${base64Image}`

    try {
        const completion = await openai.chat.completions.create({
            model: "gpt-4o",
            messages: [
                {
                    role: "system",
                    content: `You are an expert OCR assistant for academic questions.
                    
                    CRITICAL: Output valid JSON.
                    **IMPORTANT escaping rule**: Since the output is JSON, you MUST double-escape all backslashes in LaTeX.
                    - CORRECT: "$\\displaystyle \\\\frac{1}{2}x$" or "$\\displaystyle \\\\times$"
                    - INCORRECT: "$\\frac{1}{2}x$" or "$\\times$" (This will become invalid JSON or lose the backslash)
                    
                    Structure:
                    {
                        "content": "The FULL text of the question. Use LaTeX for math ($...$).",
                        "alternatives": [
                            {"id": "A", "content": "Text for A"},
                            {"id": "B", "content": "Text for B"},
                            {"id": "C", "content": "Text for C"},
                            {"id": "D", "content": "Text for D"}
                        ]
                    }
                    
                    Rules:
                    1. **TRANSCRIBE EVERYTHING**: Start from the very top. Include context/intro text.
                    2. **Math Formatting**: 
                       - Use '$' for inline math.
                       - **ALWAYS** start every math expression with '\\displaystyle'.
                       - **DOUBLE ESCAPE** all LaTeX commands (e.g., \\\\times, \\\\frac, \\\\approx).
                       - Use '\\\\' for line breaks in matrices (escaped as \\\\\\\\ in JSON string).
                    3. **No Solving**: Just transcribe.
                    4. **Alternatives**: Extract options exactly.
                    5. **Text Formatting**: 
                       - Don't use \n\n for line breaks, just use a line break.
                    `
                },
                {
                    role: "user",
                    content: [
                        { type: "text", text: "Transcribe the full content of this question image." },
                        { type: "image_url", image_url: { "url": dataUrl } },
                    ],
                },
            ],
            response_format: { type: "json_object" },
        })

        const content = completion.choices[0].message.content
        if (!content) throw new Error("No content returned")

        return JSON.parse(content)

    } catch (error: any) {
        console.error("Error processing image:", error)
        throw new Error("Failed to process image: " + error.message)
    }
}

export async function generateQuestionSolution(question: string, alternatives: any[]) {
    if (!process.env.OPENAI_API_KEY) throw new Error('OpenAI API Key not configured')

    try {
        const completion = await openai.chat.completions.create({
            model: "o3-mini",
            messages: [
                {
                    role: "system",
                    content: `You are a highly intelligent math tutor assistant specialized in the Chilean PAES exam.
                    
                    CRITICAL: Output valid JSON.
                    
                    **Structure**:
                    {
                        "correct_answer": "Letter A, B, C, D or E",
                        "explanation": "The full formatted solution string here.",
                        "difficulty": "easy, medium, or hard",
                        "topic": "Specific math topic"
                    }

                    **CONTENT GENERATION RULES (For the "explanation" field)**:
                    Resuelve el ejercicio paso a paso con enfoque PAES.
                    
                    **REGLAS DE FORMATO ESTRICTAS (CRÍTICO):**
                    1. **ECUACIONES**:
                       - USA SOLO $$$...$$$ para ecuaciones largas o importantes.
                       - USA SOLO $...$ para ecuaciones en línea.
                       - **PROHIBIDO** usar \\( ... \\) o \\[ ... \\].
                       - **SIEMPRE** inicia las ecuaciones con \\displaystyle dentro de los signos pesos.
                       - Ejemplo CORRECTO: "$\\displaystyle 2x + 1 = 0$"
                       - Ejemplo INCORRECTO: "\\( 2x + 1 = 0 \\)" 
                    
                    2. **TEXTO EN NEGRITA (TEXTBF)**:
                       - Si quieres poner algo en negrita que contiene matemáticas, ENCIERRA TODO EL COMANDO EN SIGNOS PESOS.
                       - **NUNCA** pongas el signo peso *dentro* del comando \\textbf.
                       - Ejemplo CORRECTO: "$\\displaystyle \\textbf{Paso 1: Calcular}$"
                       - Ejemplo INCORRECTO: "\\displaystyle \\textbf{$Paso 1: Calcular$}"
                       - Ejemplo INCORRECTO: "Texto normal \\textbf{$negrita con math$}" -> DEBE SER "$\\displaystyle \\textbf{negrita con math}$"
                    
                    3. **ESTRUCTURA**:
                       - Mantén un orden claro: Datos, Procedimiento, Justificación, Conclusión.
                       - La alternativa final debe ir así: "$\\boxed{\\textbf{A}}$"

                    **IMPORTANT ESCAPING RULE**:
                    Since the output is JSON, you MUST double-escape all backslashes in LaTeX strings.
                    - CORRECT: "$\\displaystyle \\\\frac{1}{2}x$"
                    - INCORRECT: "$\\frac{1}{2}x$" or "$\\times$"
                    `
                },
                {
                    role: "user",
                    content: `Question: ${question}\n\nAlternatives:\n${alternatives.map(a => `${a.id}) ${a.content}`).join('\n')}`
                }
            ],
            response_format: { type: "json_object" },
        })

        const content = completion.choices[0].message.content
        if (!content) throw new Error("No content returned")

        return JSON.parse(content)

    } catch (error: any) {
        console.error("Error generating solution:", error)
        throw new Error("Failed to generate solution: " + error.message)
    }
}

export async function categorizeQuestion(question: string, ejes: any[], topics: any[], subject: string = 'm2') {
    if (!process.env.OPENAI_API_KEY) throw new Error('OpenAI API Key not configured')

    try {
        const completion = await openai.chat.completions.create({
            model: "o3-mini",
            messages: [
                {
                    role: "system",
                    content: `You are an expert in the Chilean PAES mathematics exams (M1 and M2). 
                    Your task is to categorize a math question based on the content provided.
                    
                    CURRENT CONTEXT: This question is for the ${subject.toUpperCase()} exam.
                    
                    CRITICAL: Output valid JSON.
                    
                    Categorization Criteria:
                    1. **Eje Temático**: Must match one of the provided Ejes names.
                    2. **Tema Específico**: Must match one of the provided Topics names that belong to the chosen Eje.
                    3. **Dificultad**: easy (Principiante), medium (Intermedio), or hard (Avanzado).
                    4. **Habilidad**: resolver_problemas, modelar, representar, or argumentar.

                    Skill Definitions:
                    - **resolver_problemas**: Solucionar situaciones rutinarias o no rutinarias, aplicar cálculos, evaluar resultados.
                    - **modelar**: Usar, entender y comparar expresiones matemáticas que describen situaciones reales, ajustar modelos.
                    - **representar**: Transferir información entre representaciones (tablas, gráficos, símbolos), traducir lenguaje natural a matemático.
                    - **argumentar**: Justificar procedimientos, pasos deductivos, detectar errores, evaluar validez de afirmaciones.

                    Curriculum Context (M1 vs M2):
                    - **M1 (Competencia Matemática 1)**: Focusing on basic operations, percentages, linear equations, basic geometry, and descriptive statistics.
                    - **M2 (Competencia Matemática 2)**: Higher complexity. Includes everything in M1 PLUS:
                        - **Números**: Real numbers, Financial Math (AFP, credits), Logarithms.
                        - **Álgebra**: Advanced systems (inf. solutions), Power/Log/Exponential functions, Trigonometric functions.
                        - **Geometría**: Homothety, Trig in right triangles (sin, cos, tan), Metric relations in circles.
                        - **Probabilidad**: Dispersion measures, Conditional probability, Combinatorics (permutatory), Binomial/Normal distributions.

                    Eje-Specific Context:
                    - **Números**: Conjuntos numéricos, porcentajes, potencias, raíces, logaritmos, matemática financiera.
                    - **Álgebra y Funciones**: Algebra, proportionality, equations, functions (linear, affine, quadratic, power, log, exponential, trig).
                    - **Geometría**: Figures (Pythagoras, area), Solids (volume), Transformations, Homothety, Trigonometry, Circle relations.
                    - **Probabilidad y Estadística**: Data (tables/graphs), Position measures, Dispersion, Combinatorics, Probability rules, Conditional, Binomial/Normal.

                    Available Ejes and Topics for ${subject.toUpperCase()} (ID and Name):
                    ${ejes.map(e => `Eje: ${e.name} (UUID: ${e.id})`).join('\n')}
                    ${topics.map(t => `Topic: ${t.name} (UUID: ${t.id}, Eje UUID: ${t.eje_id})`).join('\n')}

                    Structure:
                    {
                        "eje_id": "UUID of the matching Eje",
                        "topic_id": "UUID of the matching Topic",
                        "difficulty": "easy | medium | hard",
                        "habilidad": "resolver_problemas | modelar | representar | argumentar"
                    }
                    `
                },
                {
                    role: "user",
                    content: `Categorize this question:\n\n${question}`
                }
            ],
            response_format: { type: "json_object" },
        })

        const content = completion.choices[0].message.content
        if (!content) throw new Error("No content returned")

        return JSON.parse(content)

    } catch (error: any) {
        console.error("Error categorizing question:", error)
        throw new Error("Failed to categorize question: " + error.message)
    }
}
