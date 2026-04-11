import { Link } from 'react-router-dom'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'

type ScreenshotPair = {
  label: string
  beforeTitle: string
  afterTitle: string
}

type ProductPageProps = {
  app: AppKey
  description: string
  features: string[]
  appStoreUrl?: string
  screenshots?: ScreenshotPair[]
}

function PhoneMockup({ title, accent, children }: { title: string; accent: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl border border-[var(--color-border)] bg-[#0D0D0F] overflow-hidden" style={{ width: '100%', maxWidth: 280 }}>
      {/* Status bar */}
      <div className="flex items-center justify-center py-2 px-4 border-b border-[var(--color-border)]">
        <span className="text-[10px] font-semibold" style={{ color: accent }}>{title}</span>
      </div>
      {/* Screen content */}
      <div className="flex items-center justify-center" style={{ aspectRatio: '9/16', background: '#111114' }}>
        {children}
      </div>
    </div>
  )
}

function ArrowIcon({ accent }: { accent: string }) {
  return (
    <div className="flex items-center justify-center px-2">
      <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke={accent} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
        <line x1="5" y1="12" x2="19" y2="12" />
        <polyline points="12 5 19 12 12 19" />
      </svg>
    </div>
  )
}

export default function ProductPage({ app, description, features, appStoreUrl, screenshots }: ProductPageProps) {
  const cfg = APPS[app]

  const defaultScreenshots: ScreenshotPair[] = [
    { label: 'Photo Analysis', beforeTitle: 'Upload a photo', afterTitle: 'Get AI diagnosis' },
    { label: 'Troubleshoot', beforeTitle: 'Describe the problem', afterTitle: 'Get step-by-step fix' },
  ]

  const shots = screenshots || defaultScreenshots

  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <div style={{ height: 120, width: 320, marginBottom: '1rem' }} className="flex items-center">
        <img
          src={cfg.logo}
          alt={cfg.name}
          style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }}
        />
      </div>
      <p className="text-xl font-semibold mb-6" style={{ color: cfg.primary }}>
        {cfg.tagline}
      </p>
      <p className="text-[var(--color-muted-fg)] text-lg mb-10 max-w-2xl">{description}</p>

      <div className="flex flex-wrap gap-3 mb-12">
        {cfg.appUrl && (
          <a
            href={cfg.appUrl}
            className="px-5 py-3 rounded-md font-semibold"
            style={{ backgroundColor: cfg.primary, color: '#0D0D0F' }}
          >
            Launch {cfg.name}
          </a>
        )}
        {appStoreUrl && (
          <a
            href={appStoreUrl}
            className="px-5 py-3 rounded-md text-white font-semibold"
            style={{ backgroundColor: cfg.primary }}
          >
            Download on App Store
          </a>
        )}
        <Link
          to={`/${app}/training`}
          className="px-5 py-3 rounded-md border border-[var(--color-border)] text-white font-semibold"
        >
          View Training
        </Link>
      </div>

      {/* ── Screenshots: Before → After ──────────────────────── */}
      <h2 className="text-2xl font-bold mb-6">See it in action</h2>
      <div className="space-y-12 mb-16">
        {shots.map((shot, i) => (
          <div key={i}>
            <h3 className="text-lg font-semibold mb-4" style={{ color: cfg.primary }}>{shot.label}</h3>
            <div className="flex items-center justify-center gap-2 md:gap-4 flex-wrap md:flex-nowrap">
              {/* Before */}
              <PhoneMockup title={shot.beforeTitle} accent={cfg.primary}>
                <div className="text-center p-6">
                  <div
                    className="w-16 h-16 rounded-xl mx-auto mb-3 flex items-center justify-center"
                    style={{ backgroundColor: `${cfg.primary}15`, border: `2px dashed ${cfg.primary}40` }}
                  >
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
                      <circle cx="12" cy="13" r="4" />
                    </svg>
                  </div>
                  <p className="text-sm text-[var(--color-muted-fg)]">{shot.beforeTitle}</p>
                  <p className="text-xs text-[var(--color-muted)] mt-1">Screenshot coming soon</p>
                </div>
              </PhoneMockup>

              {/* Arrow */}
              <ArrowIcon accent={cfg.primary} />

              {/* After */}
              <PhoneMockup title={shot.afterTitle} accent={cfg.primary}>
                <div className="text-center p-6">
                  <div
                    className="w-16 h-16 rounded-xl mx-auto mb-3 flex items-center justify-center"
                    style={{ backgroundColor: `${cfg.primary}15` }}
                  >
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke={cfg.primary} strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                      <polyline points="22 4 12 14.01 9 11.01" />
                    </svg>
                  </div>
                  <p className="text-sm text-[var(--color-muted-fg)]">{shot.afterTitle}</p>
                  <p className="text-xs text-[var(--color-muted)] mt-1">Screenshot coming soon</p>
                </div>
              </PhoneMockup>
            </div>
          </div>
        ))}
      </div>

      <h2 className="text-2xl font-bold mb-4">Features</h2>
      <ul className="grid gap-3 md:grid-cols-2 mb-12">
        {features.map((f) => (
          <li key={f} className="rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-4">
            {f}
          </li>
        ))}
      </ul>

      <div className="flex gap-6 text-sm">
        <Link to={`/${app}/support`} style={{ color: cfg.primary }}>Support</Link>
        <Link to={`/${app}/privacy`} style={{ color: cfg.primary }}>Privacy Policy</Link>
        <Link to={`/${app}/terms`} style={{ color: cfg.primary }}>Terms of Service</Link>
      </div>
    </div>
  )
}
