import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/context/auth-provider";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  metadataBase: new URL('https://paeslab.cl'),
  title: {
    default: "PAES Lab | Prepara tu PAES M2 con Inteligencia Artificial",
    template: "%s | PAES Lab"
  },
  description: "La plataforma definitiva para puntajes nacionales. Práctica adaptativa, seguimiento en tiempo real y explicaciones detalladas para la PAES M2 y M1.",
  keywords: ["PAES", "Matemáticas", "M2", "M1", "Preuniversitario", "Chile", "Ensayo PAES", "Inteligencia Artificial", "Educación"],
  authors: [{ name: "PAES Lab Team" }],
  creator: "PAES Lab",
  publisher: "PAES Lab",
  openGraph: {
    type: "website",
    locale: "es_CL",
    url: "https://paeslab.cl",
    title: "PAES Lab | Domina la PAES con IA",
    description: "Entrenador inteligente para la PAES Matemáticas. Detecta tus vacíos y maximiza tu puntaje con práctica personalizada.",
    siteName: "PAES Lab",
    images: [
      {
        url: "/og-image.png",
        width: 1200,
        height: 630,
        alt: "PAES Lab Preview",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "PAES Lab | Prepara tu PAES M2",
    description: "Entrenador inteligente para la PAES Matemáticas. Maximiza tu puntaje.",
    images: ["/og-image.png"],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es">
      <body className={inter.className}>
        <AuthProvider>
          {children}
        </AuthProvider>
      </body>
    </html>
  );
}
