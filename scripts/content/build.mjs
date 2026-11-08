#!/usr/bin/env node
// Valida el banco de preguntas (content/questions/*.json) y genera supabase/seed_content.sql.
//
//   node scripts/content/build.mjs            -> solo valida y muestra estadísticas
//   node scripts/content/build.mjs --sql      -> valida y escribe el seed SQL
//
// Ver content/SPEC.md para el formato.

import fs from 'node:fs'
import path from 'node:path'
import crypto from 'node:crypto'
import katex from 'katex'

const ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), '../..')
const dirArg = process.argv.indexOf('--dir')
const QDIR = dirArg > -1 ? path.resolve(process.argv[dirArg + 1]) : path.join(ROOT, 'content/questions')
const taxonomy = JSON.parse(fs.readFileSync(path.join(ROOT, 'content/taxonomy.json'), 'utf8'))

const HABILIDADES = ['resolver_problemas', 'modelar', 'representar', 'argumentar']
const DIFFICULTIES = ['easy', 'medium', 'hard']
const NO_SE = 'No sé responder esta pregunta'
const SUFICIENCIA = {
  A: '(1) por sí sola',
  B: '(2) por sí sola',
  C: 'Ambas juntas, (1) y (2)',
  D: 'Cada una por sí sola, (1) ó (2)',
  E: 'Se requiere información adicional',
}
// Namespace fijo para UUID v5: la misma key produce siempre el mismo id (seed idempotente).
const NAMESPACE = '6f1c2a3e-9b4d-5e8f-a1b2-c3d4e5f6a7b8'

