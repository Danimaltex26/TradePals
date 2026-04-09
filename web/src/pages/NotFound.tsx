import { Link } from 'react-router-dom'

export default function NotFound() {
  return (
    <div className="mx-auto max-w-xl px-4 py-24 text-center">
      <h1 className="text-4xl font-extrabold mb-2">404</h1>
      <p className="text-[var(--color-muted-fg)] mb-6">Page not found.</p>
      <Link to="/" className="text-[var(--color-primary)] font-semibold">Back home</Link>
    </div>
  )
}
