import { MetadataRoute } from 'next'

export default function robots(): MetadataRoute.Robots {
    return {
        rules: {
            userAgent: '*',
            allow: '/',
            disallow: '/app/', // Don't crawl private dashboard
        },
        sitemap: 'https://paeslab.cl/sitemap.xml',
    }
}
