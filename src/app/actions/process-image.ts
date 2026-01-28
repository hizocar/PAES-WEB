'use server'

import OpenAI from 'openai'

const openai = new OpenAI({
    apiKey: process.env.OPENAI_API_KEY,
})

export async function processQuestionImage(formData: FormData) {
    const file = formData.get('image') as File

    if (!file) {
        throw new Error('No image provided')
    }

    if (!process.env.OPENAI_API_KEY) {
        throw new Error('OpenAI API Key not configured')
    }

    // Convert file to base64
    const buffer = await file.arrayBuffer()
    const base64Image = Buffer.from(buffer).toString('base64')
    const dataUrl = `data:${file.type};base64,${base64Image}`

    try {
        const completion = await openai.chat.completions.create({
            model: "gpt-4o-mini",
            messages: [
                {
                    role: "system",
                    content: `You are an assistant that extracts multiple-choice questions from images. 
                    Output valid JSON only. No markdown formatting.
                    
                    Structure:
                    {
                        "content": "The main question text. Use LaTeX for math equations (e.g. $x^2$).",
                        "alternatives": [
                            {"id": "A", "content": "Text for A"},
                            {"id": "B", "content": "Text for B"},
                            {"id": "C", "content": "Text for C"},
                            {"id": "D", "content": "Text for D"}
                        ],
                        "correct_answer": "The letter (A, B, C or D) of the correct option. If not marked in image, solve the problem and determine which option is correct.",
                        "difficulty": "easy, medium, or hard (guess based on content)",
                        "topic": "Short topic suggestion based on content (e.g. 'Probabilidades', 'Algebra')",
                        "explanation": "A concise step-by-step solution. Use LaTeX for math ($...$)."
                    }
                    
                    Rules:
                    1. Transcribe text exactly. 
                    2. Determine if it is a Math question, use LaTeX for all mathematical expressions.
                    3. IMPORTANT: YOU MUST WRAP ALL LATEX EXPRESSIONS IN '$' (for inline) OR '$$' (for block). 
                       Example: "Calculate $x^2$" NOT "Calculate x^2" or "Calculate \frac{1}{2}".
                       NEVER output bare LaTeX commands like \frac, \text, \sqrt without wrapping them in $.
                    4. Do not include 'Alternative A' prefix in the alternative content, just the content itself.
                    5. Solve the problem in the 'explanation' field. Be concise but clear.
                    `
                },
                {
                    role: "user",
                    content: [
                        { type: "text", text: "Extract the question from this image." },
                        {
                            type: "image_url",
                            image_url: {
                                "url": dataUrl,
                            },
                        },
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
