import type { AppKey } from '../lib/supabase'

export type AppConfig = {
  key: AppKey
  name: string
  tagline: string
  logo: string
  /** Hex color used for headings, links, and CTA buttons on this app's pages. */
  primary: string
  /** Live app URL (subdomain). Undefined = not yet deployed. */
  appUrl?: string
}

export const APPS: Record<AppKey, AppConfig> = {
  splicepal: {
    key: 'splicepal',
    name: 'SplicePal',
    tagline: 'AI assistant for fiber splicers',
    logo: '/splicepal-logo.png',
    primary: '#33cc33',
    appUrl: 'https://splicepal.tradepals.net',
  },
  weldpal: {
    key: 'weldpal',
    name: 'WeldPal',
    tagline: 'AI field companion for welders & CWIs',
    logo: '/weldpal-logo.png',
    primary: '#F97316',
    appUrl: 'https://weldpal.tradepals.net',
  },
  poolpal: {
    key: 'poolpal',
    name: 'PoolPal',
    tagline: 'AI field companion for pool & spa service techs',
    logo: '/poolpal-logo.png',
    primary: '#14B8A6',
    appUrl: 'https://poolpal.tradepals.net',
  },
  voltpal: {
    key: 'voltpal',
    name: 'VoltPal',
    tagline: 'AI field companion for industrial electricians',
    logo: '/voltpal-logo.png',
    primary: '#FACC15',
    appUrl: 'https://voltpal.tradepals.net',
  },
  pipepal: {
    key: 'pipepal',
    name: 'PipePal',
    tagline: 'AI field companion for plumbers, pipefitters & steamfitters',
    logo: '/pipepal-logo.png',
    primary: '#3B82F6',
    appUrl: 'https://pipepal.tradepals.net',
  },
  windpal: {
    key: 'windpal',
    name: 'WindPal',
    tagline: 'AI field companion for wind turbine technicians',
    logo: '/windpal-logo.png',
    primary: '#10B981',
    appUrl: 'https://windpal.tradepals.net',
  },
}
