import { Helmet } from '@dr.pogodin/react-helmet'

// Canonical base URL. Hardcoded so we serve a single canonical regardless of
// whether the user landed on www.tradepals.net, http variants, or UTM-tagged URLs.
const SITE_URL = 'https://tradepals.net'
const SITE_NAME = 'TradePals'
const DEFAULT_OG_IMAGE = '/tradepals-logo.png' // Stopgap — replace with 1200×630 social cards in Phase 3.

export type PageMetaProps = {
  /** <title> + og:title + twitter:title. Keep under ~60 chars to avoid SERP truncation. */
  title: string
  /** Meta description + og:description + twitter:description. Aim for 140–160 chars. */
  description: string
  /** Pathname (e.g. "/splicepal" or "/about"). Used to build the canonical URL. Required. */
  path: string
  /** Absolute or root-relative URL to social share image. Defaults to TradePals logo. */
  ogImage?: string
  /** og:type — use 'article' for blog-style content, 'website' for everything else. */
  ogType?: 'website' | 'article'
  /** When true, emits robots="noindex,nofollow". Use for auth pages, account, admin. */
  noindex?: boolean
  /** Optional schema.org JSON-LD object. Stringified and injected as <script type="application/ld+json">. */
  jsonLd?: Record<string, unknown> | Record<string, unknown>[]
  /** Optional theme-color override (per-app brand). Falls back to global #0D0D0F in index.html. */
  themeColor?: string
}

/**
 * Single source of truth for per-page metadata. Render once per route, near the top of the page component.
 *
 * Crawlers see these tags whether they execute JS or not — react-helmet flushes them
 * synchronously into the DOM at first render, so Google's renderer picks them up.
 *
 * For social crawlers that DON'T run JS (LinkedIn, Twitter, Discord, FB), per-route
 * meta still only resolves correctly once we add build-time prerendering (Phase 2).
 * Until then, social shares show whatever was in the static index.html.
 */
export default function PageMeta({
  title,
  description,
  path,
  ogImage = DEFAULT_OG_IMAGE,
  ogType = 'website',
  noindex,
  jsonLd,
  themeColor,
}: PageMetaProps) {
  // Strip query and hash for a clean canonical. Always lowercase the path to dedupe.
  const cleanPath = path.split('?')[0].split('#')[0].toLowerCase()
  const normalizedPath = cleanPath.startsWith('/') ? cleanPath : `/${cleanPath}`
  const canonicalUrl = `${SITE_URL}${normalizedPath === '/' ? '' : normalizedPath}`
  const absoluteOgImage = ogImage.startsWith('http') ? ogImage : `${SITE_URL}${ogImage}`

  const jsonLdArray = jsonLd ? (Array.isArray(jsonLd) ? jsonLd : [jsonLd]) : []

  return (
    <Helmet>
      <title>{title}</title>
      <meta name="description" content={description} />
      <link rel="canonical" href={canonicalUrl} />

      {/* Open Graph */}
      <meta property="og:title" content={title} />
      <meta property="og:description" content={description} />
      <meta property="og:url" content={canonicalUrl} />
      <meta property="og:type" content={ogType} />
      <meta property="og:site_name" content={SITE_NAME} />
      <meta property="og:image" content={absoluteOgImage} />

      {/* Twitter */}
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:title" content={title} />
      <meta name="twitter:description" content={description} />
      <meta name="twitter:image" content={absoluteOgImage} />

      {/* Robots — only emit when we want to override the global default (which is index,follow) */}
      {noindex && <meta name="robots" content="noindex,nofollow" />}

      {/* Optional theme color (per-app brand) */}
      {themeColor && <meta name="theme-color" content={themeColor} />}

      {/* Structured data */}
      {jsonLdArray.map((schema, i) => (
        <script key={i} type="application/ld+json">{JSON.stringify(schema)}</script>
      ))}
    </Helmet>
  )
}
