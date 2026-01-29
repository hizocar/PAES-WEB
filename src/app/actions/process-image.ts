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
            model: "gpt-4o",
            messages: [
                {
                    role: "system",
                    content: `You are a highly intelligent math tutor assistant. Solve the multiple-choice question step-by-step.
                    
                    CRITICAL: Output valid JSON.
                    **IMPORTANT escaping rule**: Since the output is JSON, you MUST double-escape all backslashes in LaTeX.
                    - CORRECT: "$\\displaystyle \\\\frac{1}{2}x$"
                    - INCORRECT: "$\\frac{1}{2}x$" or "$\\times$"
                    
                    Structure:
                    {
                        "correct_answer": "Letter A, B, C, D or E",
                        "explanation": "Step-by-step solution in LaTeX ($...$). Be extremely clear.",
                        "difficulty": "easy, medium, or hard",
                        "topic": "Specific math topic (e.g. 'Probabilidades', 'Álgebra')"
                    }
                    
                    Rules:
                    1. **Math Formatting (CRITICAL)**: 
                       - Use '$' for inline math.
                       - **ALWAYS** start every math expression with '\\displaystyle'.
                       - **DOUBLE ESCAPE** all LaTeX commands (e.g. \\\\times, \\\\cdot, \\\\frac).
                    2. **Logic**: Verify your answer before outputting.
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
