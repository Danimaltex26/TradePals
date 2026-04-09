import { Link } from 'react-router-dom'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

export default function Home() {
  return (
    <div className="mx-auto max-w-6xl px-4 py-16">
      <section className="text-center mb-20">
        <h1 className="text-4xl md:text-6xl font-extrabold tracking-tight">
          AI field companions for <span className="text-[var(--color-primary)]">skilled trades</span>.
        </h1>
        <p className="mt-5 text-lg text-[var(--color-muted-fg)] max-w-2xl mx-auto">
          Purpose-built mobile apps that put expert knowledge in your hand on the jobsite — and full training at your desk.
        </p>
      </section>

      <section className="grid gap-6 md:grid-cols-2">
        <ProductCard
          appKey="splicepal"
          bullets={[
            'OTDR trace analysis',
            'Splice troubleshooting',
            'Reference library + cert prep',
          ]}
        />
        <ProductCard
          appKey="weldpal"
          bullets={[
            'Visual weld defect analysis',
            'Troubleshooting guides',
            'AWS / API / ASME cert prep',
          ]}
        />
        <ComingSoonCard
          name="WindPal"
          logo="/windpal-logo.png"
          tagline="AI field companion for wind turbine technicians"
          accent="#22D3EE"
          bullets={[
            'Blade damage photo analysis',
            'Gearbox & generator troubleshooting',
            'GWO / BZEE cert prep',
          ]}
        />
        <ComingSoonCard
          name="LiftPal"
          logo="/liftpal-logo.png"
          tagline="AI field companion for elevator & lift technicians"
          accent="#A855F7"
          bullets={[
            'Control board fault diagnosis',
            'Hoistway inspection checklists',
            'NAEC / QEI cert prep',
          ]}
        />
        <ComingSoonCard
          name="VoltPal"
          tagline="AI field companion for industrial electricians"
          accent="#FACC15"
          bullets={[
            'Panel & fault photo diagnosis',
            'NEC code reference & lookups',
            'Apprentice / journeyman exam prep',
          ]}
        />
        <ComingSoonCard
          name="PoolPal"
          tagline="AI field companion for pool & spa service techs"
          accent="#14B8A6"
          bullets={[
            'Water chemistry & algae photo analysis',
            'Pump, heater & equipment troubleshooting',
            'CPO (PHTA) cert prep',
          ]}
        />
      </section>
    </div>
  )
}

function ComingSoonCard({
  name,
  logo,
  tagline,
  bullets,
  accent,
}: {
  name: string
  logo?: string
  tagline: string
  bullets: string[]
  accent: string
}) {
  return (
    <div
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 relative opacity-80"
      aria-disabled="true"
    >
      <span
        className="absolute top-4 right-4 text-[11px] font-bold uppercase tracking-wider px-2 py-1 rounded"
        style={{ backgroundColor: accent, color: '#0D0D0F' }}
      >
        Coming Soon
      </span>
      <div className="mb-3 flex items-center" style={{ height: 96, width: 240 }}>
        {logo ? (
          <img src={logo} alt={name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} />
        ) : (
          <span className="text-3xl font-extrabold" style={{ color: accent }}>
            {name}
          </span>
        )}
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4">{tagline}</p>
      <ul className="space-y-1 text-sm">
        {bullets.map((b) => (
          <li key={b}>• {b}</li>
        ))}
      </ul>
      <div className="mt-5 text-sm font-semibold text-[var(--color-muted)]">
        In development
      </div>
    </div>
  )
}

function ProductCard({ appKey, bullets }: { appKey: AppKey; bullets: string[] }) {
  const app = APPS[appKey]
  return (
    <Link
      to={`/${appKey}`}
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 transition-colors"
      style={{ borderColor: 'var(--color-border)' }}
      onMouseEnter={(e) => (e.currentTarget.style.borderColor = app.primary)}
      onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
    >
      <div
        className="mb-3 flex items-center justify-start"
        style={{ height: 96, width: 240 }}
      >
        <img
          src={app.logo}
          alt={app.name}
          style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }}
        />
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4">{app.tagline}</p>
      <ul className="space-y-1 text-sm">
        {bullets.map((b) => (
          <li key={b}>• {b}</li>
        ))}
      </ul>
      <div className="mt-5 text-sm font-semibold" style={{ color: app.primary }}>
        Learn more →
      </div>
    </Link>
  )
}
