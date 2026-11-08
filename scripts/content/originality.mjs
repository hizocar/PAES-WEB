#!/usr/bin/env node
// Chequeo de originalidad: compara cada pregunta del banco contra el texto de las pruebas
// oficiales (referencia interna, fuera del repo) y marca coincidencias literales de frases.
//
//   node scripts/content/originality.mjs [--dir content/questions] [--ref ~/Proyectos/PAES-WEB-facsimiles/_texto]
//
// Criterio: n-gramas de 6 palabras normalizadas (sin LaTeX, sin tildes, sin puntuación).
// Se ignoran las frases de formato: las que aparecen en 3 o más pruebas oficiales distintas
// ("¿cuál es la probabilidad de que...") y las alternativas fijas de suficiencia de datos.
// Una pregunta se marca si comparte >= 3 n-gramas específicos con un mismo documento
// (unas 8 palabras seguidas o más), o si el 20% o más de su texto está en el corpus.

import fs from 'node:fs'
import path from 'node:path'
import os from 'node:os'

const arg = (name, def) => {
  const i = process.argv.indexOf(name)
  return i > -1 ? process.argv[i + 1] : def
}
const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), '../..')
const QDIR = path.resolve(arg('--dir', path.join(ROOT, 'content/questions')))
const REF = path.resolve(arg('--ref', path.join(os.homedir(), 'Proyectos/PAES-WEB-facsimiles/_texto')).replace(/^~/, os.homedir()))
const N = 6
const REVIEWED_FILE = path.join(ROOT, 'content/originality-reviewed.json')
const REVIEWED = fs.existsSync(REVIEWED_FILE) ? JSON.parse(fs.readFileSync(REVIEWED_FILE, 'utf8')) : {}

// Frases de formato que aparecen en cualquier pregunta tipo PAES y no indican copia.
const GENERIC = [
  'cual de las siguientes afirmaciones es',
  'de las siguientes afirmaciones es verdadera',
  'cual de las siguientes expresiones representa',
  'en cual de los pasos se cometio el error',
  'por si sola si la afirmacion',
  'se requiere informacion adicional',
  'cada una por si sola',
  'ambas juntas 1 y 2',
  'se puede determinar',
]

function normalize(text) {
  return text
    .replace(/\$[^$]*\$/g, ' ')
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9ñ ]+/g, ' ')
    .replace(/\s+/g, ' ')
    .trim()
}

function shingles(text) {
  const words = normalize(text).split(' ').filter(Boolean)
  const out = new Set()
  for (let i = 0; i + N <= words.length; i++) {
    const g = words.slice(i, i + N).join(' ')
    if (!GENERIC.some((p) => g.includes(p) || p.includes(g))) out.add(g)
  }
  return out
}

if (!fs.existsSync(REF)) {
  console.error(`No existe el corpus de referencia: ${REF}`)
  process.exit(2)
}

// Índice n-grama -> documentos
const index = new Map()
for (const f of fs.readdirSync(REF).filter((f) => f.endsWith('.txt'))) {
  for (const g of shingles(fs.readFileSync(path.join(REF, f), 'utf8'))) {
    if (!index.has(g)) index.set(g, new Set())
    index.get(g).add(f)
  }
}

const flagged = []
let total = 0
for (const f of fs.readdirSync(QDIR).filter((f) => f.endsWith('.json')).sort()) {
  for (const q of JSON.parse(fs.readFileSync(path.join(QDIR, f), 'utf8'))) {
    total++
    const alts = q.format === 'suficiencia' ? [] : Object.values(q.alternatives)
    const text = [q.content, ...alts].join(' \n ')
    const grams = shingles(text)
    const hitsByDoc = new Map()
    let hits = 0
    for (const g of grams) {
      const docs = index.get(g)
      if (!docs || docs.size >= 3) continue // frase de formato, no de contenido
      hits++
      for (const d of docs) {
        if (!hitsByDoc.has(d)) hitsByDoc.set(d, [])
        hitsByDoc.get(d).push(g)
      }
    }
    const ratio = grams.size ? hits / grams.size : 0
    const worst = [...hitsByDoc.entries()].sort((a, b) => b[1].length - a[1].length)[0]
    if (((worst && worst[1].length >= 3) || ratio >= 0.2) && !REVIEWED[q.key]) {
      flagged.push({ key: q.key, ratio, doc: worst?.[0], sample: worst?.[1].slice(0, 3) })
    }
  }
}

console.log(`Corpus: ${index.size} n-gramas de referencia. Preguntas revisadas: ${total}.`)
if (!flagged.length) {
  console.log('✓ Sin coincidencias literales relevantes con el material oficial.')
  process.exit(0)
}
console.log(`✗ ${flagged.length} preguntas con coincidencias:`)
for (const f of flagged) {
  console.log(`  - ${f.key}: ${(f.ratio * 100).toFixed(0)}% de n-gramas en el corpus; más cercano: ${f.doc}`)
  for (const s of f.sample ?? []) console.log(`      «${s}»`)
}
process.exit(1)
