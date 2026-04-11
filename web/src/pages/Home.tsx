import { Link } from 'react-router-dom'
import { APPS } from '../content/apps'
import type { AppKey } from '../lib/supabase'

export default function Home() {
  return (
    <div>
      {/* ── Hero ──────────────────────────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 pt-20 pb-16 text-center">
        <h1 className="text-4xl md:text-6xl font-extrabold tracking-tight">
          AI field companions for <span className="text-[var(--color-primary)]">skilled trades</span>.
        </h1>
        <p className="mt-5 text-lg text-[var(--color-muted-fg)] max-w-2xl mx-auto">
          Purpose-built mobile apps that put expert knowledge in your hand on the jobsite — and full training at your desk.
        </p>
        <div className="mt-8 flex justify-center gap-4">
          <Link
            to="/about"
            className="px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
          >
            Learn More
          </Link>
          <Link
            to="/training"
            className="px-6 py-3 rounded-lg border border-[var(--color-border)] text-sm font-semibold hover:border-[var(--color-primary)] transition"
          >
            Explore Training
          </Link>
        </div>
      </section>

      {/* ── The Workforce Gap ─────────────────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-6xl px-4 py-20">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
              The skilled trades are facing a <span className="text-[var(--color-primary)]">critical workforce shortage</span>.
            </h2>
            <p className="text-[var(--color-muted-fg)] max-w-3xl mx-auto text-lg">
              An aging workforce, decades of underinvestment in vocational training, and a construction and infrastructure boom are colliding. The trades need more workers — and the workers that enter need to get skilled faster than ever.
            </p>
          </div>

          <div className="grid gap-6 md:grid-cols-3 text-center">
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
              <p className="text-4xl font-extrabold text-[var(--color-primary)] mb-2">650K+</p>
              <p className="text-[var(--color-muted-fg)]">
                Unfilled construction jobs in the U.S. alone — a record high, with demand still climbing.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
              <p className="text-4xl font-extrabold text-[var(--color-primary)] mb-2">53</p>
              <p className="text-[var(--color-muted-fg)]">
                Average age of a master electrician. Plumbers, welders, and fiber techs aren't far behind. Knowledge is retiring.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
              <p className="text-4xl font-extrabold text-[var(--color-primary)] mb-2">$1.2T</p>
              <p className="text-[var(--color-muted-fg)]">
                In U.S. infrastructure spending signed into law — fiber, electrical, water, and energy projects that need skilled hands.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* ── Apprentice to Journeyman ──────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 py-20">
        <div className="md:grid md:grid-cols-2 md:gap-12 items-center">
          <div>
            <h2 className="text-3xl md:text-4xl font-extrabold mb-6">
              From apprentice to journeyman, <span className="text-[var(--color-primary)]">faster</span>.
            </h2>
            <p className="text-[var(--color-muted-fg)] text-lg mb-4">
              The traditional path takes years of riding alongside a senior tech, absorbing knowledge one job at a time. That model works — but it doesn't scale when there aren't enough mentors to go around.
            </p>
            <p className="text-[var(--color-muted-fg)] text-lg mb-4">
              TradePals doesn't replace the apprenticeship. It <strong className="text-white">accelerates</strong> it. An apprentice with a Pal app learns from every job — even when they're working alone. They get instant feedback on their work, structured troubleshooting when they're stuck, and reference data at their fingertips instead of in a truck manual they forgot.
            </p>
            <p className="text-[var(--color-muted-fg)] text-lg">
              Journeymen use it too — for the edge cases, the unfamiliar equipment, the code questions that come up once a year. The goal isn't to replace expertise. It's to make expertise <strong className="text-white">available everywhere</strong>.
            </p>
          </div>
          <div className="mt-10 md:mt-0">
            <div className="space-y-4">
              <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-5">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">📸</span>
                  <div>
                    <h3 className="font-bold text-white mb-1">Photo analysis in the field</h3>
                    <p className="text-sm text-[var(--color-muted-fg)]">
                      Snap a photo of a weld, a panel, a pool, or an OTDR trace. Get an AI-powered diagnosis with ranked causes, next steps, and code references — in seconds.
                    </p>
                  </div>
                </div>
              </div>
              <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-5">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">🔧</span>
                  <div>
                    <h3 className="font-bold text-white mb-1">Troubleshooting that thinks like a senior tech</h3>
                    <p className="text-sm text-[var(--color-muted-fg)]">
                      Describe the symptom, pick the equipment, and get a structured diagnosis — probable causes ranked by likelihood, step-by-step fixes, and escalation criteria.
                    </p>
                  </div>
                </div>
              </div>
              <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-5">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">📋</span>
                  <div>
                    <h3 className="font-bold text-white mb-1">Reference data + calculators</h3>
                    <p className="text-sm text-[var(--color-muted-fg)]">
                      Wire sizing, chemical dosing, loss budgets, fixture units, motor FLA — the tables you actually need, always in your pocket. Plus AI-powered lookups for the rest.
                    </p>
                  </div>
                </div>
              </div>
              <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-5">
                <div className="flex items-start gap-3">
                  <span className="text-2xl">📶</span>
                  <div>
                    <h3 className="font-bold text-white mb-1">Works offline — syncs when you're back</h3>
                    <p className="text-sm text-[var(--color-muted-fg)]">
                      No signal in the basement? Take your photos anyway. They queue locally and process automatically when you're back online. You'll get a notification when results are ready.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* ── Training Angle ────────────────────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-6xl px-4 py-20 text-center">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Training that meets you <span className="text-[var(--color-primary)]">where you are</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] max-w-3xl mx-auto text-lg mb-10">
            Certification prep, code deep-dives, and practical guides — built for tradespeople, not students. Study for your journeyman exam on the couch, or look up a code reference in the truck between jobs.
          </p>
          <div className="grid gap-6 md:grid-cols-3">
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 text-left">
              <h3 className="font-bold text-white mb-2">Certification prep</h3>
              <p className="text-sm text-[var(--color-muted-fg)]">
                Structured content aligned to industry certifications — FOT, CFOT, AWS CWI, CPO, Journeyman, Master Plumber, NFPA 70E, and more. Each Pal app covers the certs relevant to that trade.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 text-left">
              <h3 className="font-bold text-white mb-2">Learn from every job</h3>
              <p className="text-sm text-[var(--color-muted-fg)]">
                Every analysis and troubleshoot session is saved to your history. Over time, your Pal app becomes a record of what you've seen, diagnosed, and fixed — a personal field journal powered by AI.
              </p>
            </div>
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 text-left">
              <h3 className="font-bold text-white mb-2">For employers too</h3>
              <p className="text-sm text-[var(--color-muted-fg)]">
                Contractors and service companies can equip their crews with Pal apps to reduce callbacks, speed up onboarding, and give junior techs the confidence to tackle more jobs independently.
              </p>
            </div>
          </div>
          <div className="mt-8">
            <Link
              to="/training"
              className="inline-block px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
            >
              Browse Training Content
            </Link>
          </div>
        </div>
      </section>

      {/* ── App Cards ─────────────────────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 py-20">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Choose your <span className="text-[var(--color-primary)]">trade</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg">
            Each Pal app is purpose-built for a specific trade — not a generic AI chatbot.
          </p>
        </div>

        <div className="grid gap-6 md:grid-cols-2">
          <ProductCard
            appKey="splicepal"
            bullets={[
              'OTDR trace analysis',
              'Splice troubleshooting',
              'Reference library + cert prep',
            ]}
          />
          <ProductCard
            appKey="weldpal"
            bullets={[
              'Visual weld defect analysis',
              'Troubleshooting guides',
              'AWS / API / ASME cert prep',
            ]}
          />
          <ProductCard
            appKey="poolpal"
            bullets={[
              'Water chemistry & algae photo analysis',
              'Pump, heater & equipment troubleshooting',
              'Chemical dosing & code reference',
            ]}
          />
          <ProductCard
            appKey="voltpal"
            bullets={[
              'Panel & fault photo diagnosis',
              'NEC code reference & lookups',
              'Apprentice / journeyman exam prep',
            ]}
          />
          <ProductCard
            appKey="pipepal"
            bullets={[
              'Leak & code violation photo diagnosis',
              'Water heater & drain troubleshooting',
              'Pipe sizing & code reference',
            ]}
          />
          <ComingSoonCard
            name="LiftPal"
            logo="/liftpal-logo.png"
            tagline="AI field companion for elevator & lift technicians"
            accent="#A855F7"
            bullets={[
              'Control board fault diagnosis',
              'Hoistway inspection checklists',
              'NAEC / QEI cert prep',
            ]}
          />
          <ComingSoonCard
            name="WindPal"
            logo="/windpal-logo.png"
            tagline="AI field companion for wind turbine technicians"
            accent="#22D3EE"
            bullets={[
              'Blade damage photo analysis',
              'Gearbox & generator troubleshooting',
              'GWO / BZEE cert prep',
            ]}
          />
          <ComingSoonCard
            name="MillPal"
            logo="/millpal-logo.png"
            tagline="AI field companion for millwrights & machinery mechanics"
            accent="#EF4444"
            bullets={[
              'Vibration & alignment photo diagnosis',
              'Bearing, gear & coupling troubleshooting',
              'Millwright / IMM cert prep',
            ]}
          />
        </div>
      </section>

      {/* ── CTA ───────────────────────────────────────────────────── */}
      <section className="bg-[#111114] border-t border-[var(--color-border)]">
        <div className="mx-auto max-w-3xl px-4 py-20 text-center">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Ready to work smarter?
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg mb-8">
            Pick your trade, sign up for free, and start diagnosing in the field today. No credit card required.
          </p>
          <Link
            to="/signin"
            className="inline-block px-8 py-4 rounded-lg bg-[var(--color-primary)] text-white font-bold text-base hover:opacity-90 transition"
          >
            Get Started Free
          </Link>
        </div>
      </section>
    </div>
  )
}

