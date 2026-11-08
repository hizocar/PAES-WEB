# Orden de reconstrucción de la base (PAES-WEB)

> **Desde 2026-11-07 la fuente de verdad es `supabase/migrations/`** (61 a 64 incluidas), y se
> aplica con `supabase db push`. Los .sql sueltos de esta carpeta quedan como histórico.
> Contenido: `node scripts/content/build.mjs --sql` y luego cargar `supabase/seed_content.sql`.
> Proyecto actual: `paeslab` (`tbraqdkhqkrkqqceplug`, sa-east-1).
>
> Migraciones nuevas de la reconstrucción:
> - 061: guards de autorización en RPCs SECURITY DEFINER y revoke a anon.
> - 062: ensayo M1 con la proporción oficial de ejes (20/17/12/11).
> - 063: corrección de wrappers, protección de columnas de profiles, sin UPDATE de ensayos,
>   is_correct calculado en la base.
> - 064: el trigger de profiles pasa a SECURITY INVOKER.

Reconstruido desde el orden en que cada archivo entró a git (`git log --reverse --diff-filter=A`).
El proyecto Supabase original (`dmcxuyktaynjrwuczwek`) fue eliminado; este es el orden para recrearlo desde cero.

## Migraciones (aplicar en este orden)

### 2026-01-27 — base
1. setup.sql
2. storage.sql
3. fix_rls.sql
4. fix_rls_policies.sql
5. fix_topics_policies.sql
6. fix_delete_policy.sql
7. add_image_support.sql
8. fix_schema_image_url.sql   (repite policies de #7 → puede chocar)
9. add_video_explanation.sql
10. setup_secure_videos.sql
11. add_question_stats.sql
12. ~~seed_questions.sql~~      OMITIR: 9 preguntas demo con 5 alternativas reales (choca con la convención E = "No sé")
13. admin_users_rpc.sql
14. question_feedback.sql
15. smart_selection_rpc.sql

### 2026-01-28
16. lives_system.sql
17. admin_lives_update.sql
18. explanation_credits.sql
19. admin_credits_update.sql
20. add_streak_columns.sql
21. leaderboard_system.sql
22. fix_reset_progress.sql
23. achievements_tables.sql
24. achievements_rpc.sql
25. smart_selection_v2.sql

### 2026-01-29
26. dashboard_rpc.sql
27. multi_subject_migration.sql
28. multi_subject_rpcs.sql
29. separate_lives_streak.sql
30. separate_achievements.sql
31. admin_subject_stats.sql
32. admin_users_subject_rpc.sql
33. fix_ejes_constraint.sql

### 2026-01-30
34. subscriptions_v2.sql
35. add_mode_to_attempts.sql
36. subscriptions_v3.sql
37. admin_delete_user_rpc.sql
38. admin_update_tier_rpc.sql
39. cleanup_expired_subscriptions.sql
40. add_onboarding_status.sql
41. add_practice_onboarding.sql

### 2026-01-31
42. add_habilidad_column.sql
43. admin_student_detail_rpc.sql
44. rewarded_ads.sql

### 2026-02-03
45. new_achievements.sql
46. fix_lives_system.sql
47. security_hardening.sql
48. fix_rpc_permissions.sql
49. paes_score_logic.sql
50. fix_lives_display.sql
51. secure_rpc.sql
52. correct_precision_logic.sql
53. fix_admin_stats_filtering.sql
54. fix_admin_refill_lives.sql

### 2026-02-04
55. fix_admin_hourly_lives.sql
56. fix_admin_hourly_lives_sync.sql
57. fix_admin_users_full.sql
58. admin_users_stats_v2.sql
59. admin_analytics_rpc.sql

### 2026-02-11
60. ensayos.sql
61. fix_create_ensayo_m1.sql

## Contenido (después de las migraciones)
62. seed_content.sql — GENERADO con `node scripts/content/build.mjs --sql` desde `content/questions/*.json`.
    Crea los ejes y tópicos de M1 y M2 (según el temario oficial) y el banco de preguntas ORIGINALES.
    Es idempotente: se puede volver a correr después de editar preguntas.

## Post-registro (correr después de que el admin cree su cuenta)
- fix_admin_permissions.sql

## Solo diagnóstico (NO aplicar)
check_m1_distribution.sql, check_question_counts.sql, check_subjects.sql,
debug_ensayo_query.sql, inspect_columns.sql
