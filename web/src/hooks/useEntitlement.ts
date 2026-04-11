import { useEffect, useState } from 'react'
import { getClient, type AppKey } from '../lib/supabase'
import { useAuth } from '../auth/AuthProvider'

export type EntitlementState = {
  loading: boolean
  active: boolean
  tier: string | null
  expiresAt: string | null
  error: string | null
}

/**
 * Reads from public.subscriptions for the given (user, app) pair.
 * RLS on the server is the real gate — this hook is for UX only.
 */
export function useEntitlement(app: AppKey): EntitlementState {
  const auth = useAuth()
  const appAuth = auth[app]
  const [state, setState] = useState<EntitlementState>({
    loading: true,
    active: false,
    tier: null,
    expiresAt: null,
    error: null,
  })

  useEffect(() => {
    if (appAuth.loading) return
    if (!appAuth.user) {
      setState({ loading: false, active: false, tier: null, expiresAt: null, error: null })
      return
    }

    let cancelled = false
    const client = getClient(app)
    client
      .from('subscriptions')
      .select('tier, expires_at')
      .eq('user_id', appAuth.user.id)
      .eq('app', app)
      .maybeSingle()
      .then(({ data, error }) => {
        if (cancelled) return
        if (error) {
          setState({ loading: false, active: false, tier: null, expiresAt: null, error: error.message })
          return
        }
        const tier = (data?.tier ?? 'free') as string
        const expiresAt = (data?.expires_at ?? null) as string | null
        const isActiveTier = tier.toLowerCase() !== 'free'
        const notExpired = !expiresAt || new Date(expiresAt) > new Date()
        setState({
          loading: false,
          active: isActiveTier && notExpired,
          tier,
          expiresAt,
          error: null,
        })
      })

    return () => {
      cancelled = true
    }
  }, [app, appAuth.user, appAuth.loading])

  return state
}
