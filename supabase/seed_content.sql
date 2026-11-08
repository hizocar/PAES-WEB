-- GENERADO por scripts/content/build.mjs — no editar a mano.
-- Banco de preguntas ORIGINALES de PAES-WEB (ver content/SPEC.md).
-- 360 preguntas. Idempotente: se puede re-ejecutar.
begin;

-- Ejes y tópicos
insert into public.ejes (name, slug, subject) values ('Números', 'numeros', 'm1')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Números enteros y racionales', 'enteros-y-racionales' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'enteros-y-racionales');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Porcentaje', 'porcentaje' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'porcentaje');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Potencias y raíces enésimas', 'potencias-y-raices' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'potencias-y-raices');
insert into public.ejes (name, slug, subject) values ('Álgebra y Funciones', 'algebra-y-funciones', 'm1')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Expresiones algebraicas', 'expresiones-algebraicas' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'expresiones-algebraicas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Proporcionalidad', 'proporcionalidad' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'proporcionalidad');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Ecuaciones e inecuaciones de primer grado', 'ecuaciones-inecuaciones-lineales' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'ecuaciones-inecuaciones-lineales');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Sistemas de ecuaciones lineales (2x2)', 'sistemas-2x2' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'sistemas-2x2');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Función lineal y afín', 'funcion-lineal-afin' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funcion-lineal-afin');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Función cuadrática', 'funcion-cuadratica' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funcion-cuadratica');
insert into public.ejes (name, slug, subject) values ('Geometría', 'geometria', 'm1')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Figuras geométricas (Pitágoras, perímetros y áreas)', 'figuras-geometricas' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'figuras-geometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Cuerpos geométricos (área y volumen)', 'cuerpos-geometricos' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'cuerpos-geometricos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Transformaciones isométricas y vectores', 'transformaciones-isometricas' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'transformaciones-isometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Semejanza y proporcionalidad de figuras', 'semejanza' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'semejanza');
insert into public.ejes (name, slug, subject) values ('Probabilidad y Estadística', 'probabilidad-y-estadistica', 'm1')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Representación de datos (tablas, gráficos, promedio)', 'tablas-y-graficos' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'tablas-y-graficos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Medidas de posición (cuartiles, percentiles, cajón)', 'medidas-de-posicion' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'medidas-de-posicion');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Reglas de las probabilidades', 'reglas-probabilidades' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'reglas-probabilidades');
insert into public.ejes (name, slug, subject) values ('Números', 'numeros', 'm2')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Conjunto de los números reales', 'numeros-reales' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'numeros-reales');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Matemática financiera', 'matematica-financiera' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'matematica-financiera');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Logaritmos', 'logaritmos' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'logaritmos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Números enteros y racionales', 'enteros-y-racionales' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'enteros-y-racionales');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Porcentaje', 'porcentaje' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'porcentaje');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Potencias y raíces enésimas', 'potencias-y-raices' from public.ejes e
  where e.slug = 'numeros' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'potencias-y-raices');
insert into public.ejes (name, slug, subject) values ('Álgebra y Funciones', 'algebra-y-funciones', 'm2')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Sistemas 2x2: única, infinitas o ninguna solución', 'sistemas-casos-solucion' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'sistemas-casos-solucion');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Función potencia, exponencial y logarítmica', 'funcion-potencia-exp-log' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funcion-potencia-exp-log');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Funciones trigonométricas (seno y coseno)', 'funciones-trigonometricas' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funciones-trigonometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Expresiones algebraicas', 'expresiones-algebraicas' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'expresiones-algebraicas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Proporcionalidad', 'proporcionalidad' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'proporcionalidad');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Ecuaciones e inecuaciones de primer grado', 'ecuaciones-inecuaciones-lineales' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'ecuaciones-inecuaciones-lineales');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Sistemas de ecuaciones lineales (2x2)', 'sistemas-2x2' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'sistemas-2x2');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Función lineal y afín', 'funcion-lineal-afin' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funcion-lineal-afin');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Función cuadrática', 'funcion-cuadratica' from public.ejes e
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'funcion-cuadratica');
insert into public.ejes (name, slug, subject) values ('Geometría', 'geometria', 'm2')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Homotecia de figuras planas', 'homotecia' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'homotecia');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Razones trigonométricas en triángulos rectángulos', 'razones-trigonometricas' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'razones-trigonometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Relaciones métricas en la circunferencia', 'circunferencia' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'circunferencia');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Esfera: superficie y volumen', 'esfera' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'esfera');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Rectas en el plano', 'rectas-en-el-plano' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'rectas-en-el-plano');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Figuras geométricas (Pitágoras, perímetros y áreas)', 'figuras-geometricas' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'figuras-geometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Cuerpos geométricos (área y volumen)', 'cuerpos-geometricos' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'cuerpos-geometricos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Transformaciones isométricas y vectores', 'transformaciones-isometricas' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'transformaciones-isometricas');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Semejanza y proporcionalidad de figuras', 'semejanza' from public.ejes e
  where e.slug = 'geometria' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'semejanza');
insert into public.ejes (name, slug, subject) values ('Probabilidad y Estadística', 'probabilidad-y-estadistica', 'm2')
  on conflict (slug, subject) do update set name = excluded.name;
insert into public.topics (eje_id, name, slug)
  select e.id, 'Medidas de dispersión', 'medidas-de-dispersion' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'medidas-de-dispersion');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Probabilidad condicional', 'probabilidad-condicional' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'probabilidad-condicional');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Permutación y combinatoria', 'permutacion-combinatoria' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'permutacion-combinatoria');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Modelos probabilísticos (binomial y normal)', 'modelos-probabilisticos' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'modelos-probabilisticos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Representación de datos (tablas, gráficos, promedio)', 'tablas-y-graficos' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'tablas-y-graficos');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Medidas de posición (cuartiles, percentiles, cajón)', 'medidas-de-posicion' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'medidas-de-posicion');
insert into public.topics (eje_id, name, slug)
  select e.id, 'Reglas de las probabilidades', 'reglas-probabilidades' from public.ejes e
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2'
  and not exists (select 1 from public.topics t where t.eje_id = e.id and t.slug = 'reglas-probabilidades');

-- Preguntas
-- m1-algebra-y-funciones-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d815a32e-fab0-561d-ab76-293f526e880f', 'm1-algebra-y-funciones-001', 'Camila compra $x$ cuadernos a $1\,200$ pesos cada uno y $y$ lápices a $450$ pesos cada uno. Si paga con un billete de $10\,000$ pesos, ¿cuál de las siguientes expresiones representa el vuelto, en pesos, que debe recibir?', '[{"id":"A","content":"$10\\,000 - 1\\,650xy$"},{"id":"B","content":"$(1\\,200x + 450y) - 10\\,000$"},{"id":"C","content":"$10\\,000 - 1\\,200x + 450y$"},{"id":"D","content":"$10\\,000 - (1\\,200x + 450y)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El gasto total es $1\,200x + 450y$ pesos, y el vuelto es lo que sobra del billete: $10\,000 - (1\,200x + 450y)$.
A suma los precios unitarios y multiplica las cantidades, lo que no representa el gasto. B invierte la resta: daría un vuelto negativo cuando el gasto es menor que el billete. C omite el paréntesis: al restar el gasto también hay que restar $450y$, no sumarlo.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd815a32e-fab0-561d-ab76-293f526e880f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a766836a-df01-5de2-9db3-4546a0dfad98', 'm1-algebra-y-funciones-002', 'Al reducir la expresión $(3a + 2)^2 - (a - 5)(a + 5)$ se obtiene:', '[{"id":"A","content":"$8a^2 + 12a - 21$"},{"id":"B","content":"$8a^2 + 6a + 29$"},{"id":"C","content":"$8a^2 + 12a + 29$"},{"id":"D","content":"$8a^2 + 29$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Se tiene $(3a + 2)^2 = 9a^2 + 12a + 4$ y $(a - 5)(a + 5) = a^2 - 25$. Entonces $9a^2 + 12a + 4 - (a^2 - 25) = 8a^2 + 12a + 29$.
A olvida que el signo menos delante del paréntesis transforma $-25$ en $+25$. B no duplica el término central del cuadrado de binomio ($6a$ en vez de $12a$). D eleva cada término al cuadrado por separado y pierde el término $12a$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a766836a-df01-5de2-9db3-4546a0dfad98', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8edd1e4d-1652-53a7-8ca7-402fd1ce3b73', 'm1-algebra-y-funciones-003', 'Martín desarrolló y redujo la expresión $(x + 5)^2 - 2(x - 3)$ de la siguiente manera:
Paso 1: $x^2 + 10x + 25 - 2(x - 3)$
Paso 2: $x^2 + 10x + 25 - 2x - 6$
Paso 3: $x^2 + 8x + 19$
¿En cuál de los pasos Martín cometió un error por primera vez?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"Martín no cometió errores"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El paso 1 desarrolla bien el cuadrado de binomio: $(x + 5)^2 = x^2 + 10x + 25$. En el paso 2, al multiplicar $-2$ por $-3$ se obtiene $+6$, no $-6$. Lo correcto es $x^2 + 10x + 25 - 2x + 6 = x^2 + 8x + 31$.
El paso 3 reduce correctamente lo que venía del paso 2; por eso, quien solo revisa la última operación puede elegir C o D. A es incorrecta porque el cuadrado de binomio está bien desarrollado.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8edd1e4d-1652-53a7-8ca7-402fd1ce3b73', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cbed8059-cb8e-5621-b7bb-2d51d4b582fc', 'm1-algebra-y-funciones-004', 'Ignacio tiene un huerto rectangular en Limache que mide $(2x + 3)$ metros de largo y $(x + 1)$ metros de ancho. Decide alargarlo $2$ metros y, para dejar espacio a un pasillo, reducir su ancho en $1$ metro.
Para cualquier valor de $x > 0$, ¿qué ocurre con el área del nuevo huerto respecto del área del huerto original?', '[{"id":"A","content":"Disminuye en $3\\ \\text{m}^2$."},{"id":"B","content":"Disminuye en $1\\ \\text{m}^2$."},{"id":"C","content":"No cambia."},{"id":"D","content":"Aumenta en $1\\ \\text{m}^2$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Área original: $(2x + 3)(x + 1) = 2x^2 + 5x + 3$. El nuevo huerto mide $(2x + 5)$ m de largo y $x$ m de ancho, con área $(2x + 5)x = 2x^2 + 5x$.
La diferencia es $2x^2 + 5x - (2x^2 + 5x + 3) = -3$: el área disminuye en $3\ \text{m}^2$, sin importar el valor de $x$.
B calcula $2(x + 1) - 1 \cdot (2x + 3) = -1$ y olvida el rectángulo de $2 \times 1$ m de la esquina. D suma y resta las medidas ($+2 - 1$) como si fueran áreas. C supone que alargar y acortar se compensan.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cbed8059-cb8e-5621-b7bb-2d51d4b582fc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('de112baf-d962-5c68-bf4a-b861bb78c235', 'm1-algebra-y-funciones-005', 'En un viñedo de Curicó, una bomba de riego entrega agua a un ritmo constante, de modo que el volumen de agua entregado es directamente proporcional al tiempo de funcionamiento. En $24$ minutos la bomba entrega $500$ litros.
¿Cuántos litros entrega la bomba en $60$ minutos?', '[{"id":"A","content":"$536$ litros"},{"id":"B","content":"$1\\,000$ litros"},{"id":"C","content":"$1\\,250$ litros"},{"id":"D","content":"$1\\,440$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Por proporcionalidad directa: $\frac{500}{24} = \frac{V}{60}$, de donde $V = \frac{500 \cdot 60}{24} = 1\,250$ litros.
A suma la diferencia de minutos ($500 + 36$) en vez de mantener la razón. B duplica el volumen, pero $60$ minutos son $2{,}5$ veces $24$ minutos, no el doble. D multiplica $24 \cdot 60$ sin usar los litros del dato.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'de112baf-d962-5c68-bf4a-b861bb78c235', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cbff7bb9-6d39-56bb-9ab2-dceaf12b4547', 'm1-algebra-y-funciones-006', 'Para pintar las salas de un colegio en Antofagasta, $6$ pintores, trabajando todos al mismo ritmo, demoran $10$ días. Si $d$ es el número de días que demoran $p$ pintores en hacer el mismo trabajo, ¿cuál de las siguientes expresiones modela la relación entre $d$ y $p$?', '[{"id":"A","content":"$d = 60p$"},{"id":"B","content":"$d = \\frac{5p}{3}$"},{"id":"C","content":"$d = 16 - p$"},{"id":"D","content":"$d = \\frac{60}{p}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'A más pintores, menos días: es una proporcionalidad inversa, por lo que el producto $p \cdot d$ es constante e igual a $6 \cdot 10 = 60$. Así, $d = \frac{60}{p}$.
A multiplica en vez de dividir (más pintores darían más días). B plantea una proporcionalidad directa ($\frac{d}{p} = \frac{10}{6}$). C supone que la suma $p + d$ se mantiene constante.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cbff7bb9-6d39-56bb-9ab2-dceaf12b4547', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f520a98d-0250-5db4-bb64-106d9b0de64c', 'm1-algebra-y-funciones-007', 'Un grupo de amigos arrienda una cabaña en Pucón por un fin de semana y reparte el costo total en partes iguales. La tabla muestra el monto $y$, en miles de pesos, que paga cada persona según la cantidad $x$ de personas que van:
$\displaystyle \begin{array}{|c|c|c|c|c|}\hline x & 2 & 3 & 5 & 6 \\ \hline y & 15 & 10 & 6 & 5 \\ \hline \end{array}$
¿Cuál de las siguientes expresiones relaciona correctamente $x$ e $y$?', '[{"id":"A","content":"$y = \\frac{30}{x}$"},{"id":"B","content":"$y = \\frac{15x}{2}$"},{"id":"C","content":"$y = 25 - 5x$"},{"id":"D","content":"$y = 30x$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'En todos los pares se cumple $x \cdot y = 30$ ($2 \cdot 15 = 3 \cdot 10 = 5 \cdot 6 = 6 \cdot 5 = 30$): el costo total es $30$ mil pesos y se divide entre las personas, así que $y = \frac{30}{x}$.
B usa la razón $\frac{y}{x}$ del primer par como si fuera proporcionalidad directa. C solo calza con los dos primeros pares (para $x = 5$ daría $0$). D confunde el producto constante con una relación directa.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f520a98d-0250-5db4-bb64-106d9b0de64c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e545c77c-01bf-54a3-81ab-df06a32903bc', 'm1-algebra-y-funciones-008', 'En una panadería de Osorno hay hornos iguales, y cada uno hornea siempre la misma cantidad de hallullas por hora. Usando $3$ hornos se hornean $1\,800$ hallullas en $4$ horas.
Considera las siguientes afirmaciones:
I) Con $6$ hornos se hornean $1\,800$ hallullas en $2$ horas.
II) Con $3$ hornos se hornean $900$ hallullas en $2$ horas.
III) Con $2$ hornos se hornean $1\,800$ hallullas en $8$ horas.
¿Cuál o cuáles de ellas son verdaderas?', '[{"id":"A","content":"Solo I"},{"id":"B","content":"Solo I y II"},{"id":"C","content":"Solo II y III"},{"id":"D","content":"I, II y III"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Cada horno hornea $\frac{1\,800}{3 \cdot 4} = 150$ hallullas por hora.
I) $6 \cdot 2 \cdot 150 = 1\,800$: verdadera. II) $3 \cdot 2 \cdot 150 = 900$: verdadera. III) $2 \cdot 8 \cdot 150 = 2\,400 \neq 1\,800$: falsa; $2$ hornos tardarían $6$ horas.
Quien elige D duplica las horas al pasar de $3$ a $2$ hornos, pero el tiempo se multiplica por $\frac{3}{2}$, no por $2$. A y C descartan una afirmación verdadera.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e545c77c-01bf-54a3-81ab-df06a32903bc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('adca21f4-bddd-51ad-803f-0d23b1d2c117', 'm1-algebra-y-funciones-009', '¿Cuál es el valor de $x$ en la ecuación $3(x - 2) + 5 = 2x + 7$?', '[{"id":"A","content":"$-4$"},{"id":"B","content":"$4$"},{"id":"C","content":"$6$"},{"id":"D","content":"$8$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Distribuyendo: $3x - 6 + 5 = 2x + 7$, es decir, $3x - 1 = 2x + 7$. Luego $x = 7 + 1 = 8$.
A resulta de escribir $3x + 6$ (error de signo al distribuir). B resulta de no distribuir el $3$ y escribir $3x - 2 + 5$. C resulta de restar el $1$ en vez de sumarlo al trasponerlo.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'adca21f4-bddd-51ad-803f-0d23b1d2c117', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a690ced2-8597-5cd8-8fe5-f8c5975d8027', 'm1-algebra-y-funciones-010', 'En Valparaíso, un taxi cobra $400$ pesos fijos al iniciar el viaje (bajada de bandera) y $180$ pesos por cada $200$ metros recorridos. Josefa pagó en total $4\,000$ pesos por un viaje.
Si $d$ representa la distancia recorrida, en metros, ¿cuál de las siguientes ecuaciones permite calcular $d$?', '[{"id":"A","content":"$400d + 180 = 4\\,000$"},{"id":"B","content":"$400 + 180d = 4\\,000$"},{"id":"C","content":"$400 + \\frac{180d}{200} = 4\\,000$"},{"id":"D","content":"$400 + \\frac{200d}{180} = 4\\,000$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Cada metro cuesta $\frac{180}{200}$ pesos, así que $d$ metros cuestan $\frac{180d}{200}$ pesos. Sumando el cobro fijo: $400 + \frac{180d}{200} = 4\,000$, de donde $d = 4\,000$ m.
A intercambia el cobro fijo con el cobro variable. B cobra $180$ pesos por cada metro, no por cada $200$ metros. D invierte la razón entre pesos y metros.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a690ced2-8597-5cd8-8fe5-f8c5975d8027', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('be07cf67-1f8a-583e-a391-7ccc29357854', 'm1-algebra-y-funciones-011', 'Benjamín quiere comprarse una bicicleta y para eso necesita juntar al menos $120\,000$ pesos. Ya tiene $45\,000$ pesos guardados y cada semana agrega $6\,000$ pesos más.
¿Cuál de las siguientes inecuaciones permite determinar el número $s$ de semanas necesarias para lograr su meta?', '[{"id":"A","content":"$45\\,000 + 6\\,000s \\leq 120\\,000$"},{"id":"B","content":"$6\\,000 + 45\\,000s \\geq 120\\,000$"},{"id":"C","content":"$45\\,000 + 6\\,000s > 120\\,000$"},{"id":"D","content":"$45\\,000 + 6\\,000s \\geq 120\\,000$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Después de $s$ semanas tiene $45\,000 + 6\,000s$ pesos. «Al menos $120\,000$» significa mayor o igual: $45\,000 + 6\,000s \geq 120\,000$, que se cumple para $s \geq 12{,}5$, es decir, desde la semana $13$.
A invierte el sentido de la desigualdad. B intercambia el monto inicial con el ahorro semanal. C usa $>$ y excluye el caso de juntar exactamente $120\,000$ pesos, que también cumple la meta.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'be07cf67-1f8a-583e-a391-7ccc29357854', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c2a9cd9b-16d9-5186-ab97-3f7c6908f94e', 'm1-algebra-y-funciones-012', 'El ascensor de carga de un edificio en Santiago soporta como máximo $650$ kg. Kevin, que pesa $80$ kg, debe subir en él cajas de $24$ kg cada una y viaja junto a ellas.
¿Cuál es la mayor cantidad de cajas que puede subir en un solo viaje?', '[{"id":"A","content":"$23$"},{"id":"B","content":"$24$"},{"id":"C","content":"$27$"},{"id":"D","content":"$28$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Se debe cumplir $80 + 24n \leq 650$, es decir, $24n \leq 570$ y $n \leq 23{,}75$. Como $n$ es un número entero, la mayor cantidad es $23$ cajas.
B aproxima $23{,}75$ hacia arriba, pero con $24$ cajas la carga sería $656$ kg y supera el máximo. C y D olvidan el peso de Kevin: $\frac{650}{24} \approx 27{,}08$; C lo trunca y D lo aproxima hacia arriba.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c2a9cd9b-16d9-5186-ab97-3f7c6908f94e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('17d0dbfd-f565-5f15-963f-7fe90a1ed9a3', 'm1-algebra-y-funciones-013', 'Al resolver la inecuación $\displaystyle \frac{2 - x}{3} \geq \frac{x + 4}{2} - 1$, Antonia escribió:
Paso 1: $2(2 - x) \geq 3(x + 4) - 6$
Paso 2: $4 - 2x \geq 3x + 6$
Paso 3: $-5x \geq 2$
Paso 4: $x \geq -\frac{2}{5}$
¿En cuál de los pasos Antonia cometió un error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Paso 1: se multiplicaron ambos lados por $6$, incluido el $-1$, que pasa a ser $-6$: correcto. Paso 2: $3(x + 4) - 6 = 3x + 6$: correcto. Paso 3: al agrupar términos queda $-5x \geq 2$: correcto.
Paso 4: al dividir por $-5$, que es negativo, el sentido de la desigualdad debe invertirse; lo correcto es $x \leq -\frac{2}{5}$.
Quien marca A suele creer que el $-1$ no se multiplicó por $6$, pero en este desarrollo sí se hizo. B y C corresponden a operaciones bien realizadas.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '17d0dbfd-f565-5f15-963f-7fe90a1ed9a3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-014
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d0bff601-be52-5094-abbe-05856c69acbe', 'm1-algebra-y-funciones-014', 'Si $x + y = 11$ y $x - y = 3$, ¿cuál es el valor de $y$?', '[{"id":"A","content":"$3$"},{"id":"B","content":"$4$"},{"id":"C","content":"$7$"},{"id":"D","content":"$8$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Sumando ambas ecuaciones: $2x = 14$, así que $x = 7$. Reemplazando en $x + y = 11$ se obtiene $y = 4$.
C corresponde al valor de $x$, no al de $y$. D resulta de calcular $11 - 3$ y olvidar dividir por $2$. A confunde $y$ con la diferencia $x - y$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd0bff601-be52-5094-abbe-05856c69acbe', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m1-algebra-y-funciones-015
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8aa3349a-495f-5cb8-896b-c0db6fcddde3', 'm1-algebra-y-funciones-015', 'Para un festival de cueca en Rancagua se vendieron $1\,200$ entradas y se recaudaron $7\,350\,000$ pesos. La entrada de adulto costaba $8\,000$ pesos y la de niño, $5\,000$ pesos.
Si $x$ es la cantidad de entradas de adulto e $y$ la cantidad de entradas de niño vendidas, ¿cuál de los siguientes sistemas permite determinar $x$ e $y$?', '[{"id":"A","content":"$\\begin{cases} x + y = 1\\,200 \\\\ 8\\,000x + 5\\,000y = 7\\,350\\,000 \\end{cases}$"},{"id":"B","content":"$\\begin{cases} x + y = 1\\,200 \\\\ 5\\,000x + 8\\,000y = 7\\,350\\,000 \\end{cases}$"},{"id":"C","content":"$\\begin{cases} x + y = 7\\,350\\,000 \\\\ 8\\,000x + 5\\,000y = 1\\,200 \\end{cases}$"},{"id":"D","content":"$\\begin{cases} x - y = 1\\,200 \\\\ 8\\,000x + 5\\,000y = 7\\,350\\,000 \\end{cases}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El total de entradas da la ecuación $x + y = 1\,200$. La recaudación suma lo obtenido por cada tipo de entrada: $8\,000x + 5\,000y = 7\,350\,000$. Resolviendo, $x = 450$ e $y = 750$.
B asigna los precios al revés. C intercambia el número de entradas con el dinero recaudado. D usa una diferencia en lugar de la suma total de entradas.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8aa3349a-495f-5cb8-896b-c0db6fcddde3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m1-algebra-y-funciones-016
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ea88fed0-4171-5a47-98e4-c10648e62d80', 'm1-algebra-y-funciones-016', 'Florencia registra el nivel de agua, en centímetros, de dos estanques de su parcela en Paine. Ambos niveles cambian de forma lineal con el tiempo.
El estanque P tiene $2$ cm de agua al inicio y $8$ cm a las $3$ horas.
El estanque Q tiene $10$ cm de agua al inicio y $2$ cm a las $4$ horas.
¿Después de cuántas horas ambos estanques tienen el mismo nivel de agua, y cuál es ese nivel?', '[{"id":"A","content":"A las $2$ horas, con $6$ cm."},{"id":"B","content":"A las $3$ horas, con $8$ cm."},{"id":"C","content":"A las $4$ horas, con $2$ cm."},{"id":"D","content":"A las $6$ horas, con $2$ cm."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'P sube $\frac{8 - 2}{3} = 2$ cm por hora: $P(t) = 2 + 2t$. Q baja $\frac{10 - 2}{4} = 2$ cm por hora: $Q(t) = 10 - 2t$. Igualando, $2 + 2t = 10 - 2t$, de donde $t = 2$, y el nivel es $P(2) = 6$ cm.
B y C son datos de un solo estanque: en esos instantes el otro tiene $4$ cm y $10$ cm, respectivamente. D intercambia el tiempo con el nivel de la solución.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ea88fed0-4171-5a47-98e4-c10648e62d80', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m1-algebra-y-funciones-017
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8e07a63a-1502-55d6-9afb-d44a698689e1', 'm1-algebra-y-funciones-017', 'Hace $4$ años, la edad de Rocío era el triple de la edad de su hermano Tomás. Dentro de $6$ años, la edad de Rocío será el doble de la de Tomás.
¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"Tomás tiene actualmente $10$ años."},{"id":"B","content":"La diferencia entre sus edades es de $20$ años."},{"id":"C","content":"Rocío tiene actualmente $30$ años."},{"id":"D","content":"La suma de sus edades actuales es $40$ años."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Con $R$ y $T$ las edades actuales: $R - 4 = 3(T - 4)$ y $R + 6 = 2(T + 6)$. De la primera, $R = 3T - 8$; al reemplazar, $3T - 2 = 2T + 12$, así que $T = 14$ y $R = 34$. La diferencia es $34 - 14 = 20$ años.
A, C y D corresponden a las edades de hace $4$ años ($10$ y $30$) y a su suma ($40$): es el error de plantear el sistema con las edades pasadas y no sumar los $4$ años al final.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8e07a63a-1502-55d6-9afb-d44a698689e1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m1-algebra-y-funciones-018
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3b83ca30-4cba-5e78-b7ca-28f94463fa03', 'm1-algebra-y-funciones-018', 'En Valdivia, una empresa arrienda bicicletas y cobra según la función $C(t) = 1\,500 + 800t$, donde $C(t)$ es el costo total, en pesos, de arrendar una bicicleta durante $t$ horas.
¿Qué representa el número $800$ en este modelo?', '[{"id":"A","content":"El cobro fijo que se paga al arrendar, sin importar las horas."},{"id":"B","content":"El costo total de arrendar la bicicleta durante una hora."},{"id":"C","content":"La cantidad máxima de horas que se puede arrendar la bicicleta."},{"id":"D","content":"El aumento del costo por cada hora adicional de arriendo."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'En una función afín $C(t) = b + mt$, la pendiente $m$ indica cuánto cambia $C$ cuando $t$ aumenta en $1$: $C(t + 1) - C(t) = 800$ pesos por cada hora adicional.
A describe al coeficiente de posición, $C(0) = 1\,500$. B es incorrecta porque una hora cuesta $C(1) = 2\,300$ pesos. C no tiene sustento: el modelo no fija un máximo de horas.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3b83ca30-4cba-5e78-b7ca-28f94463fa03', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-019
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f444180e-3c27-509c-8a1a-445cdb2a3e95', 'm1-algebra-y-funciones-019', 'Un globo meteorológico lanzado en Punta Arenas registra la temperatura del aire a medida que sube. La temperatura $T$, en grados Celsius, varía de forma afín con la altura $h$, en kilómetros, según la tabla:
$\displaystyle \begin{array}{|c|c|c|c|c|}\hline h & 0 & 1 & 3 & 6 \\ \hline T & 4 & 1 & -5 & -14 \\ \hline \end{array}$
¿Cuál de las siguientes funciones modela la temperatura del aire según la altura?', '[{"id":"A","content":"$T(h) = -3h - 4$"},{"id":"B","content":"$T(h) = -3h + 4$"},{"id":"C","content":"$T(h) = 3h + 4$"},{"id":"D","content":"$T(h) = 4h - 3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La pendiente es $\frac{1 - 4}{1 - 0} = -3$ (la temperatura baja $3$ grados por cada kilómetro de altura) y el valor inicial es $T(0) = 4$. Luego $T(h) = -3h + 4$, lo que se comprueba con $T(6) = -18 + 4 = -14$.
C ignora que la temperatura disminuye (signo de la pendiente). A cambia el signo del valor inicial. D intercambia la pendiente con el coeficiente de posición.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f444180e-3c27-509c-8a1a-445cdb2a3e95', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-020
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('622b22be-3f5b-5590-9a94-f1b2adfa56e1', 'm1-algebra-y-funciones-020', 'Un estanque de agua potable en Coyhaique se vacía a un ritmo constante. A las $2$ horas de comenzar el vaciado le quedan $900$ litros, y a las $5$ horas le quedan $450$ litros.
¿Cuántas horas después de comenzar el vaciado queda completamente vacío?', '[{"id":"A","content":"$3$ horas"},{"id":"B","content":"$6$ horas"},{"id":"C","content":"$8$ horas"},{"id":"D","content":"$12$ horas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Entre la hora $2$ y la hora $5$ salen $450$ litros, es decir, $150$ litros por hora. Al inicio tenía $900 + 2 \cdot 150 = 1\,200$ litros, así que $V(t) = 1\,200 - 150t$, que vale $0$ en $t = 8$.
A es el tiempo que falta desde la hora $5$, no desde el inicio. B toma los $900$ litros como cantidad inicial. D divide los $450$ litros por $5$ horas en vez de por $3$, con lo que obtiene un ritmo de $90$ litros por hora.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '622b22be-3f5b-5590-9a94-f1b2adfa56e1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-021
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b5b816d9-282c-561b-8b43-1a1521ccc253', 'm1-algebra-y-funciones-021', 'Sea $f(x) = ax + b$ una función afín con $a < 0$ y $b > 0$. ¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"$f$ es una función creciente."},{"id":"B","content":"$f(0) < 0$"},{"id":"C","content":"La gráfica de $f$ corta al eje $X$ en un punto de abscisa positiva."},{"id":"D","content":"$f(x) > 0$ para todo $x > 0$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'La gráfica corta al eje $X$ cuando $ax + b = 0$, es decir, en $x = -\frac{b}{a}$. Como $b > 0$ y $a < 0$, el número $-\frac{b}{a}$ es positivo.
A es falsa: con $a < 0$ la función es decreciente. B es falsa: $f(0) = b > 0$. D es falsa: para $x > -\frac{b}{a}$ la función toma valores negativos; por ejemplo, si $f(x) = -2x + 4$, entonces $f(3) = -2$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b5b816d9-282c-561b-8b43-1a1521ccc253', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-022
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e3d581e6-d661-5c36-8ca0-de11d4164e61', 'm1-algebra-y-funciones-022', '¿Cuáles son las coordenadas del vértice de la parábola de ecuación $y = x^2 - 6x + 5$?', '[{"id":"A","content":"$(-3, 32)$"},{"id":"B","content":"$(3, -4)$"},{"id":"C","content":"$(3, 4)$"},{"id":"D","content":"$(6, 5)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La abscisa del vértice es $x = -\frac{b}{2a} = -\frac{-6}{2 \cdot 1} = 3$, y su ordenada es $3^2 - 6 \cdot 3 + 5 = -4$. El vértice es $(3, -4)$.
A usa $x = \frac{b}{2a}$, sin el signo menos. C calcula bien la abscisa, pero se equivoca en el signo de la ordenada. D usa $x = -\frac{b}{a}$, olvidando el $2$ del denominador.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e3d581e6-d661-5c36-8ca0-de11d4164e61', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-023
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7f18cf8e-357a-53ce-9489-1d1928224c55', 'm1-algebra-y-funciones-023', 'Diego lanza una pelota hacia arriba desde la terraza de su casa en La Serena. La altura $h$, en metros, de la pelota a los $t$ segundos del lanzamiento está dada por $h(t) = -5t^2 + 20t + 1{,}5$.
¿Cuál es la altura máxima que alcanza la pelota?', '[{"id":"A","content":"$1{,}5$ m"},{"id":"B","content":"$20$ m"},{"id":"C","content":"$21{,}5$ m"},{"id":"D","content":"$61{,}5$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El máximo se alcanza en $t = -\frac{20}{2 \cdot (-5)} = 2$ segundos, y la altura es $h(2) = -20 + 40 + 1{,}5 = 21{,}5$ m.
A es la altura inicial $h(0)$ (que también es $h(4)$, valor que se obtiene si se usa $t = -\frac{b}{a}$). B omite la altura desde la que se lanza la pelota. D comete un error de signo y calcula $5 \cdot 4 + 40 + 1{,}5$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7f18cf8e-357a-53ce-9489-1d1928224c55', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-024
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('86f411da-c17e-5c44-9bff-958cd6bc57d3', 'm1-algebra-y-funciones-024', 'En un parque de Temuco se construirá una pasarela con un arco de forma parabólica. En un sistema de coordenadas, $x$ es la distancia horizontal, en metros, desde un extremo del arco, e $y$ es la altura del arco, en metros. Algunas mediciones del plano son:
$\displaystyle \begin{array}{|c|c|c|c|c|c|}\hline x & 0 & 10 & 20 & 30 & 40 \\ \hline y & 0 & 15 & 20 & 15 & 0 \\ \hline \end{array}$
¿Cuál de las siguientes funciones describe la altura del arco?', '[{"id":"A","content":"$y = -\\frac{x^2}{20} + 2x$"},{"id":"B","content":"$y = -\\frac{x^2}{40} + x$"},{"id":"C","content":"$y = -(x - 20)^2 + 20$"},{"id":"D","content":"$y = \\frac{x^2}{20} - 2x$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Los ceros en $x = 0$ y $x = 40$ permiten escribir $y = a\,x(x - 40)$. Con el punto $(20, 20)$: $20 = a \cdot 20 \cdot (-20)$, así que $a = -\frac{1}{20}$ e $y = -\frac{x^2}{20} + 2x$. Se comprueba con $x = 10$: $y = -5 + 20 = 15$.
B tiene los ceros correctos, pero su altura máxima es $10$ m. C tiene el vértice correcto, pero con $a = -1$ da $y = -80$ en $x = 10$. D tiene el signo de $a$ cambiado: se abre hacia arriba y toma valores negativos entre los ceros.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '86f411da-c17e-5c44-9bff-958cd6bc57d3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-025
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3deaa6ac-d952-56e7-8f7c-c2ed379d103c', 'm1-algebra-y-funciones-025', 'Considera la función $f(x) = -2(x - 1)^2 + 8$. ¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"La gráfica de $f$ es una parábola que se abre hacia arriba."},{"id":"B","content":"El vértice de la gráfica de $f$ es el punto $(-1, 8)$."},{"id":"C","content":"El valor máximo de $f$ es $8$ y su gráfica corta al eje $X$ en $x = -1$ y en $x = 3$."},{"id":"D","content":"La gráfica de $f$ intersecta al eje $Y$ en el punto $(0, 8)$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Como el coeficiente $-2$ es negativo, la parábola se abre hacia abajo y su vértice $(1, 8)$ es un máximo. Los ceros cumplen $(x - 1)^2 = 4$, es decir, $x = -1$ o $x = 3$. Por lo tanto, C es verdadera.
A ignora el signo de $-2$. B cambia el signo de la abscisa del vértice (en $(x - h)^2$ el vértice está en $x = h$). D confunde el valor máximo con el intercepto: $f(0) = -2 + 8 = 6$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3deaa6ac-d952-56e7-8f7c-c2ed379d103c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-026
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('748ec413-1dc4-5243-8a30-9f0c59ae093d', 'm1-algebra-y-funciones-026', 'Matías y Sofía juntaron dinero para la once de su curso en Talca. Matías aportó $2\,000$ pesos más que el triple de lo que aportó Sofía, y entre los dos reunieron $26\,000$ pesos.
¿Cuánto dinero aportó Sofía?', '[{"id":"A","content":"$6\\,000$ pesos"},{"id":"B","content":"$6\\,500$ pesos"},{"id":"C","content":"$7\\,000$ pesos"},{"id":"D","content":"$8\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Si Sofía aportó $x$ pesos, Matías aportó $3x + 2\,000$. Entonces $x + 3x + 2\,000 = 26\,000$, es decir, $4x = 24\,000$ y $x = 6\,000$.
B divide $26\,000$ por $4$ sin descontar los $2\,000$ pesos. C suma los $2\,000$ en lugar de restarlos: $(26\,000 + 2\,000) : 4$.
D plantea $3x + 2\,000 = 26\,000$, olvidando sumar el aporte de Sofía.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '748ec413-1dc4-5243-8a30-9f0c59ae093d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-027
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6e700acb-dbbc-5dc9-b283-2be1db37005d', 'm1-algebra-y-funciones-027', 'Fernanda tiene en Arica un plan de telefonía móvil que cuesta $13\,000$ pesos al mes. Cuando se le acaban los datos del plan, puede comprar gigas adicionales a $1\,500$ pesos cada uno.
Si este mes no quiere gastar más de $25\,000$ pesos en total, ¿cuál es la mayor cantidad de gigas adicionales que puede comprar?', '[{"id":"A","content":"$7$"},{"id":"B","content":"$8$"},{"id":"C","content":"$16$"},{"id":"D","content":"$17$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Con $g$ gigas adicionales el gasto es $13\,000 + 1\,500g$, y debe cumplirse $13\,000 + 1\,500g \leq 25\,000$.
Luego $1\,500g \leq 12\,000$, es decir, $g \leq 8$. Como gastar exactamente $25\,000$ pesos está permitido, el máximo es $8$.
A usa la desigualdad estricta ($<$), que excluye el caso de gastar justo $25\,000$ pesos.
C y D olvidan el costo fijo del plan: $25\,000 : 1\,500 \approx 16{,}7$, y truncan o redondean ese valor.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6e700acb-dbbc-5dc9-b283-2be1db37005d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-028
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b0192e88-555b-5f84-a786-c620f35f51ab', 'm1-algebra-y-funciones-028', 'En la asignatura de Historia, Martina tiene tres notas: $4{,}8$, $6{,}1$ y $5{,}2$. Le falta una cuarta nota, $x$, y las cuatro notas tienen la misma ponderación.
Si Martina quiere terminar con un promedio de al menos $5{,}5$, ¿cuál de las siguientes inecuaciones permite determinar los valores posibles de $x$?', '[{"id":"A","content":"$\\displaystyle \\frac{4{,}8 + 6{,}1 + 5{,}2 + x}{4} \\geq 5{,}5$"},{"id":"B","content":"$\\displaystyle \\frac{4{,}8 + 6{,}1 + 5{,}2 + x}{4} \\leq 5{,}5$"},{"id":"C","content":"$\\displaystyle \\frac{4{,}8 + 6{,}1 + 5{,}2}{3} + x \\geq 5{,}5$"},{"id":"D","content":"$\\displaystyle 4{,}8 + 6{,}1 + 5{,}2 + \\frac{x}{4} \\geq 5{,}5$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El promedio de las cuatro notas es la suma de ellas dividida por $4$, y "al menos $5{,}5$" significa mayor o igual que $5{,}5$. Eso es la opción A, cuya solución es $x \geq 5{,}9$.
B invierte el sentido de la desigualdad: describe un promedio de a lo más $5{,}5$.
C promedia solo las tres primeras notas y suma $x$ completa, como si la cuarta nota valiera lo mismo que todo el promedio anterior.
D divide por $4$ solo la nota que falta y no la suma completa.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b0192e88-555b-5f84-a786-c620f35f51ab', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-029
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7b74e55c-a3a3-5403-8fd1-504ab5c16ea0', 'm1-algebra-y-funciones-029', 'Ignacia resolvió la ecuación $\displaystyle \frac{x + 1}{2} - \frac{x - 3}{5} = 2$ de la siguiente manera:
Paso 1: multiplicó ambos lados por $10$ y obtuvo $5(x + 1) - 2(x - 3) = 20$.
Paso 2: eliminó los paréntesis y obtuvo $5x + 5 - 2x - 6 = 20$.
Paso 3: redujo los términos semejantes y obtuvo $3x - 1 = 20$.
Paso 4: despejó $x$ y obtuvo $x = 7$.
¿En cuál de los pasos cometió un error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'El Paso 1 es correcto: $10 \cdot \frac{x+1}{2} = 5(x+1)$, $10 \cdot \frac{x-3}{5} = 2(x-3)$ y $10 \cdot 2 = 20$.
En el Paso 2, $-2(x - 3) = -2x + 6$, no $-2x - 6$: el signo menos debe multiplicar también al $-3$. Lo correcto es $5x + 5 - 2x + 6 = 20$, es decir, $3x + 11 = 20$ y $x = 3$.
Los Pasos 3 y 4 son algebraicamente coherentes con lo que se escribió antes ($3x - 1 = 20$ da $x = 7$), por lo que no contienen un error nuevo; el resultado es incorrecto solo por arrastrar el error del Paso 2.
Comprobación: con $x = 3$, $\frac{4}{2} - \frac{0}{5} = 2$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7b74e55c-a3a3-5403-8fd1-504ab5c16ea0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-030
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7b9bc0ef-8729-5e63-a523-3d4220747fe7', 'm1-algebra-y-funciones-030', 'En una estación de servicio de Los Ángeles, el precio que se paga por la bencina es directamente proporcional a la cantidad de litros cargados. Por $12$ litros, Cristóbal pagó $15\,480$ pesos.
¿Cuánto pagará por $30$ litros de la misma bencina?', '[{"id":"A","content":"$6\\,192$ pesos"},{"id":"B","content":"$33\\,480$ pesos"},{"id":"C","content":"$38\\,700$ pesos"},{"id":"D","content":"$46\\,440$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El precio por litro es $15\,480 : 12 = 1\,290$ pesos, así que $30$ litros cuestan $30 \cdot 1\,290 = 38\,700$ pesos.
A trata la relación como inversa: $15\,480 \cdot 12 : 30 = 6\,192$.
B redondea el precio a $1\,000$ pesos por cada uno de los $18$ litros adicionales: $15\,480 + 18\,000$.
D triplica el precio, como si $30$ litros fueran el triple de $12$ (en realidad son $2{,}5$ veces).', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7b9bc0ef-8729-5e63-a523-3d4220747fe7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-031
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1253cd99-ceb4-51ec-a646-efac50d18e3b', 'm1-algebra-y-funciones-031', 'Para llenar el estanque de riego de una parcela en Melipilla se usan $k$ llaves iguales, todas abiertas al mismo tiempo y con el mismo caudal. El tiempo $t$, en horas, que demora en llenarse el estanque se modela con la función $\displaystyle t(k) = \frac{36}{k}$.
¿Qué representa el número $36$ en este modelo?', '[{"id":"A","content":"El tiempo, en horas, que demora una sola llave en llenar el estanque."},{"id":"B","content":"La cantidad de llaves que se usan para llenar el estanque."},{"id":"C","content":"El tiempo, en horas, que demoran $k$ llaves en llenar el estanque."},{"id":"D","content":"La cantidad de horas que disminuye el tiempo de llenado por cada llave que se agrega."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El tiempo y la cantidad de llaves son inversamente proporcionales, y $36 = k \cdot t$ es la constante de proporcionalidad. Con $k = 1$ se obtiene $t(1) = 36$: es el tiempo que demora una sola llave.
B confunde la constante con la variable $k$. C describe $t(k)$, no el número $36$.
D supone una disminución constante, propia de un modelo afín; aquí la disminución no es fija (de $1$ a $2$ llaves baja $18$ horas, pero de $2$ a $3$ llaves baja solo $6$ horas).', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1253cd99-ceb4-51ec-a646-efac50d18e3b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-032
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3b6b3c97-7cc8-574c-b28b-27fd118fea8c', 'm1-algebra-y-funciones-032', 'Un camión de reparto recorre siempre el mismo tramo de carretera entre dos ciudades del norte de Chile. El tiempo que demora es inversamente proporcional a la rapidez constante con que viaja. La tabla muestra algunos valores:
$\displaystyle \begin{array}{|c|c|}\hline \text{Rapidez (km/h)} & \text{Tiempo (h)} \\ \hline 30 & 4 \\ \hline 40 & 3 \\ \hline 60 & p \\ \hline q & 1{,}5 \\ \hline \end{array}$
¿Cuáles son los valores de $p$ y $q$?', '[{"id":"A","content":"$p = 1$ y $q = 55$"},{"id":"B","content":"$p = 2$ y $q = 45$"},{"id":"C","content":"$p = 2$ y $q = 80$"},{"id":"D","content":"$p = 8$ y $q = 11{,}25$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'En una proporcionalidad inversa el producto es constante: $30 \cdot 4 = 40 \cdot 3 = 120$. Entonces $60 \cdot p = 120$, con $p = 2$, y $q \cdot 1{,}5 = 120$, con $q = 80$.
A supone que el tiempo baja $1$ hora por cada $10$ km/h, como en una relación afín.
B obtiene bien $p$, pero calcula $q$ multiplicando $30 \cdot 1{,}5$ en lugar de dividir $120 : 1{,}5$.
D trata la relación como directa: $p = 4 \cdot \frac{60}{30} = 8$ y $q = 30 \cdot \frac{1{,}5}{4} = 11{,}25$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3b6b3c97-7cc8-574c-b28b-27fd118fea8c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-033
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d42ad498-7ff6-5e01-a79a-f73c474c8325', 'm1-algebra-y-funciones-033', 'En una imprenta de Concepción, $4$ máquinas iguales, funcionando al mismo ritmo, imprimen $6\,000$ folletos en $3$ horas.
¿Cuántas horas demorarán $6$ máquinas iguales a las anteriores en imprimir $15\,000$ folletos?', '[{"id":"A","content":"$2$"},{"id":"B","content":"$5$"},{"id":"C","content":"$7{,}5$"},{"id":"D","content":"$11{,}25$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Cada máquina imprime $6\,000 : (4 \cdot 3) = 500$ folletos por hora. Las $6$ máquinas imprimen $3\,000$ folletos por hora, así que demoran $15\,000 : 3\,000 = 5$ horas.
A considera solo el aumento de máquinas ($3 \cdot \frac{4}{6} = 2$) y olvida que hay más folletos.
C considera solo el aumento de folletos ($3 \cdot \frac{15\,000}{6\,000} = 7{,}5$) y olvida que hay más máquinas.
D trata la cantidad de máquinas como directamente proporcional al tiempo: $3 \cdot \frac{6}{4} \cdot \frac{15\,000}{6\,000} = 11{,}25$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd42ad498-7ff6-5e01-a79a-f73c474c8325', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-034
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8b5b453e-d206-5733-a669-708e16503959', 'm1-algebra-y-funciones-034', 'Rodrigo comprará un televisor de $360\,000$ pesos en una tienda de Rancagua y lo pagará en $n$ cuotas iguales sin interés, cada una de $v$ pesos.
¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"$n$ y $v$ son directamente proporcionales."},{"id":"B","content":"Cada vez que $n$ aumenta en $1$, el valor $v$ disminuye siempre en el mismo monto."},{"id":"C","content":"Si paga en $12$ cuotas, cada cuota es de $36\\,000$ pesos."},{"id":"D","content":"Si paga en $8$ cuotas en lugar de $4$, el valor de cada cuota se reduce a la mitad."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Se cumple $n \cdot v = 360\,000$, de modo que $n$ y $v$ son inversamente proporcionales. Con $4$ cuotas, $v = 90\,000$; con $8$ cuotas, $v = 45\,000$, que es la mitad. D es verdadera.
A es falsa: al aumentar $n$, $v$ disminuye.
B es falsa: de $4$ a $5$ cuotas, $v$ baja de $90\,000$ a $72\,000$ (baja $18\,000$), y de $5$ a $6$ cuotas baja a $60\,000$ (baja $12\,000$).
C es falsa: $360\,000 : 12 = 30\,000$ pesos.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8b5b453e-d206-5733-a669-708e16503959', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-035
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('720ff401-1a5a-5949-ad5e-6093e39fe8bf', 'm1-algebra-y-funciones-035', '¿Cuál de las siguientes expresiones es igual a $3(2a - b) - 2(a - 4b)$?', '[{"id":"A","content":"$4a - 11b$"},{"id":"B","content":"$4a + b$"},{"id":"C","content":"$4a + 5b$"},{"id":"D","content":"$8a + 5b$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Se distribuye: $3(2a - b) = 6a - 3b$ y $-2(a - 4b) = -2a + 8b$. Sumando, $6a - 3b - 2a + 8b = 4a + 5b$.
A escribe $-2 \cdot (-4b) = -8b$, un error de signo.
B solo cambia el signo de $-4b$ sin multiplicarlo por $2$: $-2a + 4b$.
D escribe $-2 \cdot a = +2a$ y suma $6a + 2a$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '720ff401-1a5a-5949-ad5e-6093e39fe8bf', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-036
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0717a28c-4fb3-55a3-b6e6-db56eb0e35a7', 'm1-algebra-y-funciones-036', 'Un terreno rectangular en Puerto Montt tiene $a$ metros de ancho, y su largo excede en $4$ metros al triple de su ancho.
¿Cuál de las siguientes expresiones representa el perímetro del terreno, en metros?', '[{"id":"A","content":"$4a + 4$"},{"id":"B","content":"$6a + 8$"},{"id":"C","content":"$8a + 4$"},{"id":"D","content":"$8a + 8$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El largo mide $3a + 4$ metros. El perímetro es $2 \cdot a + 2 \cdot (3a + 4) = 2a + 6a + 8 = 8a + 8$.
A suma solo un ancho y un largo ($a + 3a + 4$): es el semiperímetro.
B considera solo los dos largos, $2(3a + 4)$, y olvida los anchos.
C no multiplica el $4$ por $2$: escribe $2a + 2 \cdot 3a + 4$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0717a28c-4fb3-55a3-b6e6-db56eb0e35a7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-037
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8885a1f4-3af3-585b-9efc-4e64ac653543', 'm1-algebra-y-funciones-037', 'Valentina elige un número entero $n$ y calcula la diferencia entre el cuadrado de su sucesor y el cuadrado del número, es decir, $(n + 1)^2 - n^2$.
¿Cuál de las siguientes afirmaciones es verdadera para cualquier número entero $n$?', '[{"id":"A","content":"El resultado es siempre igual a $1$."},{"id":"B","content":"El resultado es siempre un número par."},{"id":"C","content":"El resultado es siempre un múltiplo de $3$."},{"id":"D","content":"El resultado es siempre un número impar."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Al desarrollar, $(n + 1)^2 - n^2 = n^2 + 2n + 1 - n^2 = 2n + 1$, que es un número par más $1$: siempre impar.
A resulta de escribir $(n + 1)^2 = n^2 + 1$, olvidando el término $2n$.
B es falsa: con $n = 1$ se obtiene $3$.
C es falsa: con $n = 2$ se obtiene $5$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8885a1f4-3af3-585b-9efc-4e64ac653543', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-038
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c2f67eb0-ddc9-5c80-90fc-9319a1b7f819', 'm1-algebra-y-funciones-038', 'Constanza imprimió una fotografía de su viaje a San Pedro de Atacama. La fotografía es rectangular y mide $x$ cm de ancho y $(x + 10)$ cm de largo. Para enmarcarla, la rodea con un marco de $4$ cm de ancho en todos sus bordes.
¿Cuál de las siguientes expresiones representa el área del marco, en $\text{cm}^2$?', '[{"id":"A","content":"$8x + 56$"},{"id":"B","content":"$16x + 80$"},{"id":"C","content":"$x^2 + 26x + 144$"},{"id":"D","content":"$16x + 144$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Con el marco, el rectángulo exterior mide $(x + 8)$ cm por $(x + 18)$ cm, porque el marco agrega $4$ cm a cada lado. El área del marco es la diferencia:
$(x + 8)(x + 18) - x(x + 10) = x^2 + 26x + 144 - x^2 - 10x = 16x + 144$.
A agrega solo $4$ cm a cada medida: $(x + 4)(x + 14) - x(x + 10)$.
B multiplica el perímetro de la fotografía por $4$ y olvida los cuatro cuadrados de $4 \times 4$ de las esquinas.
C es el área total del rectángulo exterior, sin restar la fotografía.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c2f67eb0-ddc9-5c80-90fc-9319a1b7f819', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-039
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('46153a12-aabc-56de-bbef-f6a18c19a9a5', 'm1-algebra-y-funciones-039', 'Durante un corte de luz en Castro, Pedro enciende una vela nueva. La altura $h$, en centímetros, de la vela a las $t$ horas de encendida se modela con la función $h(t) = 24 - 1{,}5t$.
¿Qué representa el número $1{,}5$ en este modelo?', '[{"id":"A","content":"La altura inicial de la vela, en centímetros."},{"id":"B","content":"Los centímetros que disminuye la altura de la vela por cada hora."},{"id":"C","content":"Las horas que demora la vela en consumirse por completo."},{"id":"D","content":"La altura de la vela, en centímetros, después de una hora."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'En $h(t) = 24 - 1{,}5t$, la pendiente $-1{,}5$ indica que por cada hora la altura baja $1{,}5$ cm. Por ejemplo, $h(0) = 24$ y $h(1) = 22{,}5$.
A corresponde al coeficiente de posición, $24 = h(0)$.
C sería $16$ horas, el valor de $t$ para el cual $h(t) = 0$.
D sería $h(1) = 22{,}5$ cm, no $1{,}5$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '46153a12-aabc-56de-bbef-f6a18c19a9a5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-040
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7d802e67-f1c9-54f9-b68d-fc5aa61d00ba', 'm1-algebra-y-funciones-040', 'Una academia de natación de Rancagua ofrece dos planes mensuales:
Plan P: $15\,000$ pesos fijos más $800$ pesos por cada clase.
Plan Q: $9\,000$ pesos fijos más $1\,100$ pesos por cada clase.
¿Cuál es la menor cantidad de clases que debe tomar una persona en un mes para que el plan P le resulte más barato que el plan Q?', '[{"id":"A","content":"$4$"},{"id":"B","content":"$20$"},{"id":"C","content":"$21$"},{"id":"D","content":"$30$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Con $x$ clases, los costos son $P(x) = 15\,000 + 800x$ y $Q(x) = 9\,000 + 1\,100x$. El plan P es más barato si $15\,000 + 800x < 9\,000 + 1\,100x$, es decir, $6\,000 < 300x$, o sea, $x > 20$.
La menor cantidad entera de clases es $21$.
B corresponde a $x = 20$, donde ambos planes cuestan lo mismo ($31\,000$ pesos), así que P todavía no es más barato.
A divide $6\,000$ por $800 + 1\,100$, sumando las tarifas por clase en lugar de restarlas.
D divide el cargo fijo del plan Q por la diferencia de tarifas: $9\,000 : 300$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7d802e67-f1c9-54f9-b68d-fc5aa61d00ba', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-041
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('750bf038-dcd6-5bda-aaa5-60d8cf15ba28', 'm1-algebra-y-funciones-041', 'En Copiapó, el cobro mensual de agua potable de una vivienda es una función afín de la cantidad $x$ de metros cúbicos consumidos. La tabla muestra el cobro para algunos consumos:
$\displaystyle \begin{array}{|c|c|}\hline \text{Consumo } (\text{m}^3) & \text{Cobro (pesos)} \\ \hline 10 & 13\,400 \\ \hline 15 & 18\,900 \\ \hline 20 & 24\,400 \\ \hline \end{array}$
¿Cuál de las siguientes funciones representa el cobro $f(x)$, en pesos?', '[{"id":"A","content":"$f(x) = 1\\,100x + 2\\,400$"},{"id":"B","content":"$f(x) = 1\\,340x$"},{"id":"C","content":"$f(x) = 2\\,400x + 1\\,100$"},{"id":"D","content":"$f(x) = 5\\,500x + 2\\,400$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Al aumentar el consumo en $5\ \text{m}^3$, el cobro aumenta $5\,500$ pesos, así que la pendiente es $5\,500 : 5 = 1\,100$ pesos por $\text{m}^3$. El cargo fijo es $13\,400 - 10 \cdot 1\,100 = 2\,400$. Luego $f(x) = 1\,100x + 2\,400$.
B usa solo el primer dato, $13\,400 : 10$, como si la relación fuera proporcional; no cumple $f(15) = 18\,900$.
C intercambia la pendiente con el coeficiente de posición.
D toma como pendiente el aumento por cada $5\ \text{m}^3$ en lugar del aumento por cada $\text{m}^3$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '750bf038-dcd6-5bda-aaa5-60d8cf15ba28', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-042
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9d2ffc13-7c1c-51ab-a543-13717aece9f8', 'm1-algebra-y-funciones-042', 'Josefina cercará un corral rectangular para gallinas en su parcela de Quillota. Uno de los lados del corral será un muro que ya existe, y para los otros tres lados usará $60$ m de malla. Si $x$ es la medida, en metros, de cada uno de los dos lados perpendiculares al muro, el área del corral, en $\text{m}^2$, está dada por $A(x) = x(60 - 2x)$.
¿Cuál es el área máxima que puede tener el corral?', '[{"id":"A","content":"$225\\ \\text{m}^2$"},{"id":"B","content":"$400\\ \\text{m}^2$"},{"id":"C","content":"$450\\ \\text{m}^2$"},{"id":"D","content":"$675\\ \\text{m}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, '$A(x) = -2x^2 + 60x$ es una parábola que se abre hacia abajo; su vértice está en $x = \frac{-60}{2 \cdot (-2)} = 15$ (el punto medio entre los ceros $0$ y $30$). El área máxima es $A(15) = 15 \cdot 30 = 450\ \text{m}^2$.
A supone un corral cuadrado cercado por los cuatro lados: $15 \cdot 15$.
B reparte la malla en tres lados iguales de $20$ m: $A(20) = 20 \cdot 20 = 400$, que no es el máximo.
D usa $x = 15$ pero calcula el largo como $60 - x = 45$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9d2ffc13-7c1c-51ab-a543-13717aece9f8', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-043
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5e0e7e86-129b-5601-97ec-e1c0f8a56901', 'm1-algebra-y-funciones-043', 'En una corrida familiar en Valdivia, el recorrido total de $9{,}5$ km se divide en tres tramos. El segundo tramo mide $1{,}5$ km más que el primero, y el tercer tramo mide el doble que el primero.

¿Cuántos kilómetros mide el tercer tramo?', '[{"id":"A","content":"$2$"},{"id":"B","content":"$3{,}5$"},{"id":"C","content":"$4$"},{"id":"D","content":"$5{,}5$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Si el primer tramo mide $x$ km, entonces $x + (x + 1{,}5) + 2x = 9{,}5$, es decir, $4x = 8$ y $x = 2$. El tercer tramo mide $2 \cdot 2 = 4$ km.
A es la medida del primer tramo.
B es la medida del segundo tramo.
D toma el tercer tramo como el doble del segundo: $x + (x + 1{,}5) + 2(x + 1{,}5) = 9{,}5$ da $x = 1{,}25$ y un tercer tramo de $5{,}5$ km.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5e0e7e86-129b-5601-97ec-e1c0f8a56901', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-044
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('11ee23ae-ba86-5176-a4ef-60a007429f59', 'm1-algebra-y-funciones-044', 'En un vivero de Limache, Rocío tiene $x$ maceteros. Si duplica la cantidad de maceteros que tiene y luego regala $7$, le quedan al menos $15$ maceteros.

¿Cuál de las siguientes inecuaciones representa esta situación?', '[{"id":"A","content":"$2(x - 7) \\geq 15$"},{"id":"B","content":"$2x - 7 > 15$"},{"id":"C","content":"$2x - 7 \\leq 15$"},{"id":"D","content":"$2x - 7 \\geq 15$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Al duplicar tiene $2x$ maceteros; al regalar $7$ le quedan $2x - 7$. "Al menos $15$" significa mayor o igual que $15$: $2x - 7 \geq 15$.
A resta los $7$ antes de duplicar, invirtiendo el orden de las acciones.
B usa la desigualdad estricta, que excluye el caso en que le quedan exactamente $15$.
C interpreta "al menos" como "a lo más".', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '11ee23ae-ba86-5176-a4ef-60a007429f59', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m1-algebra-y-funciones-045
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8a17b1cf-9618-51f7-8222-e502f6d2ce88', 'm1-algebra-y-funciones-045', 'Una impresora 3D de un liceo técnico de Talcahuano consume filamento a un ritmo constante: en $3$ horas de trabajo usa $45$ g de filamento.

¿Cuántos gramos de filamento usará en $8$ horas de trabajo?', '[{"id":"A","content":"$15$"},{"id":"B","content":"$50$"},{"id":"C","content":"$53$"},{"id":"D","content":"$120$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El consumo es directamente proporcional al tiempo: usa $45 : 3 = 15$ g por hora, así que en $8$ horas usa $15 \cdot 8 = 120$ g.
A es el consumo en una sola hora.
B suma a $45$ g la diferencia de horas, $8 - 3 = 5$, como si cada hora extra consumiera $1$ g.
C suma $8$ a $45$, mezclando horas con gramos.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8a17b1cf-9618-51f7-8222-e502f6d2ce88', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-046
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8d371ea1-bd20-5113-9095-bdd217710255', 'm1-algebra-y-funciones-046', 'Una estudiante de arquitectura de La Serena construye la maqueta de un edificio a escala $1 : 250$, es decir, cada longitud de la maqueta es $250$ veces menor que la longitud real correspondiente.

Si la altura real del edificio es $h$ metros, ¿cuál de las siguientes expresiones representa la altura de la maqueta, en centímetros?', '[{"id":"A","content":"$\\frac{h}{250}$"},{"id":"B","content":"$0{,}4h$"},{"id":"C","content":"$2{,}5h$"},{"id":"D","content":"$250h$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La altura real en centímetros es $100h$. En la maqueta se divide por $250$: $\frac{100h}{250} = 0{,}4h$ cm. Por ejemplo, un edificio de $50$ m mide $20$ cm en la maqueta.
A divide por $250$ pero deja el resultado en metros.
C invierte la razón: calcula $\frac{250}{100}h$.
D multiplica por $250$ en lugar de dividir.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8d371ea1-bd20-5113-9095-bdd217710255', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m1-algebra-y-funciones-047
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3b0ebc4a-1c60-5364-a18e-0f6e2543379a', 'm1-algebra-y-funciones-047', 'Si $a + b = 7$ y $a \cdot b = 10$, ¿cuál es el valor de $a^{2} + b^{2}$?', '[{"id":"A","content":"$29$"},{"id":"B","content":"$39$"},{"id":"C","content":"$49$"},{"id":"D","content":"$69$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Como $(a + b)^{2} = a^{2} + 2ab + b^{2}$, se tiene $a^{2} + b^{2} = (a + b)^{2} - 2ab = 49 - 20 = 29$. Se puede comprobar con $a = 5$ y $b = 2$: $25 + 4 = 29$.
B resta $ab$ una sola vez, olvidando el factor $2$ del término central.
C supone que $(a + b)^{2} = a^{2} + b^{2}$.
D suma $2ab$ en lugar de restarlo.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3b0ebc4a-1c60-5364-a18e-0f6e2543379a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-048
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('814e2076-d5ad-535d-b05b-9cee6bb4b484', 'm1-algebra-y-funciones-048', 'Mariana quiere factorizar la expresión $9a^{2} - 16 - (3a + 4)(a - 2)$ y realiza el siguiente desarrollo, en el que comete un error:
Paso 1: $(3a + 4)(3a - 4) - (3a + 4)(a - 2)$
Paso 2: $(3a + 4)\left[(3a - 4) - (a - 2)\right]$
Paso 3: $(3a + 4)(3a - 4 - a - 2)$
Paso 4: $(3a + 4)(2a - 6) = 2(3a + 4)(a - 3)$

¿En cuál de los pasos se cometió el error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'El Paso 1 es correcto, porque $9a^{2} - 16 = (3a + 4)(3a - 4)$ es una suma por diferencia. El Paso 2 es correcto: se factoriza el término común $(3a + 4)$.
En el Paso 3, al eliminar el paréntesis precedido de un signo menos, debía cambiar el signo de ambos términos: $(3a - 4) - (a - 2) = 3a - 4 - a + 2 = 2a - 2$. Mariana escribió $-2$ en lugar de $+2$.
El Paso 4 reduce correctamente lo que se obtuvo en el Paso 3. La factorización correcta es $2(3a + 4)(a - 1)$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '814e2076-d5ad-535d-b05b-9cee6bb4b484', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m1-algebra-y-funciones-049
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b7177410-6aa8-5d23-bf5e-1e4e92ae7295', 'm1-algebra-y-funciones-049', 'Sofía, que vive en Osorno, abrió un saco nuevo de alimento para su perro. La cantidad de alimento que queda en el saco, en kilogramos, $d$ días después de abrirlo se modela con la función $A(d) = 15 - 0{,}4d$.

¿Qué representa el número $0{,}4$ en este modelo?', '[{"id":"A","content":"La cantidad de kilogramos de alimento que tenía el saco al abrirlo."},{"id":"B","content":"La cantidad de kilogramos de alimento que come el perro cada día."},{"id":"C","content":"La cantidad de días que dura el saco de alimento."},{"id":"D","content":"La cantidad de kilogramos de alimento que quedan en el saco después de $15$ días."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'El $0{,}4$ es la pendiente (con signo negativo): cada día que pasa, la cantidad de alimento disminuye $0{,}4$ kg, que es lo que come el perro diariamente.
A corresponde al $15$, que es $A(0)$.
C confunde la pendiente con la duración del saco, que es $15 : 0{,}4 = 37{,}5$ días.
D confunde la pendiente con $A(15) = 15 - 6 = 9$ kg.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b7177410-6aa8-5d23-bf5e-1e4e92ae7295', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-050
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('66d723f7-a666-53c0-b227-8c3c80e64cfb', 'm1-algebra-y-funciones-050', 'La gráfica de una función afín $f$ es una recta que pasa por los puntos $(-2,\ 7)$ y $(4,\ -2)$.

¿En qué punto la gráfica de $f$ intersecta al eje $Y$?', '[{"id":"A","content":"$(0,\\ 4)$"},{"id":"B","content":"$\\left(0,\\ \\frac{17}{3}\\right)$"},{"id":"C","content":"$(0,\\ 10)$"},{"id":"D","content":"$\\left(\\frac{8}{3},\\ 0\\right)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La pendiente es $m = \frac{-2 - 7}{4 - (-2)} = \frac{-9}{6} = -\frac{3}{2}$. Desde $(-2,\ 7)$, al avanzar $2$ unidades hasta $x = 0$, la función baja $3$: $f(0) = 7 - 3 = 4$. El punto es $(0,\ 4)$.
B invierte la pendiente ($-\frac{2}{3}$): $7 - \frac{4}{3} = \frac{17}{3}$.
C usa la pendiente con el signo cambiado: $7 + 3 = 10$.
D es la intersección con el eje $X$, ya que $f(x) = -\frac{3}{2}x + 4$ se anula en $x = \frac{8}{3}$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '66d723f7-a666-53c0-b227-8c3c80e64cfb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m1-algebra-y-funciones-051
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('071fe83b-8c05-5bd3-a89a-2991d3e8123b', 'm1-algebra-y-funciones-051', 'Una emprendedora de Coyhaique vende frascos de mermelada de calafate. Su ganancia semanal $G$, en miles de pesos, cuando vende cada frasco a $x$ miles de pesos, se modela con la función $G(x) = -30x^{2} + 360x - 600$.

¿Cuál es la ganancia semanal máxima que puede obtener, en miles de pesos?', '[{"id":"A","content":"$-600$"},{"id":"B","content":"$6$"},{"id":"C","content":"$210$"},{"id":"D","content":"$480$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Como el coeficiente de $x^{2}$ es negativo, la ganancia máxima está en el vértice: $x = -\frac{360}{2 \cdot (-30)} = 6$. Entonces $G(6) = -30 \cdot 36 + 360 \cdot 6 - 600 = -1\,080 + 2\,160 - 600 = 480$.
A calcula la abscisa como $-\frac{b}{a} = 12$, olvidando el $2$ del denominador: $G(12) = -600$.
B es el precio que maximiza la ganancia, no la ganancia máxima.
C evalúa en $x = 3$, la mitad de la abscisa del vértice: $G(3) = 210$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '071fe83b-8c05-5bd3-a89a-2991d3e8123b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-052
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a1936af0-a0ef-5a28-885c-cefe3cd32d59', 'm1-algebra-y-funciones-052', 'Sea $f(x) = ax^{2} + bx + c$ una función cuadrática, con $a$, $b$ y $c$ números reales tales que $a > 0$ y $c < 0$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"El vértice de la parábola está en el cuarto cuadrante."},{"id":"B","content":"La parábola intersecta al eje $X$ en dos puntos distintos."},{"id":"C","content":"La función $f$ alcanza un valor máximo."},{"id":"D","content":"El eje de simetría de la parábola es una recta $x = k$, con $k > 0$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Como $f(0) = c < 0$, la parábola pasa por un punto bajo el eje $X$, y como $a > 0$, se abre hacia arriba; por lo tanto, corta al eje $X$ en dos puntos. Equivalentemente, el discriminante $b^{2} - 4ac$ es positivo, pues $-4ac > 0$.
A y D son falsas: $f(x) = x^{2} + 4x - 1$ cumple las condiciones y su vértice es $(-2,\ -5)$, en el tercer cuadrante, con eje de simetría $x = -2$.
C es falsa: con $a > 0$ la función alcanza un mínimo, no un máximo.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a1936af0-a0ef-5a28-885c-cefe3cd32d59', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m1-algebra-y-funciones-053
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4a86390d-b126-5f1c-ae80-dba45b9aa808', 'm1-algebra-y-funciones-053', 'En una fiesta costumbrista de Chillán, todos los platos de paila marina tienen el mismo precio y todos los vasos de mote con huesillo también. La familia Rojas pagó $28\,500$ pesos por $4$ pailas marinas y $3$ motes con huesillo, y la familia Millán pagó $31\,000$ pesos por $3$ pailas marinas y $5$ motes con huesillo.

¿Cuántos pesos más cuesta una paila marina que un mote con huesillo?', '[{"id":"A","content":"$1\\,000$"},{"id":"B","content":"$2\\,500$"},{"id":"C","content":"$3\\,500$"},{"id":"D","content":"$4\\,500$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Sean $p$ el precio de una paila y $m$ el de un mote: $4p + 3m = 28\,500$ y $3p + 5m = 31\,000$. Multiplicando la primera por $5$ y la segunda por $3$ y restando: $20p - 9p = 142\,500 - 93\,000$, es decir, $11p = 49\,500$ y $p = 4\,500$. Luego $3m = 28\,500 - 18\,000$, así que $m = 3\,500$. La diferencia es $1\,000$ pesos.
B resta los totales pagados por las familias, que corresponden a cantidades distintas de productos.
C es el precio de un mote con huesillo.
D es el precio de una paila marina.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4a86390d-b126-5f1c-ae80-dba45b9aa808', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm1' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m1-geometria-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3ee9c05b-468a-5414-94df-b0a4a0508dbc', 'm1-geometria-001', 'Catalina quiere cercar completamente su huerto en Puerto Montt, que tiene forma rectangular de $12$ m de largo y $7{,}5$ m de ancho. ¿Cuántos metros de malla necesita, como mínimo, para rodear todo el borde del huerto?', '[{"id":"A","content":"$19{,}5$ m"},{"id":"B","content":"$31{,}5$ m"},{"id":"C","content":"$39$ m"},{"id":"D","content":"$90$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Para rodear el huerto se necesita su perímetro: $2 \cdot (12 + 7{,}5) = 2 \cdot 19{,}5 = 39$ m.
A suma solo el largo y el ancho una vez, olvidando que cada lado se repite. B olvida uno de los anchos ($12 + 12 + 7{,}5$). D calcula el área ($12 \cdot 7{,}5 = 90$), que mide superficie y no longitud.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3ee9c05b-468a-5414-94df-b0a4a0508dbc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('257bb861-3622-584e-955c-ae7a8dc339c7', 'm1-geometria-002', 'Ignacio va a pintar la fachada de su casa en Valdivia. Apoya una escalera recta de $6{,}5$ m de largo contra la pared vertical, de modo que el pie de la escalera queda sobre el suelo horizontal a $2{,}5$ m de la base de la pared. ¿A qué altura de la pared llega el extremo superior de la escalera?', '[{"id":"A","content":"$4$ m"},{"id":"B","content":"$6$ m"},{"id":"C","content":"$9$ m"},{"id":"D","content":"$36$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La pared, el suelo y la escalera forman un triángulo rectángulo cuya hipotenusa es la escalera. Por el teorema de Pitágoras: $h^2 = 6{,}5^2 - 2{,}5^2 = 42{,}25 - 6{,}25 = 36$, de donde $h = 6$ m.
A resta directamente las longitudes ($6{,}5 - 2{,}5$) sin elevar al cuadrado. C las suma. D olvida extraer la raíz cuadrada al final.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '257bb861-3622-584e-955c-ae7a8dc339c7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8be7cc5a-bf6b-5525-8a2b-f24922432ff6', 'm1-geometria-003', 'En el plano cartesiano se dibuja el triángulo de vértices $A(1, 1)$, $B(7, 1)$ y $C(4, 5)$. ¿Cuál es el área de este triángulo, en unidades cuadradas?', '[{"id":"A","content":"$12$"},{"id":"B","content":"$15$"},{"id":"C","content":"$16$"},{"id":"D","content":"$24$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El lado $AB$ es horizontal y mide $7 - 1 = 6$. La altura correspondiente es la distancia vertical de $C$ a la recta $y = 1$, es decir, $5 - 1 = 4$. El área es $\frac{6 \cdot 4}{2} = 12$.
B usa como altura el lado inclinado $AC = \sqrt{3^2 + 4^2} = 5$, que no es perpendicular a la base. C corresponde al perímetro ($6 + 5 + 5 = 16$). D olvida dividir por $2$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8be7cc5a-bf6b-5525-8a2b-f24922432ff6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e74d19d7-59eb-586d-ae6d-81249110529c', 'm1-geometria-004', 'Una plaza circular en Rancagua tiene $20$ m de diámetro. En su centro hay una pileta circular de $3$ m de radio. La municipalidad cubrirá con pasto toda la plaza, excepto la pileta. Si el área de un círculo de radio $r$ es $\pi r^2$, ¿cuál es el área que se cubrirá con pasto?', '[{"id":"A","content":"$91\\pi$ m²"},{"id":"B","content":"$94\\pi$ m²"},{"id":"C","content":"$97\\pi$ m²"},{"id":"D","content":"$391\\pi$ m²"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El radio de la plaza es $20 : 2 = 10$ m, así que su área es $\pi \cdot 10^2 = 100\pi$ m². La pileta tiene área $\pi \cdot 3^2 = 9\pi$ m². El área con pasto es $100\pi - 9\pi = 91\pi$ m².
B resta $2\pi \cdot 3 = 6\pi$, que es el perímetro de la pileta y no su área. C resta $3\pi$, olvidando elevar el radio al cuadrado. D usa el diámetro $20$ como si fuera el radio ($400\pi - 9\pi$).', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e74d19d7-59eb-586d-ae6d-81249110529c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5ab1addd-da38-554a-bae7-9a4f16dfaa07', 'm1-geometria-005', 'Un cuadrado tiene una diagonal que mide $8$ cm. ¿Cuál de las siguientes afirmaciones sobre este cuadrado es verdadera?', '[{"id":"A","content":"Su lado mide $4$ cm."},{"id":"B","content":"Su perímetro mide $32$ cm."},{"id":"C","content":"Su área mide $64$ cm²."},{"id":"D","content":"Su área mide $32$ cm²."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Si el lado es $a$, por Pitágoras $a^2 + a^2 = 8^2$, es decir, $2a^2 = 64$ y $a^2 = 32$. Por lo tanto, el área es $32$ cm² y el lado es $\sqrt{32} = 4\sqrt{2}$ cm.
A toma la mitad de la diagonal como lado. B multiplica la diagonal por $4$, como si la diagonal fuera el lado. C eleva la diagonal al cuadrado en lugar del lado. El perímetro correcto es $16\sqrt{2} \approx 22{,}6$ cm.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5ab1addd-da38-554a-bae7-9a4f16dfaa07', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8d98539a-f0ad-5e4e-a3ec-f30a4c0da3f0', 'm1-geometria-006', 'Tomás, carpintero de Chillán, debe calcular el área de la cubierta de una mesa con forma de trapecio isósceles. Sus bases miden $16$ cm y $10$ cm (en una maqueta) y cada lado no paralelo mide $5$ cm. Su procedimiento es el siguiente:

Paso 1: Cada lado no paralelo sobresale $\frac{16 - 10}{2} = 3$ cm respecto de la base menor.
Paso 2: La altura $h$ cumple $h^2 = 5^2 + 3^2 = 34$, por lo que $h = \sqrt{34}$ cm.
Paso 3: El área es $\frac{16 + 10}{2} \cdot h = 13h$.
Paso 4: El área es $13\sqrt{34}$ cm².

¿En cuál paso cometió Tomás el primer error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Al trazar la altura desde un extremo de la base menor se forma un triángulo rectángulo cuya hipotenusa es el lado no paralelo ($5$ cm) y uno de sus catetos es $3$ cm. Entonces $h^2 = 5^2 - 3^2 = 16$ y $h = 4$ cm; Tomás sumó los cuadrados en vez de restarlos, así que el error está en el paso 2.
El paso 1 es correcto, y los pasos 3 y 4 usan bien la fórmula del trapecio, aunque arrastran el valor erróneo de $h$. El área correcta es $13 \cdot 4 = 52$ cm².', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8d98539a-f0ad-5e4e-a3ec-f30a4c0da3f0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b9ef10be-7c78-567a-87c5-1d09a5464b06', 'm1-geometria-007', 'Julieta tiene un terreno en Coquimbo con forma de L. En un plano con unidades en metros, sus vértices, en orden, son $(0, 0)$, $(10, 0)$, $(10, 4)$, $(4, 4)$, $(4, 9)$ y $(0, 9)$, y sus lados son los segmentos que unen vértices consecutivos (el último con el primero). ¿Cuántos metros de cerca necesita para rodear todo el terreno?', '[{"id":"A","content":"$19$ m"},{"id":"B","content":"$27$ m"},{"id":"C","content":"$38$ m"},{"id":"D","content":"$60$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los lados miden: $10$, $4$, $10 - 4 = 6$, $9 - 4 = 5$, $4$ y $9$. El perímetro es $10 + 4 + 6 + 5 + 4 + 9 = 38$ m.
A es la mitad del perímetro. B omite los dos tramos interiores de la L ($6$ m y $5$ m). D corresponde al área del terreno ($10 \cdot 4 + 4 \cdot 5 = 60$ m²), no a la longitud del borde.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b9ef10be-7c78-567a-87c5-1d09a5464b06', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c02fa6e9-8cd8-5c01-8517-a876af7c7043', 'm1-geometria-008', 'Benjamín compró un acuario con forma de paralelepípedo recto de $60$ cm de largo, $30$ cm de ancho y $40$ cm de alto. Si $1$ litro equivale a $1\,000$ cm³, ¿cuántos litros de agua caben en el acuario completamente lleno?', '[{"id":"A","content":"$0{,}72$ L"},{"id":"B","content":"$7{,}2$ L"},{"id":"C","content":"$72$ L"},{"id":"D","content":"$720$ L"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El volumen es $60 \cdot 30 \cdot 40 = 72\,000$ cm³. Como $1$ L $= 1\,000$ cm³, caben $72\,000 : 1\,000 = 72$ L.
Las demás alternativas provienen de errores de conversión: D divide por $100$, B divide por $10\,000$ y A divide por $100\,000$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c02fa6e9-8cd8-5c01-8517-a876af7c7043', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a7b3797f-92c0-5588-a1c2-86bd09672e35', 'm1-geometria-009', 'En una parcela cerca de Ovalle se quiere fabricar un estanque cilíndrico para agua de riego, cuya base tenga $60$ cm de diámetro y que pueda contener exactamente $226{,}08$ litros cuando está lleno. El volumen de un cilindro es $V = \pi r^2 h$, donde $r$ es el radio de la base y $h$ la altura. Considerando $\pi \approx 3{,}14$ y que $1$ L $= 1\,000$ cm³, ¿qué altura debe tener el estanque?', '[{"id":"A","content":"$8$ cm"},{"id":"B","content":"$20$ cm"},{"id":"C","content":"$80$ cm"},{"id":"D","content":"$320$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El volumen es $226{,}08$ L $= 226\,080$ cm³ y el radio es $60 : 2 = 30$ cm. De $V = \pi r^2 h$ se despeja $h = \frac{V}{\pi r^2} = \frac{226\,080}{3{,}14 \cdot 900} = \frac{226\,080}{2\,826} = 80$ cm.
A convierte mal los litros ($22\,608$ cm³ en lugar de $226\,080$). B usa el diámetro $60$ como si fuera el radio. D divide el diámetro dos veces y usa $r = 15$ cm.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a7b3797f-92c0-5588-a1c2-86bd09672e35', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('919be550-ad60-572a-84a4-715336ebbeec', 'm1-geometria-010', 'El área total de la superficie de un cubo es $150$ cm². ¿Cuál es su volumen?', '[{"id":"A","content":"$5$ cm³"},{"id":"B","content":"$25$ cm³"},{"id":"C","content":"$125$ cm³"},{"id":"D","content":"$15\\,625$ cm³"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Un cubo tiene $6$ caras cuadradas iguales, así que cada cara mide $150 : 6 = 25$ cm². Su arista es $\sqrt{25} = 5$ cm y su volumen es $5^3 = 125$ cm³.
A confunde la arista con el volumen. B da el área de una cara. D toma $25$ como si fuera la arista y calcula $25^3$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '919be550-ad60-572a-84a4-715336ebbeec', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9f70a3f2-5f91-5d54-809e-9eff703f7946', 'm1-geometria-011', 'Una fábrica de conservas de Talcahuano envasa en latas cilíndricas. Para un nuevo formato se duplica el radio de la base de la lata y la altura se reduce a la mitad. Sofía, del área de diseño, afirma: «Como una medida se duplica y la otra se reduce a la mitad, el volumen de la lata se mantiene igual».

Si el volumen de un cilindro es $V = \pi r^2 h$, ¿cuál de las siguientes afirmaciones es correcta respecto del volumen de la nueva lata comparado con el de la original?', '[{"id":"A","content":"Se reduce a la mitad."},{"id":"B","content":"Se mantiene igual, como dice Sofía."},{"id":"C","content":"Se duplica."},{"id":"D","content":"Se cuadruplica."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Con radio $2r$ y altura $\frac{h}{2}$: $V'' = \pi (2r)^2 \cdot \frac{h}{2} = \pi \cdot 4r^2 \cdot \frac{h}{2} = 2\pi r^2 h = 2V$. El volumen se duplica.
Sofía (B) se equivoca porque el radio aparece al cuadrado: duplicarlo multiplica el volumen por $4$, no por $2$. D considera solo el efecto del radio y olvida la altura. A invierte el efecto de los cambios.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9f70a3f2-5f91-5d54-809e-9eff703f7946', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('dfc2601e-ee9e-51e3-8c5b-dd109f8d481d', 'm1-geometria-012', 'Daniela arma cajas de cartón sin tapa para vender alfajores en su local de La Serena. Cada caja tiene forma de paralelepípedo recto con una base rectangular de $20$ cm por $15$ cm y una altura de $10$ cm. Sin considerar pestañas ni uniones, ¿cuántos centímetros cuadrados de cartón necesita para cada caja?', '[{"id":"A","content":"$700$ cm²"},{"id":"B","content":"$1\\,000$ cm²"},{"id":"C","content":"$1\\,300$ cm²"},{"id":"D","content":"$3\\,000$ cm²"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La caja tiene la base y cuatro caras laterales (no tiene tapa). Base: $20 \cdot 15 = 300$ cm². Caras laterales: $2 \cdot (20 \cdot 10) + 2 \cdot (15 \cdot 10) = 400 + 300 = 700$ cm². Total: $300 + 700 = 1\,000$ cm².
A considera solo las caras laterales y olvida la base. C incluye también la tapa ($1\,000 + 300$). D calcula el volumen ($20 \cdot 15 \cdot 10$), que no mide cartón.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'dfc2601e-ee9e-51e3-8c5b-dd109f8d481d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0169da43-24d4-5802-a7c1-f60c01280905', 'm1-geometria-013', 'La familia de Rocío tiene en Talca una piscina con forma de prisma recto. Mide $10$ m de largo y $4$ m de ancho; su profundidad es de $1$ m en un extremo y aumenta de manera uniforme a lo largo del largo hasta $2$ m en el otro extremo. Así, cada pared lateral larga es un trapecio de bases $1$ m y $2$ m y altura $10$ m, y el ancho de $4$ m es la altura del prisma. Recuerda que el área de un trapecio es $\frac{(B + b) \cdot h}{2}$ y que $1$ m³ $= 1\,000$ L.

Si la llenan con una bomba que entrega $2\,000$ litros por hora, ¿cuántas horas tarda en llenarse la piscina vacía?', '[{"id":"A","content":"$20$ horas"},{"id":"B","content":"$30$ horas"},{"id":"C","content":"$40$ horas"},{"id":"D","content":"$60$ horas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'El área del trapecio lateral es $\frac{(2 + 1) \cdot 10}{2} = 15$ m². El volumen del prisma es $15 \cdot 4 = 60$ m³ $= 60\,000$ L. El tiempo es $60\,000 : 2\,000 = 30$ horas.
A usa una profundidad constante de $1$ m ($40$ m³) y C una de $2$ m ($80$ m³). D olvida dividir por $2$ en la fórmula del trapecio y obtiene $120$ m³.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0169da43-24d4-5802-a7c1-f60c01280905', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-014
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('072a3310-9740-5291-9bde-250814d49bdd', 'm1-geometria-014', 'Al punto $P(3, -2)$ se le aplica una traslación según el vector $\vec{v} = (-5, 4)$. ¿Cuáles son las coordenadas del punto trasladado?', '[{"id":"A","content":"$(-15, -8)$"},{"id":"B","content":"$(-2, -6)$"},{"id":"C","content":"$(8, -6)$"},{"id":"D","content":"$(-2, 2)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Trasladar según $\vec{v}$ es sumar sus componentes a las coordenadas del punto: $(3 + (-5),\ -2 + 4) = (-2, 2)$.
A multiplica las coordenadas en lugar de sumarlas. B suma bien la primera componente, pero resta la segunda. C resta el vector, lo que corresponde a trasladar según $-\vec{v}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '072a3310-9740-5291-9bde-250814d49bdd', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-015
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('618bd66b-e50f-59e7-a8e5-e6740e1c6171', 'm1-geometria-015', 'En el plano cartesiano, un punto $P$ se rota en $90^\circ$ en sentido antihorario con centro en el origen $O(0, 0)$, y se obtiene el punto $Q(-3, 5)$. ¿Cuáles son las coordenadas de $P$?', '[{"id":"A","content":"$(-5, -3)$"},{"id":"B","content":"$(3, -5)$"},{"id":"C","content":"$(3, 5)$"},{"id":"D","content":"$(5, 3)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Para recuperar $P$ hay que deshacer la rotación, es decir, rotar $Q$ en $90^\circ$ en sentido horario: $(x, y) \to (y, -x)$. Así, $Q(-3, 5) \to (5, 3)$. Comprobación: al rotar $(5, 3)$ en $90^\circ$ antihorario, $(x, y) \to (-y, x)$ da $(-3, 5)$.
A vuelve a rotar $Q$ en sentido antihorario en lugar de deshacer el giro. B aplica una rotación de $180^\circ$. C solo cambia el signo de la primera coordenada, como en una reflexión respecto del eje $Y$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '618bd66b-e50f-59e7-a8e5-e6740e1c6171', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-016
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('80d96403-080b-574a-8e53-061e1c9059be', 'm1-geometria-016', 'En un videojuego que se desarrolla sobre un plano cartesiano, Martina mueve su personaje desde la posición $(2, 5)$ hasta la posición $(-1, 9)$ mediante una traslación. Luego aplica exactamente la misma traslación a un cofre ubicado en $(6, -3)$. ¿En qué posición queda el cofre?', '[{"id":"A","content":"$(3, 1)$"},{"id":"B","content":"$(-3, 4)$"},{"id":"C","content":"$(5, 6)$"},{"id":"D","content":"$(9, -7)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El vector de traslación es la posición final menos la inicial: $(-1 - 2,\ 9 - 5) = (-3, 4)$. Aplicado al cofre: $(6 - 3,\ -3 + 4) = (3, 1)$.
B es el vector de traslación, no la nueva posición del cofre. C suma al cofre la posición final del personaje, $(-1, 9)$, en lugar del vector. D aplica el vector opuesto $(3, -4)$, al restar en sentido inverso.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '80d96403-080b-574a-8e53-061e1c9059be', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-017
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b8749543-cfb9-5095-b813-1ff72fedbddc', 'm1-geometria-017', 'El triángulo de vértices $P(1, 2)$, $Q(4, 2)$ y $R(1, 6)$ se refleja respecto del eje $Y$, obteniéndose el triángulo $P''Q''R''$. ¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"$Q'' = (4, -2)$"},{"id":"B","content":"El área del triángulo $P''Q''R''$ es $12$ unidades cuadradas."},{"id":"C","content":"$R'' = (1, -6)$"},{"id":"D","content":"El perímetro del triángulo $P''Q''R''$ es $12$ unidades."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La reflexión respecto del eje $Y$ transforma $(x, y)$ en $(-x, y)$: $P''(-1, 2)$, $Q''(-4, 2)$ y $R''(-1, 6)$. Como es una isometría, conserva las medidas: los lados miden $3$, $4$ y $\sqrt{3^2 + 4^2} = 5$, y el perímetro es $12$.
A y C reflejan respecto del eje $X$ (cambian el signo de $y$) o cambian mal los signos. B confunde el área, que es $\frac{3 \cdot 4}{2} = 6$, con el perímetro.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b8749543-cfb9-5095-b813-1ff72fedbddc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-018
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('60f48cd9-e3fc-5bcc-8a76-f8a0849358dd', 'm1-geometria-018', 'Vicente usa una aplicación para reorganizar el plano de una feria costumbrista en Valparaíso, dibujado sobre un plano cartesiano. Un puesto de empanadas está en el punto $(a, b)$, con $a$ y $b$ números positivos distintos. Primero refleja el puesto respecto del eje $X$ y, después, rota el resultado en $90^\circ$ en sentido antihorario con centro en el origen. ¿Cuáles son las coordenadas finales del puesto?', '[{"id":"A","content":"$(-b, -a)$"},{"id":"B","content":"$(-b, a)$"},{"id":"C","content":"$(b, -a)$"},{"id":"D","content":"$(b, a)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'La reflexión respecto del eje $X$ transforma $(a, b)$ en $(a, -b)$. La rotación de $90^\circ$ antihoraria con centro en el origen transforma $(x, y)$ en $(-y, x)$, así que $(a, -b) \to (b, a)$. La composición equivale a reflejar respecto de la recta $y = x$.
A aplica las transformaciones en el orden inverso (primero rota a $(-b, a)$ y luego refleja). B aplica solo la rotación y omite la reflexión. C aplica solo una rotación en sentido horario.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '60f48cd9-e3fc-5bcc-8a76-f8a0849358dd', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-019
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4061eccb-e149-5610-af79-80a1a5ecf4d0', 'm1-geometria-019', 'Florencia diseña en un software un logo que debe ser simétrico respecto de una recta vertical, en un plano cartesiano. Al dibujar un punto del logo en $(5, 2)$, el software ubica automáticamente su punto simétrico en $(-3, 2)$. ¿Cuál es la ecuación de la recta respecto de la cual es simétrico el logo?', '[{"id":"A","content":"$x = -1$"},{"id":"B","content":"$x = 1$"},{"id":"C","content":"$x = 4$"},{"id":"D","content":"$y = 2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'El eje de simetría pasa por el punto medio del segmento que une un punto con su imagen y es perpendicular a él. El punto medio de $(5, 2)$ y $(-3, 2)$ tiene abscisa $\frac{5 + (-3)}{2} = 1$, y como el segmento es horizontal, el eje es la recta vertical $x = 1$.
A comete un error de signo al promediar ($\frac{-5 + 3}{2}$). C calcula la mitad de la distancia entre los puntos ($\frac{5 - (-3)}{2} = 4$), que no es la ubicación del eje. D es la recta horizontal que contiene a ambos puntos, no la que los refleja.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4061eccb-e149-5610-af79-80a1a5ecf4d0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-020
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('648bf84c-2866-5ef9-abbc-2801cddffb22', 'm1-geometria-020', 'Una tarde en Antofagasta, Antonella observa que un poste vertical de $4$ m de altura proyecta una sombra de $6$ m sobre el suelo horizontal. En el mismo momento, un edificio cercano proyecta una sombra de $27$ m. ¿Cuál es la altura del edificio?', '[{"id":"A","content":"$18$ m"},{"id":"B","content":"$25$ m"},{"id":"C","content":"$40{,}5$ m"},{"id":"D","content":"$108$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Los rayos del sol llegan paralelos, así que los triángulos formados por cada objeto y su sombra son semejantes: $\frac{h}{27} = \frac{4}{6}$, de donde $h = \frac{4 \cdot 27}{6} = 18$ m.
B supone que la diferencia entre altura y sombra se mantiene ($27 - 2$), lo cual no es proporcional. C invierte la razón ($\frac{27 \cdot 6}{4}$). D multiplica $4 \cdot 27$ sin dividir por $6$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '648bf84c-2866-5ef9-abbc-2801cddffb22', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-021
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('40da9869-ac16-5b3d-8147-ffc57d28199b', 'm1-geometria-021', 'En el plano de un departamento en Ñuñoa, dibujado a escala $1 : 50$, el living es un rectángulo de $9$ cm por $8$ cm. ¿Cuál es el área real del living?', '[{"id":"A","content":"$0{,}36$ m²"},{"id":"B","content":"$8{,}5$ m²"},{"id":"C","content":"$18$ m²"},{"id":"D","content":"$180$ m²"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Con escala $1 : 50$, cada centímetro del plano equivale a $50$ cm reales. Las medidas reales son $9 \cdot 50 = 450$ cm $= 4{,}5$ m y $8 \cdot 50 = 400$ cm $= 4$ m. El área es $4{,}5 \cdot 4 = 18$ m².
A multiplica el área del plano ($72$ cm²) por $50$, cuando las áreas se multiplican por $50^2 = 2\,500$. B suma los lados reales en vez de multiplicarlos. D convierte $180\,000$ cm² a m² dividiendo por $1\,000$ en lugar de $10\,000$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '40da9869-ac16-5b3d-8147-ffc57d28199b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-022
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('83c4e890-7e33-5aa4-b668-d31a9032f8a1', 'm1-geometria-022', 'Dos triángulos son semejantes y la razón entre las longitudes de sus lados correspondientes, del menor al mayor, es $2 : 3$. Si el área del triángulo menor es $20$ cm², ¿cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"El área del triángulo mayor es $30$ cm²."},{"id":"B","content":"El perímetro del triángulo mayor es $1{,}5$ veces el perímetro del menor."},{"id":"C","content":"El área del triángulo mayor es $60$ cm²."},{"id":"D","content":"Cada ángulo del triángulo mayor mide $1{,}5$ veces el ángulo correspondiente del menor."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Si la razón de semejanza es $\frac{2}{3}$, los perímetros están en la misma razón: el mayor es $\frac{3}{2} = 1{,}5$ veces el menor. Las áreas están en razón $\left(\frac{2}{3}\right)^2 = \frac{4}{9}$, así que el área mayor es $20 \cdot \frac{9}{4} = 45$ cm².
A aplica a las áreas la razón lineal. C multiplica el área por $3$. D es falsa porque los triángulos semejantes tienen ángulos correspondientes iguales.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '83c4e890-7e33-5aa4-b668-d31a9032f8a1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-023
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a58966fd-21b9-5bb2-a47f-c6eadbc5b07d', 'm1-geometria-023', 'En el triángulo $ABC$, el punto $D$ está sobre el lado $AB$ y el punto $E$ está sobre el lado $AC$, de modo que el segmento $DE$ es paralelo a $BC$. Se sabe que $AD = 4$ cm, $DB = 6$ cm, $AE = x$ cm y $EC = (x + 3)$ cm. ¿Cuánto mide el lado $AC$?', '[{"id":"A","content":"$6$ cm"},{"id":"B","content":"$7$ cm"},{"id":"C","content":"$9$ cm"},{"id":"D","content":"$15$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Por el teorema de Thales, como $DE \parallel BC$: $\frac{AD}{DB} = \frac{AE}{EC}$, es decir, $\frac{4}{6} = \frac{x}{x + 3}$. Entonces $4x + 12 = 6x$, de donde $x = 6$. Luego $AC = x + (x + 3) = 6 + 9 = 15$ cm.
A entrega solo $AE = x$ y C solo $EC$, sin sumar ambos tramos. B plantea mal la proporción, $\frac{AD}{AB} = \frac{AE}{EC}$, es decir $\frac{4}{10} = \frac{x}{x + 3}$, que da $x = 2$ y $AC = 7$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a58966fd-21b9-5bb2-a47f-c6eadbc5b07d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-024
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('19f2793b-5bf8-53c5-be93-89decbac967a', 'm1-geometria-024', 'Matías colecciona autos a escala $1 : 24$. Uno de sus modelos mide $18$ cm de largo. ¿Cuál de las siguientes expresiones permite calcular el largo del auto real, en metros?', '[{"id":"A","content":"$\\dfrac{18 \\cdot 24}{100}$"},{"id":"B","content":"$\\dfrac{18}{24 \\cdot 100}$"},{"id":"C","content":"$\\dfrac{24}{18 \\cdot 100}$"},{"id":"D","content":"$18 \\cdot 24 \\cdot 100$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Escala $1 : 24$ significa que cada centímetro del modelo corresponde a $24$ cm del auto real. El largo real es $18 \cdot 24 = 432$ cm, y para pasar a metros se divide por $100$: $\frac{18 \cdot 24}{100} = 4{,}32$ m.
B divide por la escala en lugar de multiplicar. C invierte la relación entre modelo y escala. D multiplica por $100$, lo que convierte metros a centímetros y no al revés.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '19f2793b-5bf8-53c5-be93-89decbac967a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-025
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('65e68ff0-fac7-57ac-a4a3-8ea75e25ee07', 'm1-geometria-025', 'Joaquín quiere estimar la altura de un árbol en un parque de Concepción. Coloca un espejo pequeño en el suelo horizontal, a $12$ m de la base del árbol, y se ubica en la línea recta que une el árbol y el espejo, a $1{,}5$ m del espejo, justo donde ve reflejada la copa del árbol. Sus ojos están a $1{,}6$ m del suelo. Por la ley de reflexión, el triángulo formado por Joaquín, sus ojos y el espejo es semejante al formado por el árbol, su copa y el espejo. ¿Cuál es la altura del árbol?', '[{"id":"A","content":"$12{,}8$ m"},{"id":"B","content":"$13{,}6$ m"},{"id":"C","content":"$14{,}4$ m"},{"id":"D","content":"$19{,}2$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Por la semejanza de los triángulos, $\frac{h}{12} = \frac{1{,}6}{1{,}5}$, de donde $h = \frac{12 \cdot 1{,}6}{1{,}5} = 12{,}8$ m.
B suma la altura de los ojos a la distancia ($12 + 1{,}6$), sin usar proporciones. C usa como distancia la de Joaquín al árbol ($13{,}5$ m) en lugar de la del espejo al árbol. D multiplica $12 \cdot 1{,}6$ y olvida dividir por $1{,}5$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '65e68ff0-fac7-57ac-a4a3-8ea75e25ee07', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'semejanza'
  on conflict do nothing;
-- m1-geometria-026
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('16647e97-9c15-5e14-8edb-702a7aed76ad', 'm1-geometria-026', 'En el plano cartesiano de una maqueta del parque de Lota, el quiosco está ubicado en el punto $K(-4, 7)$. Para un diseño simétrico, el arquitecto ubica un segundo quiosco en la imagen de $K$ al reflejarlo respecto del eje $X$. ¿En qué punto queda el segundo quiosco?', '[{"id":"A","content":"$(-4, -7)$"},{"id":"B","content":"$(4, -7)$"},{"id":"C","content":"$(4, 7)$"},{"id":"D","content":"$(7, -4)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Al reflejar respecto del eje $X$, la abscisa se mantiene y la ordenada cambia de signo: $(x, y) \to (x, -y)$. Así, $K(-4, 7) \to (-4, -7)$.
$(4, 7)$ corresponde a reflejar respecto del eje $Y$, y $(4, -7)$ a cambiar el signo de ambas coordenadas (simetría respecto del origen).
$(7, -4)$ resulta de intercambiar las coordenadas, lo que no es una reflexión respecto del eje $X$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '16647e97-9c15-5e14-8edb-702a7aed76ad', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-027
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('257c2d06-36b3-5cca-8540-5528988c6041', 'm1-geometria-027', 'Una aspiradora robot se mueve sobre el piso de un living, representado en un plano cartesiano con unidades en metros. Parte desde su base y realiza primero un desplazamiento según el vector $\vec{u} = (3, -2)$ y luego otro según el vector $\vec{v} = (-6, 5)$. ¿Según qué vector $\vec{w}$ debe desplazarse a continuación para volver exactamente a su base?', '[{"id":"A","content":"$(-3, 3)$"},{"id":"B","content":"$(3, -3)$"},{"id":"C","content":"$(9, -7)$"},{"id":"D","content":"$(-9, 7)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Los dos desplazamientos equivalen a uno solo según $\vec{u} + \vec{v} = (3 - 6, -2 + 5) = (-3, 3)$.
Para volver a la base se necesita el vector opuesto: $\vec{w} = -(\vec{u} + \vec{v}) = (3, -3)$.
$(-3, 3)$ es la suma $\vec{u} + \vec{v}$, que lleva desde la base hasta la posición actual, no de regreso.
$(9, -7)$ y $(-9, 7)$ corresponden a las restas $\vec{u} - \vec{v}$ y $\vec{v} - \vec{u}$, que no representan el recorrido realizado.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '257c2d06-36b3-5cca-8540-5528988c6041', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-028
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5fc7e162-fae7-53bc-a03e-c2167d2d083a', 'm1-geometria-028', 'Renata diseña la animación de una rueda de la fortuna en un programa que usa un plano cartesiano. Una cabina está en el punto $P(5, 3)$ y el eje de la rueda está en el punto $C(2, 1)$. Si la cabina gira $90^\circ$ en sentido antihorario con centro en $C$, ¿cuáles son las coordenadas de su nueva posición?', '[{"id":"A","content":"$(-3, 5)$"},{"id":"B","content":"$(-2, 3)$"},{"id":"C","content":"$(0, 4)$"},{"id":"D","content":"$(4, -2)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Se trabaja con el vector desde el centro: $\vec{CP} = (5 - 2, 3 - 1) = (3, 2)$.
Una rotación de $90^\circ$ antihoraria transforma $(a, b)$ en $(-b, a)$, por lo que $(3, 2) \to (-2, 3)$.
Se suma de vuelta el centro: $P'' = (2 - 2, 1 + 3) = (0, 4)$.
$(-3, 5)$ es el resultado de rotar con centro en el origen; $(-2, 3)$ olvida sumar las coordenadas del centro; $(4, -2)$ corresponde a girar en sentido horario.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5fc7e162-fae7-53bc-a03e-c2167d2d083a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-029
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('85a93d62-337e-5cc3-9014-2fc8a3f2281d', 'm1-geometria-029', 'Sobre un plano cartesiano, a un polígono se le aplica primero una reflexión respecto del eje $X$ y, a continuación, una traslación según el vector $(0, 5)$. ¿Cuál de las siguientes expresiones entrega la imagen final de un vértice cualquiera $(x, y)$ del polígono?', '[{"id":"A","content":"$(-x, y + 5)$"},{"id":"B","content":"$(x, -y - 5)$"},{"id":"C","content":"$(x, y - 5)$"},{"id":"D","content":"$(x, 5 - y)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La reflexión respecto del eje $X$ lleva $(x, y)$ a $(x, -y)$. Luego la traslación según $(0, 5)$ suma $5$ a la ordenada: $(x, -y + 5) = (x, 5 - y)$.
$(x, -y - 5)$ se obtiene si primero se traslada y después se refleja, es decir, invirtiendo el orden.
$(-x, y + 5)$ corresponde a reflejar respecto del eje $Y$, y $(x, y - 5)$ a no reflejar y trasladar en sentido contrario.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '85a93d62-337e-5cc3-9014-2fc8a3f2281d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-030
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b3ad5579-0568-56ef-a053-cd76cbdbca9b', 'm1-geometria-030', 'Sea $P(a, b)$ un punto cualquiera del segundo cuadrante del plano cartesiano, es decir, con $a < 0$ y $b > 0$. ¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"Al rotar $P$ en $180^\\circ$ con centro en el origen, su imagen queda en el cuarto cuadrante."},{"id":"B","content":"Al reflejar $P$ respecto del eje $Y$, su imagen queda en el tercer cuadrante."},{"id":"C","content":"Al trasladar $P$ según el vector $(1, 0)$, su imagen queda en el primer cuadrante."},{"id":"D","content":"Al girar $P$ en $90^\\circ$ alrededor del origen, en contra del movimiento de los punteros del reloj, su imagen queda en el primer cuadrante."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La rotación de $180^\circ$ con centro en el origen lleva $(a, b)$ a $(-a, -b)$; como $-a > 0$ y $-b < 0$, la imagen siempre está en el cuarto cuadrante.
La reflexión respecto del eje $Y$ da $(-a, b)$, con ambas coordenadas positivas: primer cuadrante, no tercero.
La traslación da $(a + 1, b)$, que queda en el primer cuadrante solo si $a > -1$; por ejemplo, $(-3, 2) \to (-2, 2)$ sigue en el segundo.
La rotación de $90^\circ$ antihoraria da $(-b, a)$, con ambas coordenadas negativas: tercer cuadrante.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b3ad5579-0568-56ef-a053-cd76cbdbca9b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-031
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2684fc9b-50e7-5611-8f06-171bb108a4ed', 'm1-geometria-031', 'Martín fabrica marcos rectangulares para fotografías. En cada marco, el largo mide $4$ cm más que el doble del ancho. Si el ancho del marco mide $a$ cm, ¿cuál de las siguientes expresiones representa el perímetro del marco, en cm?', '[{"id":"A","content":"$3a + 4$"},{"id":"B","content":"$6a + 8$"},{"id":"C","content":"$8a + 8$"},{"id":"D","content":"$2a^2 + 4a$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'El largo es $2a + 4$, así que el perímetro es $2 \cdot (a + 2a + 4) = 2 \cdot (3a + 4) = 6a + 8$.
$3a + 4$ es solo la suma de un largo y un ancho, es decir, la mitad del perímetro.
$8a + 8$ resulta de tomar el ancho como $2a$, calculando $2 \cdot (2a + 2a + 4)$, y $2a^2 + 4a = a \cdot (2a + 4)$ es el área del marco, no su perímetro.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2684fc9b-50e7-5611-8f06-171bb108a4ed', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-032
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1203b191-4f15-5b00-92fa-ba96a9d46440', 'm1-geometria-032', 'Para Fiestas Patrias, Agustina arma un volantín con forma de rombo. El área de un rombo se calcula como la mitad del producto de las medidas de sus diagonales. Si el volantín debe tener un área de $600$ cm² y una de sus diagonales mide $40$ cm, ¿cuánto mide cada lado del volantín?', '[{"id":"A","content":"$15$ cm"},{"id":"B","content":"$20$ cm"},{"id":"C","content":"$25$ cm"},{"id":"D","content":"$35$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'De $\frac{40 \cdot d}{2} = 600$ se obtiene $d = 30$ cm para la otra diagonal.
Las diagonales de un rombo se cortan perpendicularmente en sus puntos medios, formando triángulos rectángulos de catetos $20$ cm y $15$ cm.
Por el teorema de Pitágoras, el lado mide $\sqrt{20^2 + 15^2} = \sqrt{625} = 25$ cm.
$15$ cm y $20$ cm son las semidiagonales, no el lado; $35$ cm resulta de sumar los catetos en lugar de aplicar Pitágoras.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1203b191-4f15-5b00-92fa-ba96a9d46440', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-033
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a0f0fe45-106d-54a2-83fa-a3c4bef3ba41', 'm1-geometria-033', 'En un colegio de Los Ángeles construirán una jardinera con forma de trapecio rectángulo. Sus lados paralelos miden $15$ m y $9$ m, y su área es de $96$ m². Se quiere rodear todo el borde de la jardinera con una hilera de ladrillos. ¿Cuántos metros de borde tiene la jardinera?', '[{"id":"A","content":"$32$ m"},{"id":"B","content":"$34$ m"},{"id":"C","content":"$38$ m"},{"id":"D","content":"$42$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'La altura cumple $\frac{(15 + 9) \cdot h}{2} = 96$, de donde $h = 8$ m; en un trapecio rectángulo esta altura es uno de sus lados.
El lado oblicuo es la hipotenusa de un triángulo rectángulo de catetos $8$ m y $15 - 9 = 6$ m: $\sqrt{8^2 + 6^2} = 10$ m.
El perímetro es $15 + 9 + 8 + 10 = 42$ m.
$32$ m omite el lado oblicuo, $34$ m omite la altura como lado, y $38$ m toma $6$ m como lado oblicuo en lugar de calcularlo con Pitágoras.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a0f0fe45-106d-54a2-83fa-a3c4bef3ba41', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-034
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('83ca4c29-ff9e-579b-8f3c-5e4c1a5f1f1a', 'm1-geometria-034', 'Un dron de reparto se programa sobre un plano cartesiano con unidades en kilómetros. Tras realizar un único desplazamiento según el vector $\vec{v} = (-3, 4)$, el dron aterriza en el punto $(2, -1)$. ¿Desde qué punto despegó?', '[{"id":"A","content":"$(-5, 5)$"},{"id":"B","content":"$(-1, -5)$"},{"id":"C","content":"$(-1, 3)$"},{"id":"D","content":"$(5, -5)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Si el punto de partida es $(x, y)$, se cumple $(x, y) + (-3, 4) = (2, -1)$. Despejando: $x = 2 + 3 = 5$ e $y = -1 - 4 = -5$, es decir, $(5, -5)$.
A resta la llegada al vector ($\vec{v} - (2, -1)$) en vez de restar el vector a la llegada.
B corrige mal el signo de la primera coordenada ($2 - 3$).
C vuelve a aplicar la traslación al punto de llegada en lugar de deshacerla.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '83ca4c29-ff9e-579b-8f3c-5e4c1a5f1f1a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-035
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c81ab1ae-79f9-5e13-9ab8-3825cdaf12cb', 'm1-geometria-035', 'En un plano cartesiano se dibuja el triángulo de vértices $A(1, 1)$, $B(5, 1)$ y $C(3, 4)$. Este triángulo se refleja respecto de la recta horizontal de ecuación $y = -1$. ¿Cuáles son los vértices del triángulo reflejado $A''B''C''$?', '[{"id":"A","content":"$A''(1, -3)$, $B''(5, -3)$ y $C''(3, -6)$"},{"id":"B","content":"$A''(1, -2)$, $B''(5, -2)$ y $C''(3, -5)$"},{"id":"C","content":"$A''(1, -1)$, $B''(5, -1)$ y $C''(3, -4)$"},{"id":"D","content":"$A''(-3, 1)$, $B''(-7, 1)$ y $C''(-5, 4)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'En una reflexión respecto de $y = -1$ la abscisa no cambia y la imagen queda a la misma distancia de la recta, pero al otro lado: $y'' = -1 - (y - (-1)) = -2 - y$.
Así, $A(1, 1) \to (1, -3)$, $B(5, 1) \to (5, -3)$ y $C(3, 4) \to (3, -6)$.
B usa $y'' = -y - 1$, es decir, cambia el signo y solo resta una vez la distancia al eje.
C refleja respecto del eje $X$ en lugar de la recta $y = -1$.
D refleja respecto de la recta vertical $x = -1$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c81ab1ae-79f9-5e13-9ab8-3825cdaf12cb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-036
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('17d0db73-dfd4-55c5-957c-accd4496d505', 'm1-geometria-036', 'En un programa de diseño, Amanda aplica a una figura dos reflexiones sucesivas en un plano cartesiano: primero la refleja respecto de la recta $x = 1$ y, luego, refleja la figura obtenida respecto de la recta $x = 4$.
¿Cuál de las siguientes afirmaciones sobre la figura final es verdadera?', '[{"id":"A","content":"Es la imagen de la figura original mediante una traslación según el vector $(3, 0)$."},{"id":"B","content":"Es la imagen de la figura original mediante una traslación según el vector $(6, 0)$."},{"id":"C","content":"Es la imagen de la figura original mediante una reflexión respecto de la recta $x = 5$."},{"id":"D","content":"Es la imagen de la figura original mediante una traslación según el vector $(-6, 0)$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'La reflexión respecto de $x = 1$ lleva $(x, y)$ a $(2 - x, y)$, y la reflexión respecto de $x = 4$ lleva $(u, y)$ a $(8 - u, y)$. Al componer: $(x, y) \to (8 - (2 - x), y) = (x + 6, y)$, que es una traslación según $(6, 0)$: el doble de la distancia entre las rectas, en el sentido de la primera a la segunda.
A usa solo la distancia entre las rectas, sin duplicarla.
C confunde la composición con una sola reflexión; dos reflexiones conservan la orientación de la figura y una reflexión la invierte.
D corresponde a aplicar las reflexiones en el orden inverso.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '17d0db73-dfd4-55c5-957c-accd4496d505', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m1-geometria-037
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ab77a884-3957-5233-a505-4630209bcb62', 'm1-geometria-037', 'En la pared de un gimnasio de Punta Arenas se pintará un mural rectangular. Para delimitarlo se pegó una cinta por todo su borde y se usaron exactamente $46$ m de cinta. Si el largo del mural es $15$ m, ¿cuál es el área del mural?', '[{"id":"A","content":"$120$ m²"},{"id":"B","content":"$240$ m²"},{"id":"C","content":"$345$ m²"},{"id":"D","content":"$465$ m²"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El perímetro es $2 \cdot (15 + a) = 46$, de donde $15 + a = 23$ y el ancho es $a = 8$ m. El área es $15 \cdot 8 = 120$ m².
B usa como ancho $46 - 2 \cdot 15 = 16$ m, olvidando que hay dos anchos.
C toma el semiperímetro $23$ como si fuera el ancho.
D usa como ancho $46 - 15 = 31$ m.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ab77a884-3957-5233-a505-4630209bcb62', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-038
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1abbb6f2-4e42-5a46-b1ac-8120b41d308c', 'm1-geometria-038', 'Una baldosa decorativa tiene forma de hexágono regular de $10$ cm de lado. Un hexágono regular se puede dividir en $6$ triángulos equiláteros congruentes cuyo lado es igual al lado del hexágono, y cada uno de esos triángulos, si sus lados miden $\ell$, tiene una superficie igual a $\frac{\sqrt{3}}{4}\ell^2$.
¿Cuál es el área de la baldosa?', '[{"id":"A","content":"$25\\sqrt{3}$ cm²"},{"id":"B","content":"$150\\sqrt{3}$ cm²"},{"id":"C","content":"$300\\sqrt{3}$ cm²"},{"id":"D","content":"$600\\sqrt{3}$ cm²"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Cada triángulo tiene área $\frac{\sqrt{3}}{4} \cdot 10^2 = 25\sqrt{3}$ cm². Como son $6$ triángulos, el área de la baldosa es $6 \cdot 25\sqrt{3} = 150\sqrt{3}$ cm².
A corresponde a un solo triángulo.
C divide por $2$ en lugar de por $4$ en la fórmula.
D omite la división por $4$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1abbb6f2-4e42-5a46-b1ac-8120b41d308c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-039
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b854416a-4da4-5395-ab35-fe0624596e41', 'm1-geometria-039', 'Un terreno rectangular en Linares tiene $40$ m de largo y su diagonal mide $50$ m. Su dueño cercará todo el borde del terreno con una malla que cuesta $3\,500$ pesos por metro y, además, instalará a lo largo de una de las diagonales una cerca liviana que cuesta $2\,000$ pesos por metro.
¿Cuánto gastará en total en cercas?', '[{"id":"A","content":"$450\\,000$ pesos"},{"id":"B","content":"$490\\,000$ pesos"},{"id":"C","content":"$590\\,000$ pesos"},{"id":"D","content":"$665\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Por el teorema de Pitágoras, el ancho es $\sqrt{50^2 - 40^2} = \sqrt{900} = 30$ m, así que el perímetro es $2 \cdot (40 + 30) = 140$ m.
El costo es $140 \cdot 3\,500 + 50 \cdot 2\,000 = 490\,000 + 100\,000 = 590\,000$ pesos.
A calcula el ancho como $50 - 40 = 10$ m, sin usar Pitágoras.
B olvida la cerca de la diagonal.
D cobra los $190$ m al precio de la malla.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b854416a-4da4-5395-ab35-fe0624596e41', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m1-geometria-040
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('40f2d86b-6910-585e-99f9-e316561f14b5', 'm1-geometria-040', 'Un recipiente con forma de paralelepípedo recto tiene una base rectangular de $40$ cm por $25$ cm y contiene agua. Ignacia sumerge completamente una piedra en el agua, sin que esta se derrame, y observa que el nivel del agua sube exactamente $3$ cm.
¿Cuál es el volumen de la piedra?', '[{"id":"A","content":"$195$ cm³"},{"id":"B","content":"$390$ cm³"},{"id":"C","content":"$1\\,000$ cm³"},{"id":"D","content":"$3\\,000$ cm³"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'El volumen de la piedra es igual al volumen de agua desplazada, que es un paralelepípedo con la misma base del recipiente y altura igual a la subida del nivel: $40 \cdot 25 \cdot 3 = 3\,000$ cm³.
A multiplica la suma $40 + 25$ por $3$.
B multiplica el perímetro de la base, $130$ cm, por $3$.
C calcula solo el área de la base, sin considerar la subida del agua.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '40f2d86b-6910-585e-99f9-e316561f14b5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-geometria-041
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ef08f350-10be-51d1-868e-4a2625330d4b', 'm1-geometria-041', 'Una caja de regalo tiene forma de prisma recto de base cuadrada, cerrada por todas sus caras. El lado de la base mide $a$ cm y la altura de la caja es el triple del lado de la base.
¿Cuál de las siguientes expresiones representa el área total de la superficie de la caja, en cm²?', '[{"id":"A","content":"$12a^2$"},{"id":"B","content":"$13a^2$"},{"id":"C","content":"$14a^2$"},{"id":"D","content":"$3a^3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Las dos bases son cuadrados de área $a^2$ cada uno, y las cuatro caras laterales son rectángulos de $a$ por $3a$, de área $3a^2$ cada uno.
El área total es $2a^2 + 4 \cdot 3a^2 = 14a^2$.
A considera solo las caras laterales. B considera una sola base, como si la caja no tuviera tapa.
D es el volumen de la caja, $a \cdot a \cdot 3a$, no su área.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ef08f350-10be-51d1-868e-4a2625330d4b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm1' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m1-numeros-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('66ce58a1-ce55-5bb6-a1e3-424e351376d6', 'm1-numeros-001', 'En Punta Arenas, a las $7{:}00$ horas la temperatura era de $-4\,^{\circ}\text{C}$. Hasta el mediodía la temperatura subió $9\,^{\circ}\text{C}$ y desde el mediodía hasta la noche bajó $7\,^{\circ}\text{C}$.

¿Cuál era la temperatura en la noche?', '[{"id":"A","content":"$-20\\,^{\\circ}\\text{C}$"},{"id":"B","content":"$-6\\,^{\\circ}\\text{C}$"},{"id":"C","content":"$-2\\,^{\\circ}\\text{C}$"},{"id":"D","content":"$12\\,^{\\circ}\\text{C}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'La temperatura de la noche se obtiene con $-4 + 9 - 7 = 5 - 7 = -2$, es decir, $-2\,^{\circ}\text{C}$.
A resulta de restar todas las variaciones: $-4 - 9 - 7 = -20$.
B invierte las variaciones (baja $9$ y sube $7$): $-4 - 9 + 7 = -6$.
D suma la bajada como si fuera subida: $-4 + 9 + 7 = 12$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '66ce58a1-ce55-5bb6-a1e3-424e351376d6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d80227db-24bf-5605-961a-4a9d79e932ba', 'm1-numeros-002', '¿Cuál es el valor de la expresión $\displaystyle \frac{2}{3} + \frac{1}{4} \cdot \frac{8}{3}$?', '[{"id":"A","content":"$\\dfrac{2}{3}$"},{"id":"B","content":"$\\dfrac{8}{7}$"},{"id":"C","content":"$\\dfrac{4}{3}$"},{"id":"D","content":"$\\dfrac{22}{9}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Primero se resuelve la multiplicación: $\frac{1}{4}\cdot\frac{8}{3} = \frac{8}{12} = \frac{2}{3}$. Luego $\frac{2}{3} + \frac{2}{3} = \frac{4}{3}$.
D resulta de sumar antes de multiplicar: $\left(\frac{2}{3}+\frac{1}{4}\right)\cdot\frac{8}{3} = \frac{11}{12}\cdot\frac{8}{3} = \frac{22}{9}$.
B suma numeradores y denominadores ($\frac{3}{7}$) y luego multiplica por $\frac{8}{3}$.
A suma numeradores y denominadores en $\frac{2}{3}+\frac{8}{12} = \frac{10}{15} = \frac{2}{3}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd80227db-24bf-5605-961a-4a9d79e932ba', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('fd06a243-1e9d-5a21-904f-2de749e4282e', 'm1-numeros-003', 'Martín tiene un bidón con $20$ litros de agua en su casa de Ovalle. Usa $\frac{3}{5}$ del agua para regar el huerto y luego $\frac{1}{4}$ del agua que le queda para lavar su bicicleta.

¿Cuántos litros de agua quedan en el bidón?', '[{"id":"A","content":"$2$ litros"},{"id":"B","content":"$3$ litros"},{"id":"C","content":"$5$ litros"},{"id":"D","content":"$6$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Para regar usa $\frac{3}{5}\cdot 20 = 12$ litros, por lo que quedan $8$ litros. Para la bicicleta usa $\frac{1}{4}\cdot 8 = 2$ litros, así que quedan $8 - 2 = 6$ litros.
A corresponde a los litros usados en la bicicleta, no a los que quedan.
C calcula $\frac{1}{4}$ del total ($5$ litros) en vez de $\frac{1}{4}$ de lo que queda.
B usa ese mismo error y resta: $20 - 12 - 5 = 3$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'fd06a243-1e9d-5a21-904f-2de749e4282e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('da2e7756-ad49-5bbf-8bd9-cfcb74a2148e', 'm1-numeros-004', 'Javiera calculó el valor de $\displaystyle \frac{3}{4} - \frac{2}{3} \div \frac{4}{9}$ de la siguiente manera:

Paso 1: $\displaystyle \frac{2}{3} \div \frac{4}{9} = \frac{2}{3} \cdot \frac{9}{4}$
Paso 2: $\displaystyle \frac{2}{3} \cdot \frac{9}{4} = \frac{18}{12}$
Paso 3: $\displaystyle \frac{18}{12} = \frac{3}{2}$
Paso 4: $\displaystyle \frac{3}{4} - \frac{3}{2} = \frac{3-3}{4-2} = 0$

¿En cuál de los pasos Javiera cometió un error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Los pasos 1, 2 y 3 son correctos: dividir por $\frac{4}{9}$ equivale a multiplicar por $\frac{9}{4}$, el producto es $\frac{18}{12}$ y al simplificar por $6$ se obtiene $\frac{3}{2}$.
En el paso 4 Javiera restó numeradores y denominadores entre sí, lo que no es válido. Lo correcto es igualar denominadores: $\frac{3}{4} - \frac{6}{4} = -\frac{3}{4}$.
Quien marca A confunde la división de fracciones con multiplicar directamente; B y C dudan de un producto y una simplificación que sí son correctos.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'da2e7756-ad49-5bbf-8bd9-cfcb74a2148e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f2edfc93-3033-5560-b576-4b0b8e62aeab', 'm1-numeros-005', 'Cuatro estudiantes de un liceo de Talca registraron la fracción de la pista de atletismo que recorrieron trotando en un minuto:

Antonia: $0{,}7$ de la pista.
Benjamín: $\frac{2}{3}$ de la pista.
Catalina: $\frac{5}{8}$ de la pista.
Diego: $0{,}65$ de la pista.

¿Cuál es el orden de los estudiantes, desde quien recorrió menos hasta quien recorrió más?', '[{"id":"A","content":"Catalina, Diego, Benjamín, Antonia"},{"id":"B","content":"Benjamín, Catalina, Diego, Antonia"},{"id":"C","content":"Catalina, Benjamín, Antonia, Diego"},{"id":"D","content":"Diego, Catalina, Benjamín, Antonia"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Al escribir todo en decimales: $\frac{5}{8} = 0{,}625$, $0{,}65$, $\frac{2}{3} \approx 0{,}667$ y $0{,}7$. El orden es Catalina, Diego, Benjamín, Antonia.
B supone que $\frac{2}{3}$ es menor que $\frac{5}{8}$ porque tiene menor denominador.
C cree que $0{,}65 > 0{,}7$ porque $65 > 7$.
D supone que $0{,}65$ es menor que $\frac{5}{8}$ sin convertir la fracción a decimal.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f2edfc93-3033-5560-b576-4b0b8e62aeab', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('802f618b-80bd-5298-a4c5-6e65c5afcfd0', 'm1-numeros-006', 'En una parcela de Talagante hay un estanque vacío. Una llave lo llena a razón de $\frac{3}{8}$ de su capacidad por hora, pero por una filtración pierde $\frac{1}{12}$ de su capacidad por hora. La llave y la filtración actúan al mismo tiempo.

¿Cuál de las siguientes expresiones representa el tiempo, en horas, que tarda el estanque en llenarse completamente?', '[{"id":"A","content":"$\\dfrac{1}{\\frac{3}{8} - \\frac{1}{12}}$"},{"id":"B","content":"$\\dfrac{1}{\\frac{3}{8} + \\frac{1}{12}}$"},{"id":"C","content":"$\\dfrac{3}{8} - \\dfrac{1}{12}$"},{"id":"D","content":"$\\dfrac{1}{\\frac{1}{12}} - \\dfrac{1}{\\frac{3}{8}}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'En cada hora el estanque gana, en neto, $\frac{3}{8} - \frac{1}{12} = \frac{9}{24} - \frac{2}{24} = \frac{7}{24}$ de su capacidad. Para completar $1$ estanque se necesitan $\frac{1}{\frac{3}{8}-\frac{1}{12}} = \frac{24}{7}$ horas.
B suma la filtración en lugar de restarla.
C es la fracción que se llena en una hora, no el tiempo total.
D calcula por separado el tiempo de vaciado ($12$ horas) y el de llenado ($\frac{8}{3}$ horas) y los resta; los tiempos no se restan, se combinan las rapideces.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '802f618b-80bd-5298-a4c5-6e65c5afcfd0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('915757cf-562b-55f9-8bfb-5fa4cc4980f3', 'm1-numeros-007', 'Sean $a$ y $b$ números racionales tales que $a < 0 < b$.

¿Cuál de las siguientes desigualdades es siempre verdadera?', '[{"id":"A","content":"$a + b < 0$"},{"id":"B","content":"$-a < b$"},{"id":"C","content":"$a^2 < b^2$"},{"id":"D","content":"$\\dfrac{1}{a} - \\dfrac{1}{b} < 0$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Como $a < 0$, se tiene $\frac{1}{a} < 0$; como $b > 0$, se tiene $\frac{1}{b} > 0$ y entonces $-\frac{1}{b} < 0$. La suma de dos números negativos es negativa, por lo que D siempre se cumple.
A falla con $a = -1$, $b = 2$, pues $a + b = 1$.
B falla con $a = -5$, $b = 1$, pues $-a = 5 > 1$.
C falla con esos mismos valores, pues $25 > 1$. Estas tres solo se cumplen para algunos valores, error típico al generalizar desde un solo ejemplo.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '915757cf-562b-55f9-8bfb-5fa4cc4980f3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('871c3357-3b5a-5903-80b2-6b2f2596c36e', 'm1-numeros-008', 'Florencia está leyendo una novela. El lunes leyó $\frac{1}{3}$ del total de páginas, el martes leyó $\frac{1}{4}$ de las páginas que le quedaban y el miércoles leyó $60$ páginas. Después de eso, aún le faltan $90$ páginas para terminar.

¿Cuántas páginas tiene la novela?', '[{"id":"A","content":"$225$"},{"id":"B","content":"$300$"},{"id":"C","content":"$360$"},{"id":"D","content":"$450$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Si la novela tiene $T$ páginas, tras el lunes quedan $\frac{2}{3}T$. El martes lee $\frac{1}{4}\cdot\frac{2}{3}T = \frac{1}{6}T$ y quedan $\frac{2}{3}T - \frac{1}{6}T = \frac{1}{2}T$.
Esa mitad corresponde a $60 + 90 = 150$ páginas, por lo que $T = 300$.
C calcula $\frac{1}{4}$ del total en vez de lo que quedaba: $1 - \frac{1}{3} - \frac{1}{4} = \frac{5}{12}$ y $\frac{5}{12}T = 150$.
A ignora lo leído el martes ($\frac{2}{3}T = 150$) y D supone que $150$ es $\frac{1}{3}$ del libro.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '871c3357-3b5a-5903-80b2-6b2f2596c36e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c00a261c-ce43-5c3d-9009-1e506daeb4bb', 'm1-numeros-009', 'En un concurso de preguntas de un colegio de Antofagasta, cada respuesta correcta suma puntos y cada respuesta incorrecta los resta. Renata comenzó la final con $3$ puntos y la tabla muestra la variación de su puntaje en cada ronda:

$\displaystyle \begin{array}{|c|c|}\hline \text{Ronda} & \text{Variación del puntaje} \\ \hline 1 & +15 \\ \hline 2 & -8 \\ \hline 3 & -12 \\ \hline 4 & +4 \\ \hline \end{array}$

¿Con cuántos puntos terminó Renata la final?', '[{"id":"A","content":"$-6$"},{"id":"B","content":"$-1$"},{"id":"C","content":"$2$"},{"id":"D","content":"$42$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El puntaje final es $3 + 15 - 8 - 12 + 4 = 2$ puntos.
A considera la ronda 4 como pérdida: $3 + 15 - 8 - 12 - 4 = -6$.
B olvida el puntaje inicial: $15 - 8 - 12 + 4 = -1$.
D suma todos los valores sin considerar los signos: $3 + 15 + 8 + 12 + 4 = 42$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c00a261c-ce43-5c3d-9009-1e506daeb4bb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0daa82e4-4494-5635-bda0-d411532eb584', 'm1-numeros-010', 'En una tienda de Iquique, una polera cuesta $18\,000$ pesos y tiene un descuento del $25\%$.

¿Cuánto se paga por la polera con el descuento aplicado?', '[{"id":"A","content":"$4\\,500$ pesos"},{"id":"B","content":"$13\\,500$ pesos"},{"id":"C","content":"$17\\,550$ pesos"},{"id":"D","content":"$22\\,500$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'El descuento es $0{,}25 \cdot 18\,000 = 4\,500$ pesos, por lo que se paga $18\,000 - 4\,500 = 13\,500$ pesos (equivale a $0{,}75 \cdot 18\,000$).
A es el monto del descuento, no el precio final.
C calcula un $2{,}5\%$ en vez de un $25\%$: $18\,000 - 450$.
D suma el $25\%$ en lugar de restarlo.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0daa82e4-4494-5635-bda0-d411532eb584', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('fe525226-4487-5609-b946-8d7eb94cbe66', 'm1-numeros-011', 'Un jarabe para la tos contiene un $0{,}4\%$ de principio activo. Una farmacéutica de La Serena quiere calcular cuántos mililitros de principio activo hay en un frasco de $250$ mL de jarabe.

¿Cuál de las siguientes expresiones permite calcularlo?', '[{"id":"A","content":"$0{,}004 \\cdot 250$"},{"id":"B","content":"$0{,}04 \\cdot 250$"},{"id":"C","content":"$0{,}4 \\cdot 250$"},{"id":"D","content":"$\\dfrac{250}{0{,}4}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El $0{,}4\%$ equivale a $\frac{0{,}4}{100} = 0{,}004$. Por lo tanto, hay $0{,}004 \cdot 250 = 1$ mL de principio activo.
B corre la coma solo un lugar ($4\%$ en vez de $0{,}4\%$).
C usa $0{,}4$, que corresponde al $40\%$.
D divide por el porcentaje en lugar de multiplicar.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'fe525226-4487-5609-b946-8d7eb94cbe66', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3855629b-7118-5ca3-b98b-fa642bae0ea4', 'm1-numeros-012', 'Gabriela compró un hervidor en Concepción y pagó $59\,500$ pesos. Ese precio incluye el IVA, que corresponde a un $19\%$ del precio sin impuesto.

Si $P$ es el precio del hervidor sin IVA, en pesos, ¿cuál de las siguientes expresiones permite calcular $P$?', '[{"id":"A","content":"$P = 59\\,500 \\cdot 0{,}81$"},{"id":"B","content":"$P = \\dfrac{59\\,500}{1{,}19}$"},{"id":"C","content":"$P = 59\\,500 \\cdot 1{,}19$"},{"id":"D","content":"$P = \\dfrac{59\\,500}{0{,}19}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El precio con IVA es $P + 0{,}19P = 1{,}19P$. Entonces $1{,}19P = 59\,500$ y $P = \frac{59\,500}{1{,}19} = 50\,000$ pesos.
A es el error típico de descontar el $19\%$ al precio final; daría $48\,195$ pesos, pero el IVA se calcula sobre el precio sin impuesto.
C vuelve a agregar el IVA.
D calcula el valor cuyo $19\%$ es $59\,500$, confundiendo el impuesto con el precio total.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3855629b-7118-5ca3-b98b-fa642bae0ea4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('83d2521b-3d6f-57b3-8cf2-b58994343ad0', 'm1-numeros-013', 'En un liceo de Rancagua hay $300$ estudiantes en tercero medio y $200$ en cuarto medio. Practica algún deporte el $40\%$ de los estudiantes de tercero medio y el $25\%$ de los de cuarto medio.

Sofía afirma: «Entre ambos niveles, el $32{,}5\%$ de los estudiantes practica algún deporte».

¿Cuál de las siguientes afirmaciones es correcta respecto de lo dicho por Sofía?', '[{"id":"A","content":"Sofía se equivoca: el porcentaje es $34\\%$."},{"id":"B","content":"Sofía tiene razón, porque $32{,}5\\%$ es el promedio entre $40\\%$ y $25\\%$."},{"id":"C","content":"Sofía se equivoca: el porcentaje es $65\\%$."},{"id":"D","content":"Sofía se equivoca: el porcentaje es $31\\%$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Practican deporte $0{,}40 \cdot 300 = 120$ estudiantes de tercero y $0{,}25 \cdot 200 = 50$ de cuarto: $170$ de $500$, es decir, $\frac{170}{500} = 34\%$.
B promedia los porcentajes sin considerar que los niveles tienen distinta cantidad de estudiantes.
C suma los porcentajes.
D intercambia los tamaños de los niveles: $\frac{0{,}40\cdot 200 + 0{,}25\cdot 300}{500} = 31\%$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '83d2521b-3d6f-57b3-8cf2-b58994343ad0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-014
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2f75dbce-c9c2-5907-9d4f-666c7fd47f2e', 'm1-numeros-014', 'El pasaje de bus entre Santiago y La Serena subió un $10\%$ en enero. En marzo, el nuevo precio volvió a subir, esta vez un $20\%$, y quedó en $26\,400$ pesos.

¿Cuál era el precio del pasaje antes de ambas alzas?', '[{"id":"A","content":"$18\\,480$ pesos"},{"id":"B","content":"$19\\,008$ pesos"},{"id":"C","content":"$20\\,000$ pesos"},{"id":"D","content":"$22\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Si el precio inicial es $x$, después de las alzas es $x \cdot 1{,}10 \cdot 1{,}20 = 1{,}32x$. Entonces $1{,}32x = 26\,400$ y $x = 20\,000$ pesos.
A resta un $30\%$ al precio final ($26\,400 \cdot 0{,}7$), sumando los porcentajes y aplicándolos sobre la base equivocada.
B descuenta un $20\%$ y luego un $10\%$ al precio final ($26\,400 \cdot 0{,}8 \cdot 0{,}9$), pero las alzas se calcularon sobre precios menores.
D revierte solo el alza de marzo ($26\,400 \div 1{,}2$).', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2f75dbce-c9c2-5907-9d4f-666c7fd47f2e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-015
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b003a02d-910f-578f-95db-25af71f84a6e', 'm1-numeros-015', 'Andrés compró un auto usado en Temuco. Se estima que el valor del auto disminuye un $12\%$ cada año respecto del valor que tenía el año anterior.

Si hoy el auto vale $V$ pesos, ¿cuál de las siguientes expresiones representa su valor estimado, en pesos, dentro de $3$ años?', '[{"id":"A","content":"$V \\cdot (1 - 0{,}36)$"},{"id":"B","content":"$V \\cdot 0{,}12^{3}$"},{"id":"C","content":"$V \\cdot 0{,}88^{3}$"},{"id":"D","content":"$V \\cdot 0{,}88 \\cdot 3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Cada año el auto conserva el $100\% - 12\% = 88\%$ del valor del año anterior, es decir, su valor se multiplica por $0{,}88$. Tras $3$ años: $V \cdot 0{,}88 \cdot 0{,}88 \cdot 0{,}88 = V \cdot 0{,}88^3$.
A supone que la disminución es siempre $12\%$ del valor inicial y resta $3 \cdot 12\% = 36\%$.
B usa el porcentaje que se pierde ($0{,}12$) en vez del que se conserva.
D multiplica por $3$ en lugar de elevar a $3$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b003a02d-910f-578f-95db-25af71f84a6e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-016
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f1afd331-0c4f-58f0-9749-3dc7e5b7bc52', 'm1-numeros-016', 'La familia Huenchullán tiene un ingreso mensual de $900\,000$ pesos y lo distribuye según la siguiente tabla. Lo que no se destina a estos tres gastos se ocupa en otros gastos.

$\displaystyle \begin{array}{|c|c|}\hline \text{Gasto} & \text{Monto destinado} \\ \hline \text{Arriendo} & 35\% \text{ del ingreso} \\ \hline \text{Alimentación} & 40\% \text{ de lo que queda después de pagar el arriendo} \\ \hline \text{Transporte} & 12\% \text{ del ingreso} \\ \hline \end{array}$

¿Cuántos pesos destina mensualmente la familia a otros gastos?', '[{"id":"A","content":"$117\\,000$ pesos"},{"id":"B","content":"$243\\,000$ pesos"},{"id":"C","content":"$351\\,000$ pesos"},{"id":"D","content":"$657\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Arriendo: $0{,}35 \cdot 900\,000 = 315\,000$ pesos, por lo que quedan $585\,000$ pesos. Alimentación: $0{,}40 \cdot 585\,000 = 234\,000$ pesos. Transporte: $0{,}12 \cdot 900\,000 = 108\,000$ pesos.
Otros gastos: $900\,000 - 315\,000 - 234\,000 - 108\,000 = 243\,000$ pesos.
A calcula la alimentación como $40\%$ del ingreso total y obtiene $100\% - 87\% = 13\%$ del ingreso.
C olvida descontar el transporte.
D es la suma de los tres gastos de la tabla, no lo que queda para otros gastos.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f1afd331-0c4f-58f0-9749-3dc7e5b7bc52', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-017
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5754ba36-7ef9-56a7-a3be-14ff45c12832', 'm1-numeros-017', 'Sean $p$ y $q$ números positivos tales que $p$ es un $25\%$ mayor que $q$.

¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"$q$ es un $20\\%$ menor que $p$."},{"id":"B","content":"$q$ es un $25\\%$ menor que $p$."},{"id":"C","content":"$q$ es el $75\\%$ de $p$."},{"id":"D","content":"$q$ es un $80\\%$ menor que $p$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Como $p = 1{,}25q$, se tiene $q = \frac{p}{1{,}25} = 0{,}8p$. Es decir, $q$ es el $80\%$ de $p$, o sea, un $20\%$ menor que $p$.
B y C suponen que el porcentaje es simétrico: que si $p$ supera a $q$ en un $25\%$, entonces $q$ es un $25\%$ menor que $p$. Pero el $25\%$ se calcula sobre $q$, no sobre $p$.
D confunde «ser el $80\%$ de $p$» con «ser un $80\%$ menor que $p$».', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5754ba36-7ef9-56a7-a3be-14ff45c12832', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-018
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('fbe70e8b-4c2d-5512-b754-6a720bfc6e51', 'm1-numeros-018', '¿Cuál es el valor de $2^{3} \cdot 2^{-5} \cdot 4^{2}$?', '[{"id":"A","content":"$\\dfrac{1}{4}$"},{"id":"B","content":"$1$"},{"id":"C","content":"$4$"},{"id":"D","content":"$16$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Como $4^2 = (2^2)^2 = 2^4$, se tiene $2^{3}\cdot 2^{-5}\cdot 2^{4} = 2^{3-5+4} = 2^{2} = 4$.
A omite el factor $4^2$: $2^{3}\cdot 2^{-5} = 2^{-2} = \frac{1}{4}$.
B escribe $4^2$ como $2^2$ en vez de $2^4$, y obtiene $2^0 = 1$.
D considera solo $4^2 = 16$, suponiendo que $2^3 \cdot 2^{-5}$ vale $1$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'fbe70e8b-4c2d-5512-b754-6a720bfc6e51', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-019
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('324672e5-3f1f-5fec-b673-2576a22592d6', 'm1-numeros-019', 'En una charla en un observatorio del norte de Chile, se explicó que la distancia media entre la Tierra y el Sol es de aproximadamente $150\,000\,000$ km.

Si $1$ km equivale a $10^{3}$ m, ¿cuál de las siguientes expresiones representa esta distancia, en metros, en notación científica?', '[{"id":"A","content":"$1{,}5 \\cdot 10^{8}$ m"},{"id":"B","content":"$1{,}5 \\cdot 10^{9}$ m"},{"id":"C","content":"$1{,}5 \\cdot 10^{11}$ m"},{"id":"D","content":"$1{,}5 \\cdot 10^{24}$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'En notación científica, $150\,000\,000 = 1{,}5 \cdot 10^{8}$ km, ya que la coma se desplaza $8$ lugares. Al pasar a metros: $1{,}5 \cdot 10^{8} \cdot 10^{3} = 1{,}5 \cdot 10^{8+3} = 1{,}5 \cdot 10^{11}$ m.
A escribe bien la distancia en km, pero no la convierte a metros.
B cuenta las $9$ cifras del número como exponente y tampoco convierte.
D multiplica los exponentes ($8 \cdot 3$) en vez de sumarlos.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '324672e5-3f1f-5fec-b673-2576a22592d6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-020
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d703e9df-5ae7-566b-8f4a-7d782ae7cd21', 'm1-numeros-020', 'Fernanda tiene un emprendimiento de cerámica en Arica. Cuando abrió su cuenta en una red social tenía $500$ seguidores y, desde entonces, la cantidad de seguidores se ha triplicado cada $2$ meses. La cantidad de seguidores después de $t$ meses se modela con $N(t) = 500 \cdot 3^{\frac{t}{2}}$.

Según el modelo, ¿cuántos seguidores tendrá la cuenta $8$ meses después de abrirla?', '[{"id":"A","content":"$4\\,500$"},{"id":"B","content":"$6\\,000$"},{"id":"C","content":"$13\\,500$"},{"id":"D","content":"$40\\,500$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Se reemplaza $t = 8$: $N(8) = 500 \cdot 3^{\frac{8}{2}} = 500 \cdot 3^{4} = 500 \cdot 81 = 40\,500$ seguidores.
A usa $3^{2}$ en lugar de $3^{4}$ (divide $8$ por $4$).
B multiplica la base por el exponente: $500 \cdot 3 \cdot 4 = 6\,000$.
C usa $3^{3}$, contando un periodo de $2$ meses menos.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd703e9df-5ae7-566b-8f4a-7d782ae7cd21', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-021
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3a536ba5-9327-51de-a926-65a7efc4e7ea', 'm1-numeros-021', 'Tomás simplificó la expresión $\sqrt{50} + \sqrt{18} - \sqrt{8}$ de la siguiente manera:

Paso 1: $\sqrt{50} = \sqrt{25 \cdot 2} = 5\sqrt{2}$
Paso 2: $\sqrt{18} = \sqrt{9 \cdot 2} = 9\sqrt{2}$
Paso 3: $\sqrt{8} = \sqrt{4 \cdot 2} = 2\sqrt{2}$
Paso 4: $5\sqrt{2} + 9\sqrt{2} - 2\sqrt{2} = 12\sqrt{2}$

¿En cuál de los pasos Tomás cometió un error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'En el paso 2, Tomás extrajo el $9$ de la raíz sin calcular su raíz cuadrada: lo correcto es $\sqrt{9 \cdot 2} = 3\sqrt{2}$.
Los pasos 1 y 3 están bien, y el paso 4 suma correctamente los valores que obtuvo, por lo que no es allí donde se originó el error.
El resultado correcto es $5\sqrt{2} + 3\sqrt{2} - 2\sqrt{2} = 6\sqrt{2}$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3a536ba5-9327-51de-a926-65a7efc4e7ea', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-022
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e4425161-50f4-51f8-a1ca-29976121b18e', 'm1-numeros-022', 'El comité de agua potable rural de una localidad de la Región de Atacama tiene un estanque con capacidad de $6{,}4 \cdot 10^{6}$ litros, que actualmente contiene $1{,}6 \cdot 10^{6}$ litros. Para completarlo se contratan camiones aljibe, cada uno con capacidad de $1{,}6 \cdot 10^{4}$ litros.

¿Cuántos camiones llenos se necesitan para completar el estanque?', '[{"id":"A","content":"$100$"},{"id":"B","content":"$300$"},{"id":"C","content":"$400$"},{"id":"D","content":"$3\\,000$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Faltan $6{,}4 \cdot 10^{6} - 1{,}6 \cdot 10^{6} = 4{,}8 \cdot 10^{6}$ litros. Luego $\frac{4{,}8 \cdot 10^{6}}{1{,}6 \cdot 10^{4}} = 3 \cdot 10^{6-4} = 3 \cdot 10^{2} = 300$ camiones.
C ignora el agua que ya hay en el estanque y divide la capacidad total.
A divide el agua que ya está en el estanque en lugar de la que falta.
D calcula bien $\frac{4{,}8}{1{,}6} = 3$, pero se equivoca al restar los exponentes y escribe $3 \cdot 10^{3}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e4425161-50f4-51f8-a1ca-29976121b18e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-023
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9ea4932b-3832-5608-92d7-4f83975f575c', 'm1-numeros-023', 'Si $x$ es un número real positivo, ¿cuál de las siguientes expresiones es equivalente a $\sqrt[3]{x^{2}} \cdot \sqrt{x}$?', '[{"id":"A","content":"$x^{\\frac{1}{6}}$"},{"id":"B","content":"$x^{\\frac{1}{3}}$"},{"id":"C","content":"$x^{\\frac{3}{5}}$"},{"id":"D","content":"$x^{\\frac{7}{6}}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Se escriben las raíces como potencias de exponente fraccionario: $\sqrt[3]{x^2} = x^{\frac{2}{3}}$ y $\sqrt{x} = x^{\frac{1}{2}}$. Al multiplicar potencias de igual base se suman los exponentes: $\frac{2}{3} + \frac{1}{2} = \frac{7}{6}$.
A resta los exponentes en vez de sumarlos.
B multiplica los exponentes: $\frac{2}{3}\cdot\frac{1}{2} = \frac{1}{3}$.
C suma numeradores y denominadores: $\frac{2+1}{3+2}$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9ea4932b-3832-5608-92d7-4f83975f575c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-024
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('87999fe6-5522-56a3-a105-a4ab6b802c44', 'm1-numeros-024', 'En una simulación de su clase de informática en Coquimbo, tres servidores reciben cada uno $3^{15}$ solicitudes. Tres estudiantes escriben el total de solicitudes recibidas entre los tres servidores:

Benjamín: $3^{45}$
Isidora: $3^{16}$
Matías: $27^{15}$

¿Cuál o cuáles de los estudiantes escribieron correctamente el total?', '[{"id":"A","content":"Solo Benjamín"},{"id":"B","content":"Solo Matías"},{"id":"C","content":"Solo Benjamín y Matías"},{"id":"D","content":"Solo Isidora"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'El total es $3^{15} + 3^{15} + 3^{15} = 3 \cdot 3^{15} = 3^{1+15} = 3^{16}$, que es lo que escribió Isidora.
Benjamín sumó los exponentes como si se tratara de una multiplicación: $3^{15}\cdot 3^{15}\cdot 3^{15} = 3^{45}$.
Matías escribió $27^{15} = (3^3)^{15} = 3^{45}$, el mismo valor incorrecto de Benjamín. Por eso C (ambos) también es incorrecta: que dos expresiones sean iguales entre sí no implica que sean correctas.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '87999fe6-5522-56a3-a105-a4ab6b802c44', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-025
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('06db1f27-8f25-5a66-ad63-a9d71bec10f8', 'm1-numeros-025', 'Una empresa de Puerto Montt fabrica cajas cúbicas de arista $a$ cm. Quiere diseñar un nuevo modelo, también cúbico, cuyo volumen sea el doble del volumen de la caja actual.

¿Cuál de las siguientes expresiones representa la arista, en cm, de la nueva caja?', '[{"id":"A","content":"$a\\sqrt[3]{2}$"},{"id":"B","content":"$a\\sqrt{2}$"},{"id":"C","content":"$2a$"},{"id":"D","content":"$8a$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'El volumen actual es $a^3$ y el nuevo debe ser $2a^3$. Si la nueva arista es $b$, entonces $b^3 = 2a^3$, de donde $b = \sqrt[3]{2a^3} = a\sqrt[3]{2}$.
B usa raíz cuadrada, lo que correspondería a duplicar el área de una cara, no el volumen.
C supone que duplicar la arista duplica el volumen, pero en realidad lo multiplica por $8$.
D eleva el $2$ al cubo en lugar de extraer su raíz cúbica.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '06db1f27-8f25-5a66-ad63-a9d71bec10f8', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-026
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9999ebcd-da58-5e7b-9321-7aefb11725db', 'm1-numeros-026', 'En una mina subterránea de la Región de O''Higgins, las posiciones bajo la superficie se representan con números negativos. Un ascensor de carga se encuentra en la posición $-120$ m, desciende $85$ m y luego asciende $140$ m.

¿En qué posición queda el ascensor?', '[{"id":"A","content":"$-65$ m"},{"id":"B","content":"$65$ m"},{"id":"C","content":"$105$ m"},{"id":"D","content":"$345$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'La posición final es $-120 - 85 + 140 = -205 + 140 = -65$, es decir, $65$ m bajo la superficie.
B entrega el valor correcto pero con el signo cambiado, como si quedara sobre la superficie.
C trata el descenso como un ascenso: $-120 + 85 + 140 = 105$.
D suma todas las cantidades sin considerar los signos: $120 + 85 + 140 = 345$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9999ebcd-da58-5e7b-9321-7aefb11725db', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-027
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('65f17951-0a61-5d48-9060-564bbdda4e57', 'm1-numeros-027', 'Catalina va a preparar sopaipillas para una once familiar en Chillán. Tiene $8\frac{1}{4}$ tazas de harina y cada tanda de masa requiere $2\frac{1}{2}$ tazas.

Si prepara $3$ tandas, ¿cuántas tazas de harina le sobran?', '[{"id":"A","content":"$\\frac{3}{4}$"},{"id":"B","content":"$1\\frac{1}{4}$"},{"id":"C","content":"$1\\frac{3}{4}$"},{"id":"D","content":"$5\\frac{3}{4}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Las tres tandas usan $3 \cdot 2\frac{1}{2} = 3 \cdot \frac{5}{2} = \frac{15}{2} = 7\frac{1}{2}$ tazas.
Sobran $8\frac{1}{4} - 7\frac{1}{2} = \frac{33}{4} - \frac{30}{4} = \frac{3}{4}$ de taza.
B resta por separado enteros y fracciones invirtiendo el orden de las fracciones: $(8-7) + (\frac{1}{2} - \frac{1}{4}) = 1\frac{1}{4}$.
C multiplica solo la parte entera: $3 \cdot 2 + \frac{1}{2} = 6\frac{1}{2}$, y $8\frac{1}{4} - 6\frac{1}{2} = 1\frac{3}{4}$.
D descuenta una sola tanda: $8\frac{1}{4} - 2\frac{1}{2} = 5\frac{3}{4}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '65f17951-0a61-5d48-9060-564bbdda4e57', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-028
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d8e0636b-d0b2-5241-91ae-5115d8b64907', 'm1-numeros-028', 'Un buzo que explora los fondos marinos de Isla de Pascua se encuentra a $18$ m bajo el nivel del mar. Primero sube una distancia igual a la tercera parte de esa profundidad y luego desciende $4$ m.

Si las posiciones bajo el nivel del mar se representan con números negativos, ¿cuál de las siguientes expresiones representa la posición final del buzo, en metros?', '[{"id":"A","content":"$-18 - \\frac{1}{3} \\cdot 18 + 4$"},{"id":"B","content":"$-18 + \\frac{1}{3} \\cdot (-18) - 4$"},{"id":"C","content":"$18 - \\frac{1}{3} \\cdot 18 - 4$"},{"id":"D","content":"$-18 + \\frac{1}{3} \\cdot 18 - 4$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El buzo parte en $-18$; subir $\frac{1}{3}$ de $18$ m es sumar $\frac{1}{3}\cdot 18 = 6$, y descender $4$ m es restar $4$: $-18 + \frac{1}{3}\cdot 18 - 4 = -16$.
A invierte el sentido de ambos movimientos (resta la subida y suma el descenso).
B toma un tercio de $-18$, lo que equivale a bajar $6$ m en lugar de subirlos.
C usa $18$ positivo como punto de partida, como si el buzo estuviera sobre el nivel del mar.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd8e0636b-d0b2-5241-91ae-5115d8b64907', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-029
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cbf16314-b9df-55f9-846f-df21927f3773', 'm1-numeros-029', 'Gaspar divide en su calculadora el costo de una cuenta y obtiene como resultado $0{,}1363636\ldots$, donde las cifras $36$ se repiten indefinidamente, es decir, el número $0{,}1\overline{36}$.

¿Cuál de las siguientes fracciones es igual a ese número?', '[{"id":"A","content":"$\\frac{135}{999}$"},{"id":"B","content":"$\\frac{136}{1\\,000}$"},{"id":"C","content":"$\\frac{3}{22}$"},{"id":"D","content":"$\\frac{136}{990}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Para un decimal semiperiódico: $0{,}1\overline{36} = \frac{136 - 1}{990} = \frac{135}{990} = \frac{3}{22}$. Comprobación: $3 : 22 = 0{,}13636\ldots$
A usa el denominador $999$, propio de un periodo de tres cifras sin anteperiodo.
B considera solo el decimal finito $0{,}136$ y descarta el periodo.
D no resta el anteperiodo en el numerador ($136$ en lugar de $135$).', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cbf16314-b9df-55f9-846f-df21927f3773', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-030
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2b393a12-2f9d-5b10-9014-f46ec135072d', 'm1-numeros-030', 'En un terminal de buses de Rancagua, los buses con destino a Santiago salen cada $12$ minutos y los buses con destino a San Fernando salen cada $18$ minutos. A las $6{:}30$ horas salió un bus hacia cada destino al mismo tiempo.

Sin contar la salida de las $6{:}30$ horas, ¿a qué hora vuelven a salir juntos por tercera vez?', '[{"id":"A","content":"A las $7{:}06$ horas"},{"id":"B","content":"A las $7{:}42$ horas"},{"id":"C","content":"A las $8{:}18$ horas"},{"id":"D","content":"A las $10{:}06$ horas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los buses coinciden cada $\text{mcm}(12, 18) = 36$ minutos.
La tercera coincidencia ocurre $3 \cdot 36 = 108$ minutos después, es decir, $1$ hora y $48$ minutos tras las $6{:}30$: a las $8{:}18$ horas.
A corresponde a la primera coincidencia ($6{:}30 + 36$ min) y B a la segunda ($6{:}30 + 72$ min).
D usa el producto $12 \cdot 18 = 216$ minutos como si fuera el tiempo entre coincidencias.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2b393a12-2f9d-5b10-9014-f46ec135072d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-031
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1ad434ec-973e-599b-ab55-4b7f782438a2', 'm1-numeros-031', 'Durante cinco noches de invierno se registraron las siguientes temperaturas mínimas en San Pedro de Atacama, en grados Celsius:

$-3, \; -1, \; 2, \; -4, \; 1$

¿Cuál es el promedio de estas temperaturas mínimas?', '[{"id":"A","content":"$-2{,}2\\,^{\\circ}\\text{C}$"},{"id":"B","content":"$-1{,}6\\,^{\\circ}\\text{C}$"},{"id":"C","content":"$-1{,}25\\,^{\\circ}\\text{C}$"},{"id":"D","content":"$-1\\,^{\\circ}\\text{C}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'La suma es $-3 - 1 + 2 - 4 + 1 = -5$ y el promedio es $\frac{-5}{5} = -1$, es decir, $-1\,^{\circ}\text{C}$.
A considera todas las temperaturas como negativas: $\frac{-11}{5} = -2{,}2$.
B suma solo las temperaturas negativas: $\frac{-8}{5} = -1{,}6$.
C divide la suma correcta por $4$ en lugar de $5$: $\frac{-5}{4} = -1{,}25$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1ad434ec-973e-599b-ab55-4b7f782438a2', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-032
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('08cf2a0f-905e-5555-9cf6-75a8a06c3466', 'm1-numeros-032', 'Un camión aljibe reparte agua en sectores rurales de la comuna de Petorca. Al comenzar su recorrido, el estanque del camión está a $\frac{3}{4}$ de su capacidad. Después de entregar $2\,400$ litros, el estanque queda a $\frac{7}{20}$ de su capacidad.

¿Cuál es la capacidad total del estanque?', '[{"id":"A","content":"$1\\,800$ litros"},{"id":"B","content":"$3\\,200$ litros"},{"id":"C","content":"$6\\,000$ litros"},{"id":"D","content":"$9\\,600$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Lo entregado corresponde a $\frac{3}{4} - \frac{7}{20} = \frac{15}{20} - \frac{7}{20} = \frac{8}{20} = \frac{2}{5}$ de la capacidad.
Si $\frac{2}{5}$ de la capacidad son $2\,400$ litros, la capacidad es $2\,400 \cdot \frac{5}{2} = 6\,000$ litros.
A multiplica $2\,400$ por $\frac{3}{4}$ en lugar de plantear la diferencia de fracciones.
B divide $2\,400$ por $\frac{3}{4}$, como si se hubiera entregado toda el agua inicial.
D resta numeradores y denominadores por separado: $\frac{7-3}{20-4} = \frac{1}{4}$, y obtiene $2\,400 \cdot 4 = 9\,600$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '08cf2a0f-905e-5555-9cf6-75a8a06c3466', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-033
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0418a327-3ec8-5b3d-8446-532244d9cdaf', 'm1-numeros-033', 'En un liceo de Curicó, una prueba tiene $50$ puntos en total y se obtiene nota $4{,}0$ con $30$ puntos. Para puntajes $p$ mayores o iguales que $30$, la nota $N$ se calcula con el modelo

$\displaystyle N = 4 + \frac{3\,(p - 30)}{20}$

Sofía obtuvo $42$ puntos en la prueba. ¿Qué nota obtuvo?', '[{"id":"A","content":"$4{,}2$"},{"id":"B","content":"$4{,}6$"},{"id":"C","content":"$5{,}2$"},{"id":"D","content":"$5{,}8$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Reemplazando $p = 42$: $N = 4 + \frac{3 \cdot 12}{20} = 4 + \frac{36}{20} = 4 + 1{,}8 = 5{,}8$.
A suma primero $4 + 3$ y multiplica por $\frac{12}{20}$: $7 \cdot 0{,}6 = 4{,}2$, sin respetar la prioridad de las operaciones.
B omite el factor $3$: $4 + \frac{12}{20} = 4{,}6$.
C divide por $30$ en lugar de $20$: $4 + \frac{36}{30} = 5{,}2$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0418a327-3ec8-5b3d-8446-532244d9cdaf', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-034
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('20bbc0b4-28fb-5de5-8b1b-4c01c37958ef', 'm1-numeros-034', 'Matías calculó el valor de $-18 : (-3) \cdot 2 - (-4) \cdot (-5)$ de la siguiente manera:

Paso 1: $-18 : (-3) \cdot 2 = -18 : (-6)$
Paso 2: $-18 : (-6) = 3$
Paso 3: $(-4) \cdot (-5) = 20$
Paso 4: $3 - 20 = -17$

¿En cuál de los pasos Matías cometió un error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La división y la multiplicación tienen la misma prioridad y se resuelven de izquierda a derecha: $-18 : (-3) \cdot 2 = 6 \cdot 2 = 12$. En el Paso 1, Matías multiplicó primero $(-3) \cdot 2$, lo que es incorrecto.
El valor correcto de la expresión es $12 - 20 = -8$.
Los Pasos 2, 3 y 4 son cálculos correctos a partir de lo obtenido antes: $-18 : (-6) = 3$, $(-4)\cdot(-5) = 20$ y $3 - 20 = -17$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '20bbc0b4-28fb-5de5-8b1b-4c01c37958ef', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-035
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7e17e6a3-6332-504f-96e0-80501bcfff50', 'm1-numeros-035', 'En una feria de Temuco, Joaquín vende huevos solo en bandejas llenas de $6$ o de $9$ unidades. Un cliente le pide exactamente $50$ huevos y Joaquín le responde que no es posible entregarle esa cantidad usando solo bandejas llenas, combinando bandejas de ambos tamaños si es necesario.

¿Cuál de los siguientes argumentos justifica correctamente la respuesta de Joaquín?', '[{"id":"A","content":"Porque $50$ no es múltiplo de $6$ ni de $9$."},{"id":"B","content":"Porque $6$ y $9$ son múltiplos de $3$, entonces cualquier total de huevos en bandejas llenas es múltiplo de $3$, y $50$ no lo es."},{"id":"C","content":"Porque $50$ es un número par y $9$ es un número impar."},{"id":"D","content":"Porque $6 \\cdot 9 = 54$ es mayor que $50$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Con $a$ bandejas de $6$ y $b$ de $9$ el total es $6a + 9b = 3(2a + 3b)$, siempre múltiplo de $3$. Como $50$ no es múltiplo de $3$, no se puede.
A no es un argumento válido: $15$ tampoco es múltiplo de $6$ ni de $9$, pero sí se forma con una bandeja de cada tipo.
C no es válido: con dos bandejas de $9$ y una de $6$ se obtienen $24$ huevos, un número par.
D no es válido: el producto $6 \cdot 9$ no tiene relación con las combinaciones posibles (por ejemplo, $6 + 9 = 15 < 54$ sí se puede formar).', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7e17e6a3-6332-504f-96e0-80501bcfff50', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-036
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('bd13454e-182f-5e17-9f3d-eca34abbfbaa', 'm1-numeros-036', 'Una familia viajará en auto de Santiago a Concepción, un trayecto de $504$ km, y compara el rendimiento de dos autos. En una prueba, el auto P recorrió $52{,}5$ km con $3{,}5$ litros de bencina y el auto Q recorrió $63$ km con $4{,}5$ litros.

Si el rendimiento de cada auto se mantiene constante, ¿cuántos litros más de bencina que el auto P usaría el auto Q en el trayecto?', '[{"id":"A","content":"$2{,}4$ litros"},{"id":"B","content":"$24$ litros"},{"id":"C","content":"$33{,}6$ litros"},{"id":"D","content":"$36$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'El auto P rinde $52{,}5 : 3{,}5 = 15$ km por litro y el auto Q, $63 : 4{,}5 = 14$ km por litro.
En $504$ km, P usa $504 : 15 = 33{,}6$ litros y Q usa $504 : 14 = 36$ litros. La diferencia es $36 - 33{,}6 = 2{,}4$ litros.
B ubica mal la coma decimal en la diferencia.
C es el consumo total del auto P y D, el consumo total del auto Q; ninguno responde la diferencia pedida.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'bd13454e-182f-5e17-9f3d-eca34abbfbaa', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-037
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2e74a9b1-6ec8-545e-a655-c6c9f0678c5e', 'm1-numeros-037', 'Un supermercado de Chillán recibió $250$ sandías y el $8\%$ de ellas llegó en mal estado.

¿Cuántas sandías llegaron en buen estado?', '[{"id":"A","content":"$20$"},{"id":"B","content":"$92$"},{"id":"C","content":"$230$"},{"id":"D","content":"$242$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Llegó en buen estado el $100\% - 8\% = 92\%$ de las sandías: $0{,}92 \cdot 250 = 230$.
A corresponde a las sandías en mal estado: $0{,}08 \cdot 250 = 20$.
B confunde el porcentaje $92\%$ con la cantidad de sandías.
D resta $8$ unidades en lugar del $8\%$: $250 - 8 = 242$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2e74a9b1-6ec8-545e-a655-c6c9f0678c5e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-038
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('db7d8147-62c3-58ff-a2b3-2b17cab4ba5d', 'm1-numeros-038', 'En un curso de $32$ estudiantes de un colegio de Coyhaique, $12$ estudiantes usan anteojos.

¿Qué porcentaje de los estudiantes del curso no usa anteojos?', '[{"id":"A","content":"$12\\%$"},{"id":"B","content":"$20\\%$"},{"id":"C","content":"$37{,}5\\%$"},{"id":"D","content":"$62{,}5\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'No usan anteojos $32 - 12 = 20$ estudiantes, y $\frac{20}{32} = 0{,}625$, es decir, el $62{,}5\%$.
A y B confunden la cantidad de estudiantes con el porcentaje.
C es el porcentaje de estudiantes que sí usa anteojos: $\frac{12}{32} = 0{,}375$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'db7d8147-62c3-58ff-a2b3-2b17cab4ba5d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-039
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5f63491e-1cce-54b5-ba36-a1ab609afd29', 'm1-numeros-039', 'En una estación de servicio de Los Ángeles, el precio del litro de bencina pasó de $1\,250$ pesos a $1\,300$ pesos.

¿En qué porcentaje aumentó el precio del litro de bencina?', '[{"id":"A","content":"En aproximadamente un $3{,}8\\%$"},{"id":"B","content":"En un $4\\%$"},{"id":"C","content":"En un $50\\%$"},{"id":"D","content":"En un $104\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El aumento fue de $1\,300 - 1\,250 = 50$ pesos, y respecto del precio inicial: $\frac{50}{1\,250} = 0{,}04$, es decir, un $4\%$.
A calcula el aumento respecto del precio final: $\frac{50}{1\,300} \approx 0{,}038$.
C confunde el aumento en pesos con el porcentaje.
D interpreta $\frac{1\,300}{1\,250} = 1{,}04$ como un aumento del $104\%$, cuando ese cociente indica que el precio nuevo es el $104\%$ del anterior.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5f63491e-1cce-54b5-ba36-a1ab609afd29', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-040
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d3c1ceba-3964-506d-8b5f-ce49ceb30d74', 'm1-numeros-040', 'Una tienda de un mall de Antofagasta ofrece un $30\%$ de descuento en zapatillas. Además, quienes pagan con la tarjeta de la tienda reciben un $10\%$ de descuento adicional sobre el precio ya rebajado.

Valentina paga con la tarjeta de la tienda unas zapatillas cuyo precio original es $60\,000$ pesos. ¿Cuánto paga?', '[{"id":"A","content":"$36\\,000$ pesos"},{"id":"B","content":"$37\\,800$ pesos"},{"id":"C","content":"$42\\,000$ pesos"},{"id":"D","content":"$46\\,200$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Con el primer descuento el precio queda en $0{,}7 \cdot 60\,000 = 42\,000$ pesos, y con el segundo, en $0{,}9 \cdot 42\,000 = 37\,800$ pesos.
A suma los descuentos como si fuera uno solo del $40\%$: $0{,}6 \cdot 60\,000 = 36\,000$, pero el $10\%$ se aplica sobre el precio rebajado.
C aplica solo el primer descuento.
D suma el $10\%$ en lugar de descontarlo: $42\,000 + 4\,200 = 46\,200$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd3c1ceba-3964-506d-8b5f-ce49ceb30d74', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-041
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9c51df92-cac0-5f7b-a507-2703e59fb45f', 'm1-numeros-041', 'Una fábrica de néctares de Los Andes tiene $40$ litros de néctar de durazno cuyo $15\%$ corresponde a pulpa de fruta. Para una nueva línea de productos, quiere agregar agua a esa mezcla de modo que la pulpa pase a ser el $12\%$ del total.

¿Cuántos litros de agua debe agregar?', '[{"id":"A","content":"$1{,}2$ litros"},{"id":"B","content":"$4{,}8$ litros"},{"id":"C","content":"$10$ litros"},{"id":"D","content":"$50$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'La cantidad de pulpa no cambia: $0{,}15 \cdot 40 = 6$ litros.
Si esos $6$ litros deben ser el $12\%$ del total, el total es $6 : 0{,}12 = 50$ litros, por lo que hay que agregar $50 - 40 = 10$ litros de agua.
A calcula la diferencia de porcentajes sobre la mezcla inicial: $3\%$ de $40$ es $1{,}2$.
B calcula el $12\%$ de $40$ litros.
D es la cantidad total de la nueva mezcla, no el agua que se agrega.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9c51df92-cac0-5f7b-a507-2703e59fb45f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-042
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cf6e18cb-3260-5c3b-837a-9efb77ef54d8', 'm1-numeros-042', 'A los trabajadores de una empresa de Concepción se les descuenta de su sueldo bruto un $10\%$ para el fondo de pensiones y un $7\%$ para salud. Ambos porcentajes se calculan sobre el sueldo bruto.

Si $S$ es el sueldo bruto en pesos, ¿cuál de las siguientes expresiones representa el sueldo que recibe un trabajador después de estos dos descuentos?', '[{"id":"A","content":"$0{,}83\\,S$"},{"id":"B","content":"$0{,}9 \\cdot 0{,}93\\,S$"},{"id":"C","content":"$S - 0{,}17$"},{"id":"D","content":"$S - 17$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Los descuentos suman $10\% + 7\% = 17\%$ del sueldo bruto, por lo que el trabajador recibe el $83\%$: $S - 0{,}17\,S = 0{,}83\,S$.
B aplica el $7\%$ sobre el sueldo ya descontado, lo que no corresponde porque ambos se calculan sobre $S$.
C resta $0{,}17$ pesos en lugar del $17\%$ de $S$.
D resta $17$ pesos, confundiendo el porcentaje con una cantidad fija.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cf6e18cb-3260-5c3b-837a-9efb77ef54d8', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-043
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d508c382-3daa-553b-ab3d-88f6fc97bc6b', 'm1-numeros-043', 'Una tienda de electrodomésticos de Valparaíso calcula el precio final de sus productos con la expresión

$\displaystyle P_f = P \cdot \left(1 - \frac{d}{100}\right) \cdot 1{,}19$

donde $P$ es el precio de lista sin impuesto, $d$ es el porcentaje de descuento y $1{,}19$ incorpora el IVA.

Si un microondas tiene un precio de lista sin impuesto de $50\,000$ pesos y su precio final es $47\,600$ pesos, ¿cuál es el porcentaje de descuento aplicado?', '[{"id":"A","content":"$4{,}8\\%$"},{"id":"B","content":"$19\\%$"},{"id":"C","content":"$20\\%$"},{"id":"D","content":"$80\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Se despeja: $50\,000 \cdot \left(1 - \frac{d}{100}\right) = \frac{47\,600}{1{,}19} = 40\,000$, entonces $1 - \frac{d}{100} = 0{,}8$ y $d = 20$.
A compara directamente $47\,600$ con $50\,000$ sin quitar el IVA: $\frac{2\,400}{50\,000} = 4{,}8\%$.
B confunde el descuento con el porcentaje del IVA.
D iguala $\frac{d}{100}$ a $0{,}8$, cuando $0{,}8$ es la fracción del precio que se paga.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd508c382-3daa-553b-ab3d-88f6fc97bc6b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-044
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7f9af0a9-dee6-5cf3-9c3c-46668529639c', 'm1-numeros-044', 'En un liceo de Quilicura, el porcentaje de estudiantes que votó en la elección del centro de estudiantes fue de $40\%$ en 2024 y de $50\%$ en 2025. En ambos años el liceo tuvo la misma cantidad de estudiantes.

¿Cuál de las siguientes afirmaciones es correcta respecto de la participación?', '[{"id":"A","content":"Aumentó en $10$ puntos porcentuales, lo que equivale a un aumento del $25\\%$ respecto de la participación de 2024."},{"id":"B","content":"Aumentó en un $10\\%$ respecto de la participación de 2024."},{"id":"C","content":"Aumentó en $25$ puntos porcentuales respecto de la participación de 2024."},{"id":"D","content":"Aumentó en un $50\\%$ respecto de la participación de 2024."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La diferencia entre $50\%$ y $40\%$ es de $10$ puntos porcentuales. En términos relativos, el aumento es $\frac{50 - 40}{40} = 0{,}25$, es decir, un $25\%$ respecto de 2024. Por ejemplo, con $1\,000$ estudiantes votaron $400$ y luego $500$: $100$ más, que es el $25\%$ de $400$.
B confunde los puntos porcentuales con el aumento porcentual.
C confunde el aumento relativo ($25\%$) con la diferencia en puntos porcentuales.
D toma el porcentaje de 2025 como si fuera el aumento.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7f9af0a9-dee6-5cf3-9c3c-46668529639c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-045
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1b2306ac-ec16-5cfd-9239-28f197cdb085', 'm1-numeros-045', '¿Cuál es el valor de $(-3)^{2} - 3^{2} + 2^{-1} \cdot 4$?', '[{"id":"A","content":"$-16$"},{"id":"B","content":"$-8$"},{"id":"C","content":"$2$"},{"id":"D","content":"$20$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Se tiene $(-3)^{2} = 9$, $3^{2} = 9$ y $2^{-1} \cdot 4 = \frac{1}{2} \cdot 4 = 2$. Entonces $9 - 9 + 2 = 2$.
A calcula $(-3)^{2}$ como $-9$: $-9 - 9 + 2 = -16$.
B interpreta el exponente negativo como un signo: $2^{-1} = -2$, y obtiene $9 - 9 - 8 = -8$.
D resta $-9$ en lugar de $9$: $9 + 9 + 2 = 20$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1b2306ac-ec16-5cfd-9239-28f197cdb085', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-046
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('22ba0706-28bd-505b-ae9e-69883c6dbb15', 'm1-numeros-046', 'En un laboratorio de una universidad de Concepción se midió con un microscopio el diámetro de un glóbulo rojo y se obtuvo $0{,}0000075$ metros.

¿Cuál de las siguientes expresiones corresponde a esta medida escrita en notación científica?', '[{"id":"A","content":"$7{,}5 \\cdot 10^{-7}$ m"},{"id":"B","content":"$7{,}5 \\cdot 10^{-6}$ m"},{"id":"C","content":"$7{,}5 \\cdot 10^{-5}$ m"},{"id":"D","content":"$7{,}5 \\cdot 10^{6}$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Para pasar de $0{,}0000075$ a $7{,}5$ la coma se desplaza $6$ lugares a la derecha, por lo que $0{,}0000075 = 7{,}5 \cdot 10^{-6}$.
A desplaza la coma un lugar de más ( en vez de 20 20 12 61 79 80 81 98 701 33 100 204 250 395 398 399 400.
C cuenta solo los ceros después de la coma ($5$).
D usa exponente positivo, que corresponde a un número muy grande.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '22ba0706-28bd-505b-ae9e-69883c6dbb15', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-047
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f42551a9-3d90-582d-8984-73ac22036b88', 'm1-numeros-047', 'Una faena minera de la Región de Antofagasta extrae $5{,}5 \cdot 10^{6}$ toneladas de mineral al año. Cada viaje de uno de sus camiones de extracción traslada $2{,}5 \cdot 10^{2}$ toneladas.

¿Cuántos viajes de camión se necesitan para trasladar el mineral extraído en un año?', '[{"id":"A","content":"$2{,}2 \\cdot 10^{3}$"},{"id":"B","content":"$2{,}2 \\cdot 10^{4}$"},{"id":"C","content":"$3 \\cdot 10^{4}$"},{"id":"D","content":"$1{,}375 \\cdot 10^{9}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Se divide: $\frac{5{,}5 \cdot 10^{6}}{2{,}5 \cdot 10^{2}} = \frac{5{,}5}{2{,}5} \cdot 10^{6-2} = 2{,}2 \cdot 10^{4}$ viajes.
A se equivoca en un orden de magnitud al restar los exponentes y obtiene ^{3} lugar de ^{4}170
C resta las partes decimales ($5{,}5 - 2{,}5 = 3$) en lugar de dividirlas.
D multiplica las cantidades: $5{,}5 \cdot 2{,}5 \cdot 10^{6+2} = 13{,}75 \cdot 10^{8}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f42551a9-3d90-582d-8984-73ac22036b88', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-048
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6e9c8342-9889-5eb4-b8c1-4649955fd3e7', 'm1-numeros-048', 'Ignacio tiene una tarjeta de memoria para su cámara fotográfica con una capacidad de $2^{8}$ GB. Cada fotografía que toma ocupa $2^{2}$ MB y se sabe que $1$ GB equivale a $2^{10}$ MB.

¿Cuántas fotografías caben como máximo en la tarjeta de memoria?', '[{"id":"A","content":"$2^{6}$"},{"id":"B","content":"$2^{16}$"},{"id":"C","content":"$2^{20}$"},{"id":"D","content":"$2^{78}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'La capacidad en MB es $2^{8} \cdot 2^{10} = 2^{18}$ MB. La cantidad de fotografías es $\frac{2^{18}}{2^{2}} = 2^{16}$.
A no convierte los GB a MB: $\frac{2^{8}}{2^{2}} = 2^{6}$.
C multiplica por $2^{2}$ en lugar de dividir: $2^{18} \cdot 2^{2} = 2^{20}$.
D multiplica los exponentes al convertir ($2^{8 \cdot 10} = 2^{80}$) y luego divide por $2^{2}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6e9c8342-9889-5eb4-b8c1-4649955fd3e7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-049
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('06b68204-e61b-59f3-af39-048cb63fde1a', 'm1-numeros-049', '¿Cuál de los siguientes argumentos justifica correctamente que el número $5^{20} - 5^{19}$ es múltiplo de $4$?', '[{"id":"A","content":"Que $5^{20}$ y $5^{19}$ son números impares y la diferencia de dos números impares es un número par."},{"id":"B","content":"Que $5^{20} - 5^{19} = 5^{20 - 19} = 5$ y que $5 - 1 = 4$."},{"id":"C","content":"Que $5^{20}$ y $5^{19}$ son, cada uno, múltiplos de $4$."},{"id":"D","content":"Que $5^{20} - 5^{19} = 5^{19} \\cdot (5 - 1) = 4 \\cdot 5^{19}$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Factorizando por $5^{19}$: $5^{20} - 5^{19} = 5^{19} \cdot 5 - 5^{19} \cdot 1 = 5^{19}(5 - 1) = 4 \cdot 5^{19}$, que es múltiplo de $4$.
A solo asegura que el número es par, no que sea múltiplo de $4$ (por ejemplo, $9 - 3 = 6$ no es múltiplo de $4$).
B aplica una propiedad falsa: la resta de potencias de igual base no equivale a restar los exponentes.
C es falsa: las potencias de $5$ son impares, por lo que no son múltiplos de $4$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '06b68204-e61b-59f3-af39-048cb63fde1a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-050
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d5977bbd-8fa9-5863-8651-8cbc8a66ca0a', 'm1-numeros-050', 'En aguas poco profundas, la rapidez $v$ de una ola, en metros por segundo, se puede modelar con la expresión $v = \sqrt{10\,h}$, donde $h$ es la profundidad del agua en metros. Un grupo de surfistas de Pichilemu estudia cómo cambia la rapidez de las olas al variar la profundidad.

¿Por cuánto se debe multiplicar la profundidad $h$ para que la rapidez de la ola se triplique?', '[{"id":"A","content":"Por $\\sqrt{3}$"},{"id":"B","content":"Por $3$"},{"id":"C","content":"Por $6$"},{"id":"D","content":"Por $9$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Si la profundidad se multiplica por $k$: $\sqrt{10\,k\,h} = \sqrt{k}\cdot\sqrt{10\,h}$. Para que la rapidez se triplique se necesita $\sqrt{k} = 3$, es decir, $k = 9$. Por ejemplo, con $h = 2{,}5$ m la rapidez es $5$ m/s, y con $h = 22{,}5$ m es $\sqrt{225} = 15$ m/s.
A invierte la relación: multiplicar por $\sqrt{3}$ solo multiplica la rapidez por $\sqrt[4]{3}$.
B supone que la rapidez es proporcional a la profundidad; con $k = 3$ la rapidez se multiplica por $\sqrt{3}$.
C duplica el factor $3$ en lugar de elevarlo al cuadrado.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd5977bbd-8fa9-5863-8651-8cbc8a66ca0a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-051
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7948731c-9f91-5ab1-a11c-e988572a1df5', 'm1-numeros-051', 'En un edificio de un hospital de Viña del Mar, los niveles se numeran con números enteros consecutivos: el nivel de la calle es el $0$ y los subterráneos se indican con números negativos. Un camillero toma el ascensor en el nivel $-3$, sube $8$ niveles, luego baja $2$ niveles y finalmente sube $6$ niveles.

¿En qué nivel termina el camillero?', '[{"id":"A","content":"$3$"},{"id":"B","content":"$9$"},{"id":"C","content":"$13$"},{"id":"D","content":"$15$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'El nivel final es $-3 + 8 - 2 + 6 = 9$.
A omite el último movimiento: $-3 + 8 - 2 = 3$.
C suma los $2$ niveles que bajó: $-3 + 8 + 2 + 6 = 13$.
D toma el nivel inicial como $3$ en lugar de $-3$: $3 + 8 - 2 + 6 = 15$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7948731c-9f91-5ab1-a11c-e988572a1df5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-052
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3bcc762b-18b9-528a-9dd0-69dbe886887c', 'm1-numeros-052', 'Una costurera de Ancud necesita un trozo de cinta cuya longitud, en metros, sea mayor que $\frac{5}{8}$ y menor que $0{,}7$.

¿Cuál de los siguientes trozos de cinta cumple esta condición?', '[{"id":"A","content":"$0{,}6$ m"},{"id":"B","content":"$0{,}62$ m"},{"id":"C","content":"$\\frac{2}{3}$ m"},{"id":"D","content":"$0{,}72$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Como $\frac{5}{8} = 0{,}625$, se busca una longitud entre $0{,}625$ m y $0{,}7$ m. Además, $\frac{2}{3} = 0{,}666\ldots$, que cumple $0{,}625 < 0{,}666\ldots < 0{,}7$.
A es menor que $\frac{5}{8}$.
B parece cumplir si se aproxima $\frac{5}{8}$ a $0{,}6$, pero $0{,}62 < 0{,}625$.
D es mayor que $0{,}7$; se elige al comparar mal $0{,}72$ con $0{,}7$ por la cantidad de cifras.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3bcc762b-18b9-528a-9dd0-69dbe886887c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-053
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5d9865ef-a481-5aa5-8271-03eaad5b368d', 'm1-numeros-053', 'Una artesana de Quinchamalí tiene $84$ tazas y $120$ platos de greda. Quiere armar la mayor cantidad posible de cajas de regalo idénticas, de modo que todas las cajas tengan la misma cantidad de tazas y la misma cantidad de platos, sin que sobre ninguna pieza.

¿Cuántas piezas en total, entre tazas y platos, tendrá cada caja?', '[{"id":"A","content":"$7$"},{"id":"B","content":"$10$"},{"id":"C","content":"$12$"},{"id":"D","content":"$17$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La mayor cantidad de cajas es el máximo común divisor de $84$ y $120$: $84 = 2^{2} \cdot 3 \cdot 7$ y $120 = 2^{3} \cdot 3 \cdot 5$, así que $\text{MCD} = 12$ cajas.
Cada caja lleva $84 : 12 = 7$ tazas y $120 : 12 = 10$ platos, es decir, $17$ piezas.
A y B consideran solo las tazas o solo los platos de cada caja.
C es la cantidad de cajas, no la cantidad de piezas por caja.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5d9865ef-a481-5aa5-8271-03eaad5b368d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-054
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3f2c6c51-84f6-5c25-bd90-b41ce616c581', 'm1-numeros-054', 'Lucía y Diego pintarán un mural en una escuela de Arica. Lucía, trabajando sola, pintaría el mural completo en $4$ horas, y Diego, trabajando solo, lo pintaría en $6$ horas. Ambos trabajan juntos durante $1$ hora; luego Lucía se retira y Diego termina solo lo que falta, a su mismo ritmo.

¿Cuántos minutos trabaja Diego solo?', '[{"id":"A","content":"$35$"},{"id":"B","content":"$144$"},{"id":"C","content":"$210$"},{"id":"D","content":"$300$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'En una hora, Lucía pinta $\frac{1}{4}$ del mural y Diego $\frac{1}{6}$; juntos pintan $\frac{1}{4} + \frac{1}{6} = \frac{5}{12}$. Falta $\frac{7}{12}$ del mural.
Diego pinta $\frac{1}{6}$ por hora, así que necesita $\frac{7}{12} : \frac{1}{6} = \frac{7}{2}$ horas, es decir, $210$ minutos.
A interpreta la fracción que falta, $\frac{7}{12}$, como horas: $\frac{7}{12} \cdot 60 = 35$ minutos.
B es el tiempo que tardarían los dos juntos en pintar todo el mural: $\frac{12}{5}$ h $= 144$ minutos.
D descuenta solo lo que pintó Diego en la primera hora: le faltaría $\frac{5}{6}$, que pinta en $5$ h $= 300$ minutos.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3f2c6c51-84f6-5c25-bd90-b41ce616c581', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-055
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('17e90128-db13-5c8b-b444-1b115e3daea2', 'm1-numeros-055', 'Un reloj de péndulo de una casona antigua de Valparaíso se atrasa $\frac{3}{4}$ de minuto cada hora, siempre al mismo ritmo.

¿Cuál de las siguientes expresiones representa la cantidad de minutos que se habrá atrasado el reloj después de $d$ días completos?', '[{"id":"A","content":"$18d$"},{"id":"B","content":"$24d + \\frac{3}{4}$"},{"id":"C","content":"$32d$"},{"id":"D","content":"$\\frac{3}{4}d$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Un día tiene $24$ horas, así que en un día el reloj se atrasa $24 \cdot \frac{3}{4} = 18$ minutos. En $d$ días se atrasa $18d$ minutos.
B suma el atraso por hora en lugar de multiplicarlo por las horas.
C divide $24$ por $\frac{3}{4}$ en lugar de multiplicar.
D usa el atraso por hora como si fuera el atraso por día.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '17e90128-db13-5c8b-b444-1b115e3daea2', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m1-numeros-056
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('87474a56-32a3-5279-9ed9-1adf0a9f9492', 'm1-numeros-056', 'En una viña del valle del Elqui se cosecharon $1\,800$ kg de uva. El $35\%$ de la cosecha se destinó a la elaboración de pisco.

¿Cuántos kilogramos de uva se destinaron a la elaboración de pisco?', '[{"id":"A","content":"$630$"},{"id":"B","content":"$1\\,170$"},{"id":"C","content":"$1\\,765$"},{"id":"D","content":"$1\\,835$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El $35\%$ de $1\,800$ es $0{,}35 \cdot 1\,800 = 630$ kg.
B corresponde al $65\%$ restante, es decir, a la uva que no se destinó a pisco.
C resta $35$ kg al total, como si el porcentaje fuera una cantidad de kilogramos.
D suma $35$ kg al total con el mismo error.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '87474a56-32a3-5279-9ed9-1adf0a9f9492', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-057
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5774ae00-cd55-5f22-8157-17d888451667', 'm1-numeros-057', 'En una laguna altiplánica de la Región de Antofagasta, un equipo de guardaparques contó $300$ flamencos este año. Esta cantidad es un $20\%$ mayor que la registrada el año anterior.

¿Cuántos flamencos se registraron el año anterior?', '[{"id":"A","content":"$240$"},{"id":"B","content":"$250$"},{"id":"C","content":"$280$"},{"id":"D","content":"$360$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Si $x$ es la cantidad del año anterior, entonces $1{,}2x = 300$, de donde $x = 300 : 1{,}2 = 250$. Comprobación: el $20\%$ de $250$ es $50$ y $250 + 50 = 300$.
A calcula el $20\%$ de descuento sobre $300$; pero el $20\%$ se aplica sobre la cantidad del año anterior, no sobre $300$.
C resta $20$ flamencos, confundiendo el porcentaje con una cantidad.
D aumenta $300$ en un $20\%$ en lugar de retroceder.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5774ae00-cd55-5f22-8157-17d888451667', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-058
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6e173249-73e5-5b63-bb2a-f868341f2827', 'm1-numeros-058', 'En Quilpué se consultó a los hogares de dos villas si reciclan sus residuos. En la villa Los Aromos, de $2\,000$ hogares, recicla el $30\%$. En la villa El Sauce, de $1\,200$ hogares, recicla el $45\%$.

¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"En la villa El Sauce reciclan más hogares que en la villa Los Aromos, porque $45\\% > 30\\%$."},{"id":"B","content":"Considerando ambas villas juntas, recicla el $75\\%$ de los hogares."},{"id":"C","content":"En la villa Los Aromos reciclan $60$ hogares más que en la villa El Sauce."},{"id":"D","content":"Considerando ambas villas juntas, recicla el $37{,}5\\%$ de los hogares."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'En Los Aromos reciclan $0{,}30 \cdot 2\,000 = 600$ hogares y en El Sauce, $0{,}45 \cdot 1\,200 = 540$. La diferencia es $600 - 540 = 60$ hogares, así que C es verdadera.
A compara solo los porcentajes, sin considerar que las villas tienen distinta cantidad de hogares.
B suma los porcentajes, que se refieren a totales distintos.
D promedia los porcentajes sin ponderar; el porcentaje real es $\frac{1\,140}{3\,200} = 35{,}625\%$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6e173249-73e5-5b63-bb2a-f868341f2827', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-059
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b02f2abe-7280-5fa3-8d7c-88aa42559fe6', 'm1-numeros-059', 'En una tienda de muebles de Calama, el sueldo mensual de cada vendedor se calcula así: recibe un sueldo base de $450\,000$ pesos y, además, una comisión del $3\%$ sobre la parte de sus ventas mensuales que excede los $2\,000\,000$ de pesos. Si vende $2\,000\,000$ de pesos o menos, recibe solo el sueldo base.

Si un vendedor vendió $v$ pesos en un mes, con $v > 2\,000\,000$, ¿cuál de las siguientes expresiones representa su sueldo $S$ de ese mes, en pesos?', '[{"id":"A","content":"$S = 450\\,000 + 0{,}03v$"},{"id":"B","content":"$S = 450\\,000 + 3(v - 2\\,000\\,000)$"},{"id":"C","content":"$S = 0{,}03(450\\,000 + v - 2\\,000\\,000)$"},{"id":"D","content":"$S = 450\\,000 + 0{,}03(v - 2\\,000\\,000)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'La comisión se calcula solo sobre el excedente, que es $v - 2\,000\,000$, y el $3\%$ equivale a multiplicar por $0{,}03$. Por lo tanto, $S = 450\,000 + 0{,}03(v - 2\,000\,000)$. Por ejemplo, si vende $3\,000\,000$ de pesos, gana $450\,000 + 30\,000 = 480\,000$ pesos.
A aplica la comisión sobre el total vendido y no solo sobre el excedente.
B multiplica por $3$ en lugar de $0{,}03$.
C aplica el $3\%$ también al sueldo base.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b02f2abe-7280-5fa3-8d7c-88aa42559fe6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-060
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ba351cdf-a987-503e-94b0-7a8e8ba81d7b', 'm1-numeros-060', 'La directiva de una junta de vecinos de Puente Alto distribuyó su presupuesto anual así: $\frac{2}{5}$ del presupuesto para mantener las áreas verdes, $0{,}25$ del presupuesto para mejorar la iluminación y el resto para actividades culturales.

¿Qué porcentaje del presupuesto se destinó a actividades culturales?', '[{"id":"A","content":"$35\\%$"},{"id":"B","content":"$57{,}5\\%$"},{"id":"C","content":"$60\\%$"},{"id":"D","content":"$73\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, '$\frac{2}{5} = 40\%$ y $0{,}25 = 25\%$. Entre ambas partidas suman $65\%$, así que el resto es $100\% - 65\% = 35\%$.
B interpreta $0{,}25$ como $2{,}5\%$: $100 - 40 - 2{,}5 = 57{,}5$.
C descuenta solo las áreas verdes.
D interpreta $\frac{2}{5}$ como $2\%$: $100 - 2 - 25 = 73$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ba351cdf-a987-503e-94b0-7a8e8ba81d7b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m1-numeros-061
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('10b0f8d0-c955-5672-b228-ca23215d787d', 'm1-numeros-061', '¿Cuál es el valor de $\left(\frac{2}{3}\right)^{-2} \cdot 3^{-1}$?', '[{"id":"A","content":"$-\\frac{3}{4}$"},{"id":"B","content":"$\\frac{4}{27}$"},{"id":"C","content":"$\\frac{3}{4}$"},{"id":"D","content":"$\\frac{27}{4}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Un exponente negativo invierte la base: $\left(\frac{2}{3}\right)^{-2} = \left(\frac{3}{2}\right)^{2} = \frac{9}{4}$ y $3^{-1} = \frac{1}{3}$. Luego, $\frac{9}{4} \cdot \frac{1}{3} = \frac{3}{4}$.
A cree que el exponente negativo cambia el signo del resultado.
B no invierte la primera base: $\frac{4}{9} \cdot \frac{1}{3} = \frac{4}{27}$.
D toma $3^{-1}$ como $3$: $\frac{9}{4} \cdot 3 = \frac{27}{4}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '10b0f8d0-c955-5672-b228-ca23215d787d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-062
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2bfac68b-9a28-52c0-8b22-dda271b6c47b', 'm1-numeros-062', 'Se estima que el corazón de una persona en reposo late, en promedio, $70$ veces por minuto.

Si se mantiene ese ritmo, ¿cuál de las siguientes expresiones representa mejor la cantidad de latidos en un año de $365$ días?', '[{"id":"A","content":"$3{,}7 \\cdot 10^{4}$"},{"id":"B","content":"$3{,}7 \\cdot 10^{5}$"},{"id":"C","content":"$3{,}7 \\cdot 10^{6}$"},{"id":"D","content":"$3{,}7 \\cdot 10^{7}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'En un año hay $60 \cdot 24 \cdot 365 = 525\,600$ minutos, así que el corazón late $70 \cdot 525\,600 = 36\,792\,000$ veces. Este número tiene $8$ cifras enteras, por lo que en notación científica es aproximadamente $3{,}7 \cdot 10^{7}$.
C resulta de olvidar el factor $10$ al escribir $70 = 7 \cdot 10$: $7 \cdot 525\,600 = 3\,679\,200 \approx 3{,}7 \cdot 10^{6}$.
A y B cuentan mal las cifras del resultado y usan un exponente aún menor.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2bfac68b-9a28-52c0-8b22-dda271b6c47b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-numeros-063
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d1a7f5a4-c677-5bef-b292-cb33629520a5', 'm1-numeros-063', '¿Cuál es el valor de $\displaystyle \frac{2^{10} + 2^{9}}{2^{8} - 2^{6}}$?', '[{"id":"A","content":"$4$"},{"id":"B","content":"$8$"},{"id":"C","content":"$12$"},{"id":"D","content":"$32$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Se factoriza la menor potencia en cada parte: $2^{10} + 2^{9} = 2^{9}(2 + 1) = 3 \cdot 2^{9}$ y $2^{8} - 2^{6} = 2^{6}(4 - 1) = 3 \cdot 2^{6}$. Entonces el cociente es $\frac{3 \cdot 2^{9}}{3 \cdot 2^{6}} = 2^{3} = 8$.
A considera solo los primeros términos: $2^{10} : 2^{8} = 4$.
C divide término a término, lo que no es válido en una suma: $\frac{2^{10}}{2^{8}} + \frac{2^{9}}{2^{6}} = 4 + 8$.
D suma exponentes en el numerador y en el denominador como si fueran productos: $\frac{2^{19}}{2^{14}} = 2^{5}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd1a7f5a4-c677-5bef-b292-cb33629520a5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm1' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('65b025ef-9164-50c2-9c1b-2b0e0170527b', 'm1-probabilidad-y-estadistica-001', 'En un curso de un liceo de Talca se preguntó a los $40$ estudiantes cuántos hermanos tienen. Los resultados se muestran en la siguiente tabla:

$\displaystyle \begin{array}{|c|c|}\hline \text{Cantidad de hermanos} & \text{Cantidad de estudiantes} \\ \hline 0 & 6 \\ \hline 1 & 14 \\ \hline 2 & 12 \\ \hline 3 & 6 \\ \hline 4 & 2 \\ \hline \end{array}$

¿Qué porcentaje de los estudiantes del curso tiene al menos $2$ hermanos?', '[{"id":"A","content":"$20\\%$"},{"id":"B","content":"$30\\%$"},{"id":"C","content":"$50\\%$"},{"id":"D","content":"$80\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, '"Al menos $2$" significa $2$, $3$ o $4$ hermanos: $12 + 6 + 2 = 20$ estudiantes. Entonces $\frac{20}{40} = 0{,}5 = 50\%$.
A cuenta solo a los que tienen más de $2$ hermanos ($8$ estudiantes). B cuenta solo a los que tienen exactamente $2$. D corresponde a "a lo más $2$" ($6 + 14 + 12 = 32$ estudiantes), es decir, interpreta la condición al revés.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '65b025ef-9164-50c2-9c1b-2b0e0170527b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d0380d89-70d7-54bf-8162-7c2df30b344f', 'm1-probabilidad-y-estadistica-002', 'Benjamín tiene las siguientes notas en las primeras cuatro pruebas de Física: $5{,}0$; $5{,}6$; $4{,}8$ y $5{,}4$. Le falta una quinta prueba, que tiene la misma ponderación que las anteriores.

¿Qué nota debe obtener en la quinta prueba para que el promedio de las cinco notas sea exactamente $5{,}4$?', '[{"id":"A","content":"$5{,}4$"},{"id":"B","content":"$5{,}6$"},{"id":"C","content":"$6{,}0$"},{"id":"D","content":"$6{,}2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Para tener promedio $5{,}4$ con cinco notas, la suma debe ser $5 \cdot 5{,}4 = 27$. La suma actual es $5{,}0 + 5{,}6 + 4{,}8 + 5{,}4 = 20{,}8$, así que la nota que falta es $27 - 20{,}8 = 6{,}2$.
A supone que basta con obtener el promedio deseado. B promedia el promedio actual ($5{,}2$) con la nota nueva, como si ambos pesaran lo mismo: $\frac{5{,}2 + x}{2} = 5{,}4$. C suma el déficit acumulado $4 \cdot 0{,}2 = 0{,}8$ al promedio actual $5{,}2$ en vez de sumarlo al promedio deseado $5{,}4$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd0380d89-70d7-54bf-8162-7c2df30b344f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d7d50405-6815-5a77-a67f-ab76f77f4114', 'm1-probabilidad-y-estadistica-003', 'Se encuestó a $60$ personas de Concepción sobre el medio de transporte que más usan para ir a su trabajo o lugar de estudio. Los datos de un gráfico de barras se resumen en la siguiente tabla:

$\displaystyle \begin{array}{|c|c|}\hline \text{Medio de transporte} & \text{Cantidad de personas} \\ \hline \text{Micro} & 24 \\ \hline \text{Biotren} & 10 \\ \hline \text{Automóvil} & 16 \\ \hline \text{Bicicleta} & 6 \\ \hline \text{A pie} & 4 \\ \hline \end{array}$

Si estos mismos datos se representan en un gráfico circular, ¿cuál es la medida del ángulo del sector que corresponde a Automóvil?', '[{"id":"A","content":"$16^\\circ$"},{"id":"B","content":"$57{,}6^\\circ$"},{"id":"C","content":"$72^\\circ$"},{"id":"D","content":"$96^\\circ$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El ángulo es proporcional a la frecuencia: $\frac{16}{60} \cdot 360^\circ = 96^\circ$.
A usa directamente la frecuencia como si fuera el ángulo. B interpreta $16$ como porcentaje y calcula el $16\%$ de $360^\circ$. C reparte los $360^\circ$ en partes iguales entre las $5$ categorías, sin considerar las frecuencias.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd7d50405-6815-5a77-a67f-ab76f77f4114', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a5a0e1d8-d725-5bf6-bb57-6a3f0050a090', 'm1-probabilidad-y-estadistica-004', 'La tabla muestra la cantidad de goles que marcó un club de fútbol de Coquimbo en cada uno de los $20$ partidos que jugó en una temporada.

$\displaystyle \begin{array}{|c|c|}\hline \text{Goles en el partido} & \text{Cantidad de partidos} \\ \hline 0 & 4 \\ \hline 1 & 7 \\ \hline 2 & 5 \\ \hline 3 & 3 \\ \hline 4 & 1 \\ \hline \end{array}$

De acuerdo con la información de la tabla, ¿cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"La media de goles por partido es $2$."},{"id":"B","content":"En el $55\\%$ de los partidos el club marcó a lo más $1$ gol."},{"id":"C","content":"La moda de los goles por partido es $7$."},{"id":"D","content":"La mediana de los goles por partido es mayor que la media."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'En a lo más $1$ gol hay $4 + 7 = 11$ partidos, y $\frac{11}{20} = 55\%$, por lo que B es verdadera.
A es falsa: la media es $\frac{0 \cdot 4 + 1 \cdot 7 + 2 \cdot 5 + 3 \cdot 3 + 4 \cdot 1}{20} = \frac{30}{20} = 1{,}5$; el valor $2$ sale de promediar los valores $0, 1, 2, 3, 4$ sin considerar las frecuencias.
C es falsa: la moda es $1$ gol; $7$ es su frecuencia. D es falsa: los datos de las posiciones $10$ y $11$ valen $1$, así que la mediana es $1$, menor que $1{,}5$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a5a0e1d8-d725-5bf6-bb57-6a3f0050a090', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('96d39fe5-8ef1-5bee-a0e8-4a125c99eabf', 'm1-probabilidad-y-estadistica-005', 'En un colegio de Puente Alto, el 3.° medio A tiene $30$ estudiantes y su promedio de notas en Matemática es $5{,}6$. El 3.° medio B tiene $20$ estudiantes y su promedio es $6{,}1$.

¿Cuál de las siguientes expresiones permite calcular el promedio de notas en Matemática de los $50$ estudiantes de ambos cursos en conjunto?', '[{"id":"A","content":"$\\displaystyle \\frac{5{,}6 + 6{,}1}{2}$"},{"id":"B","content":"$\\displaystyle \\frac{30 \\cdot 5{,}6 + 20 \\cdot 6{,}1}{50}$"},{"id":"C","content":"$\\displaystyle \\frac{30 \\cdot 6{,}1 + 20 \\cdot 5{,}6}{50}$"},{"id":"D","content":"$\\displaystyle \\frac{30 \\cdot 5{,}6 + 20 \\cdot 6{,}1}{2}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La suma de las notas del 3.° A es $30 \cdot 5{,}6$ y la del 3.° B es $20 \cdot 6{,}1$. El promedio conjunto es la suma total dividida por los $50$ estudiantes, lo que da $\frac{168 + 122}{50} = 5{,}8$.
A promedia los dos promedios como si ambos cursos tuvieran la misma cantidad de estudiantes. C cruza los tamaños con los promedios. D suma bien las notas, pero divide por la cantidad de cursos en lugar de la cantidad de estudiantes.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '96d39fe5-8ef1-5bee-a0e8-4a125c99eabf', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('356b1b59-d0e9-51ba-ac18-1f7a0438e9ff', 'm1-probabilidad-y-estadistica-006', 'Se encuestó a $200$ personas de Antofagasta sobre su deporte favorito. Los resultados se muestran en la tabla, donde falta el dato de básquetbol:

$\displaystyle \begin{array}{|c|c|}\hline \text{Deporte} & \text{Cantidad de personas} \\ \hline \text{Fútbol} & 70 \\ \hline \text{Básquetbol} & x \\ \hline \text{Tenis} & 30 \\ \hline \text{Natación} & 40 \\ \hline \text{Otros} & 20 \\ \hline \end{array}$

¿Qué porcentaje de los encuestados prefiere el básquetbol?', '[{"id":"A","content":"$20\\%$"},{"id":"B","content":"$25\\%$"},{"id":"C","content":"$40\\%$"},{"id":"D","content":"$80\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Como el total es $200$, se tiene $x = 200 - (70 + 30 + 40 + 20) = 40$ personas, y $\frac{40}{200} = 20\%$.
B divide $40$ por $160$, que es la suma de las otras categorías y no el total. C confunde la cantidad de personas ($40$) con el porcentaje. D es el porcentaje de quienes no prefieren el básquetbol.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '356b1b59-d0e9-51ba-ac18-1f7a0438e9ff', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('15982f66-2bd6-53d3-b34a-2f04d76f9ae2', 'm1-probabilidad-y-estadistica-007', 'En un club de lectura de Puerto Montt se registró cuántos libros leyó cada socio durante el año:

$\displaystyle \begin{array}{|c|c|}\hline \text{Libros leídos} & \text{Cantidad de socios} \\ \hline 1 & 3 \\ \hline 2 & 5 \\ \hline 3 & 8 \\ \hline 4 & 4 \\ \hline \end{array}$

Ignacio calculó la media de libros leídos por socio de la siguiente manera:

Paso 1: El total de socios es $3 + 5 + 8 + 4 = 20$.
Paso 2: Multiplicó cada valor por su frecuencia: $1 \cdot 3 = 3$, $2 \cdot 5 = 10$, $3 \cdot 8 = 24$ y $4 \cdot 4 = 16$.
Paso 3: Sumó los productos, obtuvo $53$, y dividió por $1 + 2 + 3 + 4 = 10$, con lo que obtuvo $5{,}3$.
Paso 4: Concluyó que cada socio leyó, en promedio, $5{,}3$ libros en el año.

¿En qué paso cometió Ignacio el primer error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los pasos 1 y 2 son correctos. En el paso 3 la suma de los productos ($53$) debe dividirse por el total de datos, es decir, por los $20$ socios, y no por la suma de los valores de la variable. La media correcta es $\frac{53}{20} = 2{,}65$ libros.
El paso 4 también es incorrecto, pero solo arrastra el error del paso 3; además, una media de $5{,}3$ es imposible porque ningún socio leyó más de $4$ libros.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '15982f66-2bd6-53d3-b34a-2f04d76f9ae2', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6c800915-6c84-5982-b8a7-193ea5286ea1', 'm1-probabilidad-y-estadistica-008', 'La tabla muestra la frecuencia absoluta de cada valor de un conjunto de datos, donde $a$ es un número entero positivo.

$\displaystyle \begin{array}{|c|c|}\hline \text{Valor} & \text{Frecuencia absoluta} \\ \hline 2 & 4 \\ \hline 4 & a \\ \hline 6 & 5 \\ \hline 8 & 3 \\ \hline \end{array}$

Si la frecuencia relativa del valor $4$ es $0{,}25$, ¿cuál es el valor de $a$?', '[{"id":"A","content":"$3$"},{"id":"B","content":"$4$"},{"id":"C","content":"$12$"},{"id":"D","content":"$16$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El total de datos es $12 + a$, por lo que $\frac{a}{12 + a} = 0{,}25$. Entonces $a = 3 + 0{,}25a$, es decir, $0{,}75a = 3$ y $a = 4$. Se comprueba: $\frac{4}{16} = 0{,}25$.
A calcula el $25\%$ de $12$, olvidando que $a$ también forma parte del total. C es la suma de las otras frecuencias. D es el total de datos, no la frecuencia del valor $4$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6c800915-6c84-5982-b8a7-193ea5286ea1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a9d6c555-7d85-5954-9429-64b3ccce6e85', 'm1-probabilidad-y-estadistica-009', 'El promedio de estatura de las $12$ jugadoras de un equipo de vóleibol de Iquique es $1{,}80$ m. Se incorpora una nueva jugadora y el promedio de estatura de las $13$ jugadoras pasa a ser $1{,}81$ m.

¿Cuál es la estatura de la nueva jugadora?', '[{"id":"A","content":"$1{,}82$ m"},{"id":"B","content":"$1{,}92$ m"},{"id":"C","content":"$1{,}93$ m"},{"id":"D","content":"$1{,}94$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'La suma de las estaturas de las $12$ jugadoras es $12 \cdot 1{,}80 = 21{,}60$ m, y la de las $13$ es $13 \cdot 1{,}81 = 23{,}53$ m. La nueva mide $23{,}53 - 21{,}60 = 1{,}93$ m.
Otra forma de verlo: la nueva jugadora mide $1{,}81$ m más los $0{,}01$ m que "aporta" a cada una de las otras $12$, es decir, $1{,}81 + 0{,}12 = 1{,}93$ m.
A solo suma $0{,}01$ al nuevo promedio. B suma $0{,}12$ al promedio antiguo y no al nuevo. D suma $13 \cdot 0{,}01$, contando también a la nueva jugadora.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a9d6c555-7d85-5954-9429-64b3ccce6e85', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c6f6afe7-b7ff-5b4b-a0ce-239393cf245f', 'm1-probabilidad-y-estadistica-010', 'Camila registró los minutos que tardó en llegar en bicicleta a su trabajo en Viña del Mar durante $9$ días:

$12, \ 20, \ 9, \ 15, \ 18, \ 11, \ 14, \ 16, \ 13$

¿Cuál es la mediana de estos tiempos?', '[{"id":"A","content":"$11$ minutos"},{"id":"B","content":"$14$ minutos"},{"id":"C","content":"$14{,}5$ minutos"},{"id":"D","content":"$18$ minutos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Ordenados de menor a mayor: $9, 11, 12, 13, 14, 15, 16, 18, 20$. Como son $9$ datos, la mediana es el dato de la posición $5$, es decir, $14$ minutos.
A es el rango ($20 - 9$). C es el promedio entre el mínimo y el máximo. D es el dato central de la lista sin ordenar.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c6f6afe7-b7ff-5b4b-a0ce-239393cf245f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d7bd9f61-45b2-581c-abea-6a895de9aedb', 'm1-probabilidad-y-estadistica-011', 'Los puntajes que obtuvieron $200$ estudiantes de un preuniversitario de Rancagua en un ensayo se representaron en un diagrama de cajón, cuyo resumen de cinco números es:

$\displaystyle \begin{array}{|c|c|c|c|c|}\hline \text{Mínimo} & Q_1 & \text{Mediana} & Q_3 & \text{Máximo} \\ \hline 420 & 560 & 640 & 720 & 890 \\ \hline \end{array}$

¿Cuál de las siguientes afirmaciones es correcta?', '[{"id":"A","content":"Aproximadamente el $75\\%$ de los estudiantes obtuvo más de $720$ puntos."},{"id":"B","content":"Aproximadamente el $50\\%$ de los estudiantes obtuvo entre $560$ y $720$ puntos."},{"id":"C","content":"El rango intercuartil de los puntajes es $470$ puntos."},{"id":"D","content":"Aproximadamente la mitad de los estudiantes obtuvo menos de $560$ puntos."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Entre $Q_1 = 560$ y $Q_3 = 720$ se encuentra aproximadamente el $50\%$ central de los datos, por lo que B es correcta.
A es falsa: sobre $Q_3$ queda cerca del $25\%$, no del $75\%$. C es falsa: $470 = 890 - 420$ es el rango; el rango intercuartil es $720 - 560 = 160$. D es falsa: bajo $Q_1$ queda cerca del $25\%$; la mitad queda bajo la mediana, $640$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd7bd9f61-45b2-581c-abea-6a895de9aedb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('25121286-4410-5c7f-8e5a-91244579df5e', 'm1-probabilidad-y-estadistica-012', 'Se registró el tiempo de traslado, en minutos, que $40$ trabajadores de Santiago tardan en llegar a su lugar de trabajo:

$\displaystyle \begin{array}{|c|c|}\hline \text{Tiempo (min)} & \text{Cantidad de trabajadores} \\ \hline 10 & 6 \\ \hline 20 & 10 \\ \hline 30 & 12 \\ \hline 40 & 8 \\ \hline 50 & 4 \\ \hline \end{array}$

Considera que el percentil $80$ es el dato que ocupa la posición $0{,}8 \cdot 40$ cuando los datos se ordenan de menor a mayor. ¿Cuál es el percentil $80$ de estos tiempos?', '[{"id":"A","content":"$20$ minutos"},{"id":"B","content":"$30$ minutos"},{"id":"C","content":"$32$ minutos"},{"id":"D","content":"$40$ minutos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La posición es $0{,}8 \cdot 40 = 32$. Las frecuencias acumuladas son $6, 16, 28, 36, 40$: los datos de las posiciones $29$ a $36$ valen $40$, así que $P_{80} = 40$ minutos.
A corresponde al percentil $20$ (contar el $80\%$ desde los valores mayores). B se detiene en la frecuencia acumulada $28$, que aún no alcanza la posición $32$. C confunde la posición del dato con su valor.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '25121286-4410-5c7f-8e5a-91244579df5e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('79b03bf0-1956-50e8-940b-b970e0c8ab6a', 'm1-probabilidad-y-estadistica-013', 'Las notas finales de Lenguaje de dos cursos de un liceo de Arica se resumen en la siguiente tabla, que muestra los cinco números de sus diagramas de cajón:

$\displaystyle \begin{array}{|c|c|c|c|c|c|}\hline \text{Curso} & \text{Mínimo} & Q_1 & \text{Mediana} & Q_3 & \text{Máximo} \\ \hline \text{A} & 2{,}8 & 4{,}5 & 5{,}4 & 6{,}1 & 6{,}9 \\ \hline \text{B} & 3{,}5 & 4{,}9 & 5{,}2 & 5{,}8 & 7{,}0 \\ \hline \end{array}$

A partir de esta información, ¿cuál de las siguientes afirmaciones se puede concluir?', '[{"id":"A","content":"El rango intercuartil de las notas del curso A es mayor que el del curso B."},{"id":"B","content":"El promedio de notas del curso A es mayor que el del curso B."},{"id":"C","content":"En el curso B hay más estudiantes con nota mayor que $5{,}2$ que en el curso A."},{"id":"D","content":"El rango de las notas del curso B es mayor que el del curso A."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'El rango intercuartil del curso A es $6{,}1 - 4{,}5 = 1{,}6$ y el del B es $5{,}8 - 4{,}9 = 0{,}9$, por lo que A se puede concluir.
B no se puede concluir: el diagrama de cajón no entrega la media, y una mediana mayor no garantiza un promedio mayor. C no se puede concluir porque no se conoce la cantidad de estudiantes de cada curso. D es falsa: el rango de A es $6{,}9 - 2{,}8 = 4{,}1$ y el de B es $7{,}0 - 3{,}5 = 3{,}5$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '79b03bf0-1956-50e8-940b-b970e0c8ab6a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-014
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('db2e505a-f84d-5aea-8937-e3e4b17ba50e', 'm1-probabilidad-y-estadistica-014', 'Considera el siguiente conjunto de datos:

$12, \ 5, \ 15, \ 7, \ 3, \ 12, \ 9, \ 5$

Si los cuartiles $Q_1$ y $Q_3$ se calculan como las medianas de la mitad inferior y de la mitad superior de los datos ordenados, respectivamente, ¿cuál es el rango intercuartil del conjunto?', '[{"id":"A","content":"$7$"},{"id":"B","content":"$8$"},{"id":"C","content":"$10$"},{"id":"D","content":"$12$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Ordenados: $3, 5, 5, 7, 9, 12, 12, 15$. La mitad inferior es $3, 5, 5, 7$, cuya mediana es $Q_1 = 5$; la superior es $9, 12, 12, 15$, con $Q_3 = 12$. El rango intercuartil es $12 - 5 = 7$.
B es la mediana del conjunto, $\frac{7 + 9}{2} = 8$. C resta $Q_1$ al máximo ($15 - 5$), confundiendo $Q_3$ con el máximo. D es el rango, $15 - 3$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'db2e505a-f84d-5aea-8937-e3e4b17ba50e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-015
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c666305d-afec-53cd-940c-bb4d277ea2d2', 'm1-probabilidad-y-estadistica-015', 'En un conjunto de $250$ datos ordenados de menor a mayor, el percentil $64$ es igual a $37$.

Según el significado del percentil, ¿aproximadamente cuántos datos del conjunto son menores o iguales que $37$?', '[{"id":"A","content":"$37$"},{"id":"B","content":"$64$"},{"id":"C","content":"$90$"},{"id":"D","content":"$160$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'El percentil $64$ es el valor bajo el cual (o hasta el cual) se encuentra aproximadamente el $64\%$ de los datos. Entonces, la cantidad de datos menores o iguales que $37$ es aproximadamente $0{,}64 \cdot 250 = 160$.
A confunde el valor del percentil con una cantidad de datos. B confunde el $64\%$ con $64$ datos. C es la cantidad aproximada de datos mayores que $37$, es decir, $250 - 160$.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c666305d-afec-53cd-940c-bb4d277ea2d2', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-016
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('61a3b2bd-a646-597d-9877-18a0078af4fc', 'm1-probabilidad-y-estadistica-016', 'Durante $7$ días, Tomás anotó los minutos de atraso de la micro que toma cada mañana en Temuco:

$4, \ 6, \ 7, \ 9, \ 10, \ 12, \ 15$

Luego se dio cuenta de que anotó mal el último dato: en lugar de $15$, debía ser $50$. Al corregir ese dato, ¿cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"La media aumenta en $5$ minutos y la mediana no cambia."},{"id":"B","content":"La media y la mediana aumentan en $5$ minutos cada una."},{"id":"C","content":"La media no cambia y la mediana aumenta."},{"id":"D","content":"La media aumenta en $35$ minutos y la mediana no cambia."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La suma de los datos aumenta en $50 - 15 = 35$ minutos, así que la media aumenta en $\frac{35}{7} = 5$ minutos (de $9$ a $14$). La mediana es el dato central, $9$, y no cambia, porque el dato corregido sigue siendo el mayor.
B supone que la mediana se comporta como la media. C invierte el efecto: la mediana es resistente a valores extremos, pero la media no. D olvida dividir el aumento de la suma por la cantidad de datos.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '61a3b2bd-a646-597d-9877-18a0078af4fc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-017
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1501cb1a-c19b-5b95-a27c-b5da21010c2b', 'm1-probabilidad-y-estadistica-017', 'La tabla muestra las edades de los $24$ participantes de una corrida familiar en La Serena:

$\displaystyle \begin{array}{|c|c|}\hline \text{Edad (años)} & \text{Cantidad de participantes} \\ \hline 15 & 3 \\ \hline 18 & 5 \\ \hline 21 & 6 \\ \hline 25 & 5 \\ \hline 30 & 3 \\ \hline 35 & 2 \\ \hline \end{array}$

Con estos datos, todos los métodos usuales para calcular cuartiles entregan el mismo resultado. ¿Cuál es el rango intercuartil de las edades?', '[{"id":"A","content":"$3$ años"},{"id":"B","content":"$4$ años"},{"id":"C","content":"$7$ años"},{"id":"D","content":"$20$ años"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Las frecuencias acumuladas son $3, 8, 14, 19, 22, 24$. Para $Q_1$ se miran las posiciones $6$ y $7$, que valen $18$; para $Q_3$, las posiciones $18$ y $19$, que valen $25$. Así, $Q_1 = 18$, $Q_3 = 25$ y el rango intercuartil es $25 - 18 = 7$ años.
A resta $Q_1$ a la mediana ($21 - 18$) y B resta la mediana a $Q_3$ ($25 - 21$): cada una mide solo la mitad de la caja. D es el rango, $35 - 15$.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1501cb1a-c19b-5b95-a27c-b5da21010c2b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-018
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('09528726-c828-5a6e-b75e-38845f0be21e', 'm1-probabilidad-y-estadistica-018', 'En la kermés de un colegio de Chillán hay una tómbola con $5$ bolitas rojas, $3$ azules y $4$ verdes, todas del mismo tamaño. Si Florencia saca una bolita al azar, ¿cuál es la probabilidad de que no sea azul?', '[{"id":"A","content":"$\\dfrac{1}{4}$"},{"id":"B","content":"$\\dfrac{1}{3}$"},{"id":"C","content":"$\\dfrac{5}{12}$"},{"id":"D","content":"$\\dfrac{3}{4}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Hay $5 + 3 + 4 = 12$ bolitas, de las cuales $9$ no son azules. La probabilidad es $\frac{9}{12} = \frac{3}{4}$. También se obtiene como $1 - \frac{3}{12}$.
A es la probabilidad de que sea azul (no se aplicó el complemento). B es la probabilidad de que sea verde y C la de que sea roja: cada una considera solo uno de los colores que no son azules.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '09528726-c828-5a6e-b75e-38845f0be21e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-019
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5e76d050-a803-5ba2-ab72-821b3e8164f0', 'm1-probabilidad-y-estadistica-019', 'En un curso de $40$ estudiantes de Osorno, $22$ practican fútbol, $15$ practican básquetbol y $8$ practican ambos deportes. Si se elige al azar a un estudiante del curso, ¿cuál es la probabilidad de que practique al menos uno de estos dos deportes?', '[{"id":"A","content":"$\\dfrac{8}{40}$"},{"id":"B","content":"$\\dfrac{11}{40}$"},{"id":"C","content":"$\\dfrac{21}{40}$"},{"id":"D","content":"$\\dfrac{29}{40}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Por la regla de la adición, $P(F \cup B) = P(F) + P(B) - P(F \cap B) = \frac{22}{40} + \frac{15}{40} - \frac{8}{40} = \frac{29}{40}$.
A es la probabilidad de practicar ambos deportes. B es la probabilidad de no practicar ninguno ($40 - 29 = 11$ estudiantes). C resta dos veces la intersección ($22 + 15 - 16$). Si no se restara la intersección se obtendría $\frac{37}{40}$, contando dos veces a quienes practican ambos.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5e76d050-a803-5ba2-ab72-821b3e8164f0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-020
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9c3d8cbd-ef0b-555a-ac55-9b2b135ead89', 'm1-probabilidad-y-estadistica-020', 'En un liceo de Puerto Varas se consultó a $80$ estudiantes de 3.° y 4.° medio si usan bicicleta para llegar al liceo. Los resultados se muestran en la tabla:

$\displaystyle \begin{array}{|c|c|c|c|}\hline  & \text{Usa bicicleta} & \text{No usa bicicleta} & \text{Total} \\ \hline \text{Tercero medio} & 12 & 28 & 40 \\ \hline \text{Cuarto medio} & 18 & 22 & 40 \\ \hline \text{Total} & 30 & 50 & 80 \\ \hline \end{array}$

Si se elige al azar a uno de estos $80$ estudiantes, ¿cuál es la probabilidad de que sea de 4.° medio y use bicicleta?', '[{"id":"A","content":"$\\dfrac{9}{40}$"},{"id":"B","content":"$\\dfrac{3}{8}$"},{"id":"C","content":"$\\dfrac{9}{20}$"},{"id":"D","content":"$\\dfrac{3}{5}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Se busca la intersección: hay $18$ estudiantes de 4.° medio que usan bicicleta entre los $80$ consultados, por lo que la probabilidad es $\frac{18}{80} = \frac{9}{40}$.
B es la probabilidad de usar bicicleta ($\frac{30}{80}$), sin considerar el curso. C divide por los $40$ estudiantes de 4.° medio, como si ya se supiera que el elegido es de ese curso. D divide por los $30$ que usan bicicleta, como si ya se supiera que la usa.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9c3d8cbd-ef0b-555a-ac55-9b2b135ead89', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-021
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7bbd06e3-b69d-565d-938b-e1716fd4c22b', 'm1-probabilidad-y-estadistica-021', 'Se lanza un dado común de seis caras. Se definen los eventos:

$A$: obtener un número primo.
$B$: obtener un número par.

¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"Los eventos $A$ y $B$ son mutuamente excluyentes."},{"id":"B","content":"$P(A \\cup B) = \\dfrac{5}{6}$"},{"id":"C","content":"$P(A \\cap B) = \\dfrac{1}{2}$"},{"id":"D","content":"$P(A \\cup B) = P(A) + P(B)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, '$A = \{2, 3, 5\}$ y $B = \{2, 4, 6\}$. Entonces $A \cup B = \{2, 3, 4, 5, 6\}$ y $P(A \cup B) = \frac{5}{6}$, por lo que B es verdadera.
A es falsa: ambos eventos comparten el $2$. C es falsa: $A \cap B = \{2\}$, así que $P(A \cap B) = \frac{1}{6}$. D es falsa: $P(A) + P(B) = 1$, porque al sumar se cuenta dos veces el $2$; la suma directa solo vale para eventos mutuamente excluyentes.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7bbd06e3-b69d-565d-938b-e1716fd4c22b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-022
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('48e111b6-ae21-5b4b-90ca-9feaa964bc62', 'm1-probabilidad-y-estadistica-022', 'Una caja contiene $6$ pilas del mismo tipo: $4$ funcionan y $2$ están descargadas. Martina saca dos pilas al azar, una tras otra y sin reposición. ¿Cuál es la probabilidad de que ambas pilas funcionen?', '[{"id":"A","content":"$\\dfrac{2}{5}$"},{"id":"B","content":"$\\dfrac{4}{9}$"},{"id":"C","content":"$\\dfrac{8}{15}$"},{"id":"D","content":"$\\dfrac{2}{3}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'La probabilidad de que la primera funcione es $\frac{4}{6}$. Sin reposición quedan $5$ pilas, de las cuales $3$ funcionan, así que la probabilidad de que la segunda también funcione es $\frac{3}{5}$. Por la regla del producto: $\frac{4}{6} \cdot \frac{3}{5} = \frac{12}{30} = \frac{2}{5}$.
B supone que hay reposición: $\left(\frac{4}{6}\right)^2 = \frac{4}{9}$. C es la probabilidad de que exactamente una funcione. D considera solo la primera extracción.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '48e111b6-ae21-5b4b-90ca-9feaa964bc62', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-023
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f90cf7d5-6045-5aa5-af61-88a0268a357d', 'm1-probabilidad-y-estadistica-023', 'En cierta época del año, la probabilidad de que llueva en un día cualquiera en Valdivia es $0{,}6$. Suponiendo que lo que ocurre en un día es independiente de lo que ocurre en otro, ¿cuál es la probabilidad de que llueva en exactamente uno de dos días consecutivos?', '[{"id":"A","content":"$0{,}24$"},{"id":"B","content":"$0{,}36$"},{"id":"C","content":"$0{,}48$"},{"id":"D","content":"$0{,}84$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Hay dos casos excluyentes: llueve el primer día y no el segundo ($0{,}6 \cdot 0{,}4 = 0{,}24$), o no llueve el primero y sí el segundo ($0{,}4 \cdot 0{,}6 = 0{,}24$). La suma es $0{,}48$.
A considera solo uno de los dos órdenes. B es la probabilidad de que llueva ambos días ($0{,}6^2$). D es la probabilidad de que llueva al menos un día ($1 - 0{,}4^2$), que incluye el caso en que llueve los dos días.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f90cf7d5-6045-5aa5-af61-88a0268a357d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-024
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('676b2ec2-69fe-5149-b1cf-e190c80b9fe3', 'm1-probabilidad-y-estadistica-024', 'Javiera quiere calcular la probabilidad de obtener exactamente un $6$ al lanzar dos dados comunes de seis caras. Su desarrollo es el siguiente:

Paso 1: La probabilidad de no obtener $6$ en un dado es $\frac{5}{6}$.
Paso 2: La probabilidad de no obtener ningún $6$ en los dos dados es $\frac{5}{6} \cdot \frac{5}{6} = \frac{25}{36}$.
Paso 3: La probabilidad de obtener al menos un $6$ es $1 - \frac{25}{36} = \frac{11}{36}$.
Paso 4: Por lo tanto, la probabilidad de obtener exactamente un $6$ es $\frac{11}{36}$.

¿En qué paso cometió Javiera el primer error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Los pasos 1, 2 y 3 son correctos: $\frac{11}{36}$ es la probabilidad de obtener al menos un $6$. El error está en el paso 4, porque "al menos un $6$" incluye el resultado en que ambos dados muestran $6$. La probabilidad de exactamente un $6$ es $\frac{11}{36} - \frac{1}{36} = \frac{10}{36} = \frac{5}{18}$.
Elegir el paso 2 sería pensar que no se puede multiplicar, pero los dados son independientes. Elegir el paso 3 sería desconfiar del complemento, que está bien aplicado.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '676b2ec2-69fe-5149-b1cf-e190c80b9fe3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-025
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('978b72f2-3c66-5b4a-bd34-7ba2dad7911c', 'm1-probabilidad-y-estadistica-025', 'Se lanzan dos monedas y se registra el resultado de cada una, donde C representa cara y S representa sello. Por ejemplo, CS significa cara en la primera moneda y sello en la segunda.

¿Cuál de los siguientes conjuntos corresponde al evento «obtener al menos una cara»?', '[{"id":"A","content":"$\\{\\text{CC}\\}$"},{"id":"B","content":"$\\{\\text{CS}, \\text{SC}\\}$"},{"id":"C","content":"$\\{\\text{CC}, \\text{CS}, \\text{SC}\\}$"},{"id":"D","content":"$\\{\\text{CC}, \\text{CS}, \\text{SC}, \\text{SS}\\}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El espacio muestral es $\{\text{CC}, \text{CS}, \text{SC}, \text{SS}\}$. "Al menos una cara" significa una o dos caras, por lo que el evento es $\{\text{CC}, \text{CS}, \text{SC}\}$.
A corresponde a "obtener dos caras". B corresponde a "obtener exactamente una cara". D es el espacio muestral completo, que incluye SS, donde no hay ninguna cara.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '978b72f2-3c66-5b4a-bd34-7ba2dad7911c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-026
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('366a1ef7-0ff5-5613-b4d8-d578b125eb3d', 'm1-probabilidad-y-estadistica-026', 'Se preguntó a $50$ familias de Quilpué cuántas mascotas tienen en su hogar. Los resultados se muestran en la tabla:

$\displaystyle \begin{array}{|c|c|}\hline \text{Cantidad de mascotas} & \text{Cantidad de familias} \\ \hline 0 & 12 \\ \hline 1 & 18 \\ \hline 2 & 11 \\ \hline 3 & 6 \\ \hline 4 & 3 \\ \hline \end{array}$

¿Qué porcentaje de estas familias tiene más de $2$ mascotas?', '[{"id":"A","content":"$18\\%$"},{"id":"B","content":"$22\\%$"},{"id":"C","content":"$40\\%$"},{"id":"D","content":"$60\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Más de $2$ mascotas significa $3$ o $4$: son $6 + 3 = 9$ familias, y $\frac{9}{50} = 0{,}18 = 18\%$.
$22\%$ corresponde solo a las familias con exactamente $2$ mascotas ($\frac{11}{50}$).
$40\%$ incluye por error a las familias con $2$ mascotas ($\frac{20}{50}$), y $60\%$ es el porcentaje de familias con a lo más $1$ mascota.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '366a1ef7-0ff5-5613-b4d8-d578b125eb3d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-027
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9da52bff-4c30-59ae-a63f-134371b5bb3a', 'm1-probabilidad-y-estadistica-027', 'En un estudio sobre hábitos de descanso, $25$ estudiantes de un liceo de Curicó registraron cuántas horas durmieron la noche anterior a una prueba:

$\displaystyle \begin{array}{|c|c|}\hline \text{Horas de sueño} & \text{Cantidad de estudiantes} \\ \hline 5 & 3 \\ \hline 6 & 7 \\ \hline 7 & 9 \\ \hline 8 & 6 \\ \hline \end{array}$

¿Cuál es el promedio de horas de sueño de estos estudiantes?', '[{"id":"A","content":"$6{,}5$ horas"},{"id":"B","content":"$6{,}72$ horas"},{"id":"C","content":"$7$ horas"},{"id":"D","content":"$42$ horas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El promedio considera las frecuencias: $\frac{5 \cdot 3 + 6 \cdot 7 + 7 \cdot 9 + 8 \cdot 6}{25} = \frac{168}{25} = 6{,}72$ horas.
$6{,}5$ horas es el promedio de los valores $5, 6, 7$ y $8$ sin ponderar por la cantidad de estudiantes.
$7$ horas es la moda, y $42$ horas resulta de dividir la suma total $168$ por la cantidad de filas de la tabla ($4$) en lugar de por $25$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9da52bff-4c30-59ae-a63f-134371b5bb3a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-028
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('799e4989-872a-52e1-bb06-ede39456eb93', 'm1-probabilidad-y-estadistica-028', 'La biblioteca de un colegio de Melipilla registró, durante varios días, cuántos libros se prestaron cada día. En la tabla falta la cantidad de días en que se prestaron $2$ libros, que se representa con $x$:

$\displaystyle \begin{array}{|c|c|}\hline \text{Libros prestados en el día} & \text{Cantidad de días} \\ \hline 1 & 6 \\ \hline 2 & x \\ \hline 3 & 8 \\ \hline 4 & 6 \\ \hline \end{array}$

Si el promedio de libros prestados por día fue $2{,}5$, ¿cuál es el valor de $x$?', '[{"id":"A","content":"$4$"},{"id":"B","content":"$6$"},{"id":"C","content":"$8$"},{"id":"D","content":"$10$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'La suma de libros es $1 \cdot 6 + 2x + 3 \cdot 8 + 4 \cdot 6 = 54 + 2x$, y la cantidad de días es $20 + x$.
De $\frac{54 + 2x}{20 + x} = 2{,}5$ se obtiene $54 + 2x = 50 + 2{,}5x$, es decir, $0{,}5x = 4$ y $x = 8$.
Con $x = 4$, $x = 6$ o $x = 10$ los promedios serían $\frac{62}{24}$, $\frac{66}{26}$ y $\frac{74}{30}$, todos distintos de $2{,}5$; estos valores aparecen al despejar mal o al olvidar sumar $x$ a la cantidad de días.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '799e4989-872a-52e1-bb06-ede39456eb93', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-029
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1c544608-28b7-5906-9db6-b2399741d6fe', 'm1-probabilidad-y-estadistica-029', 'Se consultó a los trabajadores de una empresa de Rancagua por el medio de transporte que usan para llegar a su trabajo, y los resultados se presentaron en un gráfico circular. Los porcentajes de cada sector se resumen en la tabla, donde falta el valor correspondiente a auto:

$\displaystyle \begin{array}{|c|c|}\hline \text{Medio de transporte} & \text{Porcentaje} \\ \hline \text{Bus} & 35\% \\ \hline \text{Metro} & 25\% \\ \hline \text{Auto} & p\% \\ \hline \text{Bicicleta} & 15\% \\ \hline \text{A pie} & 10\% \\ \hline \end{array}$

Si $42$ trabajadores llegan en bicicleta, ¿cuántos trabajadores más llegan en bus que en auto?', '[{"id":"A","content":"$20$"},{"id":"B","content":"$28$"},{"id":"C","content":"$42$"},{"id":"D","content":"$56$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Como los porcentajes suman $100\%$, $p = 100 - 35 - 25 - 15 - 10 = 15$.
El $15\%$ del total corresponde a $42$ trabajadores, así que el total es $\frac{42}{0{,}15} = 280$.
En bus llegan $0{,}35 \cdot 280 = 98$ y en auto $0{,}15 \cdot 280 = 42$; la diferencia es $56$.
$20$ es la diferencia en puntos porcentuales, no en personas; $28$ compara bus con metro ($10\%$ de $280$); $42$ es la cantidad que llega en auto, no la diferencia.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1c544608-28b7-5906-9db6-b2399741d6fe', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-030
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d1330545-3267-51a9-94a1-04d09695278f', 'm1-probabilidad-y-estadistica-030', 'Se preguntó a $15$ socios de un club de cine de Valparaíso cuántas veces fueron al cine el mes pasado. Sus respuestas fueron:

$2, \ 0, \ 1, \ 3, \ 1, \ 2, \ 1, \ 0, \ 4, \ 1, \ 2, \ 1, \ 3, \ 1, \ 2$

¿Cuál de las siguientes tablas de frecuencia absoluta representa correctamente estos datos?', '[{"id":"A","content":"$\\begin{array}{|c|c|c|c|c|c|}\\hline \\text{Veces} & 0 & 1 & 2 & 3 & 4 \\\\ \\hline \\text{Frecuencia} & 2 & 5 & 4 & 3 & 1 \\\\ \\hline \\end{array}$"},{"id":"B","content":"$\\begin{array}{|c|c|c|c|c|c|}\\hline \\text{Veces} & 0 & 1 & 2 & 3 & 4 \\\\ \\hline \\text{Frecuencia} & 2 & 6 & 4 & 2 & 1 \\\\ \\hline \\end{array}$"},{"id":"C","content":"$\\begin{array}{|c|c|c|c|c|c|}\\hline \\text{Veces} & 0 & 1 & 2 & 3 & 4 \\\\ \\hline \\text{Frecuencia} & 2 & 6 & 4 & 2 & 2 \\\\ \\hline \\end{array}$"},{"id":"D","content":"$\\begin{array}{|c|c|c|c|c|c|}\\hline \\text{Veces} & 0 & 1 & 2 & 3 & 4 \\\\ \\hline \\text{Frecuencia} & 1 & 6 & 4 & 2 & 2 \\\\ \\hline \\end{array}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Al contar cada valor: el $0$ aparece $2$ veces, el $1$ aparece $6$ veces, el $2$ aparece $4$ veces, el $3$ aparece $2$ veces y el $4$ aparece $1$ vez; el total es $15$.
La primera tabla suma $15$, pero asigna mal las frecuencias de $1$ y de $3$.
La tercera suma $16$ y la cuarta asigna mal las frecuencias de $0$ y de $4$, por lo que ninguna coincide con los datos.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd1330545-3267-51a9-94a1-04d09695278f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-031
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5f1dab35-0123-5d42-8df6-81e8d5db50e0', 'm1-probabilidad-y-estadistica-031', 'En una feria de Chillán se preguntó a $72$ personas por su fruta de temporada favorita. Los resultados son los siguientes:

$\displaystyle \begin{array}{|c|c|}\hline \text{Fruta} & \text{Cantidad de personas} \\ \hline \text{Frutilla} & 18 \\ \hline \text{Cereza} & 24 \\ \hline \text{Durazno} & 12 \\ \hline \text{Sandía} & 18 \\ \hline \end{array}$

Si estos datos se representan en un gráfico circular, ¿cuánto mide el ángulo del sector que corresponde a cereza?', '[{"id":"A","content":"$24^\\circ$"},{"id":"B","content":"$90^\\circ$"},{"id":"C","content":"$120^\\circ$"},{"id":"D","content":"$144^\\circ$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Cada sector es proporcional a su frecuencia: $\frac{24}{72} \cdot 360^\circ = \frac{1}{3} \cdot 360^\circ = 120^\circ$.
$24^\circ$ confunde la frecuencia absoluta con la medida del ángulo.
$90^\circ$ supone que las cuatro frutas tienen sectores iguales, y $144^\circ$ resulta de usar un total de $60$ personas, omitiendo a quienes prefieren durazno.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5f1dab35-0123-5d42-8df6-81e8d5db50e0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-032
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('96d2d907-d59c-59c5-a73a-e4c8052a9326', 'm1-probabilidad-y-estadistica-032', 'En un estudio sobre los hogares de una villa de Temuco se registró la cantidad de integrantes de cada hogar. La tabla muestra las frecuencias relativas, donde $p$ y $q$ son valores desconocidos:

$\displaystyle \begin{array}{|c|c|}\hline \text{Integrantes del hogar} & \text{Frecuencia relativa} \\ \hline 1 & 0{,}1 \\ \hline 2 & p \\ \hline 3 & 0{,}4 \\ \hline 4 & q \\ \hline \end{array}$

El promedio de integrantes por hogar puede calcularse sumando los productos de cada valor por su frecuencia relativa. Si este promedio es $2{,}9$ integrantes, ¿cuál es el valor de $p$?', '[{"id":"A","content":"$0{,}2$"},{"id":"B","content":"$0{,}3$"},{"id":"C","content":"$0{,}4$"},{"id":"D","content":"$0{,}5$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Las frecuencias relativas suman $1$: $0{,}1 + p + 0{,}4 + q = 1$, es decir, $p + q = 0{,}5$.
Del promedio: $1 \cdot 0{,}1 + 2p + 3 \cdot 0{,}4 + 4q = 2{,}9$, es decir, $2p + 4q = 1{,}6$.
Restando el doble de la primera ecuación: $2q = 0{,}6$, así que $q = 0{,}3$ y $p = 0{,}2$.
$0{,}3$ es el valor de $q$; $0{,}4$ es el valor que se obtiene para $q$ si se ignora $p$ en la ecuación del promedio; $0{,}5$ resulta de olvidar $q$ en la suma de frecuencias.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '96d2d907-d59c-59c5-a73a-e4c8052a9326', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-033
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1f5e16ad-f3cb-5ede-86d7-30d6e1194335', 'm1-probabilidad-y-estadistica-033', 'Dos cursos de $20$ estudiantes cada uno, de un colegio de Calama, registraron cuántas horas dedicaron a estudiar Historia durante una semana:

$\displaystyle \begin{array}{|c|c|c|}\hline \text{Horas de estudio} & \text{Curso A} & \text{Curso B} \\ \hline 1 & 2 & 6 \\ \hline 2 & 5 & 3 \\ \hline 3 & 8 & 2 \\ \hline 4 & 3 & 4 \\ \hline 5 & 2 & 5 \\ \hline \end{array}$

A partir de la información de la tabla, ¿cuál de las siguientes conclusiones es correcta?', '[{"id":"A","content":"El promedio de horas de estudio del curso A es mayor que el del curso B."},{"id":"B","content":"Ambos cursos tienen la misma moda de horas de estudio."},{"id":"C","content":"El rango de las horas de estudio del curso B es mayor que el del curso A."},{"id":"D","content":"Ambos cursos tienen la misma mediana de horas de estudio."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'En ambos cursos, los datos ordenados en las posiciones $10$ y $11$ valen $3$: en A las frecuencias acumuladas son $2, 7, 15$ y en B son $6, 9, 11$. Por eso, ambas medianas son $3$ horas.
El promedio de A es $\frac{58}{20} = 2{,}9$ y el de B es $\frac{59}{20} = 2{,}95$, así que A no supera a B.
La moda de A es $3$ horas y la de B es $1$ hora. Ambos rangos valen $5 - 1 = 4$, por lo que no son distintos.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1f5e16ad-f3cb-5ede-86d7-30d6e1194335', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-034
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5996bf1a-5000-5583-bd23-110d83b15f49', 'm1-probabilidad-y-estadistica-034', 'En la asignatura de Química, la nota final de Bastián se calcula como un promedio ponderado: la primera prueba vale $30\%$, la segunda prueba vale $30\%$ y el examen vale $40\%$. Bastián obtuvo un $5{,}0$ en la primera prueba, un $6{,}0$ en la segunda y un $4{,}0$ en el examen.
¿Cuál es su nota final?', '[{"id":"A","content":"$3{,}3$"},{"id":"B","content":"$4{,}9$"},{"id":"C","content":"$5{,}0$"},{"id":"D","content":"$5{,}1$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La nota final es $0{,}3 \cdot 5{,}0 + 0{,}3 \cdot 6{,}0 + 0{,}4 \cdot 4{,}0 = 1{,}5 + 1{,}8 + 1{,}6 = 4{,}9$.
A suma solo los aportes de las dos pruebas y olvida el del examen.
C es el promedio simple de las tres notas, sin considerar las ponderaciones.
D asigna el $40\%$ a la nota $6{,}0$ en vez de al examen.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5996bf1a-5000-5583-bd23-110d83b15f49', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-035
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('be1748eb-695c-5a5d-98b7-9bc756356735', 'm1-probabilidad-y-estadistica-035', 'Un servicio de arriendo de bicicletas de Valdivia registró cuántas bicicletas arrendó cada día durante una semana:
$\displaystyle \begin{array}{|c|c|c|c|c|c|c|}\hline \text{Lun} & \text{Mar} & \text{Mié} & \text{Jue} & \text{Vie} & \text{Sáb} & \text{Dom} \\ \hline 48 & 62 & 35 & 70 & 54 & 46 & 63 \\ \hline \end{array}$
¿En cuántos días de esa semana se arrendaron más bicicletas que el promedio diario de la semana?', '[{"id":"A","content":"$1$"},{"id":"B","content":"$2$"},{"id":"C","content":"$3$"},{"id":"D","content":"$4$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El total es $48 + 62 + 35 + 70 + 54 + 46 + 63 = 378$, por lo que el promedio diario es $\frac{378}{7} = 54$ bicicletas.
Superan ese valor el martes ($62$), el jueves ($70$) y el domingo ($63$): son $3$ días.
D cuenta también el viernes, pero $54$ es igual al promedio y no mayor.
A y B resultan de comparar con un promedio mal calculado o de omitir días al revisar la tabla.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'be1748eb-695c-5a5d-98b7-9bc756356735', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-036
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f49e8a80-dc60-5ae8-81e7-f2bd07c4abb5', 'm1-probabilidad-y-estadistica-036', 'Una profesora de Educación Física de Rancagua registró el tiempo, en segundos, que $16$ estudiantes lograron mantener una plancha abdominal:
$12, \ 25, \ 18, \ 30, \ 22, \ 15, \ 28, \ 35, \ 19, \ 24, \ 11, \ 27, \ 33, \ 20, \ 16, \ 29$
Quiere agrupar los datos en los intervalos $[10, 20)$, $[20, 30)$ y $[30, 40)$, donde cada intervalo incluye su extremo izquierdo y no incluye el derecho. ¿Cuál de las siguientes opciones muestra correctamente la cantidad de estudiantes en cada intervalo?', '[{"id":"A","content":"$[10, 20)$: $7$; $[20, 30)$: $6$; $[30, 40)$: $3$"},{"id":"B","content":"$[10, 20)$: $6$; $[20, 30)$: $8$; $[30, 40)$: $2$"},{"id":"C","content":"$[10, 20)$: $7$; $[20, 30)$: $7$; $[30, 40)$: $2$"},{"id":"D","content":"$[10, 20)$: $6$; $[20, 30)$: $7$; $[30, 40)$: $3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'En $[10, 20)$ están $12, 18, 15, 19, 11$ y $16$: son $6$ datos. En $[20, 30)$ están $25, 22, 28, 24, 27, 20$ y $29$: son $7$. En $[30, 40)$ están $30, 35$ y $33$: son $3$. El total es $16$.
A ubica el dato $20$ en el primer intervalo, aunque $20$ no pertenece a $[10, 20)$.
B ubica el dato $30$ en el segundo intervalo.
C comete ambos errores, como si los intervalos incluyeran el extremo derecho y no el izquierdo.', 'm1', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f49e8a80-dc60-5ae8-81e7-f2bd07c4abb5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-037
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('37303769-5502-5fe3-981c-c1a7677e11ad', 'm1-probabilidad-y-estadistica-037', 'Una pastelería de Curicó registró la cantidad de kuchenes que vendió cada mes:
$\displaystyle \begin{array}{|c|c|c|c|c|}\hline \text{Marzo} & \text{Abril} & \text{Mayo} & \text{Junio} & \text{Julio} \\ \hline 200 & 250 & 300 & 345 & 420 \\ \hline \end{array}$
La variación porcentual de las ventas de un mes respecto del mes anterior se calcula como $\displaystyle \frac{V_{\text{actual}} - V_{\text{anterior}}}{V_{\text{anterior}}} \cdot 100\%$.
¿En qué mes la variación porcentual de las ventas, respecto del mes anterior, fue mayor?', '[{"id":"A","content":"Abril"},{"id":"B","content":"Mayo"},{"id":"C","content":"Junio"},{"id":"D","content":"Julio"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Las variaciones son: abril $\frac{50}{200} \cdot 100\% = 25\%$; mayo $\frac{50}{250} \cdot 100\% = 20\%$; junio $\frac{45}{300} \cdot 100\% = 15\%$; julio $\frac{75}{345} \cdot 100\% \approx 21{,}7\%$. La mayor es la de abril.
D corresponde al mes con el mayor aumento absoluto ($75$ kuchenes), pero ese aumento se compara con una base más grande.
B y C se obtienen al dividir por el valor del mes actual o al comparar solo las diferencias, sin dividir.', 'm1', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '37303769-5502-5fe3-981c-c1a7677e11ad', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-038
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6fe96f9b-2248-5c20-ac68-b52082e700b3', 'm1-probabilidad-y-estadistica-038', 'En una fonda de Rancagua hay una ruleta dividida en $20$ sectores de igual área, numerados del $1$ al $20$. Quien hace girar la ruleta gana un premio si la flecha se detiene en un número que sea múltiplo de $3$ o múltiplo de $4$.
¿Cuál es la probabilidad de ganar un premio en un giro?', '[{"id":"A","content":"$\\frac{1}{4}$"},{"id":"B","content":"$\\frac{3}{10}$"},{"id":"C","content":"$\\frac{1}{2}$"},{"id":"D","content":"$\\frac{11}{20}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Los múltiplos de $3$ son $3, 6, 9, 12, 15, 18$ (seis números) y los múltiplos de $4$ son $4, 8, 12, 16, 20$ (cinco números). El $12$ está en ambos grupos, así que los casos favorables son $6 + 5 - 1 = 10$.
La probabilidad es $\frac{10}{20} = \frac{1}{2}$.
A considera solo los múltiplos de $4$ y B solo los múltiplos de $3$.
D suma $6 + 5 = 11$ y cuenta dos veces el $12$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6fe96f9b-2248-5c20-ac68-b52082e700b3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-039
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9d14a0df-283c-598a-9f91-13390e9caeef', 'm1-probabilidad-y-estadistica-039', 'En una bolsa hay $5$ tarjetas del mismo tamaño, numeradas del $1$ al $5$. Joaquín saca una tarjeta al azar, anota su número y, sin devolverla a la bolsa, saca otra tarjeta al azar.
¿Cuál es la probabilidad de obtener dos números cuya suma resulte par?', '[{"id":"A","content":"$\\frac{3}{10}$"},{"id":"B","content":"$\\frac{2}{5}$"},{"id":"C","content":"$\\frac{1}{2}$"},{"id":"D","content":"$\\frac{13}{25}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'La suma es par si ambas tarjetas son impares o ambas son pares. Hay $3$ impares y $2$ pares.
$P(\text{ambas impares}) = \frac{3}{5} \cdot \frac{2}{4} = \frac{6}{20}$ y $P(\text{ambas pares}) = \frac{2}{5} \cdot \frac{1}{4} = \frac{2}{20}$.
Como son casos excluyentes, la probabilidad es $\frac{6}{20} + \frac{2}{20} = \frac{8}{20} = \frac{2}{5}$.
A considera solo el caso de dos impares. C supone que par e impar son igualmente probables.
D calcula como si la primera tarjeta se devolviera: $\frac{9}{25} + \frac{4}{25}$.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9d14a0df-283c-598a-9f91-13390e9caeef', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-040
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8d38f357-ae4e-5834-8002-f7f4edf2eae8', 'm1-probabilidad-y-estadistica-040', 'En una caja hay $10$ fichas del mismo tamaño: $6$ son rojas y están numeradas del $1$ al $6$, y $4$ son azules y están numeradas del $1$ al $4$. Se saca una ficha al azar.
¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"Los eventos «sacar una ficha roja» y «sacar una ficha con número par» son mutuamente excluyentes."},{"id":"B","content":"La probabilidad de sacar una ficha azul o con número par es igual a la suma de la probabilidad de sacar una ficha azul y la de sacar una ficha con número par."},{"id":"C","content":"La probabilidad de sacar una ficha con el número $1$ es $\\frac{1}{10}$."},{"id":"D","content":"La probabilidad de sacar una ficha roja o con número par es $\\frac{4}{5}$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Las fichas rojas son $6$ y las azules con número par son $2$ (el $2$ y el $4$), así que hay $6 + 2 = 8$ fichas rojas o con número par: la probabilidad es $\frac{8}{10} = \frac{4}{5}$, y D es verdadera.
A es falsa: las fichas rojas $2$, $4$ y $6$ cumplen ambos eventos.
B es falsa: las fichas azules $2$ y $4$ se contarían dos veces; la probabilidad real es $\frac{7}{10}$ y la suma da $\frac{4}{10} + \frac{5}{10} = \frac{9}{10}$.
C es falsa: hay dos fichas con el número $1$ (una roja y una azul), así que la probabilidad es $\frac{2}{10}$.', 'm1', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8d38f357-ae4e-5834-8002-f7f4edf2eae8', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m1-probabilidad-y-estadistica-041
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e2ea0589-c0f0-5b3b-9786-ebee89005a3a', 'm1-probabilidad-y-estadistica-041', 'En una corrida de montaña en Pucón, los tiempos, en minutos, de los primeros $10$ corredores inscritos en una categoría fueron, ordenados de menor a mayor:
$41, \ 43, \ 44, \ 46, \ 48, \ 50, \ 51, \ 53, \ 55, \ 58$
Luego se agregó a la lista un corredor más de la misma categoría, cuyo tiempo fue de $45$ minutos. ¿Cuál es la mediana de los tiempos de los $11$ corredores?', '[{"id":"A","content":"$48$ minutos"},{"id":"B","content":"$49$ minutos"},{"id":"C","content":"$50$ minutos"},{"id":"D","content":"$51$ minutos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Al incorporar el $45$, los datos ordenados son $41, 43, 44, 45, 46, 48, 50, 51, 53, 55, 58$. Con $11$ datos, la mediana es el que ocupa la posición $6$, es decir, $48$ minutos.
B es la mediana de los $10$ datos originales, $\frac{48 + 50}{2} = 49$, y supone que no cambia al agregar un dato.
C toma el sexto dato de la lista original sin reordenar.
D toma el séptimo dato de la lista original, como si la posición central se desplazara hacia arriba.', 'm1', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e2ea0589-c0f0-5b3b-9786-ebee89005a3a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm1' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m2-algebra-y-funciones-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b213a6cb-4bb3-5dcd-bcb3-6976c8a29eb9', 'm2-algebra-y-funciones-001', 'Considera el siguiente sistema de ecuaciones en $x$ e $y$, con $k$ un número real:

$\begin{cases} 2x+ky=5 \\ 4x+6y=7 \end{cases}$

¿Para qué valor de $k$ el sistema no tiene solución?', '[{"id":"A","content":"$-3$"},{"id":"B","content":"$2$"},{"id":"C","content":"$3$"},{"id":"D","content":"$12$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El sistema no tiene solución cuando los coeficientes de $x$ e $y$ son proporcionales pero los términos libres no lo son: $\frac{2}{4}=\frac{k}{6}\neq\frac{5}{7}$.
De $\frac{2}{4}=\frac{k}{6}$ se obtiene $k=3$, y $\frac{1}{2}\neq\frac{5}{7}$, así que con $k=3$ las rectas son paralelas y distintas.
A es un error de signo. D resulta de plantear mal la proporción ($2\cdot6=k$, o $\frac{4}{2}\cdot6$). Con $k=2$ el sistema tiene solución única.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b213a6cb-4bb3-5dcd-bcb3-6976c8a29eb9', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-casos-solucion'
  on conflict do nothing;
-- m2-algebra-y-funciones-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('649f7d30-2047-53dd-bb42-73171f835d62', 'm2-algebra-y-funciones-002', 'Considera el siguiente sistema de ecuaciones en $x$ e $y$:

$\begin{cases} x-2y=4 \\ -3x+6y=-12 \end{cases}$

¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"Tiene solución única, que es $(4,0)$."},{"id":"B","content":"No tiene solución, porque las rectas que representan las ecuaciones son paralelas y distintas."},{"id":"C","content":"Tiene infinitas soluciones y una de ellas es $(2,-1)$."},{"id":"D","content":"Tiene infinitas soluciones y una de ellas es $(0,2)$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'La segunda ecuación es la primera multiplicada por $-3$: $-3(x-2y)=-3\cdot4$. Ambas representan la misma recta, por lo que el sistema tiene infinitas soluciones.
El par $(2,-1)$ cumple $2-2(-1)=4$, así que es una de ellas.
A es incorrecta: $(4,0)$ es solución, pero no la única. B confunde rectas coincidentes con paralelas. D falla porque $0-2\cdot2=-4\neq4$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '649f7d30-2047-53dd-bb42-73171f835d62', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-casos-solucion'
  on conflict do nothing;
-- m2-algebra-y-funciones-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2e60c876-4299-59cb-84fa-08f157fa15e4', 'm2-algebra-y-funciones-003', 'Considera el siguiente sistema de ecuaciones en $x$ e $y$, con $a$, $b$ y $c$ números reales:

$\begin{cases} ax+3y=6 \\ 2x+by=c \end{cases}$

Se puede determinar la cantidad de soluciones del sistema, si se sabe que:

(1) $a=2$ y $b=3$
(2) $c=6$', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Con (1): el sistema queda $2x+3y=6$ y $2x+3y=c$. Si $c=6$ tiene infinitas soluciones, y si $c\neq6$ no tiene solución. No basta.
Con (2): si $a=2$ y $b=3$ hay infinitas soluciones, pero si, por ejemplo, $a=1$ y $b=0$ hay solución única. No basta.
Juntas: las dos ecuaciones son idénticas, $2x+3y=6$, y el sistema tiene infinitas soluciones. Se requieren ambas.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2e60c876-4299-59cb-84fa-08f157fa15e4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-casos-solucion'
  on conflict do nothing;
-- m2-algebra-y-funciones-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f59c9608-9348-531c-9b5d-938f47ab1d3a', 'm2-algebra-y-funciones-004', 'Considera el siguiente sistema de ecuaciones en $x$ e $y$, con $m$ un número real:

$\begin{cases} (m-1)x+2y=4 \\ 3x+my=6 \end{cases}$

¿Para qué valor o valores de $m$ el sistema no tiene solución?', '[{"id":"A","content":"Solo para $m=-2$"},{"id":"B","content":"Solo para $m=3$"},{"id":"C","content":"Para $m=-2$ y para $m=3$"},{"id":"D","content":"Para ningún valor de $m$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'El sistema no tiene solución única cuando $(m-1)\cdot m-2\cdot3=0$, es decir, $m^2-m-6=(m-3)(m+2)=0$, de donde $m=3$ o $m=-2$.
Con $m=3$: $2x+2y=4$ y $3x+3y=6$; ambas equivalen a $x+y=2$, así que hay infinitas soluciones.
Con $m=-2$: $-3x+2y=4$ y $3x-2y=6$, es decir, $-3x+2y=-6$; los coeficientes son proporcionales y los términos libres no, así que no hay solución.
C es el error de no revisar los términos libres. B confunde el caso de infinitas soluciones con el de ninguna.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f59c9608-9348-531c-9b5d-938f47ab1d3a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-casos-solucion'
  on conflict do nothing;
-- m2-algebra-y-funciones-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a22c90eb-c33a-55b6-a3a0-2788ec13911a', 'm2-algebra-y-funciones-005', 'En un laboratorio de microbiología se estudia un cultivo de bacterias. La cantidad de bacterias $N$ al cabo de $t$ horas se modela mediante la función $N(t)=500\cdot2^{\frac{t}{3}}$.

Según este modelo, ¿cuántas bacterias habrá en el cultivo al cabo de $9$ horas?', '[{"id":"A","content":"$1\\,500$"},{"id":"B","content":"$3\\,000$"},{"id":"C","content":"$4\\,000$"},{"id":"D","content":"$256\\,000$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, '$N(9)=500\cdot2^{\frac{9}{3}}=500\cdot2^3=500\cdot8=4\,000$ bacterias. La población se duplica cada $3$ horas.
A resulta de calcular $500\cdot3$, ignorando la base $2$. B multiplica $500\cdot2\cdot3$ en vez de calcular la potencia.
D usa el exponente $9$ en lugar de $\frac{9}{3}$: $500\cdot2^9$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a22c90eb-c33a-55b6-a3a0-2788ec13911a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-potencia-exp-log'
  on conflict do nothing;
-- m2-algebra-y-funciones-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('758fc810-11ea-5ea8-946b-3fb18c255293', 'm2-algebra-y-funciones-006', 'El yodo-131 es un isótopo radiactivo que se usa en medicina nuclear y cuya vida media es de $8$ días, es decir, cada $8$ días la masa de una muestra se reduce a la mitad.

Un hospital recibe una muestra de $80$ mg de yodo-131. ¿Cuál de las siguientes funciones modela la masa $m$, en mg, que queda de la muestra al cabo de $t$ días?', '[{"id":"A","content":"$m(t)=80\\cdot\\left(\\dfrac{1}{2}\\right)^{8t}$"},{"id":"B","content":"$m(t)=80\\cdot\\left(\\dfrac{1}{2}\\right)^{\\frac{t}{8}}$"},{"id":"C","content":"$m(t)=80-5t$"},{"id":"D","content":"$m(t)=80\\cdot\\left(\\dfrac{1}{2}\\right)^{t}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Cada $8$ días la masa se multiplica por $\frac{1}{2}$, así que en $t$ días ocurren $\frac{t}{8}$ reducciones a la mitad: $m(t)=80\cdot\left(\frac{1}{2}\right)^{\frac{t}{8}}$. Se verifica que $m(8)=40$ y $m(16)=20$.
A reduce a la mitad $8$ veces por día. D lo hace una vez por día, ignorando la vida media.
C es un modelo lineal: coincide en $m(8)=40$, pero da $m(16)=0$ en vez de $20$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '758fc810-11ea-5ea8-946b-3fb18c255293', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-potencia-exp-log'
  on conflict do nothing;
-- m2-algebra-y-funciones-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c7492304-e0db-561e-82f4-a7d1f8304246', 'm2-algebra-y-funciones-007', 'La población de una ciudad del sur de Chile se modela mediante la función $P(t)=120\,000\cdot(1{,}05)^t$, donde $t$ es la cantidad de años transcurridos desde el último censo.

Considerando $\log 2\approx0{,}301$ y $\log 1{,}05\approx0{,}021$, ¿cuál es la menor cantidad de años completos que deben transcurrir para que la población supere el doble de la registrada en el censo?', '[{"id":"A","content":"$14$"},{"id":"B","content":"$15$"},{"id":"C","content":"$20$"},{"id":"D","content":"$40$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Se busca $t$ tal que $120\,000\cdot(1{,}05)^t>240\,000$, es decir, $(1{,}05)^t>2$.
Aplicando logaritmo: $t\cdot\log 1{,}05>\log 2$, luego $t>\frac{0{,}301}{0{,}021}\approx14{,}3$. El menor número entero de años es $15$.
A trunca $14{,}3$ hacia abajo, pero a los $14$ años la población aún no se duplica. C supone un crecimiento lineal de $5\%$ del valor inicial por año ($\frac{100\%}{5\%}=20$). D divide $2$ entre $0{,}05$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c7492304-e0db-561e-82f4-a7d1f8304246', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-potencia-exp-log'
  on conflict do nothing;
-- m2-algebra-y-funciones-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('215205a5-175c-5e1b-a150-0fc4b1017355', 'm2-algebra-y-funciones-008', 'Considera la función exponencial $f(x)=a\cdot b^x$, con $a$ distinto de cero, $b>0$ y $b\neq1$.

Se puede determinar el valor de $f(3)$, si se sabe que:

(1) $f(0)=2$
(2) $f(1)=6$ y $f(2)=18$', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Con (1): $f(0)=a\cdot b^0=a=2$, pero $b$ queda libre; por ejemplo, $f(3)=2\cdot2^3=16$ o $f(3)=2\cdot3^3=54$. No basta.
Con (2): $\frac{f(2)}{f(1)}=b=\frac{18}{6}=3$ y $a=\frac{6}{3}=2$, luego $f(3)=2\cdot3^3=54$. Es suficiente.
Por lo tanto, (2) por sí sola es suficiente y (1) por sí sola no lo es.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '215205a5-175c-5e1b-a150-0fc4b1017355', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-potencia-exp-log'
  on conflict do nothing;
-- m2-algebra-y-funciones-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('46f4add9-bc76-55dc-954c-c22bbb7ae3df', 'm2-algebra-y-funciones-009', 'En la siguiente tabla se presentan algunos valores de una función $f$:

$\displaystyle \begin{array}{|c|c|c|c|c|}\hline x & 1 & 2 & 4 & 8 \\ \hline f(x) & 0 & 1 & 2 & 3 \\ \hline \end{array}$

¿Cuál de las siguientes funciones es consistente con todos los valores de la tabla?', '[{"id":"A","content":"$f(x)=x-1$"},{"id":"B","content":"$f(x)=\\dfrac{x}{2}$"},{"id":"C","content":"$f(x)=2^{x-1}$"},{"id":"D","content":"$f(x)=\\log_2 x$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, '$\log_2 1=0$, $\log_2 2=1$, $\log_2 4=2$ y $\log_2 8=3$: coincide con todos los valores.
A cumple los dos primeros puntos, pero $f(4)=3\neq2$. B da $f(1)=\frac{1}{2}\neq0$.
C es la función inversa de la correcta: intercambia los papeles de $x$ y $f(x)$, y da $f(1)=1\neq0$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '46f4add9-bc76-55dc-954c-c22bbb7ae3df', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-potencia-exp-log'
  on conflict do nothing;
-- m2-algebra-y-funciones-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cc3f6071-30ac-5bcb-8358-198bd0d67536', 'm2-algebra-y-funciones-010', 'En un puerto de la zona central, la altura $h$ del nivel del mar, en metros, respecto de una marca fija se modela mediante la función $h(t)=3+2\operatorname{sen}\left(\dfrac{\pi t}{6}\right)$, donde $t$ es la cantidad de horas transcurridas desde la medianoche, con $0\le t\le 12$.

Un barco solo puede entrar al puerto cuando la altura del nivel del mar es mayor que $4$ metros. ¿En qué intervalo de tiempo, después de la medianoche, el barco puede entrar al puerto?', '[{"id":"A","content":"Entre las $0{:}00$ y las $6{:}00$ horas"},{"id":"B","content":"Entre las $1{:}00$ y las $3{:}00$ horas"},{"id":"C","content":"Entre las $2{:}00$ y las $4{:}00$ horas"},{"id":"D","content":"Entre las $1{:}00$ y las $5{:}00$ horas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Se requiere $3+2\operatorname{sen}\left(\frac{\pi t}{6}\right)>4$, es decir, $\operatorname{sen}\left(\frac{\pi t}{6}\right)>\frac{1}{2}$.
En $[0,2\pi]$ esto ocurre para $\frac{\pi}{6}<\frac{\pi t}{6}<\frac{5\pi}{6}$, o sea, $1<t<5$: entre la $1{:}00$ y las $5{:}00$.
A es el intervalo en que la marea está sobre $3$ m (seno positivo). B considera solo el tramo hasta el máximo, que ocurre a las $3{:}00$. C toma un intervalo simétrico en torno al máximo sin resolver la inecuación.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cc3f6071-30ac-5bcb-8358-198bd0d67536', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funciones-trigonometricas'
  on conflict do nothing;
-- m2-algebra-y-funciones-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9e84b174-7424-5240-949e-6aa66bb681e4', 'm2-algebra-y-funciones-011', 'La función $f(x)=a\operatorname{sen}(bx)+c$, con $a>0$ y $b>0$, tiene valor máximo $7$, valor mínimo $1$ y período $4\pi$.

¿Cuál de las siguientes expresiones corresponde a $f(x)$?', '[{"id":"A","content":"$3\\operatorname{sen}\\left(\\dfrac{x}{2}\\right)+4$"},{"id":"B","content":"$3\\operatorname{sen}(2x)+4$"},{"id":"C","content":"$4\\operatorname{sen}\\left(\\dfrac{x}{2}\\right)+3$"},{"id":"D","content":"$6\\operatorname{sen}\\left(\\dfrac{x}{2}\\right)+1$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La amplitud es $a=\frac{7-1}{2}=3$ y el desplazamiento vertical es $c=\frac{7+1}{2}=4$.
El período de $\operatorname{sen}(bx)$ es $\frac{2\pi}{b}=4\pi$, de donde $b=\frac{1}{2}$. Así, $f(x)=3\operatorname{sen}\left(\frac{x}{2}\right)+4$.
B usa $b=2$, que da período $\pi$. C intercambia amplitud y desplazamiento (máximo $7$ pero mínimo $-1$).
D toma como amplitud la diferencia entre máximo y mínimo y como desplazamiento el mínimo, lo que da máximo $7$ y mínimo $-5$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9e84b174-7424-5240-949e-6aa66bb681e4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funciones-trigonometricas'
  on conflict do nothing;
-- m2-algebra-y-funciones-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2d0cc644-9cde-5f16-b6f9-43ece5b2272b', 'm2-algebra-y-funciones-012', 'Considera la función $f(x)=a\operatorname{sen}(bx)$, con $a>0$ y $b>0$.

Se puede determinar el valor de $b$, si se sabe que:

(1) el valor máximo de $f$ es $3$.
(2) $f(\pi)=0$', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'E', 'hard'::difficulty_level, 'Con (1): el máximo de $f$ es $a$, así que $a=3$, pero $b$ puede ser cualquier número positivo. No basta.
Con (2): $a\operatorname{sen}(b\pi)=0$ y, como $a>0$, $\operatorname{sen}(b\pi)=0$, lo que se cumple para $b=1,2,3,\ldots$ No basta.
Juntas: $f(x)=3\operatorname{sen}(x)$ y $f(x)=3\operatorname{sen}(2x)$ cumplen ambas condiciones, así que $b$ sigue sin determinarse.
Se requiere información adicional, por ejemplo, el período de $f$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2d0cc644-9cde-5f16-b6f9-43ece5b2272b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funciones-trigonometricas'
  on conflict do nothing;
-- m2-algebra-y-funciones-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4550e4ba-6536-5f37-a126-e68cee0095cb', 'm2-algebra-y-funciones-013', 'Considera la función $g(x)=2\operatorname{sen}(x)-1$.

¿Cuál de los siguientes puntos pertenece a la gráfica de $g$?', '[{"id":"A","content":"$(0,1)$"},{"id":"B","content":"$\\left(\\dfrac{\\pi}{2},2\\right)$"},{"id":"C","content":"$(\\pi,1)$"},{"id":"D","content":"$\\left(\\dfrac{3\\pi}{2},-3\\right)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, '$g\left(\frac{3\pi}{2}\right)=2\cdot(-1)-1=-3$, así que el punto de D pertenece a la gráfica.
A: $g(0)=2\cdot0-1=-1\neq1$. B: $g\left(\frac{\pi}{2}\right)=2\cdot1-1=1\neq2$; el valor $2$ resulta de olvidar el $-1$.
C: $g(\pi)=2\cdot0-1=-1\neq1$; el error es un signo del término independiente.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4550e4ba-6536-5f37-a126-e68cee0095cb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funciones-trigonometricas'
  on conflict do nothing;
-- m2-algebra-y-funciones-101
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7f454122-600a-5e90-bcd7-63cf8d1aec73', 'm2-algebra-y-funciones-101', 'Considera la función $f(x)=x^{2}-6x+k$, con $k$ un número real y dominio el conjunto de los números reales. Se sabe que el valor mínimo de $f$ es $-4$.

¿Cuáles son los ceros de $f$?', '[{"id":"A","content":"$x=-5$ y $x=-1$"},{"id":"B","content":"$x=1$ y $x=5$"},{"id":"C","content":"$x=3$ y $x=-4$"},{"id":"D","content":"$x=3-\\sqrt{13}$ y $x=3+\\sqrt{13}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El mínimo se alcanza en el vértice, $x=-\dfrac{-6}{2}=3$, y vale $f(3)=9-18+k=k-9$.
De $k-9=-4$ se obtiene $k=5$, luego $f(x)=x^{2}-6x+5=(x-1)(x-5)$, con ceros $x=1$ y $x=5$.
A tiene los signos cambiados al factorizar; C entrega las coordenadas del vértice, no los ceros.
D supone que $k=-4$, confundiendo el valor mínimo con el término libre.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7f454122-600a-5e90-bcd7-63cf8d1aec73', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-102
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c55b141f-1b4c-54a9-bcfb-27e0f7e07c17', 'm2-algebra-y-funciones-102', 'Una clavadista se lanza desde una plataforma en una piscina olímpica. Su altura $h$ sobre el agua, en metros, a los $t$ segundos de haber saltado, se modela mediante la función $h(t)=-5t^{2}+5t+10$.

Según el modelo, ¿cuántos segundos después de saltar llega la clavadista al agua?', '[{"id":"A","content":"$0{,}5$ s"},{"id":"B","content":"$2$ s"},{"id":"C","content":"$10$ s"},{"id":"D","content":"$11{,}25$ s"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Llega al agua cuando $h(t)=0$: $-5t^{2}+5t+10=0$, es decir, $t^{2}-t-2=0$, o sea $(t-2)(t+1)=0$.
Como $t\geq0$, se descarta $t=-1$ y se obtiene $t=2$ s.
$0{,}5$ s es el instante en que alcanza la altura máxima (abscisa del vértice) y $11{,}25$ es esa altura máxima, en metros.
$10$ es la altura inicial de la plataforma, no un tiempo.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c55b141f-1b4c-54a9-bcfb-27e0f7e07c17', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-103
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a0a39264-a7bf-50ef-929d-8197f7eaff67', 'm2-algebra-y-funciones-103', 'Considera la función $f(x)=ax^{2}+bx+c$, con dominio el conjunto de los números reales, donde $a$, $b$ y $c$ son números reales tales que $a<0$ y $c>0$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"La gráfica de $f$ no intersecta al eje X."},{"id":"B","content":"El vértice de la gráfica de $f$ está en el segundo cuadrante."},{"id":"C","content":"El valor mínimo de $f$ es $c$."},{"id":"D","content":"$f$ tiene dos ceros reales, uno positivo y otro negativo."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'El discriminante es $b^{2}-4ac$; como $ac<0$, se tiene $-4ac>0$ y el discriminante es positivo: hay dos ceros reales distintos.
Además, el producto de los ceros es $\dfrac{c}{a}<0$, por lo que tienen distinto signo. Así, D es siempre verdadera y A es falsa.
B depende de $b$: si $b>0$, la abscisa del vértice $-\frac{b}{2a}$ es positiva y el vértice queda en el primer cuadrante.
C es falsa: con $a<0$ la parábola abre hacia abajo y no tiene mínimo; $c$ es solo el valor $f(0)$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a0a39264-a7bf-50ef-929d-8197f7eaff67', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-104
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1ae40424-041e-589c-8bd6-63e87a352282', 'm2-algebra-y-funciones-104', 'Un agricultor de Curicó quiere cercar un terreno rectangular junto a un muro recto, de modo que el muro forma uno de los lados y no necesita malla. El lado opuesto al muro tendrá un portón de $4$ m de ancho, que tampoco lleva malla. Dispone de $60$ m de malla en total.

Si usa toda la malla, ¿cuál es el área máxima, en $\text{m}^{2}$, que puede tener el terreno?', '[{"id":"A","content":"$256$"},{"id":"B","content":"$450$"},{"id":"C","content":"$512$"},{"id":"D","content":"$1\\,024$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Sea $x$ la medida de cada lado perpendicular al muro e $y$ la del lado opuesto al muro. La malla cumple $2x+(y-4)=60$, luego $y=64-2x$.
El área es $A(x)=x(64-2x)=-2x^{2}+64x$, cuyo vértice está en $x=\dfrac{64}{4}=16$, con $A(16)=16\cdot32=512$.
$450$ se obtiene al ignorar el portón ($y=60-2x$); $256$ supone que el terreno debe ser cuadrado de lado $16$.
$1\,024$ eleva al cuadrado el lado de $32$ m, sin usar la función área.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1ae40424-041e-589c-8bd6-63e87a352282', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-105
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('52996ba6-be2d-5af8-9ae3-72b78783da21', 'm2-algebra-y-funciones-105', 'La tabla muestra cinco pares ordenados que pertenecen a la gráfica de una parábola, definida por la función $f$:

$\displaystyle \begin{array}{|c|c|c|c|c|c|}\hline x & 0 & 1 & 2 & 3 & 4 \\ \hline f(x) & 5 & 0 & -3 & -4 & -3 \\ \hline \end{array}$

¿Con qué expresión algebraica se define $f(x)$?', '[{"id":"A","content":"$(x+3)^{2}-4$"},{"id":"B","content":"$-(x-3)^{2}-4$"},{"id":"C","content":"$(x-3)^{2}+4$"},{"id":"D","content":"$(x-3)^{2}-4$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'La tabla es simétrica respecto de $x=3$ ($f(2)=f(4)=-3$), por lo que el vértice es $(3,-4)$ y $f(x)=a(x-3)^{2}-4$.
Con $f(0)=5$: $9a-4=5$, luego $a=1$ y $f(x)=(x-3)^{2}-4$. Se comprueba: $f(1)=4-4=0$.
A ubica el vértice en $x=-3$ (error de signo en la traslación) y C cambia el signo de la ordenada del vértice.
B corresponde a una parábola que abre hacia abajo, pero los valores de la tabla crecen a ambos lados de $x=3$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '52996ba6-be2d-5af8-9ae3-72b78783da21', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-106
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d7c66a3f-f36e-5585-b256-9ad872b579ff', 'm2-algebra-y-funciones-106', 'Un teatro de Valparaíso cobra $8\,000$ pesos por entrada y vende $400$ entradas por función. Un estudio indica que por cada aumento de $500$ pesos en el precio de la entrada se venden $20$ entradas menos.

Si el ingreso por función se modela como el producto entre el precio y la cantidad de entradas vendidas, ¿qué precio por entrada maximiza el ingreso según este modelo?', '[{"id":"A","content":"$8\\,000$ pesos"},{"id":"B","content":"$9\\,000$ pesos"},{"id":"C","content":"$13\\,000$ pesos"},{"id":"D","content":"$17\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Con $n$ aumentos de $500$ pesos, el ingreso es $I(n)=(8\,000+500n)(400-20n)$.
Sus ceros son $n=-16$ y $n=20$, así que el vértice está en $n=\dfrac{-16+20}{2}=2$, con un precio de $8\,000+2\cdot500=9\,000$ pesos.
$13\,000$ pesos usa $n=10$, la mitad de $20$, olvidando el otro cero; $17\,000$ pesos usa $n=18$, al sumar mal los ceros por un error de signo.
$8\,000$ pesos supone, sin verificarlo, que no conviene subir el precio.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd7c66a3f-f36e-5585-b256-9ad872b579ff', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-107
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('26ffc016-3ed6-5d48-af32-b2e2cc29c1fd', 'm2-algebra-y-funciones-107', 'Considera la parábola de ecuación $y=x^{2}+4x+3$ y la recta de ecuación $y=2x+m$, con $m$ un número real.

¿Para qué valor de $m$ la recta y la parábola se intersectan en un único punto?', '[{"id":"A","content":"$-2$"},{"id":"B","content":"$2$"},{"id":"C","content":"$3$"},{"id":"D","content":"$4$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Igualando: $x^{2}+4x+3=2x+m$, es decir, $x^{2}+2x+(3-m)=0$.
Hay un único punto de intersección si el discriminante es cero: $4-4(3-m)=0$, luego $m=2$ (el punto es $(-1,0)$).
$4$ aparece al trasponer mal el término y usar $m-3$ como término libre; $-2$ es un error de signo al despejar.
$3$ es el punto de corte de la parábola con el eje Y, que no tiene relación con la condición pedida.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '26ffc016-3ed6-5d48-af32-b2e2cc29c1fd', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-108
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c6dfb5cd-ca58-5b1e-ab17-344f679ef055', 'm2-algebra-y-funciones-108', 'Benjamín resolvió la ecuación $2x^{2}-8x=10$ completando el cuadrado, como se muestra a continuación:

Paso 1: $x^{2}-4x=10$
Paso 2: $x^{2}-4x+4=14$
Paso 3: $(x-2)^{2}=14$
Paso 4: $x=2+\sqrt{14}$ o $x=2-\sqrt{14}$

¿En cuál de los pasos cometió Benjamín el primer error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Al dividir por $2$ la ecuación original se obtiene $x^{2}-4x=5$: Benjamín dividió solo el lado izquierdo, por lo que el error está en el paso 1.
Las soluciones correctas son $x=5$ y $x=-1$, pues $x^{2}-4x+4=9$ y $(x-2)^{2}=9$.
Los pasos 2, 3 y 4 son correctos a partir de la ecuación que escribió en el paso 1: sumó $4$ a ambos lados, factorizó el trinomio y extrajo raíz con ambos signos.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c6dfb5cd-ca58-5b1e-ab17-344f679ef055', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-109
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0e4569d2-1eb8-559c-ac74-c79354101a01', 'm2-algebra-y-funciones-109', 'Considera la función $f(x)=(x-2)(x+6)$, cuyo dominio es el conjunto de los números reales.

¿Cuál es el valor mínimo de $f$?', '[{"id":"A","content":"$-16$"},{"id":"B","content":"$-12$"},{"id":"C","content":"$-2$"},{"id":"D","content":"$16$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Los ceros de $f$ son $x=2$ y $x=-6$, y el eje de simetría pasa por su punto medio: $x=\dfrac{2+(-6)}{2}=-2$.
El valor mínimo es $f(-2)=(-4)\cdot4=-16$.
$-12$ es $f(0)$, el corte con el eje Y; $-2$ es la abscisa del vértice, no el valor de la función.
$16$ resulta de un error de signo al multiplicar $(-4)\cdot4$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0e4569d2-1eb8-559c-ac74-c79354101a01', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-110
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('65b1a82f-f633-5aec-88c8-350bc535e507', 'm2-algebra-y-funciones-110', 'Una aplicación de transporte cobra en Concepción un cargo fijo por viaje más un monto constante por cada kilómetro recorrido. Un viaje de $4$ km cuesta $4\,700$ pesos y uno de $10$ km cuesta $9\,500$ pesos.

¿Cuál de las siguientes funciones modela el costo $C$, en pesos, de un viaje de $x$ kilómetros?', '[{"id":"A","content":"$C(x)=950x$"},{"id":"B","content":"$C(x)=1\\,175x$"},{"id":"C","content":"$C(x)=800x+4\\,700$"},{"id":"D","content":"$C(x)=800x+1\\,500$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'El costo por kilómetro es la pendiente: $\dfrac{9\,500-4\,700}{10-4}=800$ pesos.
El cargo fijo es $4\,700-800\cdot4=1\,500$ pesos, luego $C(x)=800x+1\,500$. Se comprueba: $C(10)=9\,500$.
A y B suponen proporcionalidad directa ($9\,500:10$ y $4\,700:4$), ignorando el cargo fijo, y no satisfacen ambos datos.
C usa como cargo fijo el costo del viaje de $4$ km.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '65b1a82f-f633-5aec-88c8-350bc535e507', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-111
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ad607697-b797-5791-9e0e-9c35c38a6d0b', 'm2-algebra-y-funciones-111', 'Una función afín $f$ cumple que $f(2)=7$ y $f(-1)=1$.

¿Cuál es el valor de $f(5)$?', '[{"id":"A","content":"$10$"},{"id":"B","content":"$13$"},{"id":"C","content":"$16$"},{"id":"D","content":"$19$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La pendiente es $\dfrac{7-1}{2-(-1)}=2$, y $f(x)=2x+n$ con $f(2)=4+n=7$, luego $n=3$.
Entonces $f(5)=2\cdot5+3=13$.
$10$ olvida el coeficiente de posición; $16$ usa pendiente $3$ (dividir $6$ por $2$ en vez de por $3$) a partir de $f(2)$.
$19$ usa esa misma pendiente errada a partir de $f(-1)$: $1+3\cdot6$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ad607697-b797-5791-9e0e-9c35c38a6d0b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-112
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9836a696-b98d-55af-836e-0e41a631a706', 'm2-algebra-y-funciones-112', 'Considera la función $f(x)=mx+n$, con dominio el conjunto de los números reales, donde $m$ y $n$ son números reales tales que $m<0$ y $n>0$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"Para todo $x>0$ se cumple que $f(x)<n$."},{"id":"B","content":"La gráfica de $f$ intersecta al eje X en un punto de abscisa negativa."},{"id":"C","content":"Si $a<b$, entonces $f(a)<f(b)$."},{"id":"D","content":"$f(1)>0$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'A: si $x>0$ y $m<0$, entonces $mx<0$, luego $f(x)=mx+n<n$. Es siempre verdadera.
B: el cero de $f$ es $x=-\dfrac{n}{m}$, que es positivo porque $n>0$ y $m<0$. Es falsa.
C: con pendiente negativa la función es decreciente, así que $a<b$ implica $f(a)>f(b)$.
D: depende de los valores; por ejemplo, con $m=-5$ y $n=1$ se tiene $f(1)=-4<0$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9836a696-b98d-55af-836e-0e41a631a706', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-113
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('aeb11923-9c62-5414-a93a-70794c8b7631', 'm2-algebra-y-funciones-113', 'Una compañía de telefonía ofrece dos planes mensuales:

Plan 1: cargo fijo de $9\,990$ pesos más $50$ pesos por cada minuto de llamadas.
Plan 2: cargo fijo de $15\,990$ pesos más $20$ pesos por cada minuto de llamadas.

¿Para qué cantidad de minutos mensuales el plan 2 resulta más barato que el plan 1?', '[{"id":"A","content":"Más de $200$ minutos"},{"id":"B","content":"Más de $300$ minutos"},{"id":"C","content":"Más de $320$ minutos"},{"id":"D","content":"Más de $533$ minutos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Con $x$ minutos, el plan 2 es más barato si $15\,990+20x<9\,990+50x$, es decir, $6\,000<30x$, o sea $x>200$.
Las rectas que representan ambos planes se cortan en $x=200$, donde ambos cuestan $19\,990$ pesos.
$300$ divide la diferencia de cargos fijos por $20$ en lugar de por la diferencia de tarifas, $30$.
$320$ y $533$ provienen de dividir el cargo fijo del plan 2 por $50$ y por $30$, respectivamente.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'aeb11923-9c62-5414-a93a-70794c8b7631', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-114
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('acf1eb1e-fc22-5aa0-8c38-4953150f111f', 'm2-algebra-y-funciones-114', 'Un estanque de riego en Ovalle se vacía a una tasa constante. En la siguiente tabla se registra el volumen $V$ de agua, en litros, a los $t$ minutos de iniciado el vaciado:

$\displaystyle \begin{array}{|c|c|c|c|}\hline t\ (\text{min}) & 0 & 5 & 12 \\ \hline V\ (\text{L}) & 1\,200 & 950 & 600 \\ \hline \end{array}$

¿Cuál de las siguientes funciones representa el volumen de agua en el estanque a los $t$ minutos?', '[{"id":"A","content":"$V(t)=1\\,200-250t$"},{"id":"B","content":"$V(t)=1\\,200-50t$"},{"id":"C","content":"$V(t)=950-50t$"},{"id":"D","content":"$V(t)=1\\,200-\\dfrac{t}{50}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'En $5$ minutos el volumen baja $250$ L, es decir, $50$ L por minuto; entre $t=5$ y $t=12$ baja $350$ L en $7$ minutos, confirmando la tasa constante.
El volumen inicial es $1\,200$ L, luego $V(t)=1\,200-50t$.
A usa como tasa por minuto la disminución de los primeros $5$ minutos.
C toma como volumen inicial el de $t=5$, y D invierte la tasa ($\frac{1}{50}$ L por minuto).', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'acf1eb1e-fc22-5aa0-8c38-4953150f111f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-115
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cf6ed7b3-cbe0-57f8-8253-a4584ba91cee', 'm2-algebra-y-funciones-115', 'Fernanda organiza una fiesta de egreso. El centro de eventos cobra $180\,000$ pesos fijos más $6\,500$ pesos por cada invitado, y ella cuenta con un presupuesto de $600\,000$ pesos.

¿Cuál es la mayor cantidad de invitados que puede tener sin exceder su presupuesto?', '[{"id":"A","content":"$27$"},{"id":"B","content":"$64$"},{"id":"C","content":"$65$"},{"id":"D","content":"$92$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Con $x$ invitados se requiere $180\,000+6\,500x\leq600\,000$, es decir, $x\leq\dfrac{420\,000}{6\,500}\approx64{,}6$.
Como $x$ es entero, la mayor cantidad es $64$ invitados.
$65$ redondea $64{,}6$ hacia arriba, lo que excede el presupuesto ($180\,000+6\,500\cdot65=602\,500$ pesos).
$92$ ignora el cargo fijo y $27$ es la parte entera de $180\,000:6\,500$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cf6ed7b3-cbe0-57f8-8253-a4584ba91cee', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-116
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a8c1ba52-6c85-5693-a747-2f28c9ea043b', 'm2-algebra-y-funciones-116', 'Dos estanques de una viña se manejan en forma simultánea. El estanque A tiene inicialmente $a$ litros de agua y pierde $p$ litros por minuto, mientras que el estanque B tiene inicialmente $b$ litros y recibe $q$ litros por minuto, con $a>b>0$ y $p>0$, $q>0$.

Cuando ambos estanques tengan la misma cantidad de agua, ¿cuántos litros habrá en cada uno?', '[{"id":"A","content":"$\\dfrac{a+b}{2}$"},{"id":"B","content":"$\\dfrac{ap+bq}{p+q}$"},{"id":"C","content":"$\\dfrac{aq-bp}{p+q}$"},{"id":"D","content":"$\\dfrac{aq+bp}{p+q}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'A los $t$ minutos, A tiene $a-pt$ litros y B tiene $b+qt$. Igualando: $a-pt=b+qt$, luego $t=\dfrac{a-b}{p+q}$.
La cantidad común es $b+q\cdot\dfrac{a-b}{p+q}=\dfrac{bp+bq+aq-bq}{p+q}=\dfrac{aq+bp}{p+q}$.
B intercambia los caudales al ponderar; C tiene un error de signo al reducir términos.
A, el promedio de $a$ y $b$, solo es correcto cuando $p=q$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a8c1ba52-6c85-5693-a747-2f28c9ea043b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-117
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b1b839d0-ec61-5ecb-b6f5-a043efebcd0f', 'm2-algebra-y-funciones-117', 'Matías resolvió la inecuación $3-\dfrac{2x}{5}\geq7$ de la siguiente manera:

Paso 1: $15-2x\geq35$
Paso 2: $-2x\geq20$
Paso 3: $x\geq-10$
Paso 4: el conjunto solución es $[-10,+\infty[$

¿En cuál de los pasos cometió Matías el primer error?', '[{"id":"A","content":"En el paso 1"},{"id":"B","content":"En el paso 2"},{"id":"C","content":"En el paso 3"},{"id":"D","content":"En el paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Paso 1: multiplicar ambos lados por $5$ es correcto. Paso 2: restar $15$ a ambos lados también lo es.
En el paso 3 dividió por $-2$ sin invertir el sentido de la desigualdad: lo correcto es $x\leq-10$.
Por ejemplo, $x=0$ cumple $x\geq-10$, pero $3-0=3$ no es mayor o igual que $7$.
El paso 4 es coherente con el paso 3, pero hereda su error; la solución correcta es $]-\infty,-10]$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b1b839d0-ec61-5ecb-b6f5-a043efebcd0f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-118
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d0523f79-1453-561b-bf03-806520cf0f7a', 'm2-algebra-y-funciones-118', '¿Cuál es el valor de $x$ que satisface la ecuación $\dfrac{x+2}{3}-\dfrac{x-1}{2}=1$?', '[{"id":"A","content":"$-5$"},{"id":"B","content":"$-1$"},{"id":"C","content":"$1$"},{"id":"D","content":"$6$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Multiplicando por $6$: $2(x+2)-3(x-1)=6$, es decir, $2x+4-3x+3=6$, luego $-x+7=6$ y $x=1$.
$-5$ aparece al no distribuir el signo menos: $2x+4-3x-3=6$.
$-1$ resulta de un error de signo al despejar al final ($-x=-1$ como $x=-1$).
$6$ se obtiene al olvidar multiplicar por $6$ el lado derecho.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd0523f79-1453-561b-bf03-806520cf0f7a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-119
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d135f484-a4d3-5ea6-871b-df18c8c398fb', 'm2-algebra-y-funciones-119', 'Sean $a$ y $b$ números reales tales que $a+b=7$ y $ab=10$.

¿Cuál es el valor de $a^{3}+b^{3}$?', '[{"id":"A","content":"$133$"},{"id":"B","content":"$203$"},{"id":"C","content":"$343$"},{"id":"D","content":"$553$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Se usa $(a+b)^{3}=a^{3}+b^{3}+3ab(a+b)$, de donde $a^{3}+b^{3}=(a+b)^{3}-3ab(a+b)$.
Reemplazando: $a^{3}+b^{3}=343-3\cdot10\cdot7=343-210=133$ (se comprueba con $a=5$ y $b=2$: $125+8=133$).
$203$ usa $2ab(a+b)$ en lugar de $3ab(a+b)$; $553$ suma el término en vez de restarlo.
$343$ supone que $(a+b)^{3}=a^{3}+b^{3}$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd135f484-a4d3-5ea6-871b-df18c8c398fb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-120
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('74685c40-4a5a-5b60-a9ab-afba1155233f', 'm2-algebra-y-funciones-120', 'Sea $n$ un número entero y considera el número $N=(n+3)^{2}-(n-1)^{2}$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"$N$ es múltiplo de $8$."},{"id":"B","content":"$N$ es un cuadrado perfecto."},{"id":"C","content":"$N$ es múltiplo de $16$."},{"id":"D","content":"$N$ es impar cuando $n$ es par."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Por diferencia de cuadrados: $N=\big((n+3)-(n-1)\big)\big((n+3)+(n-1)\big)=4(2n+2)=8(n+1)$, que es múltiplo de $8$ para todo entero $n$.
C es falsa: con $n=0$ se obtiene $N=8$, que no es múltiplo de $16$; además, con $n=0$, D también falla, pues $8$ es par.
B es falsa: con $n=1$ se obtiene $N=16$, pero con $n=2$ se obtiene $N=24$, que no es cuadrado perfecto.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '74685c40-4a5a-5b60-a9ab-afba1155233f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-121
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4dcd6a14-2f8d-599b-b19e-ceb2bf984a65', 'm2-algebra-y-funciones-121', 'Un rectángulo tiene lados de medidas $(2x+3)$ cm y $(x-1)$ cm, con $x>1$. A su área se le resta el área de un cuadrado de lado $x$ cm.

¿Cuál de las siguientes expresiones representa el resultado, en $\text{cm}^{2}$?', '[{"id":"A","content":"$x^{2}-x-3$"},{"id":"B","content":"$x^{2}+5x-3$"},{"id":"C","content":"$3x^{2}+x-3$"},{"id":"D","content":"$x^{2}+x-3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'El área del rectángulo es $(2x+3)(x-1)=2x^{2}-2x+3x-3=2x^{2}+x-3$.
Restando el área del cuadrado: $2x^{2}+x-3-x^{2}=x^{2}+x-3$.
A tiene un error de signo en el término lineal ($-3x+2x$); B suma $2x$ y $3x$ sin considerar el signo de $-1$.
C suma el área del cuadrado en lugar de restarla.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4dcd6a14-2f8d-599b-b19e-ceb2bf984a65', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-122
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8578baed-9498-5867-ba8e-6ee7058590ee', 'm2-algebra-y-funciones-122', 'Para un concierto en Concepción se vendieron $1\,300$ entradas en total, entre entradas de galería, a $15\,000$ pesos cada una, y entradas de cancha, a $20\,000$ pesos cada una. Lo recaudado por las entradas de cancha fue el triple de lo recaudado por las entradas de galería.

Si $x$ es la cantidad de entradas de galería e $y$ la cantidad de entradas de cancha vendidas, ¿cuál de los siguientes sistemas permite determinar $x$ e $y$?', '[{"id":"A","content":"$\\begin{cases} x+y=1\\,300 \\\\ 3\\cdot20\\,000y=15\\,000x \\end{cases}$"},{"id":"B","content":"$\\begin{cases} x+y=1\\,300 \\\\ y=3x \\end{cases}$"},{"id":"C","content":"$\\begin{cases} 15\\,000x+20\\,000y=1\\,300 \\\\ 20\\,000y=3\\cdot15\\,000x \\end{cases}$"},{"id":"D","content":"$\\begin{cases} x+y=1\\,300 \\\\ 20\\,000y=3\\cdot15\\,000x \\end{cases}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La cantidad total de entradas da $x+y=1\,300$. Lo recaudado en cancha es $20\,000y$ y en galería $15\,000x$; la condición es $20\,000y=3\cdot15\,000x$.
Su solución es $x=400$ e $y=900$: en cancha se recaudan $18\,000\,000$ pesos y en galería $6\,000\,000$ pesos.
A pone el factor $3$ en el lado equivocado; B compara cantidades de entradas en vez de dinero recaudado.
C iguala el dinero total a la cantidad de entradas.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8578baed-9498-5867-ba8e-6ee7058590ee', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m2-algebra-y-funciones-123
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('725a9026-1705-5d4f-993d-7c0db02a8dab', 'm2-algebra-y-funciones-123', 'Un número natural de dos cifras cumple las siguientes condiciones:

la suma de sus cifras es $11$, y
si se intercambia la cifra de las decenas con la de las unidades, el número obtenido es $27$ unidades mayor que el número original.

¿Cuál es el producto de las cifras del número original?', '[{"id":"A","content":"$18$"},{"id":"B","content":"$24$"},{"id":"C","content":"$28$"},{"id":"D","content":"$30$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Sea $10d+u$ el número, con $d$ la cifra de las decenas y $u$ la de las unidades. Se plantea el sistema $d+u=11$ y $10u+d=10d+u+27$.
La segunda ecuación se reduce a $9u-9d=27$, es decir, $u-d=3$. Resolviendo: $u=7$ y $d=4$; el número es $47$ y $74-47=27$.
El producto de las cifras es $4\cdot7=28$.
Los distractores corresponden a otros pares de cifras que suman $11$: $2$ y $9$ (producto $18$), $3$ y $8$ ($24$), $5$ y $6$ ($30$), que no cumplen la segunda condición.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '725a9026-1705-5d4f-993d-7c0db02a8dab', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m2-algebra-y-funciones-124
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d7d97b1b-6e7e-5617-a059-bbe29cc1c8c6', 'm2-algebra-y-funciones-124', 'En un huerto de paltas de Quillota, $6$ máquinas cosechadoras, trabajando $8$ horas diarias, terminan la cosecha en $10$ días. Todas las máquinas trabajan al mismo ritmo.

¿Cuántos días tardarían $4$ de estas máquinas en cosechar el mismo huerto si trabajan $10$ horas diarias?', '[{"id":"A","content":"$5{,}\\overline{3}$"},{"id":"B","content":"$8{,}\\overline{3}$"},{"id":"C","content":"$12$"},{"id":"D","content":"$18{,}75$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El trabajo total es $6\cdot8\cdot10=480$ horas-máquina. Con $4$ máquinas a $10$ horas diarias se completan $40$ horas-máquina por día.
Se requieren $\dfrac{480}{40}=12$ días. Ambas magnitudes son inversamente proporcionales a la cantidad de días.
$18{,}75$ trata las horas diarias como directamente proporcionales a los días; $5{,}\overline{3}$ trata así a las máquinas.
$8{,}\overline{3}$ considera ambas magnitudes como directamente proporcionales.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd7d97b1b-6e7e-5617-a059-bbe29cc1c8c6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m2-algebra-y-funciones-125
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b262d176-5050-5ae2-a6d2-ebc5e74dbfcb', 'm2-algebra-y-funciones-125', 'La distancia de frenado de un automóvil es directamente proporcional al cuadrado de su rapidez. En cierto pavimento, un automóvil que circula a $50$ km/h necesita $15$ m para frenar.

En el mismo pavimento, ¿cuántos metros necesita para frenar si circula a $100$ km/h?', '[{"id":"A","content":"$30$"},{"id":"B","content":"$45$"},{"id":"C","content":"$60$"},{"id":"D","content":"$225$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Se tiene $d=k\cdot v^{2}$. Al duplicar la rapidez, la distancia se multiplica por $2^{2}=4$: $d=4\cdot15=60$ m.
También: $k=\dfrac{15}{2\,500}$, luego $d=\dfrac{15}{2\,500}\cdot10\,000=60$.
$30$ supone proporcionalidad directa con la rapidez (no con su cuadrado) y $45$ multiplica por $3$ sin justificación.
$225$ eleva al cuadrado la distancia en lugar de la razón entre las rapideces.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b262d176-5050-5ae2-a6d2-ebc5e74dbfcb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m2-algebra-y-funciones-126
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('53c0bb0f-8c26-579d-8122-918b77c0b939', 'm2-algebra-y-funciones-126', 'Considera la función $f(x)=a(x-1)(x-7)$, con $a$ un número real distinto de cero y dominio el conjunto de los números reales. Se sabe que el valor máximo de $f$ es $18$.

¿Cuál es el valor de $f(0)$?', '[{"id":"A","content":"$-14$"},{"id":"B","content":"$-7$"},{"id":"C","content":"$7$"},{"id":"D","content":"$14$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Los ceros de $f$ son $1$ y $7$, así que el eje de simetría es $x=\dfrac{1+7}{2}=4$.
El máximo es $f(4)=a\cdot3\cdot(-3)=-9a=18$, de donde $a=-2$ (negativo, como corresponde a un máximo).
Luego, $f(0)=-2\cdot(-1)\cdot(-7)=-14$.
D usa $a=2$, que daría un mínimo y no un máximo.
B y C ignoran el cálculo de $a$ y usan $a=-1$ o $a=1$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '53c0bb0f-8c26-579d-8122-918b77c0b939', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-127
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('af306609-a97a-5644-8ee3-7c32ce845d75', 'm2-algebra-y-funciones-127', 'En un partido de básquetbol, la altura $h$, en metros, de un balón lanzado por una jugadora se modela mediante la función $h(t)=-5t^{2}+8t+1{,}8$, donde $t$ es el tiempo, en segundos, transcurrido desde el lanzamiento.

¿Durante cuánto tiempo el balón se encuentra a más de $4{,}8$ m de altura?', '[{"id":"A","content":"$0{,}4$ s"},{"id":"B","content":"$0{,}6$ s"},{"id":"C","content":"$1$ s"},{"id":"D","content":"$1{,}6$ s"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Se resuelve $-5t^{2}+8t+1{,}8>4{,}8$, es decir, $5t^{2}-8t+3<0$.
Como $5t^{2}-8t+3=(5t-3)(t-1)$, la inecuación se cumple para $0{,}6<t<1$.
El balón está sobre $4{,}8$ m durante $1-0{,}6=0{,}4$ s.
B es el instante en que alcanza esa altura al subir y C, el instante en que vuelve a ella al bajar.
D es la suma de ambos instantes, no su diferencia.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'af306609-a97a-5644-8ee3-7c32ce845d75', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-128
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f8f9cdce-7ba9-581c-bfe5-945c0b53b996', 'm2-algebra-y-funciones-128', 'Considera la función $f(x)=x^{2}-2kx+k+6$, con $k$ un número real y dominio el conjunto de los números reales.

¿Para qué valor o valores de $k$ el vértice de la parábola asociada a $f$ está sobre el eje X?', '[{"id":"A","content":"Solo para $k=3$"},{"id":"B","content":"Para $k=-3$ o para $k=2$"},{"id":"C","content":"Para $k=-2$ o para $k=3$"},{"id":"D","content":"Solo para $k=-2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'El vértice está sobre el eje X cuando la parábola toca ese eje en un solo punto, es decir, cuando el discriminante es cero.
$(-2k)^{2}-4(k+6)=0\Rightarrow4k^{2}-4k-24=0\Rightarrow k^{2}-k-6=0\Rightarrow(k-3)(k+2)=0$.
Por lo tanto, $k=3$ o $k=-2$. (También: el vértice es $(k,\,-k^{2}+k+6)$ y su ordenada debe ser $0$).
B tiene un error de signo al factorizar, y A y D consideran solo una de las dos soluciones.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f8f9cdce-7ba9-581c-bfe5-945c0b53b996', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-129
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c1719188-4c39-5717-802e-f55d25010777', 'm2-algebra-y-funciones-129', 'Considera la función $f(x)=a(x-h)^{2}+k$, con dominio el conjunto de los números reales, donde $a$, $h$ y $k$ son números reales tales que $a>0$, $h\neq0$ y $k<0$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"La gráfica de $f$ intersecta al eje Y en un punto ubicado bajo el eje X."},{"id":"B","content":"El eje de simetría de la parábola asociada a $f$ es la recta $x=-h$."},{"id":"C","content":"El valor máximo de $f$ es $k$."},{"id":"D","content":"La gráfica de $f$ intersecta al eje X en dos puntos distintos."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Como $a>0$, la parábola se abre hacia arriba y su vértice $(h,\,k)$ es un mínimo; como $k<0$, ese mínimo está bajo el eje X, así que la gráfica corta al eje X en dos puntos.
A no siempre se cumple: $f(0)=ah^{2}+k$ puede ser positivo; por ejemplo, con $a=1$, $h=3$ y $k=-1$, $f(0)=8$.
B es falsa: el eje de simetría es $x=h$.
C es falsa: con $a>0$, $k$ es el valor mínimo y la función no tiene máximo.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c1719188-4c39-5717-802e-f55d25010777', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-130
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('fe07bd1f-f328-5e78-a3e8-c8f508f9dc1c', 'm2-algebra-y-funciones-130', 'Se quiere escribir la función $f(x)=x^{2}-8x+11$ en la forma $f(x)=(x-h)^{2}+k$ para identificar directamente su vértice.

¿Cuál de las siguientes expresiones corresponde a esa forma?', '[{"id":"A","content":"$f(x)=(x+4)^{2}-5$"},{"id":"B","content":"$f(x)=(x-4)^{2}+11$"},{"id":"C","content":"$f(x)=(x-8)^{2}-53$"},{"id":"D","content":"$f(x)=(x-4)^{2}-5$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Se completa el cuadrado con la mitad del coeficiente de $x$: $x^{2}-8x+11=x^{2}-8x+16-16+11=(x-4)^{2}-5$.
El vértice es $(4,\,-5)$.
A tiene un error de signo dentro del paréntesis.
B agrega $16$ para formar el cuadrado, pero no lo resta.
C usa el coeficiente completo $8$ en lugar de su mitad.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'fe07bd1f-f328-5e78-a3e8-c8f508f9dc1c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-131
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3736f116-0f69-51ea-bac1-6be05b3d8915', 'm2-algebra-y-funciones-131', 'Una agricultora de Paine dispone de $24$ m de malla para cercar un corral rectangular. Con la misma malla debe construir, además, una división interior paralela a uno de los lados, que separe el corral en dos partes iguales. Toda la malla se usa en el contorno y en la división.

¿Cuál es el área máxima, en $\text{m}^{2}$, que puede tener el corral?', '[{"id":"A","content":"$18$"},{"id":"B","content":"$24$"},{"id":"C","content":"$36$"},{"id":"D","content":"$48$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Sea $x$ la medida del lado paralelo a la división (aparece $3$ veces) e $y$ la del otro lado (aparece $2$ veces): $3x+2y=24$, de donde $y=12-1{,}5x$.
El área es $A(x)=x(12-1{,}5x)=-1{,}5x^{2}+12x$, cuyo máximo está en $x=\dfrac{-12}{2\cdot(-1{,}5)}=4$.
Entonces $y=6$ y el área máxima es $4\cdot6=24\ \text{m}^{2}$.
C corresponde a un cuadrado de $6$ m de lado, sin descontar la división.
A cuenta la división dos veces ($4x+2y=24$) y D duplica el resultado correcto.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3736f116-0f69-51ea-bac1-6be05b3d8915', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-132
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f5b47daa-61e3-5c77-861f-59c18ab2bea6', 'm2-algebra-y-funciones-132', 'Mateo debe resolver la ecuación $2x^{2}=3x+2$, en $x$, y anotar todas sus soluciones reales.

¿Qué valores debe anotar?', '[{"id":"A","content":"$\\left\\{-2,\\,\\dfrac{1}{2}\\right\\}$"},{"id":"B","content":"$\\left\\{-\\dfrac{1}{2},\\,2\\right\\}$"},{"id":"C","content":"$\\left\\{\\dfrac{1}{2},\\,2\\right\\}$"},{"id":"D","content":"$\\left\\{-1,\\,4\\right\\}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Se iguala a cero: $2x^{2}-3x-2=0$, que se factoriza como $(2x+1)(x-2)=0$.
Las soluciones son $x=-\dfrac{1}{2}$ y $x=2$.
A intercambia los signos de las soluciones.
C tiene un error de signo en una de ellas.
D aplica la fórmula general dividiendo por $2$ en lugar de $2a=4$: $\dfrac{3\pm5}{2}$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f5b47daa-61e3-5c77-861f-59c18ab2bea6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-133
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('aaeb485d-5269-500a-8f88-3343eead5a41', 'm2-algebra-y-funciones-133', 'La cantidad de visitantes diarios de una feria costumbrista en Chiloé se modela mediante la función $V(t)=-40(t-5)^{2}+1\,000$, donde $t$ es la cantidad de días transcurridos desde la inauguración, con $0\leq t\leq10$.

¿Cuál es el primer valor de $t$ para el que la cantidad de visitantes es $640$?', '[{"id":"A","content":"$2$"},{"id":"B","content":"$3$"},{"id":"C","content":"$5$"},{"id":"D","content":"$8$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Se resuelve $-40(t-5)^{2}+1\,000=640$: $(t-5)^{2}=\dfrac{360}{40}=9$.
Entonces $t-5=3$ o $t-5=-3$, es decir, $t=8$ o $t=2$. El primero es $t=2$.
D es la segunda vez que se registran $640$ visitantes.
C es el día de mayor afluencia (vértice), y B toma la raíz $3$ como si fuera el valor de $t$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'aaeb485d-5269-500a-8f88-3343eead5a41', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-cuadratica'
  on conflict do nothing;
-- m2-algebra-y-funciones-134
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1c7f6075-4acf-5c4b-9c7d-7b2562ad516a', 'm2-algebra-y-funciones-134', 'Un día de verano, la temperatura del aire a nivel del mar en la zona central es de $24\,^{\circ}\text{C}$ y, a medida que se asciende, disminuye $6\,^{\circ}\text{C}$ por cada kilómetro de altura.

Si $h$ es la altura sobre el nivel del mar, en metros, ¿cuál de las siguientes funciones modela la temperatura $T$, en $^{\circ}\text{C}$, a esa altura?', '[{"id":"A","content":"$T(h)=24-6h$"},{"id":"B","content":"$T(h)=24-0{,}6h$"},{"id":"C","content":"$T(h)=24-0{,}06h$"},{"id":"D","content":"$T(h)=24-0{,}006h$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'La temperatura baja $6\,^{\circ}\text{C}$ cada $1\,000$ m, es decir, $\dfrac{6}{1\,000}=0{,}006\,^{\circ}\text{C}$ por metro.
Por lo tanto, $T(h)=24-0{,}006h$; por ejemplo, a $1\,000$ m se tiene $T=18\,^{\circ}\text{C}$.
A usa la tasa por kilómetro, aunque $h$ está en metros.
B y C convierten mal la unidad, como si $1$ km fuera $10$ m o $100$ m.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1c7f6075-4acf-5c4b-9c7d-7b2562ad516a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-135
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6e381016-f9a3-5352-af63-a8a4d4f2d0a5', 'm2-algebra-y-funciones-135', 'En el plano cartesiano, la recta $L_1$ tiene ecuación $y=-2x+8$ y la recta $L_2$ tiene ecuación $y=mx+2$, con $m$ un número real positivo. Ambas rectas se intersectan en un punto cuya abscisa es $2$.

¿Cuál es el área, en unidades cuadradas, del triángulo que forman $L_1$, $L_2$ y el eje X?', '[{"id":"A","content":"$6$"},{"id":"B","content":"$8$"},{"id":"C","content":"$12$"},{"id":"D","content":"$24$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'En $x=2$, $L_1$ da $y=4$; entonces $4=2m+2$ y $m=1$, por lo que $L_2$ es $y=x+2$.
$L_1$ corta al eje X en $x=4$ y $L_2$, en $x=-2$: la base del triángulo mide $6$ y su altura es $4$.
El área es $\dfrac{6\cdot4}{2}=12$.
D no divide por $2$. B usa como base solo el tramo de $0$ a $4$.
A usa como altura la ordenada $2$ del intercepto de $L_2$ con el eje Y.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6e381016-f9a3-5352-af63-a8a4d4f2d0a5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-136
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('04ba34f1-6263-5121-aa55-afcbeaf6acb1', 'm2-algebra-y-funciones-136', 'Considera las funciones $f(x)=ax+b$ y $g(x)=bx+a$, con dominio el conjunto de los números reales, donde $a$ y $b$ son números reales distintos entre sí.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"Las gráficas de $f$ y $g$ son rectas paralelas."},{"id":"B","content":"Las gráficas de $f$ y $g$ se intersectan en un punto del eje Y."},{"id":"C","content":"Las gráficas de $f$ y $g$ se intersectan en el punto $(a+b,\\,1)$."},{"id":"D","content":"Las gráficas de $f$ y $g$ se intersectan en el punto $(1,\\,a+b)$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Al igualar: $ax+b=bx+a\Rightarrow(a-b)x=a-b$. Como $a\neq b$, se obtiene $x=1$, y entonces $y=a+b$.
Así, las gráficas siempre se cortan en $(1,\,a+b)$.
A es falsa: las pendientes $a$ y $b$ son distintas, así que las rectas no son paralelas.
B es falsa: los coeficientes de posición $b$ y $a$ son distintos.
C intercambia las coordenadas del punto de intersección.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '04ba34f1-6263-5121-aa55-afcbeaf6acb1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-137
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('dfcc598d-8683-56c1-b322-eae3a218c12e', 'm2-algebra-y-funciones-137', 'Una función afín $f$, con dominio el conjunto de los números reales, cumple que $f(x+2)-f(x)=6$ para todo número real $x$. Además, $f(1)=4$.

¿Cuál es el valor de $f(5)$?', '[{"id":"A","content":"$10$"},{"id":"B","content":"$16$"},{"id":"C","content":"$22$"},{"id":"D","content":"$28$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Si $f(x)=mx+n$, entonces $f(x+2)-f(x)=2m=6$, así que la pendiente es $m=3$.
Luego, $f(5)=f(1)+3\cdot(5-1)=4+12=16$. (También: $f(3)=4+6=10$ y $f(5)=10+6=16$).
A aplica el aumento de $6$ una sola vez.
D toma $6$ como pendiente: $4+6\cdot4=28$.
C suma tres veces el aumento de $6$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'dfcc598d-8683-56c1-b322-eae3a218c12e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-138
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b9e84c84-c325-55a1-8f33-81817c5e9043', 'm2-algebra-y-funciones-138', 'En la siguiente tabla se presentan algunos valores de una función afín $f$:

$\displaystyle \begin{array}{|c|c|c|c|}\hline x & 2 & 5 & 9 \\ \hline f(x) & 1 & 7 & 15 \\ \hline \end{array}$

¿Cuál de las siguientes expresiones define a $f$?', '[{"id":"A","content":"$f(x)=2x-3$"},{"id":"B","content":"$f(x)=2x+3$"},{"id":"C","content":"$f(x)=3x-5$"},{"id":"D","content":"$f(x)=\\dfrac{1}{2}x$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La pendiente es $\dfrac{7-1}{5-2}=\dfrac{6}{3}=2$ (y también $\dfrac{15-7}{9-5}=2$).
Con el punto $(2,\,1)$: $1=2\cdot2+n$, de donde $n=-3$. Así, $f(x)=2x-3$.
B tiene la pendiente correcta, pero un error de signo en el coeficiente de posición.
C y D cumplen solo con el primer par de la tabla: por ejemplo, $3\cdot5-5=10\neq7$ y $\dfrac{1}{2}\cdot5\neq7$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b9e84c84-c325-55a1-8f33-81817c5e9043', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'funcion-lineal-afin'
  on conflict do nothing;
-- m2-algebra-y-funciones-139
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1032c44f-2a47-5e0b-a278-deac5eb27d86', 'm2-algebra-y-funciones-139', '¿Cuál de las siguientes expresiones es un factor de $x^{4}-13x^{2}+36$?', '[{"id":"A","content":"$x-6$"},{"id":"B","content":"$x-4$"},{"id":"C","content":"$x^{2}+4$"},{"id":"D","content":"$x+2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Con $u=x^{2}$, la expresión es $u^{2}-13u+36=(u-4)(u-9)$.
Entonces $x^{4}-13x^{2}+36=\left(x^{2}-4\right)\left(x^{2}-9\right)=(x-2)(x+2)(x-3)(x+3)$, y $x+2$ es un factor.
B y A confunden los factores $x^{2}-4$ o la constante $36$ con factores lineales $x-4$ o $x-6$.
C tiene un error de signo: $x^{2}+4$ no divide a la expresión.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1032c44f-2a47-5e0b-a278-deac5eb27d86', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-140
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6f423b82-f553-59bc-9255-da22d8e919f7', 'm2-algebra-y-funciones-140', 'Javiera simplificó la expresión $\dfrac{2x^{2}-8}{x^{2}-4x+4}$, con $x\neq2$ y $x\neq-2$, de la siguiente manera:

Paso 1: $2x^{2}-8=2\left(x^{2}-4\right)$
Paso 2: $2\left(x^{2}-4\right)=2(x-2)(x+2)$
Paso 3: $x^{2}-4x+4=(x-2)(x+2)$
Paso 4: $\dfrac{2(x-2)(x+2)}{(x-2)(x+2)}=2$

¿En cuál de los pasos Javiera cometió el primer error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los Pasos 1 y 2 son correctos: se factoriza por $2$ y luego se aplica la diferencia de cuadrados.
En el Paso 3 está el error: $x^{2}-4x+4$ es un cuadrado de binomio, $(x-2)^{2}$, no una suma por diferencia.
Con la factorización correcta, la expresión se simplifica a $\dfrac{2(x+2)}{x-2}$.
El Paso 4, a partir de lo que escribió en el Paso 3, está bien realizado.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6f423b82-f553-59bc-9255-da22d8e919f7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-141
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b5df39f7-c94d-5d96-a256-bc793e766853', 'm2-algebra-y-funciones-141', 'Un rectángulo tiene un perímetro de $34$ cm y su diagonal mide $13$ cm.

¿Cuál es el área del rectángulo?', '[{"id":"A","content":"$30\\ \\text{cm}^{2}$"},{"id":"B","content":"$60\\ \\text{cm}^{2}$"},{"id":"C","content":"$72{,}25\\ \\text{cm}^{2}$"},{"id":"D","content":"$120\\ \\text{cm}^{2}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Si los lados miden $a$ y $b$: $a+b=17$ y, por Pitágoras, $a^{2}+b^{2}=169$.
Como $(a+b)^{2}=a^{2}+2ab+b^{2}$, se tiene $289=169+2ab$, de donde $2ab=120$ y $ab=60$ (los lados miden $5$ cm y $12$ cm).
D olvida dividir $2ab$ por $2$, y A divide por $4$.
C supone que el rectángulo es un cuadrado de lado $8{,}5$ cm, lo que no es compatible con la diagonal dada.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b5df39f7-c94d-5d96-a256-bc793e766853', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'expresiones-algebraicas'
  on conflict do nothing;
-- m2-algebra-y-funciones-142
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e4554aa0-0e21-5086-acbc-c842b397ca50', 'm2-algebra-y-funciones-142', 'En una asignatura, la nota final es el promedio de cuatro notas con igual ponderación. Tomás tiene las notas $3{,}5$; $4{,}2$ y $3{,}8$, y le falta rendir la cuarta evaluación.

¿Cuál es la nota mínima que debe obtener en la cuarta evaluación para que su nota final sea al menos $4{,}0$?', '[{"id":"A","content":"$4{,}0$"},{"id":"B","content":"$4{,}2$"},{"id":"C","content":"$4{,}5$"},{"id":"D","content":"$5{,}0$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Se plantea $\dfrac{3{,}5+4{,}2+3{,}8+x}{4}\geq4{,}0$, es decir, $11{,}5+x\geq16$, de donde $x\geq4{,}5$.
La nota mínima es $4{,}5$.
A supone que basta con obtener la nota que se quiere de promedio.
B suma a $4{,}0$ lo que le falta al promedio actual ($\approx3{,}83$) para llegar a $4{,}0$.
D comete un error al sumar las tres notas (obtiene $11$ en lugar de $11{,}5$).', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e4554aa0-0e21-5086-acbc-c842b397ca50', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-143
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a82571ce-e3be-5cf7-8f83-3827e44c6168', 'm2-algebra-y-funciones-143', 'Considera la ecuación $k(x-2)=3x+4$, en $x$, con $k$ un número real distinto de $3$.

La solución de esta ecuación es un número negativo si y solo si $k$ pertenece a un intervalo. ¿Cuál es ese intervalo?', '[{"id":"A","content":"$\\left]-2,\\,3\\right[$"},{"id":"B","content":"$\\left]-\\infty,\\,-2\\right[\\cup\\left]3,\\,+\\infty\\right[$"},{"id":"C","content":"$\\left]3,\\,+\\infty\\right[$"},{"id":"D","content":"$\\left]-\\infty,\\,3\\right[$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Se despeja: $kx-2k=3x+4\Rightarrow(k-3)x=2k+4\Rightarrow x=\dfrac{2k+4}{k-3}$.
Este cociente es negativo cuando el numerador y el denominador tienen signos opuestos, lo que ocurre si $-2<k<3$ (si $k=-2$, la solución es $0$, que no es negativa).
B es el conjunto de valores para los que la solución es positiva.
D solo considera el signo del denominador y C invierte esa condición.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a82571ce-e3be-5cf7-8f83-3827e44c6168', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-144
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1f0e8384-b8a2-5991-b7ab-031cb26e73ab', 'm2-algebra-y-funciones-144', 'El estacionamiento de un centro comercial cobra $900$ pesos por la primera hora y $15$ pesos por cada minuto adicional. Martín dispone de $4\,500$ pesos para pagar el estacionamiento y estima que se quedará más de una hora.

Si $t$ es el tiempo total de permanencia, en minutos, con $t>60$, ¿cuál de las siguientes inecuaciones permite determinar los valores de $t$ que Martín puede pagar?', '[{"id":"A","content":"$900+15t\\leq4\\,500$"},{"id":"B","content":"$15(t-60)\\leq4\\,500$"},{"id":"C","content":"$900+15(t-60)\\geq4\\,500$"},{"id":"D","content":"$900+15(t-60)\\leq4\\,500$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Los minutos adicionales son $t-60$, así que el cobro es $900+15(t-60)$ pesos, y no debe superar los $4\,500$ pesos.
Por lo tanto, $900+15(t-60)\leq4\,500$, que da $t\leq300$ minutos.
A cobra los $15$ pesos también por los primeros $60$ minutos.
B olvida el cobro de la primera hora.
C invierte el sentido de la desigualdad.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1f0e8384-b8a2-5991-b7ab-031cb26e73ab', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'ecuaciones-inecuaciones-lineales'
  on conflict do nothing;
-- m2-algebra-y-funciones-145
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ec9dae29-8684-5830-ad27-81840e52fce7', 'm2-algebra-y-funciones-145', 'En una feria libre, Rocío pagó $14\,400$ pesos por $3$ kg de paltas y $2$ kg de tomates. Ese mismo día y en el mismo puesto, Andrés pagó $14\,000$ pesos por $2$ kg de paltas y $5$ kg de tomates.

¿Cuánto cuesta en ese puesto comprar $1$ kg de paltas y $1$ kg de tomates?', '[{"id":"A","content":"$2\\,800$ pesos"},{"id":"B","content":"$4\\,000$ pesos"},{"id":"C","content":"$5\\,200$ pesos"},{"id":"D","content":"$5\\,680$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Si $p$ y $t$ son los precios por kilogramo: $3p+2t=14\,400$ y $2p+5t=14\,000$.
Multiplicando la primera por $2$ y la segunda por $3$ y restando: $11t=13\,200$, así que $t=1\,200$ y $p=4\,000$.
El costo pedido es $p+t=5\,200$ pesos.
B es solo el precio de las paltas y A es la diferencia $p-t$.
D suma las dos ecuaciones y divide por $5$, sin considerar que se obtiene $5p+7t$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ec9dae29-8684-5830-ad27-81840e52fce7', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m2-algebra-y-funciones-146
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('db65d56b-b4d8-572b-8d40-2f16c1ecabe4', 'm2-algebra-y-funciones-146', 'Un profesor de Educación Física organiza a los estudiantes de su curso en grupos. Si forma grupos de $4$ estudiantes, quedan $3$ estudiantes sin grupo. Si, en cambio, forma grupos de $5$ estudiantes, al último grupo le faltan $2$ integrantes para estar completo y, contando ese grupo incompleto, se forman $2$ grupos menos que al formar grupos de $4$.

¿Cuántos estudiantes tiene el curso?', '[{"id":"A","content":"$43$"},{"id":"B","content":"$47$"},{"id":"C","content":"$63$"},{"id":"D","content":"$65$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Sean $g$ la cantidad de grupos de $4$ y $h$ la de grupos de $5$. Si $N$ es la cantidad de estudiantes: $N=4g+3$, $N=5h-2$ y $g=h+2$.
Reemplazando: $4(h+2)+3=5h-2$, de donde $h=13$ y $N=63$. (Verificación: $63=4\cdot15+3$ y $63=5\cdot13-2$).
A cumple las dos primeras condiciones, pero con solo $1$ grupo de diferencia.
B interpreta que en los grupos de $5$ sobran $2$ estudiantes, y D no descuenta los $2$ integrantes que faltan.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'db65d56b-b4d8-572b-8d40-2f16c1ecabe4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'sistemas-2x2'
  on conflict do nothing;
-- m2-algebra-y-funciones-147
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('3106e8da-fc20-5f0e-b6b0-034f1a4b6b0e', 'm2-algebra-y-funciones-147', 'Las variables $x$ e $y$, ambas positivas, son inversamente proporcionales.

Si el valor de $x$ aumenta en un $25\%$, ¿cuál de las siguientes afirmaciones es verdadera respecto del valor de $y$?', '[{"id":"A","content":"Aumenta en un $25\\%$."},{"id":"B","content":"Disminuye en un $25\\%$."},{"id":"C","content":"Disminuye en un $75\\%$."},{"id":"D","content":"Disminuye en un $20\\%$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Como $x\cdot y=k$ constante, si $x$ pasa a $1{,}25x$, entonces $y$ pasa a $\dfrac{k}{1{,}25x}=\dfrac{y}{1{,}25}=0{,}8y$.
Es decir, $y$ disminuye en un $20\%$.
B supone que $y$ baja en el mismo porcentaje en que sube $x$, lo que no mantiene constante el producto: $1{,}25\cdot0{,}75\neq1$.
A describe una proporcionalidad directa, y C confunde el $75\%$ restante con la disminución.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '3106e8da-fc20-5f0e-b6b0-034f1a4b6b0e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'algebra-y-funciones' and e.subject = 'm2' and t.slug = 'proporcionalidad'
  on conflict do nothing;
-- m2-geometria-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5620f027-3d0c-506a-9b9a-09ef71c238fa', 'm2-geometria-001', 'En un plano cartesiano se dibuja el triángulo de vértices $A(2, 1)$, $B(6, 1)$ y $C(2, 4)$. A este triángulo se le aplica una homotecia con centro en el origen y razón negativa, y se obtiene el triángulo $A''B''C''$, cuya área es $54$ unidades cuadradas.

¿Cuáles son las coordenadas de $C''$, la imagen del vértice $C$?', '[{"id":"A","content":"$(-18, -36)$"},{"id":"B","content":"$(-6, -12)$"},{"id":"C","content":"$(6, 12)$"},{"id":"D","content":"$(18, 36)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El triángulo $ABC$ es rectángulo en $A$, con catetos $AB = 4$ y $AC = 3$, así que su área es $\frac{4 \cdot 3}{2} = 6$.
En una homotecia de razón $k$ las áreas se multiplican por $k^2$: $6k^2 = 54$, de donde $k^2 = 9$ y, como la razón es negativa, $k = -3$.
Con centro en el origen, $C'' = -3 \cdot (2, 4) = (-6, -12)$.
A usa $k = -9$ (confunde la razón de áreas con la razón de homotecia), C usa $k = 3$ ignorando el signo y D combina ambos errores.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5620f027-3d0c-506a-9b9a-09ef71c238fa', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'homotecia'
  on conflict do nothing;
-- m2-geometria-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9e11c5df-cb78-52d7-894b-9650a59b8478', 'm2-geometria-002', 'Para ampliar un logo sobre una pantalla cuadriculada, una diseñadora de Concepción aplica una homotecia de centro $P(2, 1)$ que transforma el punto $A(4, 3)$ en el punto $A''(8, 7)$.

Si aplica la misma homotecia al punto $B(1, 2)$, ¿cuáles son las coordenadas de su imagen $B''$?', '[{"id":"A","content":"$(-1, 4)$"},{"id":"B","content":"$(0, 3)$"},{"id":"C","content":"$(3, 6)$"},{"id":"D","content":"$(5, -2)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Como $\overrightarrow{PA''} = k \cdot \overrightarrow{PA}$, se tiene $(6, 6) = k \cdot (2, 2)$, luego $k = 3$.
Entonces $B'' = P + 3 \cdot \overrightarrow{PB} = (2, 1) + 3 \cdot (-1, 1) = (-1, 4)$.
B usa $k = 2$ (la distancia que se agrega en lugar de la razón), C multiplica las coordenadas de $B$ por $3$ como si el centro fuera el origen y D resta el vector $3 \cdot \overrightarrow{PB}$ en lugar de sumarlo.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9e11c5df-cb78-52d7-894b-9650a59b8478', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'homotecia'
  on conflict do nothing;
-- m2-geometria-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b992a127-bc39-5642-a63e-7fc31e1873e0', 'm2-geometria-003', 'En Fiestas Patrias, Martina eleva un volantín. En cierto momento, el volantín está $12$ m más arriba que su mano, la distancia horizontal entre su mano y el punto ubicado justo debajo del volantín es $5$ m, y el hilo, completamente tenso y recto, mide $13$ m.

Si $\alpha$ es el ángulo que forma el hilo con la horizontal que pasa por la mano de Martina, ¿cuál es el valor de $\operatorname{sen}(\alpha)$?', '[{"id":"A","content":"$\\frac{5}{13}$"},{"id":"B","content":"$\\frac{5}{12}$"},{"id":"C","content":"$\\frac{12}{13}$"},{"id":"D","content":"$\\frac{12}{5}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El hilo es la hipotenusa ($13$ m) de un triángulo rectángulo cuyo cateto opuesto a $\alpha$ es la altura ($12$ m) y cuyo cateto adyacente es la distancia horizontal ($5$ m).
Por lo tanto, $\operatorname{sen}(\alpha) = \frac{12}{13}$.
A corresponde a $\cos(\alpha)$, B a $\tan$ del otro ángulo agudo y D a $\tan(\alpha)$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b992a127-bc39-5642-a63e-7fc31e1873e0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'razones-trigonometricas'
  on conflict do nothing;
-- m2-geometria-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f4f8d24c-7a89-5570-850b-7626409d8182', 'm2-geometria-004', 'Desde un punto $P$ en el suelo, Ignacio observa la parte más alta de una torre de telecomunicaciones con un ángulo de elevación de $30^\circ$. Luego camina $20$ m en línea recta hacia la base de la torre, hasta un punto $Q$, desde donde la observa con un ángulo de elevación de $45^\circ$.

Considera que $P$, $Q$ y la base de la torre están alineados sobre un terreno horizontal, que la torre es vertical y que la estatura de Ignacio es despreciable. Además, $\tan(30^\circ) = \frac{\sqrt{3}}{3}$ y $\tan(45^\circ) = 1$.

¿Cuál es la altura de la torre?', '[{"id":"A","content":"$10(\\sqrt{3}-1)$ m"},{"id":"B","content":"$\\frac{20\\sqrt{3}}{3}$ m"},{"id":"C","content":"$20$ m"},{"id":"D","content":"$10(\\sqrt{3}+1)$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Sea $h$ la altura. Desde $Q$, $\tan(45^\circ) = 1$, así que la distancia de $Q$ a la base es $h$; desde $P$ esa distancia es $h + 20$.
Entonces $\frac{\sqrt{3}}{3} = \frac{h}{h + 20}$, es decir, $\sqrt{3}\,h = h + 20$, de donde $h = \frac{20}{\sqrt{3} - 1} = 10(\sqrt{3} + 1) \approx 27{,}3$ m.
A aparece al racionalizar con el signo equivocado, B multiplica los $20$ m por $\tan(30^\circ)$, como si esa fuera la distancia de $P$ a la base, y C supone que la altura es igual a lo caminado.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f4f8d24c-7a89-5570-850b-7626409d8182', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'razones-trigonometricas'
  on conflict do nothing;
-- m2-geometria-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9704f3b2-01e2-5056-bfa2-cee9e3021d58', 'm2-geometria-005', 'Considera el triángulo $ABC$, rectángulo en $C$.

Se puede determinar la medida del lado $AB$, si se sabe que:

(1) $\tan(\angle BAC) = \frac{3}{4}$.
(2) El perímetro del triángulo $ABC$ es $24$ cm.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Con (1): los catetos están en razón $BC : AC = 3 : 4$, así que los lados son $3k$, $4k$ y $5k$ para algún $k > 0$; $AB = 5k$ no queda determinado.
Con (2): hay infinitos triángulos rectángulos de perímetro $24$ cm (por ejemplo, de lados $6$, $8$, $10$ o uno isósceles), con hipotenusas distintas.
Juntas: $3k + 4k + 5k = 24$, luego $k = 2$ y $AB = 10$ cm.
Por lo tanto, se necesitan ambas afirmaciones.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9704f3b2-01e2-5056-bfa2-cee9e3021d58', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'razones-trigonometricas'
  on conflict do nothing;
-- m2-geometria-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('be338870-9d49-5145-884d-74b68a13de0b', 'm2-geometria-006', 'En una circunferencia, las cuerdas $AB$ y $CD$ se intersecan en el punto $P$. Se sabe que $AP = 4$ cm, $PB = 9$ cm y que $PD$ mide el cuádruple de $CP$.

Considerando que, cuando dos cuerdas de una circunferencia se intersecan, se cumple que $AP \cdot PB = CP \cdot PD$, ¿cuál es la medida de $PD$?', '[{"id":"A","content":"$6$ cm"},{"id":"B","content":"$12$ cm"},{"id":"C","content":"$15$ cm"},{"id":"D","content":"$24$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Sea $CP = x$; entonces $PD = 4x$ y $x \cdot 4x = 4 \cdot 9 = 36$, de donde $x^2 = 9$ y $x = 3$.
Luego $PD = 4 \cdot 3 = 12$ cm.
A supone que $P$ es punto medio de $CD$ ($CP = PD = 6$), C entrega la cuerda completa $CD = 15$ cm y D resuelve $x^2 = 36$ olvidando dividir por $4$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'be338870-9d49-5145-884d-74b68a13de0b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'circunferencia'
  on conflict do nothing;
-- m2-geometria-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('967227af-0fa2-58df-815b-a38f796d8dde', 'm2-geometria-007', 'Desde un punto $P$ exterior a una circunferencia de centro $O$ se traza el segmento $PT$, tangente a la circunferencia en $T$, que mide $12$ cm. Además, desde $P$ se traza una recta que pasa por $O$ y corta a la circunferencia en los puntos $A$ y $B$, con $A$ entre $P$ y $O$, de modo que $PA = 8$ cm.

¿Cuánto mide el radio de la circunferencia?', '[{"id":"A","content":"$5$ cm"},{"id":"B","content":"$9$ cm"},{"id":"C","content":"$10$ cm"},{"id":"D","content":"$13$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Por la relación entre tangente y secante, $PT^2 = PA \cdot PB$, es decir, $144 = 8 \cdot PB$ y $PB = 18$ cm.
Como la secante pasa por el centro, $AB = PB - PA = 10$ cm es un diámetro, y el radio mide $5$ cm.
(También: el triángulo $PTO$ es rectángulo en $T$, así que $(8 + r)^2 = 12^2 + r^2$, de donde $r = 5$.)
B es la mitad de $PB$, C es el diámetro y D es la distancia $PO$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '967227af-0fa2-58df-815b-a38f796d8dde', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'circunferencia'
  on conflict do nothing;
-- m2-geometria-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('c0993d05-a2bd-5630-a020-a1a22a899ae9', 'm2-geometria-008', 'En una circunferencia de centro $O$ se ubican los puntos $A$, $B$ y $C$, de modo que $C$ está sobre el arco mayor $AB$.

Se puede determinar la medida del ángulo inscrito $\angle ACB$, si se sabe que:

(1) El ángulo del centro $\angle AOB$ mide $100^\circ$.
(2) El ángulo $\angle OAB$ mide $40^\circ$.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'El ángulo inscrito $\angle ACB$ subtiende el arco menor $AB$, así que mide la mitad del ángulo del centro $\angle AOB$.
Con (1): $\angle ACB = \frac{100^\circ}{2} = 50^\circ$. Basta.
Con (2): el triángulo $AOB$ es isósceles ($OA = OB$ son radios), así que $\angle OBA = 40^\circ$ y $\angle AOB = 180^\circ - 80^\circ = 100^\circ$; de nuevo $\angle ACB = 50^\circ$. Basta.
Cada afirmación por sí sola es suficiente.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'c0993d05-a2bd-5630-a020-a1a22a899ae9', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'circunferencia'
  on conflict do nothing;
-- m2-geometria-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a6cda31d-6578-5aa0-b975-44fbf30ac47e', 'm2-geometria-009', 'Para un cumpleaños, Camila infla un globo de forma esférica. Primero lo infla hasta que su radio mide $6$ cm y luego sigue inflándolo hasta que su radio mide $12$ cm.

Si el área de la superficie de una esfera de radio $r$ es $4\pi r^2$, ¿en cuánto aumentó el área de la superficie del globo entre ambos momentos?', '[{"id":"A","content":"$144\\pi$ $\\text{cm}^2$"},{"id":"B","content":"$432\\pi$ $\\text{cm}^2$"},{"id":"C","content":"$576\\pi$ $\\text{cm}^2$"},{"id":"D","content":"$2016\\pi$ $\\text{cm}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'Superficie inicial: $4\pi \cdot 6^2 = 144\pi$ cm²; superficie final: $4\pi \cdot 12^2 = 576\pi$ cm².
El aumento es $576\pi - 144\pi = 432\pi$ cm².
A supone que al duplicar el radio la superficie se duplica, C es la superficie final (no el aumento) y D es la diferencia de volúmenes, $\frac{4}{3}\pi(12^3 - 6^3)$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a6cda31d-6578-5aa0-b975-44fbf30ac47e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'esfera'
  on conflict do nothing;
-- m2-geometria-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('387dea0f-7cf8-5fed-9fe4-eb116d0cc0a0', 'm2-geometria-010', 'Un tubo cilíndrico cerrado contiene exactamente $3$ pelotas de tenis, consideradas esferas de radio $r$ cm, apiladas una sobre otra. Cada pelota toca la superficie lateral del tubo, la pelota inferior toca la base, la superior toca la tapa y las pelotas consecutivas se tocan entre sí.

Si el volumen de una esfera de radio $r$ es $\frac{4}{3}\pi r^3$, ¿cuál es el volumen, en $\text{cm}^3$, del espacio del tubo que no ocupan las pelotas?', '[{"id":"A","content":"$2\\pi r^3$"},{"id":"B","content":"$4\\pi r^3$"},{"id":"C","content":"$6\\pi r^3$"},{"id":"D","content":"$20\\pi r^3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'El tubo tiene radio basal $r$ y altura $6r$ (tres diámetros), así que su volumen es $\pi r^2 \cdot 6r = 6\pi r^3$.
Las tres pelotas ocupan $3 \cdot \frac{4}{3}\pi r^3 = 4\pi r^3$.
El espacio libre es $6\pi r^3 - 4\pi r^3 = 2\pi r^3$.
B es el volumen de las pelotas, C el del tubo completo y D resulta de usar el diámetro $2r$ como radio del tubo: $\pi(2r)^2 \cdot 6r - 4\pi r^3 = 20\pi r^3$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '387dea0f-7cf8-5fed-9fe4-eb116d0cc0a0', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'esfera'
  on conflict do nothing;
-- m2-geometria-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('dc8a3b40-66a1-59bb-8419-64db3613cf37', 'm2-geometria-011', 'En una aplicación de mapas se usa un sistema de coordenadas en el que cada unidad equivale a $1$ km. Un ciclista avanza en línea recta desde el punto $(-2, 1)$ hasta el punto $(4, 4)$.

¿Cuál de las siguientes ecuaciones corresponde a la recta que contiene la trayectoria del ciclista?', '[{"id":"A","content":"$y = 2x + 5$"},{"id":"B","content":"$y = -\\frac{1}{2}x$"},{"id":"C","content":"$y = \\frac{1}{2}x - 2$"},{"id":"D","content":"$y = \\frac{1}{2}x + 2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'La pendiente es $m = \frac{4 - 1}{4 - (-2)} = \frac{3}{6} = \frac{1}{2}$.
Reemplazando $(4, 4)$: $4 = \frac{1}{2} \cdot 4 + n$, así que $n = 2$ y la recta es $y = \frac{1}{2}x + 2$ (también pasa por $(-2, 1)$).
A invierte el cociente de la pendiente ($\frac{\Delta x}{\Delta y}$), B cambia el signo de la pendiente (solo pasa por $(-2, 1)$) y C tiene el coeficiente de posición con el signo equivocado.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'dc8a3b40-66a1-59bb-8419-64db3613cf37', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'rectas-en-el-plano'
  on conflict do nothing;
-- m2-geometria-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8cc02d05-e00a-52b3-8e8c-3b71e33dcc76', 'm2-geometria-012', 'Considera las rectas $L_1: 3x - 2y + 6 = 0$ y $L_2: kx + 6y - 1 = 0$, con $k$ un número real.

¿Cuál de las siguientes afirmaciones es verdadera?', '[{"id":"A","content":"Si $k = 9$, entonces $L_1$ y $L_2$ son paralelas."},{"id":"B","content":"Si $k = -4$, entonces $L_1$ y $L_2$ son perpendiculares."},{"id":"C","content":"Si $k = 4$, entonces $L_1$ y $L_2$ son perpendiculares."},{"id":"D","content":"Si $k = -9$, entonces $L_1$ y $L_2$ se intersecan en un único punto."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'La pendiente de $L_1$ es $\frac{3}{2}$ y la de $L_2$ es $-\frac{k}{6}$.
Con $k = 4$: $\frac{3}{2} \cdot \left(-\frac{4}{6}\right) = -1$, así que son perpendiculares. C es verdadera.
A es falsa: con $k = 9$ la pendiente de $L_2$ es $-\frac{3}{2}$ (signo opuesto, no paralelas). B es falsa: con $k = -4$ el producto de pendientes es $\frac{3}{2} \cdot \frac{2}{3} = 1$.
D es falsa: con $k = -9$ ambas pendientes son $\frac{3}{2}$ y $L_2$ equivale a $3x - 2y + \frac{1}{3} = 0$, paralela y distinta de $L_1$, por lo que no se intersecan.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8cc02d05-e00a-52b3-8e8c-3b71e33dcc76', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'rectas-en-el-plano'
  on conflict do nothing;
-- m2-geometria-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f7270d4b-67f1-593b-8d84-c41b388a9dfe', 'm2-geometria-013', 'Considera la recta $L$ de ecuación $y = mx + n$, con $m$ y $n$ números reales.

Se puede determinar el valor de $m$, si se sabe que:

(1) $L$ es perpendicular a la recta de ecuación $2x + 6y = 5$.
(2) $L$ interseca al eje $Y$ en el punto $(0, -1)$.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Con (1): la recta $2x + 6y = 5$ tiene pendiente $-\frac{2}{6} = -\frac{1}{3}$; una perpendicular cumple $m \cdot \left(-\frac{1}{3}\right) = -1$, así que $m = 3$. Basta.
Con (2): solo se sabe que $n = -1$; las rectas $y = x - 1$ e $y = 5x - 1$, por ejemplo, cumplen la condición con pendientes distintas. No basta.
Por lo tanto, (1) por sí sola es suficiente.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f7270d4b-67f1-593b-8d84-c41b388a9dfe', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'rectas-en-el-plano'
  on conflict do nothing;
-- m2-geometria-101
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d5114f3e-7f8b-5669-a2f0-1ae1cc32afa4', 'm2-geometria-101', 'Un club de rayuela de Puerto Montt quiere techar una cancha rectangular. Para cercarla se necesitan exactamente $34$ m de malla y, al medir de una esquina a la esquina opuesta, se obtiene una diagonal de $13$ m.

¿Cuál es el área de la cancha?', '[{"id":"A","content":"$30\\ \\text{m}^2$"},{"id":"B","content":"$60\\ \\text{m}^2$"},{"id":"C","content":"$120\\ \\text{m}^2$"},{"id":"D","content":"$289\\ \\text{m}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Si los lados miden $a$ y $b$, entonces $a + b = 17$ y, por Pitágoras, $a^2 + b^2 = 169$.
Como $(a + b)^2 = a^2 + 2ab + b^2$, se tiene $289 = 169 + 2ab$, de donde $2ab = 120$ y el área es $ab = 60\ \text{m}^2$ (los lados son $5$ m y $12$ m).
A divide dos veces por $2$, C entrega $2ab$ sin despejar el área y D calcula $(a + b)^2$ como si fuera el área.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd5114f3e-7f8b-5669-a2f0-1ae1cc32afa4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-102
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1d177f7b-0d56-59a5-9a64-14de45d2d99d', 'm2-geometria-102', 'Un triángulo isósceles tiene perímetro $36$ cm, y la razón entre la medida de cada lado igual y la medida de la base es $5 : 8$. Para calcular su área, Benjamín realizó el siguiente procedimiento, en el que cometió un error:

Paso 1: escribe los lados como $5k$, $5k$ y $8k$; de $18k = 36$ obtiene $k = 2$, así que los lados miden $10$ cm, $10$ cm y $16$ cm.
Paso 2: traza la altura hacia la base, que la divide en dos segmentos de $8$ cm cada uno.
Paso 3: aplica el teorema de Pitágoras y obtiene $h^2 = 10^2 + 8^2$, es decir, $h = \sqrt{164}$ cm.
Paso 4: calcula el área como $\frac{16 \cdot \sqrt{164}}{2} = 8\sqrt{164}\ \text{cm}^2$.

¿En cuál de los pasos se cometió el error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los Pasos 1 y 2 son correctos: $5k + 5k + 8k = 18k = 36$ da $k = 2$, y en un triángulo isósceles la altura hacia la base la divide en mitades de $8$ cm.
En el Paso 3 el lado de $10$ cm es la hipotenusa del triángulo rectángulo, así que $h^2 = 10^2 - 8^2 = 36$ y $h = 6$ cm; Benjamín sumó los cuadrados en vez de restarlos.
El Paso 4 usa bien la fórmula del área, pero arrastra el valor erróneo: el área correcta es $\frac{16 \cdot 6}{2} = 48\ \text{cm}^2$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1d177f7b-0d56-59a5-9a64-14de45d2d99d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-103
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('05d0a66a-3d82-5b81-b004-3902063d0912', 'm2-geometria-103', 'Una familia de Chillán compró un terreno con forma de triángulo cuyos lados miden $13$ m, $14$ m y $15$ m. Para calcular su área, se traza la altura correspondiente al lado de $14$ m.

¿Cuál es el área del terreno?', '[{"id":"A","content":"$42\\ \\text{m}^2$"},{"id":"B","content":"$84\\ \\text{m}^2$"},{"id":"C","content":"$168\\ \\text{m}^2$"},{"id":"D","content":"$210\\ \\text{m}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'La altura $h$ divide el lado de $14$ m en segmentos $x$ y $14 - x$. Por Pitágoras en ambos triángulos: $13^2 - x^2 = h^2 = 15^2 - (14 - x)^2$.
Desarrollando, $169 - x^2 = 29 + 28x - x^2$, así que $x = 5$ y $h = \sqrt{169 - 25} = 12$ m.
El área es $\frac{14 \cdot 12}{2} = 84\ \text{m}^2$.
A divide dos veces por $2$, C olvida dividir por $2$ y D multiplica dos lados ($14 \cdot 15$) como si formaran un ángulo recto.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '05d0a66a-3d82-5b81-b004-3902063d0912', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-104
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cf19a5d8-bf28-58d7-a3bb-9b4bf1ad0840', 'm2-geometria-104', 'En una tienda de marcos de Valparaíso, una lámina rectangular de $a$ cm de largo y $b$ cm de ancho se rodea con un paspartú de ancho uniforme $x$ cm, de modo que el conjunto formado por la lámina y el paspartú también es un rectángulo.

¿Cuál de las siguientes expresiones representa el área, en $\text{cm}^2$, solo del paspartú?', '[{"id":"A","content":"$2x(a + b) + 4x^2$"},{"id":"B","content":"$(a + 2x)(b + 2x)$"},{"id":"C","content":"$2x(a + b)$"},{"id":"D","content":"$x(a + b) + x^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El rectángulo completo mide $(a + 2x)$ por $(b + 2x)$, porque el paspartú se agrega a ambos lados de cada dimensión.
El área del paspartú es $(a + 2x)(b + 2x) - ab = 2ax + 2bx + 4x^2 = 2x(a + b) + 4x^2$.
B es el área total, sin restar la lámina; C considera solo las cuatro franjas laterales y olvida los cuatro cuadrados de las esquinas; D agrega el ancho $x$ una sola vez en cada dimensión.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cf19a5d8-bf28-58d7-a3bb-9b4bf1ad0840', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-105
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('51f230a0-7f13-5d1c-bbd9-502d239f5914', 'm2-geometria-105', 'Tomás arma un volantín con forma de rombo usando dos varillas de colihue que se cruzan perpendicularmente en sus puntos medios: una de $12$ cm y otra de $16$ cm. Luego rodea todo el borde del volantín con hilo.

¿Cuántos centímetros de hilo necesita como mínimo?', '[{"id":"A","content":"$14$ cm"},{"id":"B","content":"$28$ cm"},{"id":"C","content":"$40$ cm"},{"id":"D","content":"$96$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Las diagonales de un rombo se cortan perpendicularmente en sus puntos medios, así que cada lado es la hipotenusa de un triángulo rectángulo de catetos $6$ cm y $8$ cm.
El lado mide $\sqrt{36 + 64} = 10$ cm y el perímetro es $4 \cdot 10 = 40$ cm.
A suma las semidiagonales como si fueran el lado, B suma las diagonales y D calcula el área del rombo ($\frac{12 \cdot 16}{2}$) en lugar del perímetro.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '51f230a0-7f13-5d1c-bbd9-502d239f5914', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-106
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('42e81235-30b4-52d7-93a5-f41ea15e1c5c', 'm2-geometria-106', 'En un videojuego, un personaje está en el punto $P(3, -2)$ del plano cartesiano. Se le aplican, en este orden, las siguientes transformaciones:
1) una reflexión respecto de la recta $y = x$;
2) una traslación según el vector $(-4, 1)$;
3) una rotación de $180^\circ$ con centro en el origen.

¿Cuáles son las coordenadas finales del personaje?', '[{"id":"A","content":"$(6, -4)$"},{"id":"B","content":"$(-6, 4)$"},{"id":"C","content":"$(-4, -6)$"},{"id":"D","content":"$(1, -3)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La reflexión respecto de $y = x$ intercambia las coordenadas: $(3, -2) \to (-2, 3)$.
La traslación da $(-2 - 4,\ 3 + 1) = (-6, 4)$, y la rotación de $180^\circ$ con centro en el origen cambia ambos signos: $(6, -4)$.
B omite la rotación, C aplica una rotación de $90^\circ$ antihoraria en lugar de $180^\circ$ y D refleja respecto del eje $X$ en vez de la recta $y = x$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '42e81235-30b4-52d7-93a5-f41ea15e1c5c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-107
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('aea94824-0e5c-5ec3-bfd0-4f0d1b1cf9fe', 'm2-geometria-107', 'Considera el punto $P(a, b)$, con $a$ y $b$ números reales tales que $a < 0 < b$. Primero se refleja $P$ con respecto al eje $Y$; después, el punto reflejado se desplaza con el vector $(2a, -2b)$, y así se obtiene el punto $P''$.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"$P''$ está en el segundo cuadrante."},{"id":"B","content":"La distancia entre $P$ y $P''$ es $2a$."},{"id":"C","content":"$P''$ es la imagen de $P$ mediante una rotación de $180^\\circ$ con centro en el origen."},{"id":"D","content":"$P''$ es la imagen de $P$ mediante una reflexión respecto del eje $X$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'La reflexión respecto del eje $Y$ lleva $(a, b)$ a $(-a, b)$, y la traslación da $P'' = (-a + 2a,\ b - 2b) = (a, -b)$.
El punto $(a, -b)$ es justamente la reflexión de $(a, b)$ respecto del eje $X$, por lo que D es verdadera.
A es falsa: como $a < 0$ y $-b < 0$, $P''$ está en el tercer cuadrante. B es falsa: la distancia es $2b$, y $2a$ es negativo. C es falsa: la rotación de $180^\circ$ daría $(-a, -b)$, distinto de $P''$ porque $a \neq 0$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'aea94824-0e5c-5ec3-bfd0-4f0d1b1cf9fe', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-108
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('da63c5fb-1b68-5265-9c52-e4ae8ac9ad14', 'm2-geometria-108', 'Un dron de reparto despega desde el punto $(1, 2)$ de un plano cartesiano. Primero se desplaza según el vector $\vec{u} = (3, -1)$ y, a continuación, según el vector $\vec{v} = (-5, 4)$.

¿Cuál de los siguientes vectores representa la traslación que lleva al dron directamente desde el punto de despegue hasta el punto de llegada?', '[{"id":"A","content":"$(-1, 5)$"},{"id":"B","content":"$(2, -3)$"},{"id":"C","content":"$(8, -5)$"},{"id":"D","content":"$(-2, 3)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Dos traslaciones sucesivas equivalen a una sola traslación según la suma de los vectores: $\vec{u} + \vec{v} = (3 - 5,\ -1 + 4) = (-2, 3)$.
En efecto, el dron llega a $(1, 2) + (-2, 3) = (-1, 5)$.
A es el punto de llegada, no el vector de traslación; B es el vector opuesto, que va de la llegada al despegue; C corresponde a $\vec{u} - \vec{v}$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'da63c5fb-1b68-5265-9c52-e4ae8ac9ad14', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-109
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('783fa139-e3aa-5224-9576-c041ec3e7cc3', 'm2-geometria-109', 'En la pantalla de control de una grúa del puerto de San Antonio, el brazo de la grúa gira en torno al punto $C(1, 2)$. El extremo del brazo está en el punto $A(4, 1)$ y la grúa gira $90^\circ$ en sentido antihorario con centro en $C$.

¿Cuáles son las coordenadas de la nueva posición del extremo del brazo?', '[{"id":"A","content":"$(-1, 4)$"},{"id":"B","content":"$(0, -1)$"},{"id":"C","content":"$(0, 6)$"},{"id":"D","content":"$(2, 5)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Se trabaja con el vector $\overrightarrow{CA} = (4 - 1,\ 1 - 2) = (3, -1)$. Una rotación de $90^\circ$ antihoraria transforma $(x, y)$ en $(-y, x)$, así que $(3, -1) \to (1, 3)$.
La nueva posición es $C + (1, 3) = (2, 5)$.
A rota $A$ en torno al origen, B gira en sentido horario y C rota $A$ en torno al origen y luego suma las coordenadas de $C$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '783fa139-e3aa-5224-9576-c041ec3e7cc3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-110
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('854fec56-e6ae-5120-b697-54e78b1a2290', 'm2-geometria-110', 'En el triángulo $ABC$, el punto $D$ está sobre el lado $AB$ y el punto $E$ está sobre el lado $AC$, de modo que el segmento $DE$ es paralelo a $BC$. Se sabe que $AD = x$ cm, $DB = (x + 2)$ cm, $AE = 6$ cm y $EC = 9$ cm.

¿Cuál es la medida del lado $AB$?', '[{"id":"A","content":"$4$ cm"},{"id":"B","content":"$\\frac{14}{3}$ cm"},{"id":"C","content":"$6$ cm"},{"id":"D","content":"$10$ cm"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Como $DE \parallel BC$, por el teorema de Thales $\frac{AD}{DB} = \frac{AE}{EC}$, es decir, $\frac{x}{x + 2} = \frac{6}{9}$.
Entonces $9x = 6x + 12$, de donde $x = 4$, y $AB = x + (x + 2) = 10$ cm.
A entrega solo $AD$, C entrega solo $DB$ y B plantea $\frac{AD}{DB} = \frac{AE}{AC}$, mezclando un segmento parcial con el lado completo.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '854fec56-e6ae-5120-b697-54e78b1a2290', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-111
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a0b8933c-347c-5430-a0f9-5c090738fcf2', 'm2-geometria-111', 'Un estudio de arquitectura construye una maqueta de un edificio a escala $1 : n$, es decir, cada longitud de la maqueta es $n$ veces menor que la longitud real correspondiente. Para pintar todo el exterior de la maqueta se usan $q$ mL de pintura, y el estanque de agua de la maqueta tiene una capacidad de $w$ mL.

Si el edificio real es semejante a la maqueta y se pinta con el mismo rendimiento, ¿cuáles expresiones representan, respectivamente, la cantidad de pintura, en mL, necesaria para el exterior del edificio real y la capacidad, en mL, de su estanque real?', '[{"id":"A","content":"$qn$ y $wn^2$"},{"id":"B","content":"$qn^2$ y $wn^2$"},{"id":"C","content":"$qn^2$ y $wn^3$"},{"id":"D","content":"$qn^3$ y $wn^3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Si la razón de semejanza entre longitudes es $n$, las áreas se multiplican por $n^2$ y los volúmenes por $n^3$.
La pintura depende del área a cubrir, así que se necesitan $qn^2$ mL; la capacidad del estanque es un volumen, así que es $wn^3$ mL.
A usa la razón lineal para el área y la cuadrática para el volumen, B trata la capacidad como un área y D trata la superficie pintada como un volumen.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a0b8933c-347c-5430-a0f9-5c090738fcf2', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-112
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('cf6f699d-7437-57f3-9e77-1ccfc7cc997b', 'm2-geometria-112', 'Un terreno tiene forma de triángulo rectángulo, con catetos de $6$ m y $8$ m. Desde el vértice del ángulo recto se construye un sendero recto y perpendicular al lado más largo del terreno, que lo divide en dos terrenos triangulares.

¿Cuál es el área del menor de esos dos terrenos?', '[{"id":"A","content":"$8{,}64\\ \\text{m}^2$"},{"id":"B","content":"$10{,}8\\ \\text{m}^2$"},{"id":"C","content":"$12\\ \\text{m}^2$"},{"id":"D","content":"$14{,}4\\ \\text{m}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'La hipotenusa mide $\sqrt{36 + 64} = 10$ m y el área total es $\frac{6 \cdot 8}{2} = 24\ \text{m}^2$.
El sendero (la altura hacia la hipotenusa) forma dos triángulos semejantes al original; el menor tiene como hipotenusa el cateto de $6$ m, así que la razón de semejanza es $\frac{6}{10} = 0{,}6$.
Su área es $0{,}6^2 \cdot 24 = 8{,}64\ \text{m}^2$ (con proyección $3{,}6$ m y altura $4{,}8$ m: $\frac{3{,}6 \cdot 4{,}8}{2} = 8{,}64$).
D multiplica el área por la razón lineal $0{,}6$ sin elevarla al cuadrado, C supone que el sendero divide el terreno en mitades y B usa el cateto de $6$ m como altura del triángulo menor.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'cf6f699d-7437-57f3-9e77-1ccfc7cc997b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-113
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7b42afd0-2e2a-587e-9e46-d74730625dec', 'm2-geometria-113', 'En un taller de velas de Pucón se derrite completamente un bloque de cera con forma de prisma recto de base cuadrada, de $8$ cm de lado y $10$ cm de altura. Con esa cera se fabrican velas cilíndricas de $2$ cm de radio y $5$ cm de altura.

Si no se pierde cera en el proceso y se considera $\pi \approx 3$, ¿cuántas velas completas se pueden fabricar como máximo?', '[{"id":"A","content":"$2$"},{"id":"B","content":"$10$"},{"id":"C","content":"$11$"},{"id":"D","content":"$21$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'El volumen del prisma es $8 \cdot 8 \cdot 10 = 640\ \text{cm}^3$ y el de cada vela es $\pi r^2 h \approx 3 \cdot 2^2 \cdot 5 = 60\ \text{cm}^3$.
Como $\frac{640}{60} \approx 10{,}7$, alcanzan para $10$ velas completas.
A usa el diámetro como radio, C redondea hacia arriba aunque la undécima vela quedaría incompleta y D usa $\pi r h$ en lugar de $\pi r^2 h$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7b42afd0-2e2a-587e-9e46-d74730625dec', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m2-geometria-114
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('21cbb16a-69f5-5f09-9b19-c60f5975051e', 'm2-geometria-114', 'Un envase cilíndrico tiene radio basal $r$ cm y altura $h$ cm. Se diseña un nuevo envase cilíndrico cuyo radio basal es el doble del original y cuya altura es la mitad de la original.

¿Cuál de las siguientes afirmaciones es verdadera al comparar el nuevo envase con el original?', '[{"id":"A","content":"El volumen se mantiene y el área lateral se duplica."},{"id":"B","content":"El volumen se duplica y el área total se duplica."},{"id":"C","content":"El volumen se duplica y el área lateral se mantiene."},{"id":"D","content":"El volumen se cuadruplica y el área lateral se mantiene."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'El nuevo volumen es $\pi (2r)^2 \cdot \frac{h}{2} = 2\pi r^2 h$, el doble del original.
La nueva área lateral es $2\pi (2r) \cdot \frac{h}{2} = 2\pi r h$, igual a la original.
El área total pasa de $2\pi rh + 2\pi r^2$ a $2\pi rh + 8\pi r^2$, que en general no es el doble, por lo que B es falsa.
A se equivoca en ambas magnitudes y D eleva al cuadrado el factor del radio sin considerar que la altura se reduce a la mitad.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '21cbb16a-69f5-5f09-9b19-c60f5975051e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m2-geometria-115
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1c1e3f23-7fe2-5077-b6be-7d7995be0146', 'm2-geometria-115', 'En una aplicación para diseñar estampados de poleras, Florencia ubica un adorno en el punto $P(4, 3)$ del plano cartesiano. Primero lo refleja con respecto a la recta de ecuación $y = -1$ y, después, aplica al punto obtenido una rotación de $180^\circ$ con centro en el origen.

¿Cuáles son las coordenadas de la posición final del adorno?', '[{"id":"A","content":"$(-4, -5)$"},{"id":"B","content":"$(-4, 3)$"},{"id":"C","content":"$(-4, 5)$"},{"id":"D","content":"$(5, 4)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'La recta $y = -1$ es horizontal: la reflexión mantiene la abscisa y la ordenada cambia a $2 \cdot (-1) - 3 = -5$, así que se obtiene $(4, -5)$.
La rotación de $180^\circ$ con centro en el origen cambia el signo de ambas coordenadas: $(4, -5) \to (-4, 5)$.
A solo cambia el signo de la abscisa en la rotación, B refleja con respecto al eje $X$ en lugar de la recta $y = -1$ y D aplica una rotación de $90^\circ$ antihoraria en lugar de $180^\circ$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1c1e3f23-7fe2-5077-b6be-7d7995be0146', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-116
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('eb9d41ac-83cd-537f-a775-0d7466d8c3cb', 'm2-geometria-116', 'Considera un punto cualquiera $P(a, b)$ del plano cartesiano. Primero se gira $P$ en $90^\circ$ en torno al origen, en sentido contrario al de las manecillas del reloj, y luego el punto obtenido se refleja con respecto al eje $X$.

¿Cuál de las siguientes transformaciones, aplicada directamente a $P$, produce siempre el mismo punto final que esa composición?', '[{"id":"A","content":"Un giro de $90^\\circ$ en torno al origen, en el sentido de las manecillas del reloj."},{"id":"B","content":"Un giro de $180^\\circ$ en torno al origen."},{"id":"C","content":"Una reflexión con respecto a la recta $y = x$."},{"id":"D","content":"Una reflexión con respecto a la recta $y = -x$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'El giro de $90^\circ$ antihorario en torno al origen transforma $(a, b)$ en $(-b, a)$, y la reflexión con respecto al eje $X$ transforma $(-b, a)$ en $(-b, -a)$.
La regla $(a, b) \to (-b, -a)$ es la reflexión con respecto a la recta $y = -x$.
A da $(b, -a)$, B da $(-a, -b)$ y C da $(b, a)$; cada una coincide con la composición solo para algunos puntos particulares, no para todos.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'eb9d41ac-83cd-537f-a775-0d7466d8c3cb', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-117
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ccf9820d-0ca7-5836-921f-0700f22c2a23', 'm2-geometria-117', 'Al aplicar una rotación de $90^\circ$ en sentido antihorario con centro en cierto punto $C$, el punto $A(5, 1)$ se transforma en el punto $A''(3, 5)$.

¿Cuáles son las coordenadas del punto $C$?', '[{"id":"A","content":"$(0, 1)$"},{"id":"B","content":"$(2, 2)$"},{"id":"C","content":"$(4, 3)$"},{"id":"D","content":"$(6, 4)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Sea $C(h, k)$. El vector $\overrightarrow{CA} = (5 - h,\ 1 - k)$ rotado en $90^\circ$ antihorario es $(k - 1,\ 5 - h)$, y debe cumplirse $A'' = C + (k - 1,\ 5 - h)$.
Así, $h + k - 1 = 3$ y $k + 5 - h = 5$, de donde $h = k = 2$: el centro es $C(2, 2)$.
Comprobación: $\overrightarrow{CA} = (3, -1)$ rota a $(1, 3)$ y $C + (1, 3) = (3, 5)$.
Las cuatro alternativas están a igual distancia de $A$ y de $A''$, pero solo $(2, 2)$ forma un ángulo recto antihorario: C es el punto medio de $AA''$ (centro de una rotación de $180^\circ$), D corresponde a una rotación horaria y A da un ángulo distinto de $90^\circ$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ccf9820d-0ca7-5836-921f-0700f22c2a23', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-118
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5cf450cb-99f4-5ca7-988a-e0672a3fadea', 'm2-geometria-118', 'En la carta náutica de una lancha de la Armada, cada unidad del plano cartesiano representa $1$ km. La lancha parte desde el punto $(-4, 2)$ y, cada hora, su posición se traslada según el vector $\vec{v} = (3, -1)$.

¿Cuál de las siguientes expresiones representa la posición de la lancha después de $t$ horas de navegación?', '[{"id":"A","content":"$(3t - 4,\\ 2 - t)$"},{"id":"B","content":"$(3t + 4,\\ -t - 2)$"},{"id":"C","content":"$(3 - 4t,\\ 2t - 1)$"},{"id":"D","content":"$(-t,\\ t)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Después de $t$ horas, el punto inicial se traslada según $t \cdot \vec{v} = (3t, -t)$, así que la posición es $(-4 + 3t,\ 2 - t) = (3t - 4,\ 2 - t)$.
Por ejemplo, con $t = 1$ se obtiene $(-1, 1)$, que es $(-4, 2) + (3, -1)$.
B resta el punto inicial en lugar de sumarlo, C intercambia los papeles del punto inicial y del vector, y D suma el punto inicial con el vector y multiplica el resultado por $t$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5cf450cb-99f4-5ca7-988a-e0672a3fadea', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'transformaciones-isometricas'
  on conflict do nothing;
-- m2-geometria-119
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('daae1289-a779-5f99-93a7-7a6030d05430', 'm2-geometria-119', 'Una junta de vecinos de Rancagua cercará un terreno con forma de trapecio isósceles cuyas bases miden $22$ m y $10$ m. Para cercar todo su contorno se necesitan exactamente $52$ m de malla.

¿Cuál es el área del terreno?', '[{"id":"A","content":"$80\\ \\text{m}^2$"},{"id":"B","content":"$96\\ \\text{m}^2$"},{"id":"C","content":"$128\\ \\text{m}^2$"},{"id":"D","content":"$160\\ \\text{m}^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los lados no paralelos suman $52 - 22 - 10 = 20$ m, así que cada uno mide $10$ m.
Al trazar las alturas desde los extremos de la base menor, a cada lado queda un segmento de $\frac{22 - 10}{2} = 6$ m, y por Pitágoras la altura es $\sqrt{10^2 - 6^2} = 8$ m.
El área es $\frac{(22 + 10) \cdot 8}{2} = 128\ \text{m}^2$.
A calcula solo el rectángulo central $10 \cdot 8$, B usa $6$ m como altura y D usa el lado no paralelo de $10$ m como altura.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'daae1289-a779-5f99-93a7-7a6030d05430', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-120
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ff5d2a3e-d131-5e5f-85a6-71d400ac9170', 'm2-geometria-120', 'Un carpintero de Valdivia arma una escuadra con forma de triángulo rectángulo cuya hipotenusa mide $13$ cm y cuyos catetos, de medidas $a$ cm y $b$ cm, suman $17$ cm. Para calcular el área de la escuadra sin determinar cada cateto, realiza el siguiente procedimiento, en el que comete un error:

Paso 1: plantea $a + b = 17$ y, por el teorema de Pitágoras, $a^2 + b^2 = 169$.
Paso 2: eleva al cuadrado la primera igualdad y obtiene $a^2 + 2ab + b^2 = 289$.
Paso 3: reemplaza $a^2 + b^2$ por $169$, obtiene $169 + 2ab = 289$ y concluye que $ab = 120$.
Paso 4: calcula el área como $\frac{ab}{2}$ y obtiene $60\ \text{cm}^2$.

¿En cuál de los pasos se cometió el error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los pasos 1 y 2 son correctos: $(a + b)^2 = a^2 + 2ab + b^2 = 17^2 = 289$.
En el Paso 3, de $169 + 2ab = 289$ se obtiene $2ab = 120$, es decir, $ab = 60$, no $120$: ahí está el error.
Con el valor correcto, el área es $\frac{60}{2} = 30\ \text{cm}^2$ (los catetos miden $5$ cm y $12$ cm). El Paso 4 usa bien la fórmula, pero arrastra el valor erróneo del paso anterior.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ff5d2a3e-d131-5e5f-85a6-71d400ac9170', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-121
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('0f6b0eeb-50d6-5898-ab54-ed7bb115b2f1', 'm2-geometria-121', 'Una empresa de señalética fabrica letreros con forma de triángulo equilátero. Para cotizar el material, necesita una expresión del área de cada letrero en función de su altura, que mide $h$ cm.

¿Cuál de las siguientes expresiones representa el área de un letrero, en $\text{cm}^2$?', '[{"id":"A","content":"$\\frac{\\sqrt{3}}{4}h^2$"},{"id":"B","content":"$\\frac{\\sqrt{3}}{3}h^2$"},{"id":"C","content":"$\\frac{2\\sqrt{3}}{3}h^2$"},{"id":"D","content":"$\\frac{4}{3}h^2$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Si el lado mide $\ell$, la altura de un triángulo equilátero es $h = \frac{\sqrt{3}}{2}\ell$, de donde $\ell = \frac{2h}{\sqrt{3}} = \frac{2\sqrt{3}}{3}h$.
El área es $\frac{\ell \cdot h}{2} = \frac{1}{2} \cdot \frac{2\sqrt{3}}{3}h \cdot h = \frac{\sqrt{3}}{3}h^2$.
A aplica la fórmula $\frac{\sqrt{3}}{4}\ell^2$ usando la altura como si fuera el lado, C multiplica lado por altura sin dividir por $2$ y D calcula $\ell^2$, el área de un cuadrado de lado $\ell$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '0f6b0eeb-50d6-5898-ab54-ed7bb115b2f1', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'figuras-geometricas'
  on conflict do nothing;
-- m2-geometria-122
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('22643482-ac26-56f6-90f9-a5f87937d04c', 'm2-geometria-122', 'Una inmobiliaria de Temuco ofrece dos terrenos rectangulares semejantes. El terreno menor mide $12$ m de largo y $8$ m de ancho, y el área del terreno mayor es $384\ \text{m}^2$.

¿Cuál es el largo del terreno mayor?', '[{"id":"A","content":"$24$ m"},{"id":"B","content":"$32$ m"},{"id":"C","content":"$36$ m"},{"id":"D","content":"$48$ m"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El área del terreno menor es $12 \cdot 8 = 96\ \text{m}^2$, y la razón entre las áreas es $\frac{384}{96} = 4$.
Como la razón de las áreas es el cuadrado de la razón de semejanza, esta es $\sqrt{4} = 2$, y el largo mayor mide $2 \cdot 12 = 24$ m (con ancho $16$ m: $24 \cdot 16 = 384$).
D multiplica el largo por la razón de áreas, C multiplica por $3$ al tomar el aumento $\frac{384 - 96}{96}$ como razón y B divide $384$ por $12$, suponiendo que el ancho del terreno mayor sigue midiendo $12$ m.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '22643482-ac26-56f6-90f9-a5f87937d04c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-123
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e30e33c9-8fa3-5d85-bcb0-9611f5f3b997', 'm2-geometria-123', 'Un parque tiene forma de triángulo $ABC$ y su área es $S\ \text{m}^2$. Se construye un sendero recto $DE$, paralelo al lado $BC$, con $D$ en el lado $AB$ y $E$ en el lado $AC$, de modo que $AD = k \cdot AB$, con $0 < k < 1$. El sendero divide el parque en el triángulo $ADE$ y el trapecio $DBCE$.

¿Cuál de las siguientes expresiones representa el área del trapecio $DBCE$, en $\text{m}^2$?', '[{"id":"A","content":"$S(1 - k)$"},{"id":"B","content":"$S(1 - k)^2$"},{"id":"C","content":"$Sk^2$"},{"id":"D","content":"$S(1 - k^2)$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Como $DE \parallel BC$, el triángulo $ADE$ es semejante al triángulo $ABC$ con razón de semejanza $\frac{AD}{AB} = k$.
Las áreas están en razón $k^2$, así que el área de $ADE$ es $Sk^2$ y la del trapecio es $S - Sk^2 = S(1 - k^2)$.
A usa la razón lineal $k$ en lugar de $k^2$, B calcula el área de un triángulo de razón $1 - k$ (que no es la figura pedida) y C es el área del triángulo $ADE$, no la del trapecio.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e30e33c9-8fa3-5d85-bcb0-9611f5f3b997', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-124
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ac66e2e4-ab5e-56a8-9c6c-a26671e1eca9', 'm2-geometria-124', 'En un mapa de senderos del Parque Nacional Conguillío, dibujado a escala $1 : 50\,000$, el tramo entre dos miradores mide $7{,}2$ cm.

¿Cuál es la longitud real de ese tramo?', '[{"id":"A","content":"$0{,}36$ km"},{"id":"B","content":"$3{,}6$ km"},{"id":"C","content":"$36$ km"},{"id":"D","content":"$360$ km"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La escala indica que $1$ cm del mapa representa $50\,000$ cm reales.
Entonces el tramo mide $7{,}2 \cdot 50\,000 = 360\,000$ cm $= 3\,600$ m $= 3{,}6$ km.
A divide por $100\,000$ en lugar de convertir bien de centímetros a kilómetros; C y D se equivocan en la conversión al tratar los $360\,000$ cm como $36\,000$ m o como $360\,000$ m.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ac66e2e4-ab5e-56a8-9c6c-a26671e1eca9', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'semejanza'
  on conflict do nothing;
-- m2-geometria-125
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('320f3b06-928c-530e-a181-eca9653b6934', 'm2-geometria-125', 'Una caja tiene forma de paralelepípedo recto rectangular y sus aristas están en la razón $2 : 3 : 6$. La varilla recta más larga que cabe en su interior une dos vértices opuestos de la caja (pasando por su interior) y mide $21$ cm.

¿Cuál es el volumen de la caja?', '[{"id":"A","content":"$216\\ \\text{cm}^3$"},{"id":"B","content":"$324\\ \\text{cm}^3$"},{"id":"C","content":"$648\\ \\text{cm}^3$"},{"id":"D","content":"$972\\ \\text{cm}^3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Sean $2a$, $3a$ y $6a$ las aristas. La diagonal del paralelepípedo mide $\sqrt{(2a)^2 + (3a)^2 + (6a)^2} = \sqrt{49a^2} = 7a$.
De $7a = 21$ se obtiene $a = 3$, así que las aristas miden $6$, $9$ y $18$ cm, y el volumen es $6 \cdot 9 \cdot 18 = 972\ \text{cm}^3$.
C es el área total $2(54 + 108 + 162) = 648\ \text{cm}^2$, B calcula $36a^2$ en lugar de $36a^3$ y A es el volumen de un cubo de arista $6$ cm, la menor de las aristas.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '320f3b06-928c-530e-a181-eca9653b6934', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m2-geometria-126
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('10671adf-69e7-5f4b-a6d1-59add2fdae4a', 'm2-geometria-126', 'Una fábrica de Talcahuano produce cubos de madera para juegos didácticos. Si la arista de uno de estos cubos se aumentara en $1$ cm, su área total aumentaría en $66\ \text{cm}^2$.

¿Cuál es el volumen del cubo original?', '[{"id":"A","content":"$125\\ \\text{cm}^3$"},{"id":"B","content":"$150\\ \\text{cm}^3$"},{"id":"C","content":"$216\\ \\text{cm}^3$"},{"id":"D","content":"$1\\,331\\ \\text{cm}^3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Si la arista mide $a$ cm, el aumento del área total es $6(a + 1)^2 - 6a^2 = 6(2a + 1)$.
De $6(2a + 1) = 66$ se obtiene $2a + 1 = 11$, es decir, $a = 5$, y el volumen es $5^3 = 125\ \text{cm}^3$.
B es el área total del cubo original ($6 \cdot 25$), C es el volumen del cubo con la arista aumentada ($6^3$) y D toma $\frac{66}{6} = 11$ como la arista, sin plantear la diferencia de áreas.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '10671adf-69e7-5f4b-a6d1-59add2fdae4a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'geometria' and e.subject = 'm2' and t.slug = 'cuerpos-geometricos'
  on conflict do nothing;
-- m2-numeros-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b8b46958-f4ee-50ca-91a1-770dff6a4bf9', 'm2-numeros-001', '¿Cuál de los siguientes números es irracional?', '[{"id":"A","content":"$\\sqrt{0{,}\\overline{4}}$"},{"id":"B","content":"$\\sqrt{2}\\cdot\\sqrt{18}$"},{"id":"C","content":"$\\dfrac{\\sqrt{75}}{\\sqrt{3}}$"},{"id":"D","content":"$\\sqrt{3}+\\sqrt{27}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'A: $0{,}\overline{4}=\frac{4}{9}$, luego $\sqrt{\frac{4}{9}}=\frac{2}{3}$, que es racional.
B: $\sqrt{2}\cdot\sqrt{18}=\sqrt{36}=6$, racional. C: $\frac{\sqrt{75}}{\sqrt{3}}=\sqrt{25}=5$, racional.
D: $\sqrt{3}+\sqrt{27}=\sqrt{3}+3\sqrt{3}=4\sqrt{3}$, que es irracional porque $\sqrt{3}$ lo es.
El error típico es pensar que toda raíz es irracional o que un decimal periódico bajo raíz no puede dar un racional.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b8b46958-f4ee-50ca-91a1-770dff6a4bf9', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'numeros-reales'
  on conflict do nothing;
-- m2-numeros-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('63fd0847-86fc-5113-b39c-0de359b4bf1d', 'm2-numeros-002', 'Martina quiere racionalizar la expresión $\dfrac{6}{\sqrt{3}-1}$ y realiza el siguiente desarrollo:

Paso 1: $\dfrac{6}{\sqrt{3}-1}\cdot\dfrac{\sqrt{3}+1}{\sqrt{3}+1}$
Paso 2: $\dfrac{6\sqrt{3}+6}{3+1}$
Paso 3: $\dfrac{6(\sqrt{3}+1)}{4}$
Paso 4: $\dfrac{3(\sqrt{3}+1)}{2}$

¿En cuál de los pasos se cometió el primer error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El Paso 1 es correcto: se amplifica por el conjugado del denominador.
En el Paso 2 el denominador debe ser $(\sqrt{3}-1)(\sqrt{3}+1)=(\sqrt{3})^2-1^2=3-1=2$, no $3+1$. Ahí está el error.
El resultado correcto es $\frac{6(\sqrt{3}+1)}{2}=3\sqrt{3}+3$.
Los pasos 3 y 4 son consecuencias algebraicamente correctas del Paso 2 (factorizar y simplificar por 2), por lo que no contienen el primer error.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '63fd0847-86fc-5113-b39c-0de359b4bf1d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'numeros-reales'
  on conflict do nothing;
-- m2-numeros-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b8306523-649c-501e-877c-e52ec1ce717b', 'm2-numeros-003', 'Sea $x$ un número real positivo.

Se puede determinar el valor de $x$, si se sabe que:

(1) $x^2=3+2\sqrt{2}$
(2) $x-\dfrac{1}{x}=2$', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Con (1): como $x>0$, $x=\sqrt{3+2\sqrt{2}}$. Además $(1+\sqrt{2})^2=1+2\sqrt{2}+2=3+2\sqrt{2}$, así que $x=1+\sqrt{2}$. Es suficiente.
Con (2): multiplicando por $x$ se obtiene $x^2-2x-1=0$, cuyas soluciones son $1+\sqrt{2}$ y $1-\sqrt{2}$. Como $1-\sqrt{2}<0$, se descarta y queda $x=1+\sqrt{2}$. También es suficiente.
Por lo tanto, cada una por sí sola determina $x$. El error frecuente es creer que (2), al ser una ecuación cuadrática, entrega dos valores, olvidando que $x$ es positivo.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b8306523-649c-501e-877c-e52ec1ce717b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'numeros-reales'
  on conflict do nothing;
-- m2-numeros-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1376d920-84d5-5457-b285-b4e8a5d173de', 'm2-numeros-004', 'Considera el número $p=\sqrt{45}-\sqrt{20}+\sqrt{5}$.

¿Entre cuáles dos números enteros consecutivos se ubica $p$ en la recta numérica?', '[{"id":"A","content":"Entre $2$ y $3$"},{"id":"B","content":"Entre $3$ y $4$"},{"id":"C","content":"Entre $4$ y $5$"},{"id":"D","content":"Entre $5$ y $6$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Se simplifica cada raíz: $\sqrt{45}=3\sqrt{5}$ y $\sqrt{20}=2\sqrt{5}$. Entonces $p=3\sqrt{5}-2\sqrt{5}+\sqrt{5}=2\sqrt{5}=\sqrt{20}$.
Como $16<20<25$, se tiene $4<\sqrt{20}<5$.
D resulta de operar los radicandos como si $\sqrt{a}-\sqrt{b}+\sqrt{c}=\sqrt{a-b+c}=\sqrt{30}$. A corresponde a quedarse solo con $\sqrt{5}$, y B a calcular $\sqrt{5}+\sqrt{5}$ con signo erróneo o a aproximar mal $2\sqrt{5}$.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1376d920-84d5-5457-b285-b4e8a5d173de', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'numeros-reales'
  on conflict do nothing;
-- m2-numeros-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e837f390-85c7-5754-a1c0-b48a0e7615c3', 'm2-numeros-005', 'Camila deposita $500\,000$ pesos en un depósito a plazo que paga un interés compuesto del $2\%$ mensual. El monto $C(n)$, en pesos, que tendrá al cabo de $n$ meses se modela mediante $C(n)=500\,000\cdot(1{,}02)^n$.

Si Camila no retira ni agrega dinero, ¿cuál será el monto al cabo de $2$ meses?', '[{"id":"A","content":"$510\\,000$ pesos"},{"id":"B","content":"$520\\,000$ pesos"},{"id":"C","content":"$520\\,200$ pesos"},{"id":"D","content":"$540\\,800$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, '$C(2)=500\,000\cdot(1{,}02)^2=500\,000\cdot1{,}0404=520\,200$ pesos.
A es el monto al cabo de un solo mes. B corresponde a interés simple ($2\%$ de $500\,000$ dos veces, sin interés sobre el interés).
D resulta de usar una tasa del $4\%$ en cada uno de los dos meses: $500\,000\cdot(1{,}04)^2$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e837f390-85c7-5754-a1c0-b48a0e7615c3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'matematica-financiera'
  on conflict do nothing;
-- m2-numeros-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('dc68b348-89ca-5dbd-989f-de027368bced', 'm2-numeros-006', 'Tomás pide un crédito de $2\,000\,000$ pesos, con una tasa de interés compuesto del $10\%$ anual. Acuerda con el banco pagar la deuda completa en una sola cuota al término de $2$ años.

¿Cuánto dinero pagará Tomás solo por concepto de intereses?', '[{"id":"A","content":"$400\\,000$ pesos"},{"id":"B","content":"$420\\,000$ pesos"},{"id":"C","content":"$2\\,400\\,000$ pesos"},{"id":"D","content":"$2\\,420\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La deuda al cabo de $2$ años es $2\,000\,000\cdot(1{,}1)^2=2\,000\,000\cdot1{,}21=2\,420\,000$ pesos.
Los intereses son la diferencia con el capital pedido: $2\,420\,000-2\,000\,000=420\,000$ pesos.
A corresponde a interés simple ($10\%$ de $2\,000\,000$ por $2$ años). D es el monto total de la cuota, no los intereses, y C es el total calculado con interés simple.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'dc68b348-89ca-5dbd-989f-de027368bced', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'matematica-financiera'
  on conflict do nothing;
-- m2-numeros-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2b716b85-d67d-5be3-80e7-657c1aefdd72', 'm2-numeros-007', 'La cuenta de capitalización individual de Rosa en su AFP tiene un saldo de $8\,000\,000$ pesos. Rosa dejará de cotizar y supondrá que el fondo obtiene una rentabilidad de un $4\%$ anual, que se capitaliza cada año sobre el saldo acumulado.

¿Cuál de las siguientes expresiones representa el saldo, en pesos, de la cuenta de Rosa al cabo de $t$ años?', '[{"id":"A","content":"$8\\,000\\,000\\cdot(1{,}04)^t$"},{"id":"B","content":"$8\\,000\\,000\\cdot(1+0{,}04t)$"},{"id":"C","content":"$8\\,000\\,000\\cdot(0{,}04)^t$"},{"id":"D","content":"$8\\,000\\,000\\cdot(1{,}4)^t$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'Cada año el saldo se multiplica por $1+\frac{4}{100}=1{,}04$, de modo que tras $t$ años queda $8\,000\,000\cdot(1{,}04)^t$.
B modela un interés simple: la ganancia no se suma al saldo para el año siguiente.
C multiplica solo por la tasa, lo que haría disminuir el saldo. D confunde $4\%$ con $0{,}4$, es decir, usa un $40\%$ anual.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2b716b85-d67d-5be3-80e7-657c1aefdd72', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'matematica-financiera'
  on conflict do nothing;
-- m2-numeros-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e8746361-51ff-5e90-b332-ff17a034ee01', 'm2-numeros-008', 'Andrés depositó un capital inicial en una cuenta de ahorro que paga una tasa fija de interés compuesto anual. No hizo retiros ni nuevos depósitos.

Se puede determinar el monto que tendrá la cuenta al cabo de $3$ años, si se sabe que:

(1) Al cabo de $1$ año, la cuenta tenía $1\,050\,000$ pesos.
(2) Al cabo de $2$ años, la cuenta tenía $1\,102\,500$ pesos.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Si $C$ es el capital inicial e $i$ la tasa, el monto al cabo de $n$ años es $C(1+i)^n$.
Con (1) solo se sabe que $C(1+i)=1\,050\,000$; por ejemplo, $C=1\,000\,000$ con $i=5\%$ o $C\approx954\,545$ con $i=10\%$ dan montos distintos a los $3$ años. No basta.
Con (2) ocurre lo mismo: hay infinitos pares $(C,i)$ con $C(1+i)^2=1\,102\,500$.
Juntas: $1+i=\frac{1\,102\,500}{1\,050\,000}=1{,}05$ y el monto a los $3$ años es $1\,102\,500\cdot1{,}05=1\,157\,625$ pesos. Se requieren ambas.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e8746361-51ff-5e90-b332-ff17a034ee01', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'matematica-financiera'
  on conflict do nothing;
-- m2-numeros-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9dbbac96-9d2b-5823-ac8f-3e7a340a0a38', 'm2-numeros-009', 'Diego tiene una deuda de $1\,000\,000$ pesos en una tarjeta de crédito que cobra un interés compuesto del $1\%$ mensual. Durante $12$ meses no hará pagos ni nuevas compras.

Diego afirma: «Un $1\%$ mensual equivale a un $12\%$ anual, así que en un año mi deuda llegará a $1\,120\,000$ pesos».

Considerando que $(1{,}01)^{12}\approx1{,}1268$, ¿cuál de las siguientes afirmaciones es correcta?', '[{"id":"A","content":"Diego se equivoca: la deuda llegará a aproximadamente $1\\,126\\,800$ pesos, porque cada mes se cobra interés también sobre los intereses anteriores."},{"id":"B","content":"Diego tiene razón, porque $12$ meses al $1\\%$ suman exactamente un $12\\%$."},{"id":"C","content":"Diego se equivoca: la deuda será menor que $1\\,120\\,000$ pesos, porque al capitalizar cada mes la tasa anual equivalente es menor que $12\\%$."},{"id":"D","content":"Diego se equivoca: la deuda llegará a aproximadamente $1\\,012\\,680$ pesos, porque la tasa anual equivalente es $1{,}268\\%$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Con interés compuesto, la deuda tras $12$ meses es $1\,000\,000\cdot(1{,}01)^{12}\approx1\,000\,000\cdot1{,}1268=1\,126\,800$ pesos.
La tasa anual equivalente es cercana a $12{,}68\%$, mayor que $12\%$, porque cada mes el $1\%$ se aplica sobre un saldo que ya incluye intereses.
B es el error de sumar tasas compuestas, que solo sería válido con interés simple. C invierte el efecto de la capitalización: la tasa equivalente es mayor, no menor.
D lee mal el factor $1{,}1268$ como si fuera un porcentaje.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9dbbac96-9d2b-5823-ac8f-3e7a340a0a38', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'matematica-financiera'
  on conflict do nothing;
-- m2-numeros-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a45593f8-fa09-5edc-980a-3ef93626c396', 'm2-numeros-010', 'La magnitud $M$ de un sismo en la escala de Richter se puede modelar mediante $M=\log\left(\dfrac{A}{A_0}\right)$, donde $A$ es la amplitud de la onda registrada por el sismógrafo y $A_0$ es una amplitud de referencia fija.

En el norte de Chile se registró un sismo de magnitud $4{,}2$. Días después, otro sismo tuvo una amplitud $500$ veces mayor que la del primero.

Considerando $\log 5\approx0{,}7$, ¿cuál fue la magnitud aproximada del segundo sismo?', '[{"id":"A","content":"$4{,}9$"},{"id":"B","content":"$5{,}6$"},{"id":"C","content":"$6{,}2$"},{"id":"D","content":"$6{,}9$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Si $A_2=500A_1$, entonces $M_2=\log\left(\frac{500A_1}{A_0}\right)=\log 500+M_1$.
Como $\log 500=\log 5+\log 100\approx0{,}7+2=2{,}7$, se obtiene $M_2\approx4{,}2+2{,}7=6{,}9$.
A suma solo $\log 5$, olvidando el factor $100$. B calcula $\log 500$ como $2\log 5$. C suma $2$, es decir, usa $\log 100$ en lugar de $\log 500$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a45593f8-fa09-5edc-980a-3ef93626c396', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'logaritmos'
  on conflict do nothing;
-- m2-numeros-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('019355de-1add-5358-a182-0b45c8e56688', 'm2-numeros-011', 'El pH de una solución se calcula como $\text{pH}=-\log\left[\text{H}^+\right]$, donde $\left[\text{H}^+\right]$ es la concentración de iones hidrógeno, en mol/L.

En un laboratorio, la muestra P tiene un pH de $3{,}4$. La muestra Q tiene una concentración de iones hidrógeno igual a la quinta parte de la concentración de la muestra P.

Considerando $\log 2\approx0{,}30$, ¿cuál es el pH aproximado de la muestra Q?', '[{"id":"A","content":"$2{,}7$"},{"id":"B","content":"$4{,}1$"},{"id":"C","content":"$4{,}4$"},{"id":"D","content":"$8{,}4$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Si $\left[\text{H}^+\right]_Q=\frac{1}{5}\left[\text{H}^+\right]_P$, entonces $\text{pH}_Q=-\log\left[\text{H}^+\right]_P+\log 5=3{,}4+\log 5$.
Como $\log 5=\log\frac{10}{2}=1-\log 2\approx0{,}70$, se obtiene $\text{pH}_Q\approx4{,}1$.
A resta $\log 5$ (error de signo: una menor concentración implica un pH mayor). C suma $1$, como si la concentración fuera diez veces menor. D suma directamente $5$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '019355de-1add-5358-a182-0b45c8e56688', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'logaritmos'
  on conflict do nothing;
-- m2-numeros-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('7779f2ea-8fb4-54f2-bdee-3f4441002223', 'm2-numeros-012', 'Sean $a$ y $b$ números reales positivos y distintos de $1$.

Se puede determinar el valor de $\log_a b$, si se sabe que:

(1) $\log_b a=\dfrac{1}{2}$
(2) $a\cdot b=8$', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Con (1): por cambio de base, $\log_a b=\frac{1}{\log_b a}=2$. Es suficiente (por ejemplo, $a=2$, $b=4$).
Con (2): hay varios pares posibles. Si $a=2$ y $b=4$, $\log_a b=2$; si $a=4$ y $b=2$, $\log_a b=\frac{1}{2}$. No basta.
Por lo tanto, (1) por sí sola es suficiente y (2) por sí sola no lo es.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '7779f2ea-8fb4-54f2-bdee-3f4441002223', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'logaritmos'
  on conflict do nothing;
-- m2-numeros-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e505a0e9-526e-53a1-9abf-9522dbdff50b', 'm2-numeros-013', 'Considera que $\log 2=p$ y $\log 3=q$.

¿Cuál de las siguientes igualdades es verdadera?', '[{"id":"A","content":"$\\log 1{,}2=2p+q-1$"},{"id":"B","content":"$\\log 6=p\\cdot q$"},{"id":"C","content":"$\\log 1{,}5=\\dfrac{q}{p}$"},{"id":"D","content":"$\\log 0{,}3=-q$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'A: $\log 1{,}2=\log\frac{12}{10}=\log(2^2\cdot3)-\log 10=2p+q-1$. Es verdadera.
B: $\log 6=\log 2+\log 3=p+q$, no $p\cdot q$ (confunde el logaritmo del producto con el producto de logaritmos).
C: $\log 1{,}5=\log\frac{3}{2}=q-p$, no $\frac{q}{p}$.
D: $\log 0{,}3=\log\frac{3}{10}=q-1$, no $-q$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e505a0e9-526e-53a1-9abf-9522dbdff50b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'logaritmos'
  on conflict do nothing;
-- m2-numeros-101
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('08559dba-9058-53de-9a53-5fe7b8da398c', 'm2-numeros-101', 'Sea $x$ un número real y considera que $2^{x}=a$.

¿Cuál de las siguientes expresiones es igual a $2^{x+3}+2^{x-1}$?', '[{"id":"A","content":"$6a$"},{"id":"B","content":"$\\dfrac{13a}{2}$"},{"id":"C","content":"$\\dfrac{17a}{2}$"},{"id":"D","content":"$10a$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Por propiedades de potencias de igual base: $2^{x+3}=2^{x}\cdot2^{3}=8a$ y $2^{x-1}=2^{x}\cdot2^{-1}=\dfrac{a}{2}$.
Luego $2^{x+3}+2^{x-1}=8a+\dfrac{a}{2}=\dfrac{17a}{2}$.
$10a$ resulta de tomar $2^{-1}$ como $2$; $6a$ de tomar $2^{-1}$ como $-2$.
$\dfrac{13a}{2}$ aparece al confundir $2^{3}$ con $2\cdot3=6$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '08559dba-9058-53de-9a53-5fe7b8da398c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-102
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d1d8cb25-4b0b-5f7f-b943-37e0cea4a50e', 'm2-numeros-102', 'Un satélite de observación transmite datos a una estación en la Antártica a una tasa constante de $3{,}2\cdot10^{6}$ bits por segundo. Debe enviar un archivo de imágenes de $100$ gigabytes.

Considera que $1$ gigabyte equivale a $10^{9}$ bytes y que $1$ byte equivale a $8$ bits.

¿Cuántos segundos demora la transmisión completa del archivo?', '[{"id":"A","content":"$3{,}125\\cdot10^{4}$"},{"id":"B","content":"$2{,}5\\cdot10^{5}$"},{"id":"C","content":"$2{,}5\\cdot10^{6}$"},{"id":"D","content":"$2{,}56\\cdot10^{18}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El archivo tiene $100\cdot10^{9}=10^{11}$ bytes, es decir, $8\cdot10^{11}$ bits.
El tiempo es $\dfrac{8\cdot10^{11}}{3{,}2\cdot10^{6}}=2{,}5\cdot10^{5}$ segundos.
$3{,}125\cdot10^{4}$ se obtiene al olvidar convertir bytes a bits.
$2{,}5\cdot10^{6}$ proviene de un error al restar los exponentes, y $2{,}56\cdot10^{18}$ de multiplicar en lugar de dividir.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd1d8cb25-4b0b-5f7f-b943-37e0cea4a50e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-103
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('dcbe912a-b19a-5c2e-bbbe-30e87b984fb9', 'm2-numeros-103', 'Sea $n$ un número entero positivo.

¿Cuál de las siguientes igualdades es verdadera para cualquier valor de $n$?', '[{"id":"A","content":"$\\dfrac{3^{n+2}-3^{n}}{8}=3^{n}$"},{"id":"B","content":"$\\left(2^{n}\\right)^{2}=2^{n^{2}}$"},{"id":"C","content":"$5^{n}+5^{n}=10^{n}$"},{"id":"D","content":"$\\sqrt{4^{n}+4^{n}}=2^{n+1}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'A: $3^{n+2}-3^{n}=3^{n}(9-1)=8\cdot3^{n}$, por lo que el cociente es $3^{n}$ para todo $n$.
B: $\left(2^{n}\right)^{2}=2^{2n}$, que coincide con $2^{n^{2}}$ solo si $n=2$ (con $n=3$: $64\neq512$).
C: $5^{n}+5^{n}=2\cdot5^{n}$, que no es $10^{n}$ salvo $n=1$.
D: $\sqrt{2\cdot4^{n}}=2^{n}\sqrt{2}$, no $2^{n+1}$: se sumaron mal los términos bajo la raíz.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'dcbe912a-b19a-5c2e-bbbe-30e87b984fb9', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-104
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2caa3186-ea7a-50fa-ab1e-080ada58b6f4', 'm2-numeros-104', 'En aguas profundas, la rapidez $v$ de una ola, en metros por segundo, se puede modelar mediante $v=\sqrt{\dfrac{g\lambda}{2\pi}}$, donde $\lambda$ es la longitud de onda, en metros, y $g$ es la aceleración de gravedad, que se considera constante.

Si la longitud de onda de una ola aumenta en un $44\%$, ¿en qué porcentaje aumenta su rapidez según el modelo?', '[{"id":"A","content":"En un $20\\%$"},{"id":"B","content":"En un $22\\%$"},{"id":"C","content":"En un $44\\%$"},{"id":"D","content":"En un $120\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Si la nueva longitud de onda es $1{,}44\lambda$, la nueva rapidez es $\sqrt{\dfrac{g\cdot1{,}44\lambda}{2\pi}}=\sqrt{1{,}44}\cdot v=1{,}2v$.
Es decir, la rapidez aumenta en un $20\%$.
$22\%$ resulta de dividir el porcentaje por $2$ en vez de aplicar la raíz al factor; $44\%$ supone proporcionalidad directa.
$120\%$ confunde el factor $1{,}2$ con el porcentaje de aumento.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2caa3186-ea7a-50fa-ab1e-080ada58b6f4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-105
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('898b5fdf-6872-5e54-95e6-44935826ad12', 'm2-numeros-105', 'Para $a>0$, se quiere reducir la expresión $\dfrac{\sqrt[3]{a^{4}}\cdot\sqrt{a^{3}}}{\sqrt[6]{a}}$ a su forma más simple.

¿Qué resultado se obtiene al reducirla?', '[{"id":"A","content":"$a\\sqrt[3]{a}$"},{"id":"B","content":"$a^{2}\\sqrt[3]{a}$"},{"id":"C","content":"$a^{2}\\sqrt[3]{a^{2}}$"},{"id":"D","content":"$a^{3}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Escribiendo cada raíz como potencia: $a^{\frac{4}{3}}\cdot a^{\frac{3}{2}}\cdot a^{-\frac{1}{6}}=a^{\frac{8}{6}+\frac{9}{6}-\frac{1}{6}}=a^{\frac{16}{6}}=a^{\frac{8}{3}}$.
Como $\frac{8}{3}=2+\frac{2}{3}$, se tiene $a^{\frac{8}{3}}=a^{2}\sqrt[3]{a^{2}}$.
$a\sqrt[3]{a}=a^{\frac{4}{3}}$ considera solo el primer factor; $a^{2}\sqrt[3]{a}=a^{\frac{7}{3}}$ surge de un error al sumar fracciones.
$a^{3}$ resulta de sumar el exponente $\frac{1}{6}$ en lugar de restarlo.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '898b5fdf-6872-5e54-95e6-44935826ad12', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-106
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('462fd43c-5d1c-5f78-8488-4f8e9846145e', 'm2-numeros-106', 'Sea $m$ un número real positivo. Considera la expresión que se describe a continuación:

"el cubo de la raíz cuarta de $m$, dividido por la raíz cuadrada de $m$".

¿Cuál de las siguientes potencias es igual a esa expresión?', '[{"id":"A","content":"$m^{-\\frac{1}{4}}$"},{"id":"B","content":"$m^{\\frac{1}{4}}$"},{"id":"C","content":"$m^{\\frac{3}{8}}$"},{"id":"D","content":"$m^{\\frac{5}{4}}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El cubo de la raíz cuarta de $m$ es $\left(\sqrt[4]{m}\right)^{3}=m^{\frac{3}{4}}$ y la raíz cuadrada es $m^{\frac{1}{2}}$.
El cociente es $m^{\frac{3}{4}-\frac{1}{2}}=m^{\frac{1}{4}}$.
$m^{-\frac{1}{4}}$ invierte el orden de la resta; $m^{\frac{5}{4}}$ suma los exponentes como si fuera un producto.
$m^{\frac{3}{8}}$ multiplica los exponentes, confundiendo división con potencia de potencia.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '462fd43c-5d1c-5f78-8488-4f8e9846145e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-107
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('57b9f25f-6d75-581e-a3be-256c1d0efc21', 'm2-numeros-107', 'En un liceo de Temuco, el $60\%$ de los estudiantes de cuarto medio son mujeres. Se sabe que el $25\%$ de las mujeres y el $40\%$ de los hombres de ese nivel participan en la selección de atletismo.

¿Qué porcentaje del total de estudiantes de cuarto medio participa en la selección de atletismo?', '[{"id":"A","content":"$31\\%$"},{"id":"B","content":"$32{,}5\\%$"},{"id":"C","content":"$34\\%$"},{"id":"D","content":"$65\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Si hay $N$ estudiantes, participan $0{,}25\cdot0{,}6N+0{,}4\cdot0{,}4N=0{,}15N+0{,}16N=0{,}31N$, es decir, el $31\%$.
$32{,}5\%$ es el promedio simple de $25\%$ y $40\%$, sin ponderar por la cantidad de mujeres y hombres.
$34\%$ resulta de intercambiar los porcentajes de mujeres y hombres.
$65\%$ suma directamente $25\%$ y $40\%$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '57b9f25f-6d75-581e-a3be-256c1d0efc21', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-108
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('1d65f191-f92c-5b2a-9b2e-b7cec560d62f', 'm2-numeros-108', 'El precio de un pasaje en bus entre Santiago y La Serena aumentó un $a\%$ durante el fin de semana largo. Después, la empresa aplicó un descuento del $b\%$ sobre ese nuevo precio, con $a$ y $b$ números positivos menores que $100$.

¿Cuál de las siguientes expresiones representa la variación porcentual del precio final respecto del precio original?', '[{"id":"A","content":"$a-b$"},{"id":"B","content":"$a-b+\\dfrac{ab}{100}$"},{"id":"C","content":"$\\dfrac{(100+a)(100-b)}{100}$"},{"id":"D","content":"$a-b-\\dfrac{ab}{100}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Si el precio original es $P$, el precio final es $P\left(1+\dfrac{a}{100}\right)\left(1-\dfrac{b}{100}\right)=P\left(1+\dfrac{a-b}{100}-\dfrac{ab}{10\,000}\right)$.
La variación porcentual es $100\cdot\left(\dfrac{a-b}{100}-\dfrac{ab}{10\,000}\right)=a-b-\dfrac{ab}{100}$.
$a-b$ supone que los porcentajes se restan directamente; $a-b+\dfrac{ab}{100}$ tiene un error de signo al desarrollar el producto.
$\dfrac{(100+a)(100-b)}{100}$ es el precio final como porcentaje del original, no la variación.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '1d65f191-f92c-5b2a-9b2e-b7cec560d62f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-109
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e801d84f-4a03-5d38-b862-f0e489f8fb54', 'm2-numeros-109', 'La cantidad de socios de una cooperativa aumentó un $p\%$ entre dos años, con $p>0$. Para volver a la cantidad inicial, la cantidad de socios tendría que disminuir un $q\%$ respecto de la cantidad aumentada.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"$q=p$"},{"id":"B","content":"$q>p$"},{"id":"C","content":"$q=\\dfrac{100p}{100-p}$"},{"id":"D","content":"$q=\\dfrac{100p}{100+p}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Si la cantidad inicial es $S$, tras el aumento es $S\left(1+\frac{p}{100}\right)$. Se requiere $S\left(1+\frac{p}{100}\right)\left(1-\frac{q}{100}\right)=S$.
Despejando: $1-\dfrac{q}{100}=\dfrac{100}{100+p}$, luego $q=\dfrac{100p}{100+p}$.
Como $100+p>100$, se cumple $q<p$, por lo que A y B son falsas (por ejemplo, con $p=25$ se obtiene $q=20$).
C usa $100-p$ en el denominador, que corresponde al caso inverso: una disminución seguida de un aumento.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e801d84f-4a03-5d38-b862-f0e489f8fb54', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-110
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('60abb0cf-c903-517c-868e-ce750870dd97', 'm2-numeros-110', 'En la elección del centro de estudiantes de un colegio votaron $480$ estudiantes, lo que corresponde al $75\%$ del total de estudiantes habilitados para votar. Del grupo que no votó, el $40\%$ estaba con licencia médica ese día.

¿Cuántos estudiantes habilitados no votaron y no estaban con licencia médica?', '[{"id":"A","content":"$96$"},{"id":"B","content":"$120$"},{"id":"C","content":"$160$"},{"id":"D","content":"$256$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El total de habilitados es $\dfrac{480}{0{,}75}=640$, por lo que no votaron $640-480=160$.
De ellos, el $60\%$ no tenía licencia: $0{,}6\cdot160=96$.
$120$ resulta de calcular el $25\%$ de $480$ en lugar del $25\%$ del total.
$160$ es el total que no votó, sin descontar a quienes tenían licencia, y $256$ es el $40\%$ de $640$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '60abb0cf-c903-517c-868e-ce750870dd97', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-111
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('5cf2552d-bf32-5379-a4fa-1b7eea8ee254', 'm2-numeros-111', 'Desde un terminal de Antofagasta salen buses de dos recorridos. Los del recorrido 1 salen cada $12$ minutos y los del recorrido 2, cada $18$ minutos. A las 6:00 horas salió un bus de cada recorrido al mismo tiempo.

¿Cuántas veces, entre las 6:00 y las 9:00 horas, ambas inclusive, salen simultáneamente buses de los dos recorridos?', '[{"id":"A","content":"$4$"},{"id":"B","content":"$5$"},{"id":"C","content":"$6$"},{"id":"D","content":"$15$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Los buses coinciden cada $\text{mcm}(12,18)=36$ minutos.
Entre las 6:00 y las 9:00 hay $180$ minutos, y $180=5\cdot36$, por lo que coinciden en los minutos $0, 36, 72, 108, 144$ y $180$: son $6$ veces.
$5$ olvida contar la salida de las 6:00; $4$ usa además un intervalo abierto.
$15$ corresponde a la cantidad de salidas del recorrido 1 sin contar la inicial ($180:12$).', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '5cf2552d-bf32-5379-a4fa-1b7eea8ee254', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-112
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('6b975804-61d2-5d51-97d9-dc3cb7fb898e', 'm2-numeros-112', 'Sean $a$ y $b$ números racionales tales que $0<a<b<1$.

¿Cuál de las siguientes desigualdades es siempre verdadera?', '[{"id":"A","content":"$\\dfrac{a}{b}<a$"},{"id":"B","content":"$\\dfrac{1}{a}<\\dfrac{1}{b}$"},{"id":"C","content":"$b-a<b^{2}-a^{2}$"},{"id":"D","content":"$a^{2}<ab$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'D: como $a>0$, multiplicar $a<b$ por $a$ conserva la desigualdad: $a^{2}<ab$. Es siempre verdadera.
A: como $0<b<1$, dividir por $b$ agranda: $\frac{a}{b}>a$. Es falsa.
B: para positivos, el mayor tiene el menor recíproco: $\frac{1}{a}>\frac{1}{b}$. Es falsa.
C: $b^{2}-a^{2}=(b-a)(b+a)$, que es mayor que $b-a$ solo si $b+a>1$; con $a=\frac{1}{4}$ y $b=\frac{1}{2}$ falla.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '6b975804-61d2-5d51-97d9-dc3cb7fb898e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-113
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ee04a9ba-52d9-5bcd-96d2-836cea2620ed', 'm2-numeros-113', 'Considera los números $p=1{,}\overline{6}$ y $q=0{,}8\overline{3}$.

¿Cuál es el valor de $\dfrac{p}{q}-\dfrac{q}{p}$?', '[{"id":"A","content":"$\\dfrac{1}{2}$"},{"id":"B","content":"$\\dfrac{3}{2}$"},{"id":"C","content":"$2$"},{"id":"D","content":"$\\dfrac{5}{2}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, '$p=1{,}\overline{6}=\dfrac{16-1}{9}=\dfrac{5}{3}$ y $q=0{,}8\overline{3}=\dfrac{83-8}{90}=\dfrac{75}{90}=\dfrac{5}{6}$.
Entonces $\dfrac{p}{q}=\dfrac{5}{3}\cdot\dfrac{6}{5}=2$ y $\dfrac{q}{p}=\dfrac{1}{2}$, por lo que la diferencia es $2-\dfrac{1}{2}=\dfrac{3}{2}$.
$2$ y $\dfrac{1}{2}$ corresponden a cada cociente por separado.
$\dfrac{5}{2}$ resulta de sumar los cocientes en vez de restarlos.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ee04a9ba-52d9-5bcd-96d2-836cea2620ed', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-114
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('61c4581f-738a-5ce9-b3af-20b624290400', 'm2-numeros-114', 'Considera que $n$ es un entero menor que cero.

¿Con cuál de estas expresiones se obtiene un resultado mayor que cero, sea cual sea el valor de $n$?', '[{"id":"A","content":"$n^{3}$"},{"id":"B","content":"$-n^{2}$"},{"id":"C","content":"$n-n^{2}$"},{"id":"D","content":"$n^{2}-n$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Si $n<0$, entonces $n^{2}>0$ y $-n>0$, por lo que $n^{2}-n$ es suma de dos positivos: siempre es positivo.
A: el cubo de un negativo es negativo.
B: $-n^{2}$ es el opuesto de un positivo, luego es negativo (no es lo mismo que $(-n)^{2}$).
C: $n-n^{2}$ es la suma de dos negativos, $n$ y $-n^{2}$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '61c4581f-738a-5ce9-b3af-20b624290400', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-115
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('156af9e7-4004-5aed-a01d-3d31ee9a3bad', 'm2-numeros-115', 'Considera el número $a=\sqrt{3}$.

¿Cuál es el valor de $a^{5}-a^{3}$?', '[{"id":"A","content":"$3$"},{"id":"B","content":"$3\\sqrt{3}$"},{"id":"C","content":"$6\\sqrt{3}$"},{"id":"D","content":"$9\\sqrt{3}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Como $a^{2}=3$, se tiene $a^{3}=a^{2}\cdot a=3\sqrt{3}$ y $a^{5}=a^{2}\cdot a^{2}\cdot a=9\sqrt{3}$.
Luego, $a^{5}-a^{3}=9\sqrt{3}-3\sqrt{3}=6\sqrt{3}$.
A resulta de restar los exponentes, como si $a^{5}-a^{3}$ fuera igual a $a^{2}$.
B corresponde solo al valor de $a^{3}$ y D, solo al valor de $a^{5}$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '156af9e7-4004-5aed-a01d-3d31ee9a3bad', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-116
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f9c5b6da-a78a-5072-ad5b-70bd79800c18', 'm2-numeros-116', 'Un glóbulo rojo humano tiene un diámetro aproximado de $7{,}5\cdot10^{-6}$ m. Una estudiante imagina una fila de glóbulos rojos ubicados uno a continuación del otro, en línea recta, que en total mide $3$ cm de largo.

¿Cuántos glóbulos rojos forman esa fila?', '[{"id":"A","content":"$4\\cdot10^{2}$"},{"id":"B","content":"$4\\cdot10^{3}$"},{"id":"C","content":"$4\\cdot10^{4}$"},{"id":"D","content":"$4\\cdot10^{5}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Se expresa la longitud en metros: $3$ cm $=3\cdot10^{-2}$ m.
La cantidad de glóbulos es $\dfrac{3\cdot10^{-2}}{7{,}5\cdot10^{-6}}=0{,}4\cdot10^{4}=4\cdot10^{3}$.
D se obtiene al no convertir los centímetros a metros ($\dfrac{3}{7{,}5\cdot10^{-6}}$).
A se obtiene al escribir $3$ cm como $3\cdot10^{-3}$ m.
C resulta de dividir mal las partes decimales, tomando $\dfrac{3}{7{,}5}=4$ en lugar de $0{,}4$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f9c5b6da-a78a-5072-ad5b-70bd79800c18', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-117
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e8b8ed9b-6dfa-55d3-940b-ae973f495b29', 'm2-numeros-117', 'Gabriel debe calcular el valor de $\left(\sqrt{5}-\sqrt{3}\right)^{2}\cdot\left(8+2\sqrt{15}\right)$ y lo hace de la siguiente manera:

Paso 1: $\left(\sqrt{5}-\sqrt{3}\right)^{2}=5-2\sqrt{15}+3=8-2\sqrt{15}$
Paso 2: la expresión queda $\left(8-2\sqrt{15}\right)\left(8+2\sqrt{15}\right)=8^{2}-\left(2\sqrt{15}\right)^{2}$
Paso 3: $\left(2\sqrt{15}\right)^{2}=2\cdot15=30$
Paso 4: el resultado es $64-30=34$

¿En cuál de los pasos Gabriel cometió el primer error?', '[{"id":"A","content":"En el Paso 1"},{"id":"B","content":"En el Paso 2"},{"id":"C","content":"En el Paso 3"},{"id":"D","content":"En el Paso 4"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'El Paso 1 es correcto: el doble producto es $2\cdot\sqrt{5}\cdot\sqrt{3}=2\sqrt{15}$.
El Paso 2 también es correcto: es una suma por su diferencia.
En el Paso 3 está el error: $\left(2\sqrt{15}\right)^{2}=2^{2}\cdot\left(\sqrt{15}\right)^{2}=4\cdot15=60$; Gabriel no elevó al cuadrado el coeficiente $2$.
El valor correcto es $64-60=4$. El Paso 4 solo arrastra el valor erróneo, pero la resta en sí está bien hecha.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e8b8ed9b-6dfa-55d3-940b-ae973f495b29', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-118
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f7f09528-838e-540d-a32f-dda0ecf681a5', 'm2-numeros-118', 'Sea $n$ un número entero.

¿Cuál es el valor de la expresión $\dfrac{4^{n+1}-2^{2n-1}}{2^{2n+1}}$?', '[{"id":"A","content":"$\\dfrac{3}{2}$"},{"id":"B","content":"$\\dfrac{7}{4}$"},{"id":"C","content":"$\\dfrac{15}{8}$"},{"id":"D","content":"$\\dfrac{7}{2}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Se escribe todo en base $2$: $4^{n+1}=2^{2n+2}$.
El numerador es $2^{2n+2}-2^{2n-1}=2^{2n-1}\left(2^{3}-1\right)=7\cdot2^{2n-1}$.
Al dividir: $\dfrac{7\cdot2^{2n-1}}{2^{2n+1}}=7\cdot2^{-2}=\dfrac{7}{4}$, que no depende de $n$.
D se obtiene al dividir por $2^{2n}$ en lugar de $2^{2n+1}$.
A resulta de tomar $2^{2n-1}$ como si fuera $4^{n}$, y C, de tomarlo como $2^{2n-2}$.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f7f09528-838e-540d-a32f-dda0ecf681a5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-119
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('20a29f45-f7bd-59e9-a824-4d48acd15800', 'm2-numeros-119', 'Según la tercera ley de Kepler, el período orbital $T$ de un satélite que gira en una órbita circular alrededor de un planeta se puede modelar mediante $T=k\sqrt{r^{3}}$, donde $r$ es el radio de la órbita y $k$ es una constante positiva que depende del planeta.

Dos satélites, P y Q, orbitan el mismo planeta. El radio de la órbita de Q es $9$ veces el radio de la órbita de P.

¿Cuántas veces es el período de Q respecto del período de P?', '[{"id":"A","content":"$9$"},{"id":"B","content":"$27$"},{"id":"C","content":"$81$"},{"id":"D","content":"$729$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Si el radio de P es $r$, el de Q es $9r$.
$\dfrac{T_Q}{T_P}=\dfrac{k\sqrt{(9r)^{3}}}{k\sqrt{r^{3}}}=\sqrt{9^{3}}=\left(\sqrt{9}\right)^{3}=27$.
A supone que el período es directamente proporcional al radio.
C eleva $9$ al cuadrado y D olvida extraer la raíz cuadrada de $9^{3}$.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '20a29f45-f7bd-59e9-a824-4d48acd15800', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'potencias-y-raices'
  on conflict do nothing;
-- m2-numeros-120
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4a3f08dc-83f7-5b48-b047-4a73595fb5cd', 'm2-numeros-120', 'En Chile, el precio que paga un consumidor incluye el IVA, que corresponde al $19\%$ del valor neto del producto. La boleta por la compra de un hervidor eléctrico indica un total de $59\,500$ pesos, con el IVA incluido.

¿A cuánto corresponde el IVA pagado en esa compra?', '[{"id":"A","content":"$9\\,500$ pesos"},{"id":"B","content":"$11\\,305$ pesos"},{"id":"C","content":"$48\\,195$ pesos"},{"id":"D","content":"$50\\,000$ pesos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'easy'::difficulty_level, 'El total equivale al $119\%$ del valor neto: $1{,}19\cdot N=59\,500$, de donde $N=50\,000$ pesos.
El IVA es $59\,500-50\,000=9\,500$ pesos (o bien $0{,}19\cdot50\,000$).
B calcula el $19\%$ del total, que ya incluye el impuesto.
C resta ese valor erróneo al total, y D es el valor neto, no el IVA.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4a3f08dc-83f7-5b48-b047-4a73595fb5cd', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-121
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('048d941b-15e6-5c32-9437-fa5f7e65a11c', 'm2-numeros-121', 'En una juguera se mezclan $x$ litros de un néctar que contiene $30\%$ de pulpa de fruta con $y$ litros de otro néctar que contiene $50\%$ de pulpa de fruta, con $x>0$ e $y>0$.

¿Cuál de las siguientes expresiones representa el porcentaje de pulpa de fruta de la mezcla?', '[{"id":"A","content":"$40\\%$"},{"id":"B","content":"$\\dfrac{80}{x+y}\\%$"},{"id":"C","content":"$\\dfrac{30x+50y}{100(x+y)}\\%$"},{"id":"D","content":"$\\dfrac{30x+50y}{x+y}\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'La mezcla tiene $0{,}3x+0{,}5y$ litros de pulpa en un total de $x+y$ litros.
El porcentaje es $\dfrac{0{,}3x+0{,}5y}{x+y}\cdot100=\dfrac{30x+50y}{x+y}\%$.
A es el promedio simple de los porcentajes, válido solo si $x=y$.
B suma los porcentajes y los divide por el volumen total.
C entrega la fracción de pulpa, pero sin multiplicar por $100$, por lo que no es un porcentaje.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '048d941b-15e6-5c32-9437-fa5f7e65a11c', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-122
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('76d5620a-976e-55df-86c3-0a830d364d6d', 'm2-numeros-122', 'En una universidad, el porcentaje de estudiantes que aprobó la asignatura de Cálculo pasó de $40\%$ en el primer semestre a $50\%$ en el segundo semestre. La cantidad de inscritos no fue la misma en ambos semestres, y cada inscrito aprobó o reprobó la asignatura.

¿Cuál de las siguientes afirmaciones se puede concluir a partir de esta información?', '[{"id":"A","content":"El porcentaje de aprobación aumentó en un $10\\%$ respecto de su valor del primer semestre."},{"id":"B","content":"El porcentaje de aprobación aumentó en un $25\\%$ respecto de su valor del primer semestre."},{"id":"C","content":"El porcentaje de reprobación disminuyó en un $10\\%$ respecto de su valor del primer semestre."},{"id":"D","content":"La cantidad de estudiantes que aprobó aumentó en un $25\\%$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'El porcentaje de aprobación subió $10$ puntos porcentuales, lo que en términos relativos es $\dfrac{50-40}{40}=0{,}25$, es decir, un aumento del $25\%$.
A confunde los puntos porcentuales con la variación porcentual.
C es falsa: la reprobación pasó de $60\%$ a $50\%$, una disminución de $\dfrac{10}{60}\approx16{,}7\%$.
D no se puede concluir, porque la cantidad de inscritos cambió: con $100$ y $60$ inscritos, los aprobados pasan de $40$ a $30$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '76d5620a-976e-55df-86c3-0a830d364d6d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'porcentaje'
  on conflict do nothing;
-- m2-numeros-123
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('de2a50e1-363d-5464-a847-7f0b023759ed', 'm2-numeros-123', 'Valentina destina $\dfrac{2}{5}$ de su sueldo mensual al arriendo y $\dfrac{1}{3}$ de lo que le queda, a alimentación.

¿Qué fracción de su sueldo le queda después de pagar estos dos gastos?', '[{"id":"A","content":"$\\dfrac{2}{15}$"},{"id":"B","content":"$\\dfrac{1}{5}$"},{"id":"C","content":"$\\dfrac{4}{15}$"},{"id":"D","content":"$\\dfrac{2}{5}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Después del arriendo le queda $1-\dfrac{2}{5}=\dfrac{3}{5}$ del sueldo.
En alimentación gasta $\dfrac{1}{3}\cdot\dfrac{3}{5}=\dfrac{1}{5}$ del sueldo, así que le queda $\dfrac{3}{5}-\dfrac{1}{5}=\dfrac{2}{5}$.
C calcula $1-\dfrac{2}{5}-\dfrac{1}{3}$, tomando el tercio sobre el sueldo completo.
B es lo que gasta en alimentación, y A calcula el tercio sobre lo gastado en arriendo.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'de2a50e1-363d-5464-a847-7f0b023759ed', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-124
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ccbaa823-0f3b-58ea-b26c-96f601788e13', 'm2-numeros-124', 'Sean $p$ un número entero impar y $q$ un número entero par.

¿Cuál de las siguientes expresiones representa siempre un número impar?', '[{"id":"A","content":"$p^{2}+q^{2}$"},{"id":"B","content":"$pq+q$"},{"id":"C","content":"$(p+q)^{2}-1$"},{"id":"D","content":"$p^{2}+pq+p$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'El cuadrado de un impar es impar y el de un par es par; así, $p^{2}+q^{2}$ es impar más par, que es impar.
En B, $pq$ es par (tiene el factor $q$) y $q$ es par, así que la suma es par.
En C, $p+q$ es impar, su cuadrado es impar y al restarle $1$ queda un par.
En D, $p^{2}$ es impar, $pq$ es par y $p$ es impar: impar más par más impar es par.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ccbaa823-0f3b-58ea-b26c-96f601788e13', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-numeros-125
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('da1abdde-cd08-5741-9546-92b8cfdf37d4', 'm2-numeros-125', 'Un estanque de agua de una parcela en Pirque está lleno hasta los $\dfrac{3}{8}$ de su capacidad. Se usa $\dfrac{1}{3}$ del agua que contiene para regar y, después, se le agregan $150$ litros, con lo que el estanque queda lleno hasta los $\dfrac{3}{4}$ de su capacidad.

¿Cuál es la capacidad del estanque?', '[{"id":"A","content":"$200$ litros"},{"id":"B","content":"$240$ litros"},{"id":"C","content":"$300$ litros"},{"id":"D","content":"$400$ litros"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Tras regar queda $\dfrac{2}{3}\cdot\dfrac{3}{8}=\dfrac{1}{4}$ de la capacidad $C$.
Entonces $\dfrac{1}{4}C+150=\dfrac{3}{4}C$, es decir, $\dfrac{1}{2}C=150$ y $C=300$ litros.
D ignora el riego: $\dfrac{3}{4}-\dfrac{3}{8}=\dfrac{3}{8}$ y $C=400$.
B toma como agua restante el tercio usado ($\dfrac{1}{8}$): $\dfrac{3}{4}-\dfrac{1}{8}=\dfrac{5}{8}$ y $C=240$.
A plantea $150=\dfrac{3}{4}C$, como si el estanque hubiera estado vacío.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'da1abdde-cd08-5741-9546-92b8cfdf37d4', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'numeros' and e.subject = 'm2' and t.slug = 'enteros-y-racionales'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-001
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('9ad50acc-0268-55aa-addb-5e171dea6835', 'm2-probabilidad-y-estadistica-001', 'En un taller de lectura se registró la cantidad de páginas que leyó cada participante durante una semana, y la varianza de esos datos fue $16$ páginas al cuadrado. A la semana siguiente, cada participante leyó exactamente el triple de páginas que la semana anterior.

¿Cuál es la desviación estándar de la cantidad de páginas leídas en la segunda semana?', '[{"id":"A","content":"$4$ páginas"},{"id":"B","content":"$7$ páginas"},{"id":"C","content":"$12$ páginas"},{"id":"D","content":"$48$ páginas"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'La desviación estándar de la primera semana es $\sqrt{16} = 4$ páginas.
Al multiplicar cada dato por $3$, la desviación estándar también se multiplica por $3$: $3 \cdot 4 = 12$ páginas (la varianza se multiplica por $9$).
A supone que la dispersión no cambia, B suma $3$ en vez de multiplicar y D multiplica la varianza por $3$ y la entrega como desviación estándar.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '9ad50acc-0268-55aa-addb-5e171dea6835', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-dispersion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-002
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f4bc7bcb-30c0-5ca2-999b-4dbb29577827', 'm2-probabilidad-y-estadistica-002', 'La cantidad de goles que anotaron en la temporada las $9$ delanteras de un club de hockey de Viña del Mar tiene media aritmética $12$ y varianza $20$, donde la varianza se calcula como el promedio de los cuadrados de las desviaciones respecto de la media.

Se incorpora al registro una décima delantera, que anotó exactamente $12$ goles. ¿Cuál de las siguientes afirmaciones es verdadera respecto de los $10$ datos?', '[{"id":"A","content":"La media se mantiene en $12$ y la varianza disminuye a $18$."},{"id":"B","content":"La media se mantiene en $12$ y la varianza se mantiene en $20$."},{"id":"C","content":"La media se mantiene en $12$ y la varianza aumenta, porque hay más datos."},{"id":"D","content":"La media disminuye a $10{,}8$ y la varianza disminuye a $18$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La suma de los $9$ datos es $9 \cdot 12 = 108$; con el nuevo dato es $120$ y la media sigue siendo $\frac{120}{10} = 12$.
La suma de los cuadrados de las desviaciones era $9 \cdot 20 = 180$, y el nuevo dato aporta $(12 - 12)^2 = 0$. La nueva varianza es $\frac{180}{10} = 18$.
B olvida que se divide por más datos, C supone que más datos implican más dispersión y D calcula la media sin sumar el nuevo dato ($\frac{108}{10}$).', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f4bc7bcb-30c0-5ca2-999b-4dbb29577827', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-dispersion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-003
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('98cd4dc8-d9cd-5949-9d74-9d7001f4a534', 'm2-probabilidad-y-estadistica-003', 'Considera el conjunto de cuatro datos $2$, $5$, $8$ y $x$, con $x$ un número real.

Se puede determinar la desviación estándar del conjunto, si se sabe que:

(1) La media aritmética del conjunto es $5$.
(2) La mediana del conjunto es igual a $x$.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Con (1): $2 + 5 + 8 + x = 20$, así que $x = 5$ y el conjunto queda determinado; su desviación estándar se puede calcular. Basta.
Con (2): si $x \leq 2$ la mediana es $3{,}5$; si $x \geq 8$ es $6{,}5$; en ninguno de esos casos coincide con $x$. Si $2 \leq x \leq 8$, la mediana es $\frac{x + 5}{2}$, e igualarla a $x$ da $x = 5$. Así, $x = 5$ y también basta.
Cada afirmación por sí sola es suficiente (ambas llevan al conjunto $2, 5, 5, 8$).', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '98cd4dc8-d9cd-5949-9d74-9d7001f4a534', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-dispersion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-004
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('ec258891-2c08-59c8-8e60-fea5f1077f6b', 'm2-probabilidad-y-estadistica-004', 'En un liceo de Valparaíso se encuestó a los estudiantes de tercero y cuarto medio sobre la forma en que llegan al establecimiento. Cada estudiante marcó una sola opción y los resultados se muestran en la tabla:

$\displaystyle \begin{array}{|c|c|c|c|}\hline & \text{Bus} & \text{A pie} & \text{Total} \\ \hline \text{Tercero medio} & 36 & 24 & 60 \\ \hline \text{Cuarto medio} & 30 & 50 & 80 \\ \hline \text{Total} & 66 & 74 & 140 \\ \hline \end{array}$

Se elige al azar a uno de los estudiantes encuestados. Si se sabe que es de cuarto medio, ¿cuál es la probabilidad de que llegue en bus?', '[{"id":"A","content":"$\\frac{3}{14}$"},{"id":"B","content":"$\\frac{3}{8}$"},{"id":"C","content":"$\\frac{5}{11}$"},{"id":"D","content":"$\\frac{33}{70}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'easy'::difficulty_level, 'La condición restringe el espacio a los $80$ estudiantes de cuarto medio, de los cuales $30$ llegan en bus: $P = \frac{30}{80} = \frac{3}{8}$.
A es $\frac{30}{140}$, la probabilidad de ser de cuarto y llegar en bus (intersección). C es $\frac{30}{66}$, la condicional invertida (ser de cuarto dado que llega en bus). D es $\frac{66}{140}$, la probabilidad de llegar en bus sin condición.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'ec258891-2c08-59c8-8e60-fea5f1077f6b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'probabilidad-condicional'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-005
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e193bcb2-25a6-568f-9bea-69c0eead298d', 'm2-probabilidad-y-estadistica-005', 'En una fábrica de envases de Rancagua, tres máquinas producen todos los envases: la máquina M1 produce el $50\%$, la M2 el $30\%$ y la M3 el $20\%$. Se sabe que salen defectuosos el $4\%$ de los envases de M1, el $5\%$ de los de M2 y el $9\%$ de los de M3.

Si se elige al azar un envase de la producción total, ¿cuál es la probabilidad de que sea defectuoso?', '[{"id":"A","content":"$0{,}018\\%$"},{"id":"B","content":"$5{,}3\\%$"},{"id":"C","content":"$6\\%$"},{"id":"D","content":"$18\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Por probabilidad total: $P(D) = 0{,}5 \cdot 0{,}04 + 0{,}3 \cdot 0{,}05 + 0{,}2 \cdot 0{,}09 = 0{,}02 + 0{,}015 + 0{,}018 = 0{,}053$, es decir, $5{,}3\%$.
A multiplica los tres porcentajes de defectos, C es su promedio simple (no pondera por la producción de cada máquina) y D es su suma.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e193bcb2-25a6-568f-9bea-69c0eead298d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'probabilidad-condicional'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-006
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e38f2e4d-c701-5222-aea5-29b42bcfa48b', 'm2-probabilidad-y-estadistica-006', 'En un huerto de paltos de Quillota, el $10\%$ de los árboles tiene cierta plaga. Un test rápido da resultado positivo en el $90\%$ de los árboles que tienen la plaga y, por error, también en el $5\%$ de los árboles que no la tienen.

Se elige un árbol al azar, se le aplica el test y el resultado es positivo. Considerando que $P(A \mid B) = \frac{P(A \cap B)}{P(B)}$, ¿cuál es la probabilidad de que el árbol tenga la plaga?', '[{"id":"A","content":"$\\frac{9}{100}$"},{"id":"B","content":"$\\frac{27}{200}$"},{"id":"C","content":"$\\frac{2}{3}$"},{"id":"D","content":"$\\frac{9}{10}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, '$P(\text{plaga} \cap +) = 0{,}1 \cdot 0{,}9 = 0{,}09$ y $P(\text{sana} \cap +) = 0{,}9 \cdot 0{,}05 = 0{,}045$, así que $P(+) = 0{,}135$.
Entonces $P(\text{plaga} \mid +) = \frac{0{,}09}{0{,}135} = \frac{2}{3}$.
A es la intersección (no divide por $P(+)$), B es $P(+)$ y D es $P(+ \mid \text{plaga})$, la condicional en el sentido inverso.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e38f2e4d-c701-5222-aea5-29b42bcfa48b', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'probabilidad-condicional'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-007
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f55f38d7-eafc-56d4-83b6-0c69109a4525', 'm2-probabilidad-y-estadistica-007', 'Se elige al azar a una persona que asistió a un concierto en Santiago. Sean $A$ el suceso «la persona tiene menos de $25$ años» y $B$ el suceso «la persona llegó en metro».

Se puede determinar $P(B \mid A)$, si se sabe que:

(1) $P(A) = 0{,}5$.
(2) $P(B) = 0{,}3$.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'E', 'medium'::difficulty_level, '$P(B \mid A) = \frac{P(A \cap B)}{P(A)}$, así que se necesita $P(A \cap B)$.
Con (1) solo se conoce el denominador, y (2) no informa sobre la intersección.
Juntas tampoco basta: si $P(A \cap B) = 0{,}1$, entonces $P(B \mid A) = 0{,}2$; si $P(A \cap B) = 0{,}2$, entonces $P(B \mid A) = 0{,}4$, y ambos casos son compatibles con $P(A) = 0{,}5$ y $P(B) = 0{,}3$.
No se sabe si los sucesos son independientes, así que se requiere información adicional.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f55f38d7-eafc-56d4-83b6-0c69109a4525', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'probabilidad-condicional'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-008
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('172abe4c-dada-590a-97ea-fcb3bd5cefc8', 'm2-probabilidad-y-estadistica-008', 'El club de ajedrez de un colegio de Antofagasta tiene $8$ integrantes y debe elegir entre ellos a un presidente, un secretario y un tesorero. Ninguna persona puede ocupar más de un cargo.

¿De cuántas maneras distintas se puede formar la directiva?', '[{"id":"A","content":"$24$"},{"id":"B","content":"$56$"},{"id":"C","content":"$336$"},{"id":"D","content":"$512$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'Los cargos son distintos, así que importa el orden: hay $8$ opciones para presidente, $7$ para secretario y $6$ para tesorero, es decir, $8 \cdot 7 \cdot 6 = 336$.
A es $3!$ (solo ordena los cargos), B es $\binom{8}{3}$ (ignora que los cargos son distintos) y D es $8^3$ (permite que una persona ocupe varios cargos).', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '172abe4c-dada-590a-97ea-fcb3bd5cefc8', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'permutacion-combinatoria'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-009
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('d831eeee-0a26-56a3-96f9-fa6f9cdea4bd', 'm2-probabilidad-y-estadistica-009', 'Un equipo de debate de una universidad de Talca está formado por $6$ mujeres y $5$ hombres. Se debe escoger una delegación de $4$ integrantes que tenga exactamente $2$ mujeres.

¿Cuál de las siguientes expresiones representa la cantidad de delegaciones distintas que se pueden formar?', '[{"id":"A","content":"$\\binom{6}{2} + \\binom{5}{2}$"},{"id":"B","content":"$\\binom{6}{2} \\cdot \\binom{5}{2}$"},{"id":"C","content":"$\\binom{11}{4}$"},{"id":"D","content":"$\\binom{11}{2} \\cdot \\binom{9}{2}$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Se eligen $2$ de las $6$ mujeres, $\binom{6}{2} = 15$ formas, y $2$ de los $5$ hombres, $\binom{5}{2} = 10$ formas. Por el principio multiplicativo hay $15 \cdot 10 = 150$ delegaciones.
A suma en vez de multiplicar ($25$), C cuenta todas las delegaciones de $4$ sin la condición ($330$) y D elige dos parejas cualesquiera del grupo y además cuenta cada delegación varias veces.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'd831eeee-0a26-56a3-96f9-fa6f9cdea4bd', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'permutacion-combinatoria'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-010
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('19e5475c-3006-5732-8ee4-289543cdf4ab', 'm2-probabilidad-y-estadistica-010', 'Seis amigos, entre ellos Antonia y Benjamín, compraron entradas para seis asientos contiguos de una misma fila de un cine. Antonia y Benjamín discutieron y no quieren sentarse uno al lado del otro.

¿De cuántas maneras distintas pueden ubicarse los seis amigos en esos asientos?', '[{"id":"A","content":"$120$"},{"id":"B","content":"$240$"},{"id":"C","content":"$360$"},{"id":"D","content":"$480$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'hard'::difficulty_level, 'Sin restricciones hay $6! = 720$ ordenamientos.
Para contar los casos en que quedan juntos, se los trata como un bloque: $5!$ ordenamientos del bloque con los otros cuatro, por $2$ órdenes dentro del bloque, es decir, $2 \cdot 120 = 240$.
Los casos pedidos son $720 - 240 = 480$.
A es $5!$ (bloque sin considerar su orden interno), B son los casos en que sí quedan juntos y C supone que exactamente la mitad de los casos cumple la condición.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '19e5475c-3006-5732-8ee4-289543cdf4ab', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'permutacion-combinatoria'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-011
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('943c959a-09b8-5cce-9642-5b6651f6d5e3', 'm2-probabilidad-y-estadistica-011', 'Una basquetbolista convierte cada lanzamiento libre con probabilidad $0{,}8$, de manera independiente entre un lanzamiento y otro. En un partido realiza $3$ lanzamientos libres.

Si la probabilidad de convertir exactamente $k$ de $n$ lanzamientos es $\binom{n}{k} p^k (1 - p)^{n - k}$, ¿cuál es la probabilidad de que convierta al menos $2$ de los $3$ lanzamientos?', '[{"id":"A","content":"$0{,}384$"},{"id":"B","content":"$0{,}512$"},{"id":"C","content":"$0{,}640$"},{"id":"D","content":"$0{,}896$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Al menos $2$ significa exactamente $2$ o exactamente $3$.
$P(X = 2) = \binom{3}{2} \cdot 0{,}8^2 \cdot 0{,}2 = 3 \cdot 0{,}64 \cdot 0{,}2 = 0{,}384$ y $P(X = 3) = 0{,}8^3 = 0{,}512$.
La suma es $0{,}384 + 0{,}512 = 0{,}896$.
A considera solo exactamente $2$, B solo exactamente $3$ y C es $0{,}8^2$, la probabilidad de convertir dos lanzamientos determinados.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '943c959a-09b8-5cce-9642-5b6651f6d5e3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'modelos-probabilisticos'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-012
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f92438e2-6a08-53e5-94ab-2cf6c4ee978a', 'm2-probabilidad-y-estadistica-012', 'La estatura de los estudiantes de un preuniversitario sigue una distribución normal con media $165$ cm y desviación estándar $8$ cm.

Considera que, si $Z$ tiene distribución normal estándar, entonces $P(Z \leq 1) = 0{,}841$ y $P(Z \leq 1{,}5) = 0{,}933$.

Si se elige un estudiante al azar, ¿cuál es la probabilidad de que mida menos de $157$ cm o más de $177$ cm?', '[{"id":"A","content":"$0{,}226$"},{"id":"B","content":"$0{,}341$"},{"id":"C","content":"$0{,}774$"},{"id":"D","content":"$0{,}908$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'hard'::difficulty_level, 'Al estandarizar: $157$ cm corresponde a $z = \frac{157 - 165}{8} = -1$ y $177$ cm a $z = \frac{177 - 165}{8} = 1{,}5$.
$P(Z < -1) = 1 - 0{,}841 = 0{,}159$ (por simetría) y $P(Z > 1{,}5) = 1 - 0{,}933 = 0{,}067$.
La probabilidad pedida es $0{,}159 + 0{,}067 = 0{,}226$.
B es $0{,}841 - 0{,}5$, C es la probabilidad de estar entre ambas estaturas (el complemento) y D es $1 - (0{,}933 - 0{,}841)$, que resta mal las áreas.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f92438e2-6a08-53e5-94ab-2cf6c4ee978a', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'modelos-probabilisticos'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-013
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f0d22f45-6fa2-5087-b33e-0d5a19b444fc', 'm2-probabilidad-y-estadistica-013', 'En un vivero se siembra un lote de $n$ semillas y cada una germina con probabilidad $p$, de forma independiente. La cantidad $X$ de semillas que germinan tiene distribución binomial, con esperanza $np$ y varianza $np(1 - p)$.

Se puede determinar el valor de $p$, si se sabe que:

(1) $n = 10$.
(2) La esperanza de $X$ es $3$ y su varianza es $2{,}1$.', '[{"id":"A","content":"(1) por sí sola"},{"id":"B","content":"(2) por sí sola"},{"id":"C","content":"Ambas juntas, (1) y (2)"},{"id":"D","content":"Cada una por sí sola, (1) ó (2)"},{"id":"E","content":"Se requiere información adicional"},{"id":"F","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'Con (1): conocer $n$ no dice nada sobre $p$; por ejemplo, $p = 0{,}3$ y $p = 0{,}5$ son posibles con $n = 10$. No basta.
Con (2): dividiendo la varianza por la esperanza, $1 - p = \frac{2{,}1}{3} = 0{,}7$, así que $p = 0{,}3$ (y $n = 10$). Basta.
Por lo tanto, (2) por sí sola es suficiente.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f0d22f45-6fa2-5087-b33e-0d5a19b444fc', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'modelos-probabilisticos'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-101
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('b79152c5-49e8-5714-b7bb-2db13adde0b6', 'm2-probabilidad-y-estadistica-101', 'En un juego de mesa se lanzan dos dados comunes y se multiplican los números obtenidos. Un jugador avanza solo si ese producto es un número par.

¿Cuál es la probabilidad de que el jugador avance en un lanzamiento?', '[{"id":"A","content":"$\\frac{1}{4}$"},{"id":"B","content":"$\\frac{1}{2}$"},{"id":"C","content":"$\\frac{3}{4}$"},{"id":"D","content":"$1$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El producto es impar solo si ambos dados muestran un número impar, lo que ocurre con probabilidad $\frac{1}{2} \cdot \frac{1}{2} = \frac{1}{4}$.
Por complemento, la probabilidad de que el producto sea par es $1 - \frac{1}{4} = \frac{3}{4}$ (son $27$ de los $36$ resultados).
A es la probabilidad del complemento, B supone que basta mirar un solo dado y D suma las probabilidades de que cada dado sea par sin restar el caso en que ambos lo son.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'b79152c5-49e8-5714-b7bb-2db13adde0b6', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-102
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('4dd49753-c55d-535a-82af-b2621bd3d5ef', 'm2-probabilidad-y-estadistica-102', 'Martina y Joaquín intentan, por separado y de manera independiente, resolver el desafío semanal de un club de matemática de Talca. La probabilidad de que Martina lo resuelva es $0{,}7$ y la de que Joaquín lo resuelva es $0{,}4$.

¿Cuál es la probabilidad de que exactamente uno de los dos resuelva el desafío?', '[{"id":"A","content":"$0{,}18$"},{"id":"B","content":"$0{,}28$"},{"id":"C","content":"$0{,}54$"},{"id":"D","content":"$0{,}82$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'medium'::difficulty_level, 'Hay dos casos disjuntos: solo Martina lo resuelve, con probabilidad $0{,}7 \cdot 0{,}6 = 0{,}42$, o solo Joaquín, con probabilidad $0{,}3 \cdot 0{,}4 = 0{,}12$.
La probabilidad pedida es $0{,}42 + 0{,}12 = 0{,}54$.
A es la probabilidad de que ninguno lo resuelva, B la de que ambos lo resuelvan y D la de que al menos uno lo resuelva, que incluye el caso en que lo resuelven los dos.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '4dd49753-c55d-535a-82af-b2621bd3d5ef', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-103
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('035059d5-e25d-5d3d-9fba-459bf852dd1d', 'm2-probabilidad-y-estadistica-103', 'Una bolsa contiene solo fichas rojas y azules, todas del mismo tipo, y hay al menos una de cada color. Se agregan a la bolsa una ficha roja y una ficha azul, y luego se extrae una ficha al azar.

¿Cuál de las siguientes afirmaciones es siempre verdadera respecto de la probabilidad de extraer una ficha roja, comparada con la que había antes de agregar las fichas?', '[{"id":"A","content":"Se mantiene, porque se agregó la misma cantidad de fichas de cada color."},{"id":"B","content":"Aumenta, si inicialmente había más fichas azules que rojas."},{"id":"C","content":"Aumenta siempre, porque ahora hay más fichas rojas en la bolsa."},{"id":"D","content":"Aumenta, si inicialmente había más fichas rojas que azules."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'hard'::difficulty_level, 'Si hay $r$ rojas y $a$ azules, la probabilidad pasa de $\frac{r}{r + a}$ a $\frac{r + 1}{r + a + 2}$.
La diferencia es $\frac{r + 1}{r + a + 2} - \frac{r}{r + a} = \frac{a - r}{(r + a)(r + a + 2)}$, que es positiva exactamente cuando $a > r$; por eso B es verdadera.
A solo vale si $r = a$; C falla, por ejemplo, con $3$ rojas y $1$ azul ($\frac{3}{4}$ baja a $\frac{4}{6}$); D es lo contrario de lo que ocurre, pues con más rojas la probabilidad disminuye.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '035059d5-e25d-5d3d-9fba-459bf852dd1d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-104
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('e08d5778-621e-5c2a-bf2c-3dd8e09a47b5', 'm2-probabilidad-y-estadistica-104', 'Un preuniversitario de La Serena aplicó un ensayo de $100$ puntos a $200$ estudiantes. El resumen de cinco números de los puntajes es el siguiente: mínimo $20$, primer cuartil $35$, mediana $48$, tercer cuartil $60$ y máximo $95$.

¿Aproximadamente cuántos estudiantes obtuvieron un puntaje entre $35$ y $95$ puntos?', '[{"id":"A","content":"$50$"},{"id":"B","content":"$75$"},{"id":"C","content":"$100$"},{"id":"D","content":"$150$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'easy'::difficulty_level, 'Entre el primer cuartil ($35$) y el máximo ($95$) se encuentra aproximadamente el $75\%$ de los datos: un $25\%$ entre $Q_1$ y la mediana, otro entre la mediana y $Q_3$, y otro entre $Q_3$ y el máximo.
El $75\%$ de $200$ es $150$ estudiantes.
A considera solo un cuarto de los datos, B confunde el porcentaje con la cantidad de estudiantes y C considera solo la mitad central (entre $Q_1$ y $Q_3$).', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'e08d5778-621e-5c2a-bf2c-3dd8e09a47b5', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-105
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('2a6e561f-2772-5c54-99d6-dc4950d11d1d', 'm2-probabilidad-y-estadistica-105', 'Un liceo transforma el puntaje $P$ de una prueba en una nota $N$ mediante el modelo $N = 0{,}05P + 1$. En un curso, los puntajes tienen primer cuartil $40$ puntos, mediana $52$ puntos y tercer cuartil $70$ puntos.

¿Cuál es el rango intercuartílico de las notas de ese curso?', '[{"id":"A","content":"$1{,}5$"},{"id":"B","content":"$2{,}5$"},{"id":"C","content":"$4{,}5$"},{"id":"D","content":"$30$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Como el modelo es creciente, los cuartiles de las notas son las imágenes de los cuartiles de los puntajes: $N(40) = 3$ y $N(70) = 4{,}5$.
El rango intercuartílico es $4{,}5 - 3 = 1{,}5$; equivale a $0{,}05 \cdot (70 - 40)$, porque sumar $1$ no cambia las distancias entre datos.
B suma también el $1$ al rango, C entrega solo el tercer cuartil de las notas y D es el rango intercuartílico de los puntajes, sin transformar.', 'm2', 'modelar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '2a6e561f-2772-5c54-99d6-dc4950d11d1d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-106
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('a610b3cb-c748-56bb-984f-02392a83772e', 'm2-probabilidad-y-estadistica-106', 'Una municipalidad encuestó a $50$ hogares sobre la cantidad de mascotas que tienen. En la siguiente tabla se presenta la frecuencia acumulada de los resultados:

$\displaystyle \begin{array}{|c|c|}\hline \text{Cantidad de mascotas} & \text{Frecuencia acumulada} \\ \hline 0 & 12 \\ \hline 1 & 30 \\ \hline 2 & 42 \\ \hline 3 & 48 \\ \hline 4 & 50 \\ \hline \end{array}$

¿Qué porcentaje de los hogares encuestados tiene al menos $2$ mascotas?', '[{"id":"A","content":"$24\\%$"},{"id":"B","content":"$40\\%$"},{"id":"C","content":"$60\\%$"},{"id":"D","content":"$84\\%$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La frecuencia acumulada en $1$ indica que $30$ hogares tienen a lo más $1$ mascota, así que $50 - 30 = 20$ hogares tienen al menos $2$.
El porcentaje es $\frac{20}{50} \cdot 100 = 40\%$.
A corresponde a los hogares con exactamente $2$ mascotas ($42 - 30 = 12$), C a los que tienen a lo más $1$ y D lee directamente la frecuencia acumulada de $2$ ($42$ de $50$), es decir, los hogares con a lo más $2$ mascotas.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'a610b3cb-c748-56bb-984f-02392a83772e', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-107
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('995962b2-c06f-5597-9da3-507c7df73b43', 'm2-probabilidad-y-estadistica-107', 'En un curso se preguntó a los estudiantes cuántos libros leyeron durante las vacaciones de invierno. Los resultados se presentan en la siguiente tabla, donde $k$ es un número natural:

$\displaystyle \begin{array}{|c|c|}\hline \text{Libros leídos} & \text{Cantidad de estudiantes} \\ \hline 0 & 2 \\ \hline 1 & 4 \\ \hline 2 & k \\ \hline 3 & 8 \\ \hline 4 & 6 \\ \hline \end{array}$

Si el promedio de libros leídos por estudiante es $2{,}4$, ¿cuál es la mediana de la cantidad de libros leídos?', '[{"id":"A","content":"$2$"},{"id":"B","content":"$2{,}4$"},{"id":"C","content":"$2{,}5$"},{"id":"D","content":"$3$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'La suma de libros es $0 \cdot 2 + 1 \cdot 4 + 2k + 3 \cdot 8 + 4 \cdot 6 = 52 + 2k$ y hay $20 + k$ estudiantes. De $\frac{52 + 2k}{20 + k} = 2{,}4$ se obtiene $52 + 2k = 48 + 2{,}4k$, es decir, $k = 10$.
Con $30$ estudiantes, la mediana es el promedio de los datos en las posiciones $15$ y $16$. Las frecuencias acumuladas son $2$, $6$, $16$, $24$ y $30$, así que ambos datos valen $2$ y la mediana es $2$.
B confunde la mediana con el promedio, C promedia $2$ y $3$, como si los datos centrales quedaran en filas distintas y D calcula la mediana de los $20$ estudiantes sin considerar a los $k$ que leyeron $2$ libros.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '995962b2-c06f-5597-9da3-507c7df73b43', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-108
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('f66addf2-8e92-5c08-a509-8e4708701e1f', 'm2-probabilidad-y-estadistica-108', 'En un colegio de Puerto Varas se encuestó a todos los estudiantes de enseñanza media. El $60\%$ practica algún deporte, el $45\%$ toca algún instrumento musical y el $20\%$ no realiza ninguna de esas dos actividades.

Si se elige al azar a uno de estos estudiantes, ¿cuál es la probabilidad de que practique algún deporte pero no toque ningún instrumento?', '[{"id":"A","content":"$0{,}25$"},{"id":"B","content":"$0{,}35$"},{"id":"C","content":"$0{,}40$"},{"id":"D","content":"$0{,}55$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'B', 'medium'::difficulty_level, 'La probabilidad de realizar al menos una actividad es $1 - 0{,}2 = 0{,}8$. Por la regla de la unión, $0{,}8 = 0{,}6 + 0{,}45 - P(D \cap M)$, de donde $P(D \cap M) = 0{,}25$.
Entonces la probabilidad de practicar deporte sin tocar un instrumento es $0{,}6 - 0{,}25 = 0{,}35$.
A es la probabilidad de realizar ambas actividades, C resta a $0{,}6$ el $20\%$ que no realiza ninguna y D es la probabilidad de realizar exactamente una de las dos actividades.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'f66addf2-8e92-5c08-a509-8e4708701e1f', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-109
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('deb4f769-706a-5849-9fe6-f3464ad904d3', 'm2-probabilidad-y-estadistica-109', 'En una feria costumbrista de Chillán se elige al azar a un visitante. Sean $A$ el suceso «el visitante vive en Concepción» y $B$ el suceso «el visitante vive en Talca». Se sabe que $P(A) = p$ y $P(B) = q$, con $p > 0$ y $q > 0$, y que cada visitante vive en una sola ciudad.

¿Cuál de las siguientes afirmaciones es siempre verdadera?', '[{"id":"A","content":"$P(A \\cup B) = p + q - pq$"},{"id":"B","content":"Los sucesos $A$ y $B$ son independientes."},{"id":"C","content":"La probabilidad de que el visitante no viva en Concepción ni en Talca es $1 - p - q$."},{"id":"D","content":"La suma $p + q$ puede ser mayor que $1$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'hard'::difficulty_level, 'Como nadie vive en dos ciudades, $A$ y $B$ son mutuamente excluyentes: $P(A \cap B) = 0$ y $P(A \cup B) = p + q$.
Luego, la probabilidad de no vivir en ninguna de las dos es $1 - P(A \cup B) = 1 - p - q$, así que C es verdadera.
A usa la fórmula de la unión para sucesos independientes, B es falsa porque $P(A \cap B) = 0 \neq pq$ cuando $p, q > 0$ y D es falsa porque $p + q = P(A \cup B) \leq 1$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select 'deb4f769-706a-5849-9fe6-f3464ad904d3', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'reglas-probabilidades'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-110
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('186c5391-4d94-55e9-99b7-c2c820d50b0d', 'm2-probabilidad-y-estadistica-110', 'En un CESFAM de Iquique se registró el tiempo de espera, en minutos, de $8$ pacientes. Los datos, ordenados de menor a mayor, son:

$4$, $7$, $9$, $x$, $15$, $18$, $20$, $25$

Se sabe que la mediana de los datos es $13$ minutos. Considera que el primer cuartil es la mediana de los cuatro datos menores y que el tercer cuartil es la mediana de los cuatro datos mayores.

¿Cuál es el rango intercuartílico de los tiempos de espera?', '[{"id":"A","content":"$5$ minutos"},{"id":"B","content":"$9$ minutos"},{"id":"C","content":"$10$ minutos"},{"id":"D","content":"$11$ minutos"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'D', 'medium'::difficulty_level, 'Con $8$ datos, la mediana es el promedio del cuarto y el quinto dato: $\frac{x + 15}{2} = 13$, de donde $x = 11$.
El primer cuartil es $\frac{7 + 9}{2} = 8$ y el tercer cuartil es $\frac{18 + 20}{2} = 19$, así que el rango intercuartílico es $19 - 8 = 11$ minutos.
A calcula la diferencia entre la mediana y el primer cuartil, B usa el tercer y el sexto dato ($9$ y $18$) como cuartiles y C toma $18$ como tercer cuartil sin promediar.', 'm2', 'resolver_problemas', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '186c5391-4d94-55e9-99b7-c2c820d50b0d', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-111
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('11cd7606-b4ca-5bf8-94de-2b4edd931e11', 'm2-probabilidad-y-estadistica-111', 'Dos cursos de un liceo de Coquimbo rindieron un test de comprensión lectora con puntaje de $0$ a $15$. El resumen de cinco números de cada curso es el siguiente:

Curso A: mínimo $2$, primer cuartil $5$, mediana $8$, tercer cuartil $10$ y máximo $14$.
Curso B: mínimo $1$, primer cuartil $6$, mediana $7$, tercer cuartil $12$ y máximo $13$.

¿Cuál de las siguientes afirmaciones se puede deducir de esta información?', '[{"id":"A","content":"La mediana del curso B es mayor que la del curso A."},{"id":"B","content":"El rango de los puntajes del curso A es mayor que el del curso B."},{"id":"C","content":"El rango intercuartílico del curso B es mayor que el del curso A."},{"id":"D","content":"En el curso A, al menos la cuarta parte de los puntajes es mayor que $12$."},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'C', 'easy'::difficulty_level, 'El rango intercuartílico del curso A es $10 - 5 = 5$ y el del curso B es $12 - 6 = 6$, así que C se deduce.
A es falsa porque la mediana de B ($7$) es menor que la de A ($8$). B es falsa porque ambos rangos valen $14 - 2 = 13 - 1 = 12$.
D no se puede deducir: el tercer cuartil de A es $10$, por lo que solo se sabe que al menos la cuarta parte de los puntajes es mayor o igual que $10$; puede haber un solo puntaje sobre $12$.', 'm2', 'argumentar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '11cd7606-b4ca-5bf8-94de-2b4edd931e11', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'medidas-de-posicion'
  on conflict do nothing;
-- m2-probabilidad-y-estadistica-112
insert into public.questions (id, external_key, content, alternatives, correct_answer, difficulty, explanation, subject, habilidad, is_active) values ('8bd60510-55ce-5bb0-9642-47f4e04eed06', 'm2-probabilidad-y-estadistica-112', 'Se preguntó a $40$ estudiantes de un preuniversitario de Arica cuántas horas durmieron la noche anterior a un ensayo. En la siguiente tabla se muestran las frecuencias relativas de las respuestas, donde $a$ es un número real:

$\displaystyle \begin{array}{|c|c|}\hline \text{Horas de sueño} & \text{Frecuencia relativa} \\ \hline 5 & 0{,}1 \\ \hline 6 & a \\ \hline 7 & 0{,}3 \\ \hline 8 & 2a \\ \hline \end{array}$

¿Cuántos estudiantes durmieron menos de $7$ horas?', '[{"id":"A","content":"$12$"},{"id":"B","content":"$16$"},{"id":"C","content":"$20$"},{"id":"D","content":"$28$"},{"id":"E","content":"No sé responder esta pregunta"}]'::jsonb, 'A', 'medium'::difficulty_level, 'Las frecuencias relativas suman $1$: $0{,}1 + a + 0{,}3 + 2a = 1$, de donde $3a = 0{,}6$ y $a = 0{,}2$.
Durmieron menos de $7$ horas quienes durmieron $5$ o $6$ horas: $0{,}1 + 0{,}2 = 0{,}3$, es decir, $0{,}3 \cdot 40 = 12$ estudiantes.
B resuelve $0{,}4 + 2a = 1$ tratando $a + 2a$ como $2a$ (obtiene $a = 0{,}3$), C suma las categorías de $6$ y $7$ horas y D cuenta a quienes durmieron $7$ horas o más.', 'm2', 'representar', true)
  on conflict (id) do update set content = excluded.content, alternatives = excluded.alternatives, correct_answer = excluded.correct_answer, difficulty = excluded.difficulty, explanation = excluded.explanation, subject = excluded.subject, habilidad = excluded.habilidad, external_key = excluded.external_key;
insert into public.question_topics (question_id, topic_id)
  select '8bd60510-55ce-5bb0-9642-47f4e04eed06', t.id from public.topics t join public.ejes e on e.id = t.eje_id
  where e.slug = 'probabilidad-y-estadistica' and e.subject = 'm2' and t.slug = 'tablas-y-graficos'
  on conflict do nothing;

commit;
