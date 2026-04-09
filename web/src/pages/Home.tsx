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
      </section>
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
      <div className="h-20 flex items-center mb-3">
        <img
          src={app.logo}
          alt={app.name}
          style={{ height: 80, width: 'auto', objectFit: 'contain' }}
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
