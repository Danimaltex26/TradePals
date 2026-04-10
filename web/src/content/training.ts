import type { AppKey } from '../lib/supabase'

export type Article = {
  slug: string
  title: string
  description: string
  body: string
}

const splicepalArticles: Article[] = [
  {
    slug: 'reading-otdr-traces',
    title: 'Reading OTDR Traces',
    description: 'How to interpret events, attenuation, and reflectance on a typical OTDR trace.',
    body: `An OTDR trace is the fingerprint of a fiber link. The horizontal axis is distance, the vertical axis is signal level in dB. The launch end is at the left, the far end at the right.

Key features to read first:
- The dead zone immediately after the launch — ignore data inside it.
- Connector events appear as small reflective spikes followed by a small loss step.
- Splice events appear as small non-reflective drops.
- The end-of-fiber event is the final reflective spike (or noise floor).

This is placeholder content. Full training will be added here.`,
  },
]

const weldpalArticles: Article[] = [
  {
    slug: 'visual-defects-cheat-sheet',
    title: 'Visual Defects Cheat Sheet',
    description: 'Quick reference for the most common surface defects on fillet and groove welds.',
    body: `Visual inspection catches the majority of weldment problems before NDT is even ordered. The defects you should be able to identify on sight:

- **Undercut** — groove melted into base metal at the toe, not filled.
- **Overlap** — weld metal flowing past the toe without fusing.
- **Porosity** — gas pockets in the weld face.
- **Convexity** — fillet weld face bulging above the leg-to-leg line.
- **Crater cracks** — star-shaped cracks at the end of a weld pass. Never acceptable per AWS D1.1.

This is placeholder content. Full training will be added here.`,
  },
]

const poolpalArticles: Article[] = [
  {
    slug: 'water-chemistry-basics',
    title: 'Water Chemistry Basics',
    description: 'Understanding pH, alkalinity, calcium hardness, and how they interact.',
    body: `Balanced water chemistry is the foundation of pool maintenance. The three core parameters — pH, total alkalinity (TA), and calcium hardness (CH) — interact constantly, and adjusting one affects the others.

- **pH** (7.2–7.8) controls sanitizer effectiveness and bather comfort.
- **Total Alkalinity** (80–120 ppm) buffers pH from bouncing.
- **Calcium Hardness** (250–350 ppm plaster, 150–250 vinyl) prevents etching or scaling.

This is placeholder content. Full training will be added here.`,
  },
]

const voltpalArticles: Article[] = [
  {
    slug: 'electrical-safety-basics',
    title: 'Electrical Safety Basics',
    description: 'Fundamental safety practices every industrial electrician should follow before working on energized or de-energized equipment.',
    body: `Electrical safety starts before you pick up a tool. The hierarchy of risk control — eliminate, substitute, engineering controls, administrative controls, PPE — applies to every task.

Key principles:
- **Lockout/Tagout (LOTO)** — always verify zero energy before hands-on work. Use your own lock and tag.
- **Live-dead-live** — test your meter on a known live source, test the circuit, then retest on the known live source.
- **Arc flash boundaries** — know the limited, restricted, and prohibited approach boundaries per NFPA 70E.
- **PPE selection** — match your PPE to the incident energy (cal/cm²) identified on the arc flash label.

This is placeholder content. Full training will be added here.`,
  },
]

const ARTICLES: Record<AppKey, Article[]> = {
  splicepal: splicepalArticles,
  weldpal: weldpalArticles,
  poolpal: poolpalArticles,
  voltpal: voltpalArticles,
}

export function listArticles(app: AppKey): Article[] {
  return ARTICLES[app]
}

export function getArticle(app: AppKey, slug: string): Article | undefined {
  return ARTICLES[app].find((a) => a.slug === slug)
}
