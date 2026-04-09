import { Link } from 'react-router-dom'
import TrainingGate from './TrainingGate'
import { listArticles } from '../content/training'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

export default function TrainingIndex({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  const articles = listArticles(app)
  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <div className="flex items-center gap-4 mb-2">
        <img src={cfg.logo} alt={cfg.name} style={{ height: 56, width: 'auto', objectFit: 'contain' }} />
        <h1 className="text-3xl font-extrabold">Training</h1>
      </div>
      <p className="text-[var(--color-muted-fg)] mb-8">
        Long-form guides and reference material for active subscribers.
      </p>
      <TrainingGate app={app}>
        <div className="grid gap-4">
          {articles.map((a) => (
            <Link
              key={a.slug}
              to={`/${app}/training/${a.slug}`}
              className="block rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-5 transition-colors"
              onMouseEnter={(e) => (e.currentTarget.style.borderColor = cfg.primary)}
              onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
            >
              <div className="font-bold text-lg mb-1" style={{ color: cfg.primary }}>{a.title}</div>
              <p className="text-sm text-[var(--color-muted-fg)]">{a.description}</p>
            </Link>
          ))}
        </div>
      </TrainingGate>
    </div>
  )
}
