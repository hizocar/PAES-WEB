import { Mascot } from "@/components/mascot/Mascot"

/**
 * Se muestra al instante al navegar entre secciones del panel, mientras llega la página.
 * Sin este archivo la pantalla anterior quedaba "congelada" hasta que respondía el servidor.
 */
export default function AppLoading() {
    return (
        <div className="flex min-h-[60vh] items-center justify-center" aria-busy="true" aria-live="polite">
            <Mascot mood="thinking" interactive={false} message={false} size={80} />
            <span className="sr-only">Cargando…</span>
        </div>
    )
}
