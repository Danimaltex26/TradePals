import { Link } from 'react-router-dom'
import { track } from '@vercel/analytics'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import PageMeta from './PageMeta'

type ScreenshotPair = {
  label: string
  beforeTitle: string
  afterTitle: string
  beforeImage?: string
  afterImage?: string
}

type StatItem = {
  value: string
  label: string
  source?: string
}

type SalaryBlock = {
  uncertifiedRange: string  // e.g. "$45K–$55K"
  certifiedRange: string    // e.g. "$65K–$85K"
  sourceLabel?: string      // e.g. "BLS Occupational Outlook Handbook, 2024"
  note?: string             // e.g. "Median pay for telecom equipment installers..."
}

type ProductPageProps = {
  app: AppKey
  description: string
  longDescription?: string
  features: string[]
  appStoreUrl?: string
  screenshots?: ScreenshotPair[]
  trainingImages?: string[]
  demoVideo?: string
  // Cert-first additions — all optional; render only when provided
  certHook?: string         // Primary hero statement leading with the cert outcome
  certSubhook?: string      // Short ROI / proof line shown in accent color below the H1
  quizUrl?: string          // Public practice quiz URL — renders a secondary hero CTA
  stats?: StatItem[]        // Stats strip band below hero (recommended: 3–4 items)
  salaryBlock?: SalaryBlock // "What [cert] is worth" comparison block
  certTrustLine?: string    // One-line cert badge text in the Training section
}

