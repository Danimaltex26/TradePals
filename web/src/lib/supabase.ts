import { createClient, type SupabaseClient } from '@supabase/supabase-js'

export type AppKey = 'splicepal' | 'weldpal' | 'poolpal' | 'voltpal'

const splicepalUrl = import.meta.env.VITE_SPLICEPAL_SUPABASE_URL
const splicepalKey = import.meta.env.VITE_SPLICEPAL_SUPABASE_ANON_KEY
const weldpalUrl = import.meta.env.VITE_WELDPAL_SUPABASE_URL
const weldpalKey = import.meta.env.VITE_WELDPAL_SUPABASE_ANON_KEY
const poolpalUrl = import.meta.env.VITE_POOLPAL_SUPABASE_URL || splicepalUrl
const poolpalKey = import.meta.env.VITE_POOLPAL_SUPABASE_ANON_KEY || splicepalKey
const voltpalUrl = import.meta.env.VITE_VOLTPAL_SUPABASE_URL || splicepalUrl
const voltpalKey = import.meta.env.VITE_VOLTPAL_SUPABASE_ANON_KEY || splicepalKey

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

export const poolpalClient: SupabaseClient = createClient(
  poolpalUrl ?? 'https://placeholder.supabase.co',
  poolpalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-poolpal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export const voltpalClient: SupabaseClient = createClient(
  voltpalUrl ?? 'https://placeholder.supabase.co',
  voltpalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-voltpal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export function getClient(app: AppKey): SupabaseClient {
  if (app === 'splicepal') return splicepalClient
  if (app === 'poolpal') return poolpalClient
  if (app === 'voltpal') return voltpalClient
  return weldpalClient
}
