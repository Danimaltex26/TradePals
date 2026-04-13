import { Link } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { useEntitlement } from '../hooks/useEntitlement'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

export default function Account() {
  return (
    <div className="mx-auto max-w-2xl px-4 py-16">
      <h1 className="text-3xl font-extrabold mb-8">My Account</h1>
      <div className="space-y-6">
        <AppSection app="splicepal" />
        <AppSection app="weldpal" />
        <AppSection app="poolpal" />
        <AppSection app="voltpal" />
        <AppSection app="pipepal" />
        <AppSection app="windpal" />
      </div>
    </div>
  )
}

function AppSection({ app }: { app: AppKey }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const ent = useEntitlement(app)
  const cfg = APPS[app]

  return (
    <section className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
      <div className="flex items-center justify-between mb-3">
        <div className="flex items-center" style={{ height: 48, maxWidth: 180 }}>
          <img
            src={cfg.logo}
            alt={cfg.name}
            style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }}
          />
        </div>
        {appAuth.user ? (
          <span className={`px-2 py-0.5 rounded text-xs font-semibold ${ent.active ? 'bg-green-500/20 text-green-300' : 'bg-gray-500/20 text-gray-300'}`}>
            {ent.loading ? '…' : ent.active ? 'PRO' : (ent.tier ?? 'Free').toUpperCase()}
          </span>
        ) : null}
      </div>

      {appAuth.loading ? (
        <p className="text-[var(--color-muted-fg)]">Loading…</p>
      ) : appAuth.user ? (
        <div className="space-y-3">
          <p className="text-sm text-[var(--color-muted-fg)]">Signed in as {appAuth.user.email}</p>
          <div className="flex gap-3">
            <Link
              to={`/${app}/training`}
              className="px-4 py-2 rounded-md font-semibold text-sm"
              style={{ backgroundColor: cfg.primary, color: '#0D0D0F' }}
            >
              View Training
            </Link>
            <button
              onClick={() => auth.signOut(app)}
              className="px-4 py-2 rounded-md border border-[var(--color-border)] text-sm"
            >
              Sign Out
            </button>
          </div>
        </div>
      ) : (
        <Link
          to="/signin"
          state={{ app }}
          className="inline-block px-4 py-2 rounded-md font-semibold text-sm"
          style={{ backgroundColor: cfg.primary, color: '#0D0D0F' }}
        >
          Sign In to {cfg.name}
        </Link>
      )}
    </section>
  )
}
