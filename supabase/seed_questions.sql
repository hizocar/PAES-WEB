-- Seed Script for PAES M2 Questions
-- Setup topics if they don't exist
DO $$
DECLARE
    -- Ejes IDs
    numeros_id uuid;
    algebra_id uuid;
    geometria_id uuid;
    prob_id uuid;
    
    -- Topic IDs
    t_porcentajes uuid;
    t_algebra uuid;
    t_geometria uuid;
    t_prob uuid;
    
    -- Question IDs (temp)
    q_id uuid;
BEGIN
    -- 1. Get Ejes IDs
    SELECT id INTO numeros_id FROM public.ejes WHERE slug = 'numeros';
    SELECT id INTO algebra_id FROM public.ejes WHERE slug = 'algebra-y-funciones';
    SELECT id INTO geometria_id FROM public.ejes WHERE slug = 'geometria';
    SELECT id INTO prob_id FROM public.ejes WHERE slug = 'probabilidad-y-estadistica';

    -- 2. Ensure Topics Exist
    -- Porcentajes (Números)
    INSERT INTO public.topics (eje_id, name, slug) 
    VALUES (numeros_id, 'Porcentajes', 'porcentajes')
    ON CONFLICT (id) DO NOTHING; -- simple check, assuming unique name/slug constraints usually
    SELECT id INTO t_porcentajes FROM public.topics WHERE slug = 'porcentajes';

    -- Ecuaciones Cuadráticas (Álgebra)
    INSERT INTO public.topics (eje_id, name, slug) 
    VALUES (algebra_id, 'Ecuaciones Cuadráticas', 'ecuaciones-cuadraticas')
    ON CONFLICT DO NOTHING RETURNING id INTO t_algebra;
    IF t_algebra IS NULL THEN SELECT id INTO t_algebra FROM public.topics WHERE slug = 'ecuaciones-cuadraticas'; END IF;

    -- Vectores (Geometría)
    INSERT INTO public.topics (eje_id, name, slug) 
    VALUES (geometria_id, 'Vectores', 'vectores')
    ON CONFLICT DO NOTHING RETURNING id INTO t_geometria;
    IF t_geometria IS NULL THEN SELECT id INTO t_geometria FROM public.topics WHERE slug = 'vectores'; END IF;

    -- Probabilidad Condicional (Probabilidad)
    INSERT INTO public.topics (eje_id, name, slug) 
    VALUES (prob_id, 'Probabilidad Condicional', 'probabilidad-condicional')
    ON CONFLICT DO NOTHING RETURNING id INTO t_prob;
    IF t_prob IS NULL THEN SELECT id INTO t_prob FROM public.topics WHERE slug = 'probabilidad-condicional'; END IF;

    -------------------------------------------------------
    -- TEMA 1: PORCENTAJES (NÚMEROS)
    -------------------------------------------------------
    
    -- EASY
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Si el $20\%$ de un número es $40$, ¿cuál es el número?',
        '[{"id": "A", "content": "$200$"}, {"id": "B", "content": "$80$"}, {"id": "C", "content": "$20$"}, {"id": "D", "content": "$8$"}, {"id": "E", "content": "$400$"}]',
        'A',
        'easy',
        'Planteamos la ecuación: $0.2 \cdot x = 40 \Rightarrow x = \frac{40}{0.2} = 200$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_porcentajes);

    -- MEDIUM
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Un artículo sube su precio un $10\%$ y luego baja un $10\%$ respecto al nuevo precio. En total, el precio:',
        '[{"id": "A", "content": "Se mantiene igual"}, {"id": "B", "content": "Baja un $1\\%$"}, {"id": "C", "content": "Sube un $1\\%$"}, {"id": "D", "content": "Baja un $10\\%$"}, {"id": "E", "content": "Falta información"}]',
        'B',
        'medium',
        'Si el precio inicial es $P$. Primero sube a $1.1P$. Luego baja $10\%$ de eso: $1.1P \cdot 0.9 = 0.99P$. Esto es un $99\%$ del original, o sea, bajó un $1\%$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_porcentajes);

    -- HARD
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Si $a$ es el $10\%$ de $b$, y $b$ es el $20\%$ de $c$, ¿qué porcentaje de $c$ es $a$?',
        '[{"id": "A", "content": "$2\\%$"}, {"id": "B", "content": "$20\\%$"}, {"id": "C", "content": "$30\\%$"}, {"id": "D", "content": "$200\\%$"}, {"id": "E", "content": "$0.02\\%$"}]',
        'A',
        'hard',
        'Tenemos $a = 0.1b$ y $b = 0.2c$. Reemplazando: $a = 0.1(0.2c) = 0.02c$. Al convertir a porcentaje, $0.02$ equivale al $2\%$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_porcentajes);


    -------------------------------------------------------
    -- TEMA 2: ECUACIONES CUADRÁTICAS (ÁLGEBRA)
    -------------------------------------------------------

    -- EASY
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        '¿Cuáles son las soluciones de $x^2 - 9 = 0$?',
        '[{"id": "A", "content": "$3$"}, {"id": "B", "content": "$-3$"}, {"id": "C", "content": "$3$ y $-3$"}, {"id": "D", "content": "$9$ y $-9$"}, {"id": "E", "content": "$0$"}]',
        'C',
        'easy',
        '$x^2 = 9 \Rightarrow x = \pm 3$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_algebra);

    -- MEDIUM
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Determine la suma de las soluciones de la ecuación $2x^2 - 8x + 3 = 0$.',
        '[{"id": "A", "content": "$8$"}, {"id": "B", "content": "$4$"}, {"id": "C", "content": "$-4$"}, {"id": "D", "content": "$3/2$"}, {"id": "E", "content": "$-8$"}]',
        'B',
        'medium',
        'Por propiedades de las raíces, la suma $x_1 + x_2 = -\frac{b}{a}$. Aquí $a=2, b=-8$. Suma = $-\frac{-8}{2} = 4$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_algebra);

    -- HARD
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        '¿Para qué valor de $k$ la ecuación $x^2 + kx + 9 = 0$ tiene una única solución real?',
        '[{"id": "A", "content": "$3$"}, {"id": "B", "content": "$6$"}, {"id": "C", "content": "$6$ y $-6$"}, {"id": "D", "content": "$9$"}, {"id": "E", "content": "$18$"}]',
        'C',
        'hard',
        'El discriminante $\Delta$ debe ser $0$. $\Delta = b^2 - 4ac = k^2 - 4(1)(9) = k^2 - 36 = 0 \Rightarrow k = \pm 6$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_algebra);
    
    -------------------------------------------------------
    -- TEMA 3: VECTORES (GEOMETRÍA)
    -------------------------------------------------------

    -- EASY
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Si $\vec{u} = (2,3)$ y $\vec{v} = (-1,2)$, calcule $\vec{u} + \vec{v}$.',
        '[{"id": "A", "content": "$(1,5)$"}, {"id": "B", "content": "$(3,1)$"}, {"id": "C", "content": "$(1,1)$"}, {"id": "D", "content": "$(-2,6)$"}, {"id": "E", "content": "$(2,5)$"}]',
        'A',
        'easy',
        'Sumamos componente a componente: $(2 + -1, 3 + 2) = (1, 5)$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_geometria);

    -- MEDIUM
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        '¿Cuál es el módulo del vector $\vec{w} = (-3, 4)$?',
        '[{"id": "A", "content": "$1$"}, {"id": "B", "content": "$7$"}, {"id": "C", "content": "$5$"}, {"id": "D", "content": "$\\sqrt{7}$"}, {"id": "E", "content": "$25$"}]',
        'C',
        'medium',
        'El módulo es $|\vec{w}| = \sqrt{(-3)^2 + 4^2} = \sqrt{9 + 16} = \sqrt{25} = 5$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_geometria);

    -- HARD
    INSERT INTO public.questions (content, alternatives, correct_answer, difficulty, explanation)
    VALUES (
        'Determine el valor de $m$ para que $\vec{a}=(m, 2)$ sea ortogonal a $\vec{b}=(4, -6)$.',
        '[{"id": "A", "content": "$2$"}, {"id": "B", "content": "$3$"}, {"id": "C", "content": "$-3$"}, {"id": "D", "content": "$1.5$"}, {"id": "E", "content": "$12$"}]',
        'B',
        'hard',
        'El producto punto debe ser $0$. $\vec{a} \cdot \vec{b} = 4m + (2)(-6) = 4m - 12 = 0 \Rightarrow m=3$.'
    ) RETURNING id INTO q_id;
    INSERT INTO public.question_topics (question_id, topic_id) VALUES (q_id, t_geometria);

END $$;
