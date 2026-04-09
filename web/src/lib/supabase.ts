import { createClient, type SupabaseClient } from '@supabase/supabase-js'

export type AppKey = 'splicepal' | 'weldpal'

const splicepalUrl = import.meta.env.VITE_SPLICEPAL_SUPABASE_URL
const splicepalKey = import.meta.env.VITE_SPLICEPAL_SUPABASE_ANON_KEY
const weldpalUrl = import.meta.env.VITE_WELDPAL_SUPABASE_URL
const weldpalKey = import.meta.env.VITE_WELDPAL_SUPABASE_ANON_KEY

if (!splicepalUrl || !splicepalKey || !weldpalUrl || !weldpalKey) {
  console.warn(
    '[TradePals] One or more Supabase env vars missing. Auth and entitlement checks will not work until configured.'
  )
}

// Each app stores its session in its own storage key so a user can be
// signed into both at the same time without collision.
export const splicepalClient: SupabaseClient = createClient(
  splicepalUrl ?? 'https://placeholder.supabase.co',
  splicepalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-splicepal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export const weldpalClient: SupabaseClient = createClient(
  weldpalUrl ?? 'https://placeholder.supabase.co',
  weldpalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-weldpal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export function getClient(app: AppKey): SupabaseClient {
  return app === 'splicepal' ? splicepalClient : weldpalClient
}
