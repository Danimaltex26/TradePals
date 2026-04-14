import { useState } from 'react'
import { Link, useLocation, useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'

type LocationState = { app?: AppKey; redirect?: string } | null

export default function SignIn() {
  const auth = useAuth()
  const nav = useNavigate()
  const location = useLocation()
  const state = location.state as LocationState
  const [app, setApp] = useState<AppKey>(state?.app ?? 'splicepal')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!email.trim() || !password) return
    setError('')
    setLoading(true)
    try {
      await auth.signIn(app, email.trim(), password)
      nav(state?.redirect ?? `/${app}/training`, { replace: true })
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Sign in failed.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="mx-auto max-w-md px-4 py-16">
      <h1 className="text-3xl font-extrabold text-center mb-2">Training Sign In</h1>
      <p className="text-center text-[var(--color-muted-fg)] mb-2">
        Access training content and certification prep on the web.
      </p>
      <p className="text-center text-xs text-[var(--color-muted)] mb-8">
        Use the same email and password from your Pal app.
      </p>

      <div className="flex gap-2 mb-6 p-1 rounded-lg border border-[var(--color-border)] bg-[var(--color-card)]">
        <AppToggle current={app} value="splicepal" onClick={setApp} label="SplicePal" />
        <AppToggle current={app} value="weldpal" onClick={setApp} label="WeldPal" />
        <AppToggle current={app} value="poolpal" onClick={setApp} label="PoolPal" />
        <AppToggle current={app} value="voltpal" onClick={setApp} label="VoltPal" />
        <AppToggle current={app} value="pipepal" onClick={setApp} label="PipePal" />
        <AppToggle current={app} value="windpal" onClick={setApp} label="WindPal" />
        <AppToggle current={app} value="liftpal" onClick={setApp} label="LiftPal" />
      </div>

      {error && (
        <div className="mb-4 px-3 py-2 rounded-md border border-red-500/40 bg-red-500/10 text-red-300 text-sm">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm mb-1" htmlFor="email">Email</label>
          <input
            id="email"
            type="email"
            className="w-full h-11 px-3 rounded-md bg-[var(--color-card)] border border-[var(--color-border)] text-white"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            autoComplete="email"
          />
        </div>
        <div>
          <label className="block text-sm mb-1" htmlFor="password">Password</label>
          <input
            id="password"
            type="password"
            className="w-full h-11 px-3 rounded-md bg-[var(--color-card)] border border-[var(--color-border)] text-white"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            autoComplete="current-password"
          />
        </div>
        <button
          type="submit"
          className="w-full h-11 rounded-md bg-[var(--color-primary)] text-white font-semibold disabled:opacity-60"
          disabled={loading}
        >
          {loading ? 'Signing in…' : 'Sign In to Training'}
        </button>
      </form>

      <p className="text-center text-sm text-[var(--color-muted-fg)] mt-6">
        Don't have an account? Sign up in the{' '}
        <Link to={`/${app}`} className="text-[var(--color-primary)] font-semibold">
          {APPS[app]?.name || 'Pal'} app
        </Link>{' '}
        first — then sign in here to access training.
      </p>
    </div>
  )
}

function AppToggle({
  current,
  value,
  onClick,
  label,
}: {
  current: AppKey
  value: AppKey
  onClick: (a: AppKey) => void
  label: string
}) {
  const active = current === value
  return (
    <button
      type="button"
      onClick={() => onClick(value)}
      className={`flex-1 h-9 rounded-md text-sm font-semibold ${
        active ? 'bg-[var(--color-primary)] text-white' : 'text-[var(--color-muted-fg)]'
      }`}
    >
      {label}
    </button>
  )
}
