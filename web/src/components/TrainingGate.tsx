import type { ReactNode } from 'react'
import { Link } from 'react-router-dom'
import { useEntitlement } from '../hooks/useEntitlement'
import { useAuth } from '../auth/AuthProvider'
import type { AppKey } from '../lib/supabase'

const APP_LABEL: Record<AppKey, string> = {
  splicepal: 'SplicePal',
  weldpal: 'WeldPal',
  poolpal: 'PoolPal',
  voltpal: 'VoltPal',
}

export default function TrainingGate({
  app,
  children,
}: {
  app: AppKey
  children: ReactNode
}) {
  const auth = useAuth()
  const appAuth = auth[app]
  const ent = useEntitlement(app)

  if (appAuth.loading || ent.loading) {
    return <div className="py-16 text-center text-[var(--color-muted-fg)]">Loading…</div>
  }

  if (!appAuth.user) {
    return (
      <div className="mx-auto max-w-xl py-16 text-center">
        <h2 className="text-2xl font-bold mb-2">Sign in required</h2>
        <p className="text-[var(--color-muted-fg)] mb-6">
          Use the same email and password from your {APP_LABEL[app]} app.
        </p>
        <Link
          to="/signin"
          state={{ app, redirect: window.location.pathname }}
          className="inline-block px-6 py-3 rounded-md bg-[var(--color-primary)] text-white font-semibold"
        >
          Sign In
        </Link>
      </div>
    )
  }

  if (!ent.active) {
    return (
      <div className="mx-auto max-w-xl py-16 text-center">
        <h2 className="text-2xl font-bold mb-2">Subscription required</h2>
        <p className="text-[var(--color-muted-fg)] mb-6">
          Training is available to active {APP_LABEL[app]} subscribers. Open the app to subscribe or restore your purchase.
        </p>
        <p className="text-sm text-[var(--color-muted)]">
          Already subscribed? Try signing out and back in to refresh your account.
        </p>
      </div>
    )
  }

  return <>{children}</>
}
