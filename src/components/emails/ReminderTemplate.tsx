import React from 'react';

interface ReminderTemplateProps {
    userName: string;
    actionUrl: string;
    customMessage?: string;
}

export const ReminderTemplate: React.FC<ReminderTemplateProps> = ({
    userName,
    actionUrl,
    customMessage
}) => (
    <div style={{ fontFamily: 'sans-serif', maxWidth: '600px', margin: '0 auto', padding: '20px', color: '#1e293b' }}>
        <div style={{ textAlign: 'center', marginBottom: '30px' }}>
            <h1 style={{ color: '#2563eb', fontSize: '24px', fontWeight: '800' }}>PAES Lab 🚀</h1>
        </div>

        <h2 style={{ fontSize: '20px', marginBottom: '20px' }}>¡No pierdas el ritmo, {userName}! 🔥</h2>

        {customMessage ? (
            <div style={{ lineHeight: '1.6', marginBottom: '15px', whiteSpace: 'pre-wrap' }}>
                {customMessage}
            </div>
        ) : (
            <>
                <p style={{ lineHeight: '1.6', marginBottom: '15px' }}>
                    La constancia es la clave para un puntaje nacional. Notamos que hace unos días no entras a practicar y tu racha podría estar en peligro.
                </p>

                <p style={{ lineHeight: '1.6', marginBottom: '25px' }}>
                    Recuerda que solo 10 minutos al día pueden hacer una gran diferencia en tu resultado final.
                </p>
            </>
        )}

        <div style={{ textAlign: 'center', margin: '40px 0' }}>
            <a
                href={actionUrl}
                style={{
                    backgroundColor: '#ea580c', // Orange for urgency
                    color: 'white',
                    padding: '16px 32px',
                    borderRadius: '50px',
                    textDecoration: 'none',
                    fontWeight: 'bold',
                    fontSize: '18px',
                    display: 'inline-block',
                    boxShadow: '0 4px 6px rgba(234, 88, 12, 0.2)'
                }}
            >
                Mantener mi Racha 🔥
            </a>
        </div>

        <p style={{ fontSize: '14px', color: '#64748b', textAlign: 'center', marginTop: '40px' }}>
            Tú puedes con esto.<br />
            El equipo de PAES Lab.
        </p>
    </div>
);
