#!/usr/bin/env bash
# Toma el Client Secret de Google desde el portapapeles, lo valida, lo guarda en .env.local
# (fuera de git) y activa el login con Google en Supabase. Nunca imprime el secreto.
set -euo pipefail
cd "$(dirname "$0")/.."
SEC="$(pbpaste | tr -d '[:space:]')"
if [[ "$SEC" != GOCSPX-* || ${#SEC} -lt 20 || ${#SEC} -gt 60 ]]; then
  echo "El portapapeles no contiene un Client Secret de Google (debe empezar con GOCSPX-)."; exit 1
fi
grep -v '^GOOGLE_OAUTH_CLIENT_SECRET=' .env.local > .env.local.tmp && mv .env.local.tmp .env.local
printf 'GOOGLE_OAUTH_CLIENT_SECRET=%s\n' "$SEC" >> .env.local && chmod 600 .env.local
echo "Secreto guardado (termina en ${SEC: -4}). Activando Google en Supabase…"
set -a; source .env.local; set +a
supabase config push --yes 2>&1 | grep -E "Auth|up to date|Error" | grep -v Storage || true
printf '' | pbcopy   # limpiar el portapapeles
echo "Listo. Prueba el botón de Google en https://www.paeslab.cl/login"
