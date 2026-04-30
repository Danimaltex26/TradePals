import { useState } from 'react'
import { Link, useLocation, useNavigate } from 'react-router-dom'
import { track } from '@vercel/analytics'
import { useAuth } from '../auth/AuthProvider'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'

type LocationState = { app?: AppKey; redirect?: string } | null

const APP_LIST: { key: AppKey; color: string }[] = [
  { key: 'splicepal', color: '#33cc33' },
  { key: 'weldpal', color: '#F97316' },
  { key: 'poolpal', color: '#14B8A6' },
  { key: 'voltpal', color: '#FACC15' },
  { key: 'pipepal', color: '#3B82F6' },
  { key: 'windpal', color: '#22D3EE' },
  { key: 'liftpal', color: '#A855F7' },
]

export default function SignIn() {
  const auth = useAuth()
  const nav = useNavigate()
  const location = useLocation()
  const state = location.state as LocationState
  const [app, setApp] = useState<AppKey | null>(state?.app ?? null)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const selected = app ? APPS[app] : null
  const selectedColor = app ? APP_LIST.find(a => a.key === app)?.color || '#4B9CD3' : '#4B9CD3'

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!app || !email.trim() || !password) return
    setError('')
    setLoading(true)
    try {
      await auth.signIn(app, email.trim(), password)
      track('sign_in', { app })
      nav(state?.redirect ?? `/${app}/training`, { replace: true })
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Sign in failed.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="mx-auto max-w-lg px-4 py-16">
      <h1 className="text-3xl font-extrabold text-center mb-2">Training Sign In</h1>
      <p className="text-center text-[var(--color-muted-fg)] mb-8">
        Access certification prep and training content on the web.
      </p>

      {/* Step 1: Choose your app */}
      <div className="mb-8">
        <div className="flex items-center gap-2 mb-4">
          <span className="w-7 h-7 rounded-full bg-[var(--color-primary)] text-white text-xs font-bold flex items-center justify-center flex-shrink-0">1</span>
          <span className="text-sm font-semibold text-white">Choose your trade app</span>
        </div>
        <div className="grid grid-cols-4 gap-3">
          {APP_LIST.map(({ key, color }) => {
            const cfg = APPS[key]
            const active = app === key
            return (
              <button
                key={key}
                type="button"
                onClick={() => { setApp(key); setError('') }}
                className="flex flex-col items-center gap-1.5 p-3 rounded-xl transition"
                style={{
                  backgroundColor: active ? color + '18' : 'var(--color-card)',
                  border: active ? `2px solid ${color}` : '2px solid var(--color-border)',
                }}
              >
                <img
                  src={cfg.logo}
                  alt={cfg.name}
                  style={{ height: 28, width: 'auto', objectFit: 'contain' }}
                />
                <span className="text-[10px] font-semibold" style={{ color: active ? color : '#A0A0A8' }}>
                  {cfg.name}
                </span>
              </button>
            )
          })}
        </div>
      </div>

      {/* Step 2: Sign in */}
      <div style={{ opacity: app ? 1 : 0.4, pointerEvents: app ? 'auto' : 'none', transition: 'opacity 0.2s' }}>
        <div className="flex items-center gap-2 mb-4">
          <span className="w-7 h-7 rounded-full bg-[var(--color-primary)] text-white text-xs font-bold flex items-center justify-center flex-shrink-0">2</span>
          <span className="text-sm font-semibold text-white">
            Sign in{selected ? ` to ${selected.name}` : ''}
          </span>
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
              placeholder="you@example.com"
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
              placeholder="Your password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              autoComplete="current-password"
            />
          </div>
          <button
            type="submit"
            className="w-full h-11 rounded-md font-semibold disabled:opacity-60 transition"
            style={{
              backgroundColor: selectedColor,
              color: app === 'voltpal' ? '#0D0D0F' : '#fff',
            }}
            disabled={loading || !app}
          >
            {loading ? 'Signing in…' : app ? `Sign In to ${selected?.name} Training` : 'Select an app above'}
          </button>
        </form>

        <p className="text-center text-xs text-[var(--color-muted)] mt-5">
          Use the same email and password from your Pal app.
        </p>

        {app && (
          <p className="text-center text-sm text-[var(--color-muted-fg)] mt-4">
            Don't have an account?{' '}
            <Link to={`/${app}`} className="font-semibold" style={{ color: selectedColor }}>
              Sign up in {selected?.name}
            </Link>{' '}
            first.
          </p>
        )}
      </div>
    </div>
  )
}
