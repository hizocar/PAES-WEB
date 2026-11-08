-- Oferta de planes definida por el dueño (2026-11-08).
-- El tier interno sigue siendo 'premium' (suscripciones, permisos y RPCs no cambian);
-- solo cambian el nombre visible, el precio y las características.
update public.plans
set name = 'Pro',
    price_clp = 990,
    features = array['Vidas ilimitadas', 'Explicaciones ilimitadas', 'Sin anuncios para recargar vidas']
where tier = 'premium';

update public.plans
set name = 'Signature',
    price_clp = 29990,
    features = array['Todo lo de Pro', 'Clases sincrónicas en vivo', 'Clases asincrónicas en video', 'Próximamente']
where tier = 'signature';

update public.plans
set features = array['M1 y M2 completas', '10 vidas por materia', '5 explicaciones al día']
where tier = 'free';
