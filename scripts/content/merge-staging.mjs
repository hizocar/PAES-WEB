#!/usr/bin/env node
// Integra archivos de una carpeta de staging al banco (content/questions), agregando
// preguntas por key. Falla si una key ya existe con contenido distinto.
//   node scripts/content/merge-staging.mjs content/staging2/m1-num [más carpetas...]
import fs from 'node:fs'
import path from 'node:path'
const QDIR = 'content/questions'
for (const dir of process.argv.slice(2)) {
  for (const f of fs.readdirSync(dir).filter((f) => f.endsWith('.json'))) {
    const target = path.join(QDIR, f)
    const bank = fs.existsSync(target) ? JSON.parse(fs.readFileSync(target, 'utf8')) : []
    const keys = new Map(bank.map((q) => [q.key, q]))
    let added = 0
    for (const q of JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'))) {
      if (keys.has(q.key)) {
        if (JSON.stringify(keys.get(q.key)) !== JSON.stringify(q)) throw new Error(`Conflicto de key ${q.key} en ${f}`)
        continue
      }
      bank.push(q); added++
    }
    bank.sort((a, b) => a.key.localeCompare(b.key, 'en', { numeric: true }))
    fs.writeFileSync(target, JSON.stringify(bank, null, 2) + '\n')
    console.log(`${f}: +${added} → ${bank.length}`)
  }
}
