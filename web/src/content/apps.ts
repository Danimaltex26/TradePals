import type { AppKey } from '../lib/supabase'

export type AppConfig = {
  key: AppKey
  name: string
  tagline: string
  logo: string
  /** Hex color used for headings, links, and CTA buttons on this app's pages. */
  primary: string
}

export const APPS: Record<AppKey, AppConfig> = {
  splicepal: {
    key: 'splicepal',
    name: 'SplicePal',
    tagline: 'AI assistant for fiber splicers',
    logo: '/splicepal-logo.png',
    primary: '#33cc33',
  },
  weldpal: {
    key: 'weldpal',
    name: 'WeldPal',
    tagline: 'AI field companion for welders & CWIs',
    logo: '/weldpal-logo.png',
    primary: '#F97316',
  },
}
