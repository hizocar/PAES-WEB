import React from 'react';

interface StartPracticeTemplateProps {
    userName: string;
    actionUrl: string;
    customMessage?: string;
}

export const StartPracticeTemplate: React.FC<StartPracticeTemplateProps> = ({
    userName,
    actionUrl,
    customMessage
}) => (
    <div style={{ fontFamily: 'sans-serif', maxWidth: '600px', margin: '0 auto', padding: '20px', color: '#1e293b' }}>
        <div style={{ textAlign: 'center', marginBottom: '30px' }}>
            <h1 style={{ color: '#2563eb', fontSize: '24px', fontWeight: '800' }}>PAES Lab 🚀</h1>
        </div>

        <h2 style={{ fontSize: '20px', marginBottom: '20px' }}>¡Hola {userName}! 👋</h2>

        {customMessage ? (
            <div style={{ lineHeight: '1.6', marginBottom: '15px', whiteSpace: 'pre-wrap' }}>
                {customMessage}
            </div>
        ) : (
            <>
                <p style={{ lineHeight: '1.6', marginBottom: '15px' }}>
                    Vemos que ya creaste tu cuenta, pero aún no has realizado tu primer entrenamiento. ¿Sabías que la única forma de mejorar en la PAES es practicando?
                </p>

                <p style={{ lineHeight: '1.6', marginBottom: '25px' }}>
                    En PAES Lab tienes acceso a:
                </p>

                <ul style={{ paddingLeft: '20px', marginBottom: '30px', lineHeight: '1.6' }}>
                    <li>✅ Ejercicios DEMRE reales y actualizados.</li>
                    <li>✅ Detección automática de tus puntos débiles.</li>
                    <li>✅ Explicaciones detalladas paso a paso.</li>
                    <li>✅ Todo 100% Gratis.</li>
                </ul>
            </>
        )}

        <div style={{ textAlign: 'center', margin: '40px 0' }}>
            <a
                href={actionUrl}
                style={{
                    backgroundColor: '#2563eb',
                    color: 'white',
                    padding: '16px 32px',
                    borderRadius: '50px',
                    textDecoration: 'none',
                    fontWeight: 'bold',
                    fontSize: '18px',
                    display: 'inline-block',
                    boxShadow: '0 4px 6px rgba(37, 99, 235, 0.2)'
                }}
            >
                Comenzar a Practicar Ahora ⚡
            </a>
        </div>

        <p style={{ fontSize: '14px', color: '#64748b', textAlign: 'center', marginTop: '40px' }}>
            Vamos por ese puntaje nacional.<br />
            El equipo de PAES Lab.
        </p>
    </div>
);
