import { Link } from 'react-router-dom'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

export default function Training() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <h1 className="text-4xl font-extrabold mb-3">Training</h1>
      <p className="text-[var(--color-muted-fg)] text-lg mb-10">
        Long-form guides and reference material for active subscribers. Pick your app to get started.
      </p>
      <div className="grid gap-6 md:grid-cols-2">
        {(Object.keys(APPS) as AppKey[]).map((key) => {
          const app = APPS[key]
          return (
            <Link
              key={key}
              to={`/${key}/training`}
              className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 transition-colors"
              onMouseEnter={(e) => (e.currentTarget.style.borderColor = app.primary)}
              onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
            >
              <div className="mb-3 flex items-center" style={{ height: 80, width: 200 }}>
                <img src={app.logo} alt={app.name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} />
              </div>
              <p className="text-[var(--color-muted-fg)] mb-4">{app.tagline}</p>
              <div className="text-sm font-semibold" style={{ color: app.primary }}>
                View {app.name} training →
              </div>
            </Link>
          )
        })}
      </div>
    </div>
  )
}
