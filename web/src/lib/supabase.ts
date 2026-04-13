import { createClient, type SupabaseClient } from '@supabase/supabase-js'

export type AppKey = 'splicepal' | 'weldpal' | 'poolpal' | 'voltpal' | 'pipepal' | 'windpal' | 'liftpal'

const splicepalUrl = import.meta.env.VITE_SPLICEPAL_SUPABASE_URL
const splicepalKey = import.meta.env.VITE_SPLICEPAL_SUPABASE_ANON_KEY
const weldpalUrl = import.meta.env.VITE_WELDPAL_SUPABASE_URL
const weldpalKey = import.meta.env.VITE_WELDPAL_SUPABASE_ANON_KEY
const poolpalUrl = import.meta.env.VITE_POOLPAL_SUPABASE_URL || splicepalUrl
const poolpalKey = import.meta.env.VITE_POOLPAL_SUPABASE_ANON_KEY || splicepalKey
const voltpalUrl = import.meta.env.VITE_VOLTPAL_SUPABASE_URL || splicepalUrl
const voltpalKey = import.meta.env.VITE_VOLTPAL_SUPABASE_ANON_KEY || splicepalKey
const pipepalUrl = import.meta.env.VITE_PIPEPAL_SUPABASE_URL || splicepalUrl
const pipepalKey = import.meta.env.VITE_PIPEPAL_SUPABASE_ANON_KEY || splicepalKey
const windpalUrl = import.meta.env.VITE_WINDPAL_SUPABASE_URL || splicepalUrl
const windpalKey = import.meta.env.VITE_WINDPAL_SUPABASE_ANON_KEY || splicepalKey
const liftpalUrl = import.meta.env.VITE_LIFTPAL_SUPABASE_URL || splicepalUrl
const liftpalKey = import.meta.env.VITE_LIFTPAL_SUPABASE_ANON_KEY || splicepalKey

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

export const pipepalClient: SupabaseClient = createClient(
  pipepalUrl ?? 'https://placeholder.supabase.co',
  pipepalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-pipepal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export const windpalClient: SupabaseClient = createClient(
  windpalUrl ?? 'https://placeholder.supabase.co',
  windpalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-windpal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export const liftpalClient: SupabaseClient = createClient(
  liftpalUrl ?? 'https://placeholder.supabase.co',
  liftpalKey ?? 'placeholder',
  {
    auth: {
      storageKey: 'tradepals-liftpal-auth',
      persistSession: true,
      autoRefreshToken: true,
    },
  }
)

export function getClient(app: AppKey): SupabaseClient {
  if (app === 'splicepal') return splicepalClient
  if (app === 'poolpal') return poolpalClient
  if (app === 'voltpal') return voltpalClient
  if (app === 'pipepal') return pipepalClient
  if (app === 'windpal') return windpalClient
  if (app === 'liftpal') return liftpalClient
  return weldpalClient
}

/** Returns the Supabase schema name for training tables */
export function getTrainingSchema(app: AppKey): string {
  const schemas: Record<AppKey, string> = {
    splicepal: 'splicepal',
    weldpal: 'weldpal',
    poolpal: 'poolpal',
    voltpal: 'voltpal',
    pipepal: 'pipepal',
    windpal: 'windpal',
    liftpal: 'liftpal',
  }
  return schemas[app]
}
