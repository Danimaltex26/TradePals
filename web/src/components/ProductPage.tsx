import { Link } from 'react-router-dom'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'

type ScreenshotPair = {
  label: string
  beforeTitle: string
  afterTitle: string
  beforeImage?: string
  afterImage?: string
}

type ProductPageProps = {
  app: AppKey
  description: string
  longDescription?: string
  features: string[]
  appStoreUrl?: string
  screenshots?: ScreenshotPair[]
  trainingImages?: string[]
}

function PhoneMockup({ title, accent, children }: { title: string; accent: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl border border-[var(--color-border)] bg-[#0D0D0F] overflow-hidden w-full" style={{ maxWidth: 220 }}>
      {/* Status bar */}
      <div className="flex items-center justify-center py-2 px-3 border-b border-[var(--color-border)]">
        <span className="text-[10px] font-semibold" style={{ color: accent }}>{title}</span>
      </div>
      {/* Screen content */}
      <div className="flex items-center justify-center" style={{ aspectRatio: '9/16', background: '#111114' }}>
        {children}
      </div>
    </div>
  )
}

/* Arrow points right on desktop, down on mobile */
function ArrowIcon({ accent }: { accent: string }) {
  return (
    <div className="flex items-center justify-center py-2 md:px-2 md:py-0">
      {/* Right arrow — desktop */}
      <svg className="hidden md:block" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={accent} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
        <line x1="5" y1="12" x2="19" y2="12" />
        <polyline points="12 5 19 12 12 19" />
      </svg>
      {/* Down arrow — mobile */}
      <svg className="md:hidden" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={accent} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
        <line x1="12" y1="5" x2="12" y2="19" />
        <polyline points="19 12 12 19 5 12" />
      </svg>
    </div>
  )
}

export default function ProductPage({ app, description, longDescription, features, appStoreUrl, screenshots, trainingImages }: ProductPageProps) {
  const cfg = APPS[app]

  const defaultScreenshots: ScreenshotPair[] = [
    { label: 'Photo Analysis', beforeTitle: 'Upload a photo', afterTitle: 'Get AI diagnosis' },
    { label: 'Troubleshoot', beforeTitle: 'Describe the problem', afterTitle: 'Get step-by-step fix' },
  ]

  const shots = screenshots || defaultScreenshots

  // Split longDescription into first paragraph (mobile summary) and rest (desktop only)
  const paragraphs = longDescription ? longDescription.split('\n\n') : []
  const firstParagraph = paragraphs[0] || null
  const restParagraphs = paragraphs.slice(1)

  return (
    <div className="mx-auto max-w-5xl px-4 py-16">
      {/* ── Hero: Logo + CTA ──────────────────────────────────── */}
      {/* Mobile: centered stack. Desktop: logo left, buttons right */}
      <div className="flex flex-col items-center md:flex-row md:items-center md:justify-between gap-6 mb-10">
        <div className="flex items-center justify-center md:justify-start" style={{ height: 100, maxWidth: 280 }}>
          <img
            src={cfg.logo}
            alt={cfg.name}
            style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }}
          />
        </div>
        <div className="flex flex-wrap justify-center md:justify-end gap-3">
          {cfg.appUrl && (
            <a
              href={cfg.appUrl}
              className="px-5 py-3 rounded-md font-semibold text-sm"
              style={{ backgroundColor: cfg.primary, color: '#0D0D0F' }}
            >
              Launch {cfg.name}
            </a>
          )}
          {appStoreUrl && (
            <a
              href={appStoreUrl}
              className="px-5 py-3 rounded-md text-white font-semibold text-sm"
              style={{ backgroundColor: cfg.primary }}
            >
              Download on App Store
            </a>
          )}
          <Link
            to="/signin"
            className="px-5 py-3 rounded-md border border-[var(--color-border)] text-white font-semibold text-sm"
          >
            Training Log In
          </Link>
        </div>
      </div>

      {/* ── Tagline + Description ────────────────────────────── */}
      <p className="text-xl font-semibold mb-4 text-center md:text-left" style={{ color: cfg.primary }}>
        {cfg.tagline}
      </p>
      <p className="text-[var(--color-muted-fg)] text-lg mb-6 max-w-3xl">{description}</p>

      {/* Long description: first paragraph always visible, rest desktop-only */}
      {firstParagraph && (
        <p className="text-[var(--color-muted-fg)] text-base leading-relaxed mb-4 max-w-3xl">{firstParagraph}</p>
      )}
      {restParagraphs.length > 0 && (
        <div className="hidden md:block text-[var(--color-muted-fg)] text-base leading-relaxed mb-12 max-w-3xl space-y-4">
          {restParagraphs.map((para, i) => (
            <p key={i}>{para}</p>
          ))}
        </div>
      )}
      {/* Spacer on mobile when long desc is truncated */}
      {firstParagraph && <div className="md:hidden mb-10" />}

      {/* ── Screenshots: Before → After ──────────────────────── */}
      <h2 className="text-2xl font-bold mb-6">See it in action</h2>
      <div className="space-y-12 mb-16">
        {shots.map((shot, i) => (
          <div key={i}>
            <h3 className="text-lg font-semibold mb-4 text-center md:text-left" style={{ color: cfg.primary }}>{shot.label}</h3>
            {/* Mobile: stacked + centered. Desktop: side by side */}
            <div className="flex flex-col items-center md:flex-row md:items-center md:justify-center gap-2 md:gap-4">
              {/* Before */}
              <PhoneMockup title={shot.beforeTitle} accent={cfg.primary}>
                {shot.beforeImage ? (
                  <img
                    src={shot.beforeImage}
                    alt={shot.beforeTitle}
                    style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                  />
                ) : (
                  <div className="text-center p-5">
                    <div
                      className="w-14 h-14 rounded-xl mx-auto mb-3 flex items-center justify-center"
                      style={{ backgroundColor: `${cfg.primary}15`, border: `2px dashed ${cfg.primary}40` }}
                    >
                      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
                        <circle cx="12" cy="13" r="4" />
                      </svg>
                    </div>
                    <p className="text-xs text-[var(--color-muted-fg)]">{shot.beforeTitle}</p>
                    <p className="text-[10px] text-[var(--color-muted)] mt-1">Screenshot coming soon</p>
                  </div>
                )}
              </PhoneMockup>

              {/* Arrow — right on desktop, down on mobile */}
              <ArrowIcon accent={cfg.primary} />

              {/* After */}
              <PhoneMockup title={shot.afterTitle} accent={cfg.primary}>
                {shot.afterImage ? (
                  <img
                    src={shot.afterImage}
                    alt={shot.afterTitle}
                    style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                  />
                ) : (
                  <div className="text-center p-5">
                    <div
                      className="w-14 h-14 rounded-xl mx-auto mb-3 flex items-center justify-center"
                      style={{ backgroundColor: `${cfg.primary}15` }}
                    >
                      <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                        <polyline points="22 4 12 14.01 9 11.01" />
                      </svg>
                    </div>
                    <p className="text-xs text-[var(--color-muted-fg)]">{shot.afterTitle}</p>
                    <p className="text-[10px] text-[var(--color-muted)] mt-1">Screenshot coming soon</p>
                  </div>
                )}
              </PhoneMockup>
            </div>
          </div>
        ))}
      </div>

      {/* ── Training Screenshots ────────────────────────────── */}
      <h2 className="text-2xl font-bold mb-6">Certification Training</h2>
      <div className="grid gap-6 grid-cols-3 mb-16">
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
                    <p style={{ fontSize: '0.625rem', color: '#6B6B73' }}>Screenshot coming soon</p>
                  </div>
                )}
              </div>
            </div>
            <p className="text-[var(--color-muted)] text-xs mt-2">{slot.label}</p>
          </div>
        ))}
      </div>

      <div className="text-[var(--color-muted-fg)] text-base leading-relaxed mb-16 max-w-3xl space-y-4">
        <p>
          Study content is built from current industry standards — not outdated textbooks. Each module covers what you'll actually see on the certification exam and in the field, updated as standards evolve.
        </p>
        <p>
          Practice with timed exams that mirror the real test format, untimed sessions to learn at your own pace, or targeted weak-area drills that focus on your lowest-scoring domains. Questions are generated fresh so you build understanding, not just memorize answers.
        </p>
        <p>
          Track your progress with a weighted readiness score that aggregates your performance across every domain. Know exactly when you're ready to sit for the real exam — no guessing.
        </p>
      </div>

      <h2 className="text-2xl font-bold mb-4">Features</h2>
      <ul className="grid gap-3 md:grid-cols-2 mb-12">
        {features.map((f) => (
          <li key={f} className="rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-4 text-sm">
            {f}
          </li>
        ))}
      </ul>

      <div className="flex justify-center md:justify-start gap-6 text-sm">
        <Link to={`/${app}/support`} style={{ color: cfg.primary }}>Support</Link>
        <Link to={`/${app}/privacy`} style={{ color: cfg.primary }}>Privacy Policy</Link>
        <Link to={`/${app}/terms`} style={{ color: cfg.primary }}>Terms of Service</Link>
      </div>
    </div>
  )
}