function PhoneMockup({ title, accent, children }: { title: string; accent: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl border border-[var(--color-border)] bg-[#0D0D0F] overflow-hidden w-full" style={{ maxWidth: 220 }}>
      <div className="flex items-center justify-center py-2 px-3 border-b border-[var(--color-border)]">
        <span className="text-[10px] font-semibold" style={{ color: accent }}>{title}</span>
      </div>
      <div className="flex items-center justify-center" style={{ aspectRatio: '9/16', background: '#111114' }}>
        {children}
      </div>
    </div>
  )
}

function ArrowIcon({ accent }: { accent: string }) {
  return (
    <div className="flex items-center justify-center py-2 md:px-2 md:py-0">
      <svg className="hidden md:block" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={accent} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
        <line x1="5" y1="12" x2="19" y2="12" />
        <polyline points="12 5 19 12 12 19" />
      </svg>
      <svg className="md:hidden" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={accent} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
        <line x1="12" y1="5" x2="12" y2="19" />
        <polyline points="19 12 12 19 5 12" />
      </svg>
    </div>
  )
}

export default function ProductPage({ app, description, longDescription, features, appStoreUrl, screenshots, trainingImages, demoVideo, certHook, certSubhook, quizUrl, stats, salaryBlock, certTrustLine }: ProductPageProps) {
  const cfg = APPS[app]

  const defaultScreenshots: ScreenshotPair[] = [
    { label: 'Photo Analysis', beforeTitle: 'Upload a photo', afterTitle: 'Get AI diagnosis' },
    { label: 'Troubleshoot', beforeTitle: 'Describe the problem', afterTitle: 'Get step-by-step fix' },
  ]

  const shots = screenshots || defaultScreenshots

  // Build per-app schema.org SoftwareApplication structured data for rich snippets.
  const softwareJsonLd: Record<string, unknown> = {
    '@context': 'https://schema.org',
    '@type': 'SoftwareApplication',
    name: cfg.name,
    applicationCategory: 'BusinessApplication',
    operatingSystem: 'Web, iOS',
    description: cfg.metaDescription,
    url: cfg.appUrl,
    image: `https://tradepals.net${cfg.logo}`,
    offers: { '@type': 'Offer', price: '0', priceCurrency: 'USD', description: 'Free tier; Pro upgrade available.' },
    publisher: { '@type': 'Organization', name: 'TradePals, LLC', url: 'https://tradepals.net' },
    keywords: cfg.certs.join(', '),
  }

  return (
    <div>
      <PageMeta
        title={cfg.metaTitle}
        description={cfg.metaDescription}
        path={`/${app}`}
        ogImage={cfg.logo}
        themeColor={cfg.primary}
        jsonLd={softwareJsonLd}
      />
      {/* ── Hero: Logo + tagline + CTA ────────────────────────── */}
      <div className="mx-auto max-w-5xl px-4 pt-16 pb-10">
        <div className="text-center mb-8">
          <div className="flex justify-center mb-4" style={{ height: 80 }}>
            <img
              src={cfg.logo}
              alt={cfg.name}
              style={{ maxHeight: '100%', objectFit: 'contain' }}
            />
          </div>
          {certHook ? (
            <>
              <h1 className="text-3xl md:text-4xl font-bold mb-3 text-white max-w-3xl mx-auto leading-tight">
                {certHook}
              </h1>
              {certSubhook && (
                <p className="text-lg md:text-xl font-semibold mb-4 max-w-2xl mx-auto" style={{ color: cfg.primary }}>
                  {certSubhook}
                </p>
              )}
              <p className="text-[var(--color-muted-fg)] text-base max-w-2xl mx-auto mb-6">{description}</p>
            </>
          ) : (
            <>
              <p className="text-xl font-semibold mb-3" style={{ color: cfg.primary }}>
                {cfg.tagline}
              </p>
              <p className="text-[var(--color-muted-fg)] text-lg max-w-2xl mx-auto mb-6">{description}</p>
            </>
          )}

          {/* Primary CTA (+ optional quiz CTA) */}
          <div className="flex flex-col sm:flex-row gap-3 justify-center items-center">
            {cfg.appUrl && (
              <a
                href={`${cfg.appUrl}/signup`}
                className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center text-white hover:opacity-90 transition"
                style={{ backgroundColor: cfg.primary }}
              >
                Get {cfg.name} Free
              </a>
            )}
            {quizUrl && (
              <a
                href={quizUrl}
                className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
                style={{ border: `2px solid ${cfg.primary}`, color: cfg.primary }}
              >
                Try the Free Practice Quiz →
              </a>
            )}
          </div>

          {/* Secondary links */}
          <div className="flex flex-wrap justify-center gap-4 mt-4">
            {cfg.appUrl && (
              <a
                href={cfg.appUrl}
                className="text-sm font-semibold"
                style={{ color: cfg.primary }}
              >
                Launch App →
              </a>
            )}
            {appStoreUrl && (
              <a
                href={appStoreUrl}
                className="text-sm font-semibold"
                style={{ color: cfg.primary }}
                onClick={() => track('app_store_click', { app })}
              >
                App Store →
              </a>
            )}
            <Link
              to="/signin"
              className="text-sm font-semibold text-[var(--color-muted-fg)] hover:text-white"
            >
              Training Log In →
            </Link>
          </div>
        </div>
      </div>

      {/* ── Stats strip (cert-first economic context) ─────────── */}
      {stats && stats.length > 0 && (
        <div className="border-y border-[var(--color-border)]" style={{ backgroundColor: `${cfg.primary}06` }}>
          <div className="mx-auto max-w-5xl px-4 py-8">
            <div className={`grid gap-6 ${stats.length === 4 ? 'grid-cols-2 md:grid-cols-4' : stats.length === 3 ? 'grid-cols-1 md:grid-cols-3' : 'grid-cols-1 md:grid-cols-2'}`}>
              {stats.map((s, i) => (
                <div key={i} className="text-center">
                  <div className="text-2xl md:text-3xl font-bold mb-1" style={{ color: cfg.primary }}>{s.value}</div>
                  <div className="text-sm text-white font-semibold mb-0.5">{s.label}</div>
                  {s.source && (
                    <div className="text-xs text-[var(--color-muted-fg)]">{s.source}</div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* ── Screenshots: Before → After (visual proof first) ── */}
      <div className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-5xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-8 text-center">See it in action</h2>
          <div className="space-y-12">
            {shots.map((shot, i) => (
              <div key={i}>
                <h3 className="text-lg font-semibold mb-4 text-center" style={{ color: cfg.primary }}>{shot.label}</h3>
                <div className="flex flex-col items-center md:flex-row md:items-center md:justify-center gap-2 md:gap-4">
                  <PhoneMockup title={shot.beforeTitle} accent={cfg.primary}>
                    {shot.beforeImage ? (
                      <img src={shot.beforeImage} alt={shot.beforeTitle} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    ) : (
                      <div className="text-center p-5">
                        <div className="w-14 h-14 rounded-xl mx-auto mb-3 flex items-center justify-center" style={{ backgroundColor: `${cfg.primary}15`, border: `2px dashed ${cfg.primary}40` }}>
                          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
                            <circle cx="12" cy="13" r="4" />
                          </svg>
                        </div>
                        <p className="text-xs text-[var(--color-muted-fg)]">{shot.beforeTitle}</p>
                      </div>
                    )}
                  </PhoneMockup>
                  <ArrowIcon accent={cfg.primary} />
                  <PhoneMockup title={shot.afterTitle} accent={cfg.primary}>
                    {shot.afterImage ? (
                      <img src={shot.afterImage} alt={shot.afterTitle} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    ) : (
                      <div className="text-center p-5">
                        <div className="w-14 h-14 rounded-xl mx-auto mb-3 flex items-center justify-center" style={{ backgroundColor: `${cfg.primary}15` }}>
                          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                            <polyline points="22 4 12 14.01 9 11.01" />
                          </svg>
                        </div>
                        <p className="text-xs text-[var(--color-muted-fg)]">{shot.afterTitle}</p>
                      </div>
                    )}
                  </PhoneMockup>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* ── Demo Video ─────────────────────────────────────────── */}
      {demoVideo && (
        <div className="mx-auto max-w-5xl px-4 py-16 text-center">
          <h2 className="text-2xl font-bold mb-2">Watch a real diagnosis</h2>
          <p className="text-[var(--color-muted-fg)] mb-6">From photo to fix — under 90 seconds.</p>
          <video
            className="mx-auto rounded-2xl border border-[var(--color-border)]"
            style={{ maxWidth: 360, maxHeight: 480, width: '100%' }}
            controls
            playsInline
            preload="none"
          >
            <source src={demoVideo} type="video/mp4" />
          </video>
        </div>
      )}

      {/* ── What [cert] is worth (salary comparison) ──────────── */}
      {salaryBlock && (
        <div className="mx-auto max-w-5xl px-4 py-12">
          <h2 className="text-2xl font-bold mb-2 text-center">What the cert is worth</h2>
          {salaryBlock.note && (
            <p className="text-[var(--color-muted-fg)] text-sm text-center mb-8 max-w-2xl mx-auto">{salaryBlock.note}</p>
          )}
          <div className="grid gap-4 md:grid-cols-2 max-w-3xl mx-auto">
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 text-center">
              <p className="text-xs uppercase tracking-wider text-[var(--color-muted-fg)] mb-2">Uncertified</p>
              <p className="text-2xl font-bold text-white">{salaryBlock.uncertifiedRange}</p>
            </div>
            <div className="rounded-xl p-6 text-center" style={{ border: `2px solid ${cfg.primary}`, backgroundColor: `${cfg.primary}10` }}>
              <p className="text-xs uppercase tracking-wider mb-2" style={{ color: cfg.primary }}>Certified</p>
              <p className="text-2xl font-bold" style={{ color: cfg.primary }}>{salaryBlock.certifiedRange}</p>
            </div>
          </div>
          {salaryBlock.sourceLabel && (
            <p className="text-xs text-[var(--color-muted-fg)] text-center mt-4">Source: {salaryBlock.sourceLabel}</p>
          )}
        </div>
      )}

      {/* ── Mid-page CTA ──────────────────────────────────────── */}
      {cfg.appUrl && (
        <div className="border-y border-[var(--color-border)] py-10 text-center" style={{ backgroundColor: `${cfg.primary}08` }}>
          <p className="text-lg font-bold text-white mb-1">Start diagnosing in the field today</p>
          <p className="text-sm text-[var(--color-muted-fg)] mb-4">Free to try. No credit card required.</p>
          <a
            href={`${cfg.appUrl}/signup`}
            className="inline-block px-8 py-4 rounded-lg font-bold text-base text-white hover:opacity-90 transition"
            style={{ backgroundColor: cfg.primary }}
          >
            Get {cfg.name} Free
          </a>
        </div>
      )}

      {/* ── About ─────────────────────────────────────────────── */}
      {longDescription && (
        <div className="mx-auto max-w-5xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-4">Why {cfg.name}?</h2>
          <div className="text-[var(--color-muted-fg)] text-base leading-relaxed max-w-3xl space-y-4">
            {longDescription.split('\n\n').slice(0, 2).map((para, i) => (
              <p key={i}>{para}</p>
            ))}
          </div>
        </div>
      )}

      {/* ── Training ──────────────────────────────────────────── */}
      <div className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-5xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-2 text-center">Certification Training</h2>
          {certTrustLine && (
            <p className="text-sm text-center mb-6" style={{ color: cfg.primary }}>{certTrustLine}</p>
          )}
          {!certTrustLine && <div className="mb-6" />}
          <div className="grid gap-6 grid-cols-3 mb-10">
            {[
              { label: 'Cert path', placeholder: <><path d="M22 10v6M2 10l10-5 10 5-10 5z" /><path d="M6 12v5c0 1.657 2.686 3 6 3s6-1.343 6-3v-5" /></> },
              { label: 'Practice exam', placeholder: <><path d="M9 11l3 3L22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" /></> },
              { label: 'Readiness score', placeholder: <><circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" /></> },
            ].map((slot, idx) => (
              <div key={idx} className="text-center">
                <div className="mx-auto" style={{ width: '100%', maxWidth: 200, borderRadius: 24, border: '3px solid #2A2A2E', background: '#111114', overflow: 'hidden' }}>
                  <div style={{ width: '100%', aspectRatio: '9/16', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    {trainingImages?.[idx] ? (
                      <img src={trainingImages[idx]} alt={slot.label} style={{ width: '100%', height: '100%', objectFit: 'cover' }} />
                    ) : (
                      <div style={{ textAlign: 'center', padding: '1rem' }}>
                        <svg width="36" height="36" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" style={{ margin: '0 auto 0.5rem' }}>{slot.placeholder}</svg>
                      </div>
                    )}
                  </div>
                </div>
                <p className="text-[var(--color-muted)] text-xs mt-2">{slot.label}</p>
              </div>
            ))}
          </div>

          <div className="text-[var(--color-muted-fg)] text-base leading-relaxed max-w-3xl mx-auto space-y-4">
            <div className="flex gap-3 items-start">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" className="flex-shrink-0 mt-0.5"><polyline points="20 6 9 17 4 12" /></svg>
              <p>Study content built from current industry standards — not outdated textbooks.</p>
            </div>
            <div className="flex gap-3 items-start">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" className="flex-shrink-0 mt-0.5"><polyline points="20 6 9 17 4 12" /></svg>
              <p>Timed exams, untimed practice, and targeted weak-area drills that mirror the real test.</p>
            </div>
            <div className="flex gap-3 items-start">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" className="flex-shrink-0 mt-0.5"><polyline points="20 6 9 17 4 12" /></svg>
              <p>Track your readiness score across every domain — know when you're ready to sit for the exam.</p>
            </div>
          </div>
        </div>
      </div>

      {/* ── Features ──────────────────────────────────────────── */}
      <div className="mx-auto max-w-5xl px-4 py-16">
        <h2 className="text-2xl font-bold mb-4">Features</h2>
        <ul className="grid gap-3 md:grid-cols-2 mb-12">
          {features.map((f) => (
            <li key={f} className="rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-4 text-sm">
              {f}
            </li>
          ))}
        </ul>

        {/* ── Bottom CTA ────────────────────────────────────────── */}
        {cfg.appUrl && (
          <div className="rounded-xl p-8 text-center mb-12" style={{ border: `2px solid ${cfg.primary}`, backgroundColor: `${cfg.primary}08` }}>
            <p className="text-lg font-bold text-white mb-1">Ready to try {cfg.name}?</p>
            <p className="text-sm text-[var(--color-muted-fg)] mb-4">Free to use. Upgrade when you're ready.</p>
            <a
              href={`${cfg.appUrl}/signup`}
              className="inline-block px-8 py-4 rounded-lg font-bold text-base text-white hover:opacity-90 transition"
              style={{ backgroundColor: cfg.primary }}
            >
              Get {cfg.name} Free
            </a>
          </div>
        )}

        <div className="flex justify-center md:justify-start gap-6 text-sm">
          <Link to={`/${app}/support`} style={{ color: cfg.primary }}>Support</Link>
          <Link to={`/${app}/privacy`} style={{ color: cfg.primary }}>Privacy Policy</Link>
          <Link to={`/${app}/terms`} style={{ color: cfg.primary }}>Terms of Service</Link>
        </div>
      </div>
    </div>
  )
}
