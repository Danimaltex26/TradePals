import { Link } from 'react-router-dom'
import type { AppKey } from '../lib/supabase'

type ProductPageProps = {
  app: AppKey
  name: string
  tagline: string
  description: string
  features: string[]
  appStoreUrl?: string
}

export default function ProductPage({ app, name, tagline, description, features, appStoreUrl }: ProductPageProps) {
  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <h1 className="text-4xl md:text-5xl font-extrabold mb-3">{name}</h1>
      <p className="text-xl text-[var(--color-primary)] font-semibold mb-6">{tagline}</p>
      <p className="text-[var(--color-muted-fg)] text-lg mb-10 max-w-2xl">{description}</p>

      <div className="flex flex-wrap gap-3 mb-12">
        {appStoreUrl && (
          <a
            href={appStoreUrl}
            className="px-5 py-3 rounded-md bg-[var(--color-primary)] text-white font-semibold"
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

      <h2 className="text-2xl font-bold mb-4">Features</h2>
      <ul className="grid gap-3 md:grid-cols-2 mb-12">
        {features.map((f) => (
          <li key={f} className="rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-4">
            {f}
          </li>
        ))}
      </ul>

      <div className="flex gap-6 text-sm text-[var(--color-muted-fg)]">
        <Link to={`/${app}/support`}>Support</Link>
        <Link to={`/${app}/privacy`}>Privacy Policy</Link>
      </div>
    </div>
  )
}
