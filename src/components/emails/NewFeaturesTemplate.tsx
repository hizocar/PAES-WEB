import React from 'react';

interface NewFeaturesTemplateProps {
    userName: string;
    actionUrl: string;
    customMessage?: string;
}

export const NewFeaturesTemplate: React.FC<NewFeaturesTemplateProps> = ({
    userName,
    actionUrl,
    customMessage
}) => (
    <div style={{ fontFamily: 'sans-serif', maxWidth: '600px', margin: '0 auto', padding: '20px', color: '#1e293b' }}>
        <div style={{ textAlign: 'center', marginBottom: '30px' }}>
            <h1 style={{ color: '#059669', fontSize: '24px', fontWeight: '800' }}>Novedades PAES Lab ✨</h1>
        </div>

        <h2 style={{ fontSize: '20px', marginBottom: '20px' }}>¡Hola {userName}! Tenemos noticias</h2>

        {customMessage ? (
            <div style={{ lineHeight: '1.6', marginBottom: '15px', whiteSpace: 'pre-wrap' }}>
                {customMessage}
            </div>
        ) : (
            <>
                <p style={{ lineHeight: '1.6', marginBottom: '15px' }}>
                    Hemos estado trabajando duro para mejorar tu experiencia de estudio. Acabamos de lanzar nuevas funcionalidades que te ayudarán a prepararte mejor.
                </p>

                <ul style={{ paddingLeft: '20px', marginBottom: '30px', lineHeight: '1.6' }}>
                    <li>🆕 <strong>Modo Repaso:</strong> Vuelve a intentar solo los ejercicios en los que te equivocaste.</li>
                    <li>📊 <strong>Estadísticas Mejoradas:</strong> Ahora puedes ver tu progreso por eje temático con más detalle.</li>
                    <li>🚀 <strong>Interfaz Más Rápida:</strong> Optimizamos todo para que pierdas menos tiempo esperando.</li>
                </ul>
            </>
        )}

        <div style={{ textAlign: 'center', margin: '40px 0' }}>
            <a
                href={actionUrl}
                style={{
                    backgroundColor: '#059669', // Green for new/fresh
                    color: 'white',
                    padding: '16px 32px',
                    borderRadius: '50px',
                    textDecoration: 'none',
                    fontWeight: 'bold',
                    fontSize: '18px',
                    display: 'inline-block',
                    boxShadow: '0 4px 6px rgba(5, 150, 105, 0.2)'
                }}
            >
                Probar lo Nuevo ✨
            </a>
        </div>

        <p style={{ fontSize: '14px', color: '#64748b', textAlign: 'center', marginTop: '40px' }}>
            Gracias por ser parte de nuestra comunidad.<br />
            El equipo de PAES Lab.
        </p>
    </div>
);
