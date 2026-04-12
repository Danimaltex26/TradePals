import { useEffect } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

const APP_KEYS = Object.keys(APPS) as AppKey[]

export default function Training() {
  const auth = useAuth()
  const nav = useNavigate()

  const loading = APP_KEYS.some((k) => auth[k].loading)
  const signedInApps = APP_KEYS.filter((k) => auth[k].user)

  // Auto-redirect when signed into exactly one app
  useEffect(() => {
    if (loading) return
    if (signedInApps.length === 1) {
      nav(`/${signedInApps[0]}/training`, { replace: true })
    }
  }, [loading, signedInApps.length])

  // Show nothing while auth state resolves
  if (loading) {
    return (
      <div className="mx-auto max-w-4xl px-4 py-16 text-center text-[var(--color-muted-fg)]">
        Loading…
      </div>
    )
  }

  // Not signed in — prompt to sign in
  if (signedInApps.length === 0) {
    return (
      <div className="mx-auto max-w-md px-4 py-16 text-center">
        <h1 className="text-3xl font-extrabold mb-3">Training</h1>
        <p className="text-[var(--color-muted-fg)] mb-6">
          Sign in with your Pal app account to access training content and certification prep.
        </p>
        <Link
          to="/signin"
          className="inline-block h-11 leading-[44px] px-8 rounded-md bg-[var(--color-primary)] text-white font-semibold"
        >
          Sign In to Training
        </Link>
      </div>
    )
  }

  // Signed into multiple apps — show only those
  return (
    <div className="mx-auto max-w-4xl px-4 py-16">
      <h1 className="text-4xl font-extrabold mb-3">Training</h1>
      <p className="text-[var(--color-muted-fg)] text-lg mb-10">
        Pick which app's training to view.
      </p>
      <div className="grid gap-6 md:grid-cols-2">
        {signedInApps.map((key) => {
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
