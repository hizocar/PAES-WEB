import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { AuthProvider } from "@/context/auth-provider";

import { FacebookPixel } from "@/components/analytics/FacebookPixel";
import { Suspense } from "react";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  metadataBase: new URL('https://paeslab.cl'),
  title: {
    default: "PAES Lab | Entrena la PAES M1 y M2 jugando",
    template: "%s | PAES Lab"
  },
  description: "Preguntas originales tipo PAES de M1 y M2, explicación paso a paso, práctica por tema y ensayos con puntaje en escala PAES. Gratis para empezar.",
  keywords: ["PAES", "Matemáticas", "M2", "M1", "Preuniversitario", "Chile", "Ensayo PAES", "Inteligencia Artificial", "Educación"],
  authors: [{ name: "PAES Lab Team" }],
  creator: "PAES Lab",
  publisher: "PAES Lab",
  openGraph: {
    type: "website",
    locale: "es_CL",
    url: "https://paeslab.cl",
    title: "PAES Lab | Entrena la PAES jugando",
    description: "Preguntas originales tipo PAES de M1 y M2, explicación paso a paso y ensayos con puntaje PAES.",
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
    title: "PAES Lab | Entrena la PAES M1 y M2",
    description: "Preguntas originales tipo PAES, explicación paso a paso y ensayos con puntaje PAES.",
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
          <Suspense fallback={null}>
            <FacebookPixel />
          </Suspense>
          {children}
        </AuthProvider>
      </body>
    </html>
  );
}
