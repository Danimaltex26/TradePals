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
  // ── SEO ────────────────────────────────────────────────────────
  /** <title> for the /[app] product page. Keep under ~60 chars for SERP truncation. */
  metaTitle: string
  /** Meta description for the /[app] product page. Aim for 140–160 chars. */
  metaDescription: string
  /** Certs supported in this app — used for keywords + structured data. */
  certs: string[]
}

export const APPS: Record<AppKey, AppConfig> = {
  splicepal: {
    key: 'splicepal',
    name: 'SplicePal',
    tagline: 'AI assistant for fiber splicers',
    logo: '/splicepal-logo.png',
    primary: '#33cc33',
    appUrl: 'https://splicepal.tradepals.net',
    metaTitle: 'SplicePal — AI Fiber Companion + CFOT Exam Prep',
    metaDescription:
      'Pass CFOT on the first try. Get on a BEAD project. SplicePal is the AI field companion for fiber splicers — OTDR trace analysis, splice troubleshooting, and FOA cert prep in one app.',
    certs: ['CFOT', 'CFOS/S', 'CFOS/T', 'CFOS/O', 'BFT', 'FOT'],
  },
  weldpal: {
    key: 'weldpal',
    name: 'WeldPal',
    tagline: 'AI field companion for welders & CWIs',
    logo: '/weldpal-logo.png',
    primary: '#F97316',
    appUrl: 'https://weldpal.tradepals.net',
    metaTitle: 'WeldPal — AI Welding Companion + AWS CWI Prep',
    metaDescription:
      'AI field companion for welders and Certified Welding Inspectors. Diagnose weld defects from a photo, look up codes, and prep for AWS CWI, CWS, and CWE — all in one app.',
    certs: ['CWI', 'CWS', 'CWE', 'AWS Certified Welder'],
  },
  poolpal: {
    key: 'poolpal',
    name: 'PoolPal',
    tagline: 'AI field companion for pool & spa service techs',
    logo: '/poolpal-logo.png',
    primary: '#14B8A6',
    appUrl: 'https://poolpal.tradepals.net',
    metaTitle: 'PoolPal — AI Pool Tech Companion + CPO Renewal Prep',
    metaDescription:
      'Diagnose chlorine, pH, and equipment issues in 30 seconds. Built for pool and spa service techs, with PHTA CPO renewal prep and pump/filter reference in one app.',
    certs: ['CPO', 'CPSP'],
  },
  voltpal: {
    key: 'voltpal',
    name: 'VoltPal',
    tagline: 'AI field companion for industrial electricians',
    logo: '/voltpal-logo.png',
    primary: '#FACC15',
    appUrl: 'https://voltpal.tradepals.net',
    metaTitle: 'VoltPal — AI Electrician Companion + NEC 2026 + Journeyman Prep',
    metaDescription:
      'NEC 2026 in your pocket. AI field companion for electricians — diagnose panels, motors, and circuits with journeyman and master license prep built in.',
    certs: ['Journeyman', 'Master Electrician', 'NEC 2026', 'EVITP', 'NFPA 70E'],
  },
  pipepal: {
    key: 'pipepal',
    name: 'PipePal',
    tagline: 'AI field companion for plumbers, pipefitters & steamfitters',
    logo: '/pipepal-logo.png',
    primary: '#3B82F6',
    appUrl: 'https://pipepal.tradepals.net',
    metaTitle: 'PipePal — AI Plumbing Companion + Master Plumber Prep',
    metaDescription:
      'Code interpreted for the job in front of you. AI field companion for plumbers, pipefitters, and steamfitters — gas, water, and master plumber license prep in one app.',
    certs: ['Journeyman Plumber', 'Master Plumber', 'UA', 'PHCC'],
  },
  windpal: {
    key: 'windpal',
    name: 'WindPal',
    tagline: 'AI field companion for wind turbine technicians',
    logo: '/windpal-logo.png',
    primary: '#22D3EE',
    appUrl: 'https://windpal.tradepals.net',
    metaTitle: 'WindPal — AI Wind Tech Companion + GWO Refresh',
    metaDescription:
      '300 feet up, alone, nacelle alarm screaming — who do you call? WindPal walks you through fault codes, climb safety, and GWO BST refresh in one field companion app.',
    certs: ['GWO BST', 'OSHA 10', 'OSHA 30'],
  },
  liftpal: {
    key: 'liftpal',
    name: 'LiftPal',
    tagline: 'AI field companion for elevator & lift technicians',
    logo: '/liftpal-logo.png',
    primary: '#A855F7',
    appUrl: 'https://liftpal.tradepals.net',
    metaTitle: 'LiftPal — AI Elevator Tech Companion + NEIEP / CET / QEI Prep',
    metaDescription:
      'Hoistway alarm at 2am? LiftPal walks you through the fault tree before your supervisor picks up. NEIEP capstone, CET, and QEI inspector prep built in.',
    certs: ['NEIEP', 'CET', 'QEI', 'OSHA 10', 'OSHA 30'],
  },
}