function uuidv5(name) {
  const ns = Buffer.from(NAMESPACE.replace(/-/g, ''), 'hex')
  const hash = crypto.createHash('sha1').update(Buffer.concat([ns, Buffer.from(name, 'utf8')])).digest()
  const b = hash.subarray(0, 16)
  b[6] = (b[6] & 0x0f) | 0x50
  b[8] = (b[8] & 0x3f) | 0x80
  const h = b.toString('hex')
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-${h.slice(12, 16)}-${h.slice(16, 20)}-${h.slice(20)}`
}

// Replica exacta del split de src/components/ui/latex-renderer.tsx
function checkText(text, where, errors) {
  if (typeof text !== 'string' || !text.trim()) return errors.push(`${where}: texto vacío`)
  if (text.includes('$$')) errors.push(`${where}: usa $$ (no soportado)`)
  if (/\\\$/.test(text)) errors.push(`${where}: contiene \\$ (rompe el renderizador)`)
  if ((text.match(/\$/g) || []).length % 2 !== 0) errors.push(`${where}: cantidad impar de $ (¿dinero con $?)`)
  if (/\*\*|^\s*[-*] |\|.*\|/m.test(text.replace(/\$[^$]*\$/g, ''))) errors.push(`${where}: parece Markdown`)
  if (/figura adjunta|imagen adjunta|gráfico adjunto/i.test(text)) errors.push(`${where}: referencia a figura inexistente`)
  if (/\\/.test(text.replace(/\$[^$]*\$/g, ''))) errors.push(`${where}: backslash fuera de LaTeX (¿"\\n" literal en vez de salto de línea?)`)
  for (const part of text.split(/(\$[^$]*\$)/g)) {
    if (part.startsWith('$') && part.endsWith('$') && part.length > 2) {
      try {
        katex.renderToString(part.slice(1, -1), { throwOnError: true })
      } catch (e) {
        errors.push(`${where}: KaTeX falla en ${part.slice(0, 60)} → ${e.message.split('\n')[0]}`)
      }
    }
  }
}

function validate(q, file, seenKeys) {
  const errors = []
  const where = `${path.basename(file)}#${q.key ?? '?'}`
  const e = (m) => errors.push(`${where}: ${m}`)

  for (const f of ['key', 'subject', 'eje', 'topic', 'habilidad', 'difficulty', 'format', 'content', 'alternatives', 'correct', 'explanation', 'verify']) {
    if (q[f] === undefined) e(`falta el campo ${f}`)
  }
  if (errors.length) return errors

  if (!/^m[12]-[a-z-]+-\d{3}$/.test(q.key)) e(`key con formato inválido`)
  if (seenKeys.has(q.key)) e(`key duplicada`)
  seenKeys.add(q.key)

  const subj = taxonomy[q.subject]
  if (!subj) e(`subject inválido ${q.subject}`)
  else if (!subj[q.eje]) e(`eje inválido ${q.eje}`)
  else if (!subj[q.eje].topics[q.topic]) e(`topic ${q.topic} no existe en ${q.subject}/${q.eje}`)
  if (!q.key.startsWith(`${q.subject}-${q.eje}-`)) e(`key no coincide con subject/eje`)
  if (!HABILIDADES.includes(q.habilidad)) e(`habilidad inválida ${q.habilidad}`)
  if (!DIFFICULTIES.includes(q.difficulty)) e(`difficulty inválida ${q.difficulty}`)

  const letters = Object.keys(q.alternatives)
  if (q.format === 'standard') {
    if (letters.join('') !== 'ABCD') e(`standard requiere exactamente A,B,C,D (tiene ${letters.join(',')})`)
  } else if (q.format === 'suficiencia') {
    if (q.subject !== 'm2') e(`suficiencia solo existe en M2`)
    for (const [k, v] of Object.entries(SUFICIENCIA)) if (q.alternatives[k] !== v) e(`suficiencia: alternativa ${k} debe ser "${v}"`)
    if (!q.content.includes('(1)') || !q.content.includes('(2)')) e(`suficiencia sin afirmaciones (1) y (2)`)
  } else e(`format inválido ${q.format}`)

  if (!letters.includes(q.correct)) e(`correct ${q.correct} no está en las alternativas`)
  const vals = Object.values(q.alternatives).map((v) => String(v).replace(/\s+/g, ''))
  if (new Set(vals).size !== vals.length) e(`alternativas repetidas`)

  checkText(q.content, `${where} content`, errors)
  checkText(q.explanation, `${where} explanation`, errors)
  for (const [k, v] of Object.entries(q.alternatives)) checkText(v, `${where} alt ${k}`, errors)

  if (/^\s*return\s*['"][A-E]['"]\s*;?\s*$/.test(q.verify)) e(`verify trivial (solo devuelve una letra)`)
  else {
    try {
      const got = new Function(q.verify)()
      if (got !== q.correct) e(`verify devolvió ${JSON.stringify(got)} pero correct es ${q.correct}`)
    } catch (err) {
      e(`verify lanzó error: ${err.message}`)
    }
  }
  return errors
}

const sqlStr = (s) => `'${String(s).replace(/'/g, "''")}'`

function buildSql(questions) {
  const out = []
  out.push('-- GENERADO por scripts/content/build.mjs — no editar a mano.')
  out.push('-- Banco de preguntas ORIGINALES de PAES-WEB (ver content/SPEC.md).')
  out.push(`-- ${questions.length} preguntas. Idempotente: se puede re-ejecutar.`)
  out.push('begin;')
  out.push('')
  out.push('-- Ejes y tópicos')
  for (const [subject, ejes] of Object.entries(taxonomy)) {
    if (subject.startsWith('_')) continue
    for (const [ejeSlug, eje] of Object.entries(ejes)) {
      out.push(`insert into public.ejes (name, slug, subject) values (${sqlStr(eje.name)}, ${sqlStr(ejeSlug)}, ${sqlStr(subject)})`)
      out.push(`  on conflict (slug, subject) do update set name = excluded.name;`)
      for (const [topicSlug, topicName] of Object.entries(eje.topics)) {
        out.push(`insert into public.topics (eje_id, name, slug)`)
        out.push(`  select e.id, ${sqlStr(topicName)}, ${sqlStr(topicSlug)} from public.ejes e`)
        out.push(`  where e.slug = ${sqlStr(ejeSlug)} and e.subject = ${sqlStr(subject)}`)
        out.push(`  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = ${sqlStr(topicSlug)});`)
      }
    }
  }
  out.push('')
  out.push('-- Preguntas')
  for (const q of questions) {
    const id = uuidv5(q.key)
    const alts = Object.entries(q.alternatives).map(([k, v]) => ({ id: k, content: v }))
    alts.push({ id: q.format === 'suficiencia' ? 'F' : 'E', content: NO_SE })
    out.push(`-- ${q.key}`)
    out.push(
      `insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values (` +
        `${sqlStr(id)}, ${sqlStr(q.key)}, ${sqlStr(q.content)}, ${sqlStr(JSON.stringify(alts))}::jsonb, ${sqlStr(q.correct)}, ${sqlStr(q.difficulty)}::difficulty_level, ` +
        `${sqlStr(q.explanation)}, ${sqlStr(q.subject)}, ${sqlStr(q.habilidad)}, true)`
    )
    out.push(
      `  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, ` +
        `difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;`
    )
    out.push(`insert into public.question_topics (question_id, topic_id)`)
    out.push(`  select ${sqlStr(id)}, t.id from public.topics t join public.ejes e on e.id = t.eje_id`)
    out.push(`  where e.slug = ${sqlStr(q.eje)} and e.subject = ${sqlStr(q.subject)} and t.slug = ${sqlStr(q.topic)}`)
    out.push(`  on conflict do nothing;`)
  }
  out.push('')
  out.push('commit;')
  return out.join('\n') + '\n'
}

// --- main ---
const files = fs.existsSync(QDIR) ? fs.readdirSync(QDIR).filter((f) => f.endsWith('.json')).sort() : []
const seenKeys = new Set()
const all = []
const errors = []
for (const f of files) {
  const file = path.join(QDIR, f)
  let arr
  try {
    arr = JSON.parse(fs.readFileSync(file, 'utf8'))
  } catch (err) {
    errors.push(`${f}: JSON inválido → ${err.message}`)
    continue
  }
  for (const q of arr) {
    errors.push(...validate(q, file, seenKeys))
    all.push(q)
  }
}

const tally = (fn) => all.reduce((acc, q) => ((acc[fn(q)] = (acc[fn(q)] || 0) + 1), acc), {})
console.log(`Preguntas: ${all.length} en ${files.length} archivos`)
console.log('Por subject/eje:', tally((q) => `${q.subject}/${q.eje}`))
console.log('Por habilidad:', tally((q) => q.habilidad))
console.log('Por dificultad:', tally((q) => q.difficulty))
console.log('Por respuesta correcta:', tally((q) => q.correct))
console.log('Por formato:', tally((q) => q.format))

if (errors.length) {
  console.error(`\n✗ ${errors.length} errores:`)
  for (const e of errors) console.error('  - ' + e)
  process.exit(1)
}
console.log('\n✓ Todo válido')

if (process.argv.includes('--sql')) {
  const target = path.join(ROOT, 'supabase/seed_content.sql')
  fs.writeFileSync(target, buildSql(all))
  console.log(`✓ Escrito ${path.relative(ROOT, target)}`)
}