function ComingSoonCard({
  name,
  logo,
  tagline,
  bullets,
  accent,
}: {
  name: string
  logo?: string
  tagline: string
  bullets: string[]
  accent: string
}) {
  return (
    <div
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 relative opacity-80"
      aria-disabled="true"
    >
      <span
        className="absolute top-4 right-4 text-[11px] font-bold uppercase tracking-wider px-2 py-1 rounded"
        style={{ backgroundColor: accent, color: '#0D0D0F' }}
      >
        Coming Soon
      </span>
      <div className="mb-3 flex items-center" style={{ height: 96, width: 240 }}>
        {logo ? (
          <img src={logo} alt={name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} />
        ) : (
          <span className="text-3xl font-extrabold" style={{ color: accent }}>
            {name}
          </span>
        )}
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4">{tagline}</p>
      <ul className="space-y-1 text-sm">
        {bullets.map((b) => (
          <li key={b}>• {b}</li>
        ))}
      </ul>
      <div className="mt-5 text-sm font-semibold text-[var(--color-muted)]">
        In development
      </div>
    </div>
  )
}

function ProductCard({ appKey, bullets }: { appKey: AppKey; bullets: string[] }) {
  const app = APPS[appKey]
  return (
    <Link
      to={`/${appKey}`}
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 transition-colors"
      style={{ borderColor: 'var(--color-border)' }}
      onMouseEnter={(e) => (e.currentTarget.style.borderColor = app.primary)}
      onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
    >
      <div
        className="mb-3 flex items-center justify-start"
        style={{ height: 96, width: 240 }}
      >
        <img
          src={app.logo}
          alt={app.name}
          style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }}
        />
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4">{app.tagline}</p>
      <ul className="space-y-1 text-sm">
        {bullets.map((b) => (
          <li key={b}>• {b}</li>
        ))}
      </ul>
      <div className="mt-5 flex items-center gap-4">
        <span className="text-sm font-semibold" style={{ color: app.primary }}>
          Learn more →
        </span>
        {app.appUrl && (
          <a
            href={app.appUrl}
            className="text-sm font-semibold px-4 py-2 rounded-md"
            style={{ backgroundColor: app.primary, color: '#0D0D0F' }}
            onClick={(e) => e.stopPropagation()}
          >
            Launch
          </a>
        )}
      </div>
    </Link>
  )
}
