import { Link } from 'react-router-dom'
import TrainingGate from './TrainingGate'
import { listArticles } from '../content/training'
import type { AppKey } from '../lib/supabase'

export default function TrainingIndex({ app, label }: { app: AppKey; label: string }) {
  const articles = listArticles(app)
  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <h1 className="text-3xl font-extrabold mb-2">{label} Training</h1>
      <p className="text-[var(--color-muted-fg)] mb-8">
        Long-form guides and reference material for active subscribers.
      </p>
      <TrainingGate app={app}>
        <div className="grid gap-4">
          {articles.map((a) => (
            <Link
              key={a.slug}
              to={`/${app}/training/${a.slug}`}
              className="block rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-5 hover:border-[var(--color-primary)] transition-colors"
            >
              <div className="font-bold text-lg mb-1">{a.title}</div>
              <p className="text-sm text-[var(--color-muted-fg)]">{a.description}</p>
            </Link>
          ))}
        </div>
      </TrainingGate>
    </div>
  )
}
