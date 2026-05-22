import { Link, useLocation } from 'react-router-dom'
import PageMeta from '../components/PageMeta'

export default function NotFound() {
  const { pathname } = useLocation()
  return (
    <div className="mx-auto max-w-xl px-4 py-24 text-center">
      <PageMeta
        title="Page Not Found — TradePals"
        description="The page you're looking for doesn't exist."
        path={pathname}
        noindex
      />
      <h1 className="text-4xl font-extrabold mb-2">404</h1>
      <p className="text-[var(--color-muted-fg)] mb-6">Page not found.</p>
      <Link to="/" className="text-[var(--color-primary)] font-semibold">Back home</Link>
    </div>
  )
}
