#!/usr/bin/env bash
# Exporta las vistas de analytics a CSV seudonimizado (sin user_id ni emails), listo para
# modelamiento en Python/R.
#
#   ./scripts/analytics/export.sh [carpeta_destino]
#
# Requiere en .env.local: SUPABASE_DB_PASSWORD y SUPABASE_DB_URL_POOLER (cadena libpq).
set -euo pipefail
cd "$(dirname "$0")/../.."
set -a; source .env.local; set +a

OUT="${1:-analytics-export/$(date +%Y-%m-%d)}"
mkdir -p "$OUT"
PSQL="${PSQL:-$(command -v psql || echo /opt/homebrew/opt/libpq/bin/psql)}"
export PGPASSWORD="$SUPABASE_DB_PASSWORD"

copy() { # $1 = archivo, $2 = consulta
  "$PSQL" "$SUPABASE_DB_URL_POOLER" -v ON_ERROR_STOP=1 -q \
    -c "\copy ($2) to '$OUT/$1' with csv header"
  echo "  $OUT/$1 ($(($(wc -l < "$OUT/$1") - 1)) filas)"
}

echo "Exportando a $OUT"
copy responses.csv "select user_key, question_id, external_key, subject, eje, topic, habilidad, authored_difficulty, source, ensayo_id, session_id, responded_at, selected_answer, timed_out, is_correct, time_spent_ms, attempt_number, saw_explanation_before from analytics.responses order by user_key, responded_at"
copy items.csv "select question_id, external_key, subject, eje, topic, habilidad, authored_difficulty, is_active from analytics.items"
copy item_stats.csv "select * from analytics.item_stats"
copy user_topic_mastery.csv "select user_key, subject, eje, topic, n_responses, accuracy, accuracy_last_10, median_time_ms, first_at, last_at from analytics.user_topic_mastery"
copy daily_activity.csv "select user_key, subject, day, sessions, seconds_studied from analytics.daily_activity"
echo "Listo. Los CSV no contienen user_id ni datos personales (user_key = sha256 del id)."
