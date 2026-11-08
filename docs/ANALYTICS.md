# Analítica de aprendizaje — PAES Lab

Qué se registra de cada alumno, dónde queda y cómo usarlo para construir modelos.

## Qué se captura

| Evento | Tabla | Campos clave |
|---|---|---|
| Respuesta en práctica o repaso | `attempts` | `selected_answer`, `is_correct` (calculado en la base, no en el navegador), `time_spent_ms`, `attempt_number`, `session_id`, `mode`, `created_at` |
| Tiempo agotado | `attempts` | `selected_answer = 'TIMEOUT'` |
| Respuesta en ensayo | `ensayo_responses` | una fila por pregunta: `position`, `eje_slug`, `selected_answer`, `is_correct` (se llena sola al entregar el ensayo) |
| Resultado del ensayo | `ensayos` | `score` (escala PAES 100–1000), `total_correct`, desglose por eje |
| Sesión de estudio | `study_sessions` | `started_at`, `ended_at`, `duration_seconds`, `subject` (se corta tras 2 min de inactividad, al ocultar la pestaña o al cambiar de M1 a M2) |
| Explicación abierta | `explanation_views` | `question_id`, `viewed_at` |
| Valoración de una pregunta | `question_feedback` | voto 👍/👎 |

Cada pregunta trae su metadata: materia (M1/M2), eje, tópico (según el temario oficial DEMRE),
habilidad (resolver problemas, modelar, representar, argumentar) y dificultad asignada.
`questions.external_key` la vincula con su versión en git (`content/questions/*.json`).

## Vistas de análisis (esquema `analytics`)

El esquema no está expuesto por la API pública. Se consulta por SQL directo o se exporta.

- **`analytics.responses`**: todas las respuestas (práctica + ensayo) en un formato único, una fila
  por respuesta, con la metadata del ítem. Es la tabla de entrada para casi cualquier modelo.
- **`analytics.items`**: metadata de cada pregunta.
- **`analytics.item_stats`**: estadística clásica por ítem: % de acierto en la primera exposición,
  tiempo mediano, discriminación (correlación punto-biserial) y dificultad empírica
  (se calcula desde 30 respuestas).
- **`analytics.user_topic_mastery`**: dominio de cada alumno por tópico (acierto total, acierto en las
  últimas 10 y tiempo mediano).
- **`analytics.daily_activity`**: sesiones y segundos estudiados por día.

`user_key` es un seudónimo estable (sha256 del id de usuario), para trabajar los datos sin
información personal.

## Exportar

```bash
./scripts/analytics/export.sh            # → analytics-export/AAAA-MM-DD/*.csv
```

## Modelos que estos datos permiten

1. **Calibración de ítems (TRI/IRT 2PL)**: estimar la dificultad y discriminación reales de cada
   pregunta con `responses` (primeras exposiciones). Sirve para corregir la dificultad asignada a
   mano y para armar ensayos de dificultad pareja. Recomendado desde unas 200 respuestas por ítem.
2. **Dominio por tópico (Bayesian Knowledge Tracing o Deep Knowledge Tracing)**: usa la secuencia
   ordenada por `responded_at`, con `attempt_number`, `time_spent_ms` y `saw_explanation_before`
   como covariables. Alimenta la selección de la siguiente pregunta (`get_smart_question`) y el
   mapa de vacíos del alumno.
3. **Predicción del puntaje PAES**: relacionar el dominio por tópico y el desempeño en práctica con
   el `score` de los ensayos, para estimar el puntaje esperado y su evolución.
4. **Riesgo de abandono**: `daily_activity` + tendencia de acierto → alertas y recordatorios.

## Pendientes conocidos

- `correct_answer` se envía al navegador junto con la pregunta. Para un uso evaluativo serio, la
  corrección debería pasar por una RPC que no revele la respuesta antes de contestar.
- En el modo ensayo no se guarda el tiempo por pregunta (solo el total).
- **Datos personales**: antes de entrenar modelos o compartir datos con terceros, revisar la
  política de privacidad y el consentimiento según la Ley 19.628 y la nueva Ley 21.719 de
  protección de datos personales. Hay que considerar que gran parte de los usuarios son menores
  de edad.
