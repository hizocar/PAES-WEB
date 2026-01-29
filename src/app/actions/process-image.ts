'use server'

import OpenAI from 'openai'

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
})

// ... imports ...

export async function processQuestionImage(formData: FormData) {
    const file = formData.get('image') as File

    if (!file) throw new Error('No image provided')
    if (!process.env.OPENAI_API_KEY) throw new Error('OpenAI API Key not configured')

    const buffer = await file.arrayBuffer()
    const base64Image = Buffer.from(buffer).toString('base64')
    const dataUrl = `data:${file.type};base64,${base64Image}`

    try {
        const completion = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages: [
                {
                    role: "system",
                    content: `You are an expert OCR assistant for academic questions.
                    Output valid JSON only. No markdown formatting.
                    
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
                    1. **TRANSCRIBE EVERYTHING**: Start from the very top of the image. Identify if there is introductory text, context, or a problem description BEFORE the actual question. Do NOT skip paragraphs.
                    2. **Preserve Context**: If the image contains a chart description or reading passage, include it in "content".
                    3. **Math Formatting**: Use LaTeX for ALL math expressions wrapped in '$' (e.g. $x^2 + 5$).
                    4. **No Solving**: Do NOT attempt to solve the question. Just transcribe.
                    5. **Alternatives**: Extract the options options text exactly.
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
            model: "gpt-4o-mini",
            messages: [
                {
                    role: "system",
                    content: `You are a math tutor assistant. Solve the provided multiple-choice question.
                    Output valid JSON only.
                    
                    Structure:
                    {
                        "correct_answer": "Letter A, B, C, D or E",
                        "explanation": "Step-by-step solution in LaTeX ($...$). Be clear and educational.",
                        "difficulty": "easy, medium, or hard",
                        "topic": "Short topic name (e.g. 'Álgebra', 'Geometría')"
                    }
                    
                    Rules:
                    1. Use valid LaTeX for math inside '$'.
                    2. Explain the logic clearly.
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
