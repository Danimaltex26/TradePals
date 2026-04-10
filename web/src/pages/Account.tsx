import { Link } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { useEntitlement } from '../hooks/useEntitlement'
import type { AppKey } from '../lib/supabase'

export default function Account() {
  return (
    <div className="mx-auto max-w-2xl px-4 py-16">
      <h1 className="text-3xl font-extrabold mb-8">My Account</h1>
      <AppSection app="splicepal" label="SplicePal" />
      <div className="h-6" />
      <AppSection app="weldpal" label="WeldPal" />
      <div className="h-6" />
      <AppSection app="poolpal" label="PoolPal" />
    </div>
  )
}

function AppSection({ app, label }: { app: AppKey; label: string }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const ent = useEntitlement(app)

  return (
    <section className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
      <div className="flex items-center justify-between mb-3">
        <h2 className="text-xl font-bold">{label}</h2>
        {appAuth.user ? (
          <span className={`px-2 py-0.5 rounded text-xs font-semibold ${ent.active ? 'bg-green-500/20 text-green-300' : 'bg-gray-500/20 text-gray-300'}`}>
            {ent.loading ? '…' : ent.active ? 'Active' : (ent.tier ?? 'Free').toUpperCase()}
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
              className="px-4 py-2 rounded-md bg-[var(--color-primary)] text-white font-semibold text-sm"
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
          className="inline-block px-4 py-2 rounded-md bg-[var(--color-primary)] text-white font-semibold text-sm"
        >
          Sign In to {label}
        </Link>
      )}
    </section>
  )
}
