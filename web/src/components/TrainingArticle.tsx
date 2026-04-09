import { Link, useParams } from 'react-router-dom'
import TrainingGate from './TrainingGate'
import { getArticle } from '../content/training'
import type { AppKey } from '../lib/supabase'

export default function TrainingArticle({ app, label }: { app: AppKey; label: string }) {
  const { slug } = useParams<{ slug: string }>()
  const article = slug ? getArticle(app, slug) : undefined

  return (
    <div className="mx-auto max-w-3xl px-4 py-16">
      <Link to={`/${app}/training`} className="text-sm text-[var(--color-muted-fg)] hover:text-white">
        ← Back to {label} training
      </Link>
      <TrainingGate app={app}>
        {article ? (
          <article className="mt-4">
            <h1 className="text-3xl font-extrabold mb-3">{article.title}</h1>
            <p className="text-[var(--color-muted-fg)] mb-8">{article.description}</p>
            <div className="prose prose-invert whitespace-pre-wrap leading-relaxed">{article.body}</div>
          </article>
        ) : (
          <p className="mt-8 text-[var(--color-muted-fg)]">Article not found.</p>
        )}
      </TrainingGate>
    </div>
  )
}
