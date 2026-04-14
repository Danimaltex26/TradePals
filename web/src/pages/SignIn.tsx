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

      <div className="grid grid-cols-4 gap-2 mb-6 p-2 rounded-lg border border-[var(--color-border)] bg-[var(--color-card)]">
        <AppToggle current={app} value="splicepal" onClick={setApp} label="SplicePal" color="#33cc33" />
        <AppToggle current={app} value="weldpal" onClick={setApp} label="WeldPal" color="#F97316" />
        <AppToggle current={app} value="poolpal" onClick={setApp} label="PoolPal" color="#14B8A6" />
        <AppToggle current={app} value="voltpal" onClick={setApp} label="VoltPal" color="#FACC15" />
        <AppToggle current={app} value="pipepal" onClick={setApp} label="PipePal" color="#3B82F6" />
        <AppToggle current={app} value="windpal" onClick={setApp} label="WindPal" color="#22D3EE" />
        <AppToggle current={app} value="liftpal" onClick={setApp} label="LiftPal" color="#A855F7" />
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
  color,
}: {
  current: AppKey
  value: AppKey
  onClick: (a: AppKey) => void
  label: string
  color: string
}) {
  const active = current === value
  return (
    <button
      type="button"
      onClick={() => onClick(value)}
      className="h-9 rounded-md text-sm font-semibold transition"
      style={{
        backgroundColor: active ? color : 'transparent',
        color: active ? (value === 'voltpal' ? '#0D0D0F' : '#fff') : '#A0A0A8',
        border: active ? 'none' : '1px solid transparent',
      }}
    >
      {label}
    </button>
  )
}
