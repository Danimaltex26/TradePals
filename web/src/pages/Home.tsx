import { useState } from 'react'
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
          Purpose-built mobile apps that put expert knowledge in your hand on the jobsite. Not a generic AI chatbot — a tool built by tradespeople, for tradespeople.
        </p>
        <div className="mt-8 flex justify-center gap-4 flex-wrap">
          <a
            href="#apps"
            className="px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
          >
            Choose Your Trade
          </a>
          <a
            href="#demo"
            className="px-6 py-3 rounded-lg border border-[var(--color-border)] text-sm font-semibold hover:border-[var(--color-primary)] transition"
          >
            See It In Action
          </a>
        </div>
      </section>

      {/* ── Quick App Grid (compact) ────────────────────────────── */}
      <section className="mx-auto max-w-5xl px-4 pb-12">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-3">
          <QuickAppCard appKey="splicepal" bullet="OTDR & splice analysis" />
          <QuickAppCard appKey="weldpal" bullet="Weld defect diagnosis" />
          <QuickAppCard appKey="poolpal" bullet="Water chemistry & equipment" />
          <QuickAppCard appKey="voltpal" bullet="Panel & motor diagnosis" />
          <QuickAppCard appKey="pipepal" bullet="Leak & code diagnosis" />
          <QuickAppCard appKey="windpal" bullet="Blade & turbine inspection" />
          <QuickAppCard appKey="liftpal" bullet="Elevator & escalator inspection" />
          <Link
            to="/#apps"
            className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-4 flex flex-col items-center justify-center text-center hover:border-[var(--color-primary)] transition"
          >
            <span className="text-2xl mb-1">+</span>
            <span className="text-xs text-[var(--color-muted-fg)]">More coming</span>
          </Link>
        </div>
      </section>

      {/* ── Pull Quote ────────────────────────────────────────────── */}
      <section className="mx-auto max-w-4xl px-4 pb-16 text-center">
        <blockquote className="text-2xl md:text-3xl font-extrabold italic text-white leading-snug">
          "TradePals doesn't replace the apprenticeship.{' '}
          <span className="text-[var(--color-primary)]">It accelerates it.</span>"
        </blockquote>
      </section>

      {/* ── The Workforce Gap ─────────────────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-6xl px-4 py-20">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
              The skilled trades are facing a <span className="text-[var(--color-primary)]">critical workforce shortage</span>.
            </h2>
            <p className="text-[var(--color-muted-fg)] max-w-3xl mx-auto text-lg">
              An aging workforce, decades of underinvestment in vocational training, and an infrastructure boom are colliding. The trades need more workers — and the workers that enter need to get skilled faster than ever.
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

      {/* ── How It Works (3 steps) ────────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 py-20">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            How it <span className="text-[var(--color-primary)]">works</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg">
            Three steps. No training required. Works in the field on day one.
          </p>
        </div>
        <div className="grid gap-8 md:grid-cols-3">
          <div className="text-center">
            <div className="w-16 h-16 rounded-full bg-[var(--color-primary)] text-white text-2xl font-extrabold flex items-center justify-center mx-auto mb-4">1</div>
            <h3 className="font-bold text-white text-lg mb-2">Take a photo or describe the problem</h3>
            <p className="text-[var(--color-muted-fg)] text-sm mb-6">
              Snap a pic of a weld, a panel, a pool, a pipe — or type in the symptom and equipment. Works offline too.
            </p>
            <div className="mx-auto" style={{ width: 200, borderRadius: 24, border: '3px solid #2A2A2E', background: '#111114', overflow: 'hidden' }}>
              <img src="/watch1.png" alt="Take a photo" style={{ width: '100%', display: 'block' }} />
            </div>
            <p className="text-[var(--color-muted)] text-xs mt-2">Shown in SplicePal</p>
          </div>
          <div className="text-center">
            <div className="w-16 h-16 rounded-full bg-[var(--color-primary)] text-white text-2xl font-extrabold flex items-center justify-center mx-auto mb-4">2</div>
            <h3 className="font-bold text-white text-lg mb-2">Get an AI diagnosis in seconds</h3>
            <p className="text-[var(--color-muted-fg)] text-sm mb-6">
              Ranked probable causes, step-by-step fixes, parts to check, code references, and escalation criteria — structured like a senior tech would explain it.
            </p>
            <div className="mx-auto" style={{ width: 200, borderRadius: 24, border: '3px solid #2A2A2E', background: '#111114', overflow: 'hidden' }}>
              <img src="/watch2.png" alt="AI diagnosis" style={{ width: '100%', display: 'block' }} />
            </div>
            <p className="text-[var(--color-muted)] text-xs mt-2">Shown in SplicePal</p>
          </div>
          <div className="text-center">
            <div className="w-16 h-16 rounded-full bg-[var(--color-primary)] text-white text-2xl font-extrabold flex items-center justify-center mx-auto mb-4">3</div>
            <h3 className="font-bold text-white text-lg mb-2">Save, learn, and prep for your cert</h3>
            <p className="text-[var(--color-muted-fg)] text-sm mb-6">
              Every diagnosis is saved to your history. Over time, your Pal app becomes a personal field journal — and your training library for the next certification.
            </p>
            <div className="mx-auto" style={{ width: 200, borderRadius: 24, border: '3px solid #2A2A2E', background: '#111114', overflow: 'hidden' }}>
              <img src="/watch3.png" alt="Save and learn" style={{ width: '100%', display: 'block' }} />
            </div>
            <p className="text-[var(--color-muted)] text-xs mt-2">Shown in SplicePal</p>
          </div>
        </div>
      </section>

      {/* ── Demo Video Placeholder ────────────────────────────────── */}
      <section id="demo" className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-4xl px-4 py-20 text-center">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            See it in <span className="text-[var(--color-primary)]">action</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg mb-8">
            Watch a real diagnosis — from photo to fix — in under 90 seconds.
          </p>
          <video
            className="mx-auto rounded-2xl border border-[var(--color-border)]"
            style={{ maxWidth: 400, maxHeight: 500, width: '100%' }}
            controls
            playsInline
            preload="metadata"
          >
            <source src="/ExampleSplice.mp4" type="video/mp4" />
            <source src="/ExampleSplice.mov" type="video/quicktime" />
            Your browser does not support the video tag.
          </video>
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
              An apprentice with a Pal app learns from every job — even when they're working alone. They get instant feedback on their work, structured troubleshooting when they're stuck, and reference data at their fingertips.
            </p>
            <p className="text-[var(--color-muted-fg)] text-lg">
              Journeymen use it too — for the edge cases, the unfamiliar equipment, the code questions that come up once a year. The goal isn't to replace expertise. It's to make expertise <strong className="text-white">available everywhere</strong>.
            </p>
          </div>
          <div className="mt-10 md:mt-0">
            <div className="space-y-4">
              <FeatureCard
                emoji="📸"
                title="Photo analysis in the field"
                desc="Snap a photo of a weld, a panel, a pool, or an OTDR trace. Get an AI-powered diagnosis with ranked causes, next steps, and code references — in seconds."
              />
              <FeatureCard
                emoji="🔧"
                title="Troubleshooting that thinks like a senior tech"
                desc="Describe the symptom, pick the equipment, and get a structured diagnosis — probable causes ranked by likelihood, step-by-step fixes, and escalation criteria."
              />
              <FeatureCard
                emoji="📋"
                title="Reference data + calculators"
                desc="Wire sizing, chemical dosing, loss budgets, fixture units, motor FLA — the tables you actually need, always in your pocket."
              />
              <FeatureCard
                emoji="📶"
                title="Works offline — syncs when you're back"
                desc="No signal in the basement? Take your photos anyway. They queue locally and process automatically when you reconnect."
              />
            </div>
          </div>
        </div>
      </section>

      {/* ── Social Proof / Testimonials ───────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-6xl px-4 py-20">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
              Trusted by techs <span className="text-[var(--color-primary)]">in the field</span>.
            </h2>
          </div>
          <div className="grid gap-6 md:grid-cols-3">
            {/* Placeholder testimonials — replace with real quotes */}
            <TestimonialCard
              quote="I used to call my foreman every time I hit an unfamiliar splice. Now I pull up SplicePal, snap a photo of the trace, and have an answer before he'd even pick up the phone."
              name="Marcus T."
              role="Fiber Splicer, 3 years experience"
              trade="splicepal"
            />
            <TestimonialCard
              quote="The troubleshooting wizard walked me through a VFD fault code I'd never seen on a Yaskawa drive. Saved me two hours and a service call."
              name="John G."
              role="Industrial Electrician, Journeyman"
              trade="voltpal"
            />
            <TestimonialCard
              quote="The LSI calculator alone is worth it. I used to fumble with the Orenda app — this one just works, and the treatment plan tells me exactly what to add."
              name="Ryan P."
              role="Pool Service Tech, CPO certified"
              trade="poolpal"
            />
          </div>
          <p className="text-center text-[var(--color-muted)] text-sm mt-8">
            Want to share your experience?{' '}
            <a href="mailto:support@tradepals.net" className="text-[var(--color-primary)]">Get in touch</a>.
          </p>
        </div>
      </section>

      {/* ── Training Section ──────────────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 py-20">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Training that meets you <span className="text-[var(--color-primary)]">where you are</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] max-w-3xl mx-auto text-lg">
            Certification prep, code deep-dives, and practical guides — built for tradespeople, not students.
          </p>
        </div>
        <div className="grid gap-6 md:grid-cols-3">
          <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
            <h3 className="font-bold text-white mb-2">Certification prep</h3>
            <p className="text-sm text-[var(--color-muted-fg)]">
              Structured content aligned to industry certs — FOT, CFOT, AWS CWI, CPO, Journeyman, Master Plumber, NFPA 70E, and more. Each Pal app covers the certs relevant to that trade.
            </p>
          </div>
          <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
            <h3 className="font-bold text-white mb-2">Learn from every job</h3>
            <p className="text-sm text-[var(--color-muted-fg)]">
              Every analysis and troubleshoot session is saved to your history. Over time, your Pal app becomes a record of what you've seen, diagnosed, and fixed — a personal field journal powered by AI.
            </p>
          </div>
          <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
            <h3 className="font-bold text-white mb-2">Study anywhere</h3>
            <p className="text-sm text-[var(--color-muted-fg)]">
              Study for your journeyman exam on the couch, or look up a code reference in the truck between jobs. Training content is always available on the web — no app download required.
            </p>
          </div>
        </div>
        <div className="mt-8 text-center">
          <Link
            to="/training"
            className="inline-block px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
          >
            Browse Training Content
          </Link>
        </div>
      </section>

      {/* ── Pricing ───────────────────────────────────────────────── */}
      <PricingSection />

      {/* ── For Employers ─────────────────────────────────────────── */}
      <section className="mx-auto max-w-6xl px-4 py-20">
        <div className="max-w-2xl">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-6">
            Equip your <span className="text-[var(--color-primary)]">entire crew</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg mb-4">
            Contractors and service companies use Pal apps to reduce callbacks, speed up onboarding, and give junior techs the confidence to handle more jobs independently.
          </p>
          <p className="text-[var(--color-muted-fg)] text-lg mb-4">
            When your newest apprentice has a master-level reference tool in their pocket, your whole operation runs smoother. Fewer phone calls to the foreman, fewer repeat visits, faster time to billable independence.
          </p>
          <ul className="space-y-2 text-[var(--color-muted-fg)] mb-6">
            <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Reduce callbacks</strong> — junior techs diagnose correctly the first time</li>
            <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Faster onboarding</strong> — new hires contribute sooner</li>
            <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Consistent quality</strong> — every tech has the same reference library</li>
            <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Certification tracking</strong> — monitor your team's cert progress</li>
          </ul>
          <a
            href="mailto:teams@tradepals.net"
            className="inline-block px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
          >
            Contact Us for Team Pricing
          </a>
        </div>
      </section>

      {/* ── App Cards ─────────────────────────────────────────────── */}
      <section id="apps" className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-6xl px-4 py-20">
          <div className="text-center mb-12">
            <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
              Choose your <span className="text-[var(--color-primary)]">trade</span>.
            </h2>
            <p className="text-[var(--color-muted-fg)] text-lg">
              Each Pal app is purpose-built for a specific trade — not a generic AI chatbot with a different skin.
            </p>
          </div>

          <div className="grid gap-6 md:grid-cols-2">
            <ProductCard appKey="splicepal" tagline="AI OTDR analysis and fiber cert prep for splicers" bullets={['OTDR trace & link analysis', 'Splice loss troubleshooting', 'CFOT / FOT / CFOS cert prep']} />
            <ProductCard appKey="weldpal" tagline="AI weld defect analysis and code prep for welders & CWIs" bullets={['Visual weld defect photo analysis', 'Process & parameter troubleshooting', 'AWS D1.1 / API 1104 / ASME cert prep']} />
            <ProductCard appKey="poolpal" tagline="AI water chemistry analysis and equipment troubleshooting for pool techs" bullets={['Water chemistry & algae photo analysis', 'Pump, heater, salt cell troubleshooting', 'LSI calculator, dosing charts, CPO prep']} />
            <ProductCard appKey="voltpal" tagline="AI panel diagnosis and NEC reference for electricians" bullets={['Panel, motor, VFD fault photo diagnosis', 'NEC code lookups & wire sizing calculators', 'Apprentice / journeyman / NFPA 70E prep']} />
            <ProductCard appKey="pipepal" tagline="AI leak diagnosis and code reference for plumbers & pipefitters" bullets={['Leak & code violation photo diagnosis', 'Water heater, drain, gas troubleshooting', 'Pipe sizing, fixture units, IPC/UPC prep']} />
            <ProductCard appKey="liftpal" tagline="AI inspection and troubleshooting for elevator & lift techs" bullets={['Controller & door system diagnosis', 'Hoistway inspection checklists', 'CET / QEI cert prep']} />
            <ProductCard appKey="windpal" tagline="AI blade analysis and turbine troubleshooting for wind techs" bullets={['Blade damage photo analysis', 'Gearbox & generator troubleshooting', 'GWO / BZEE cert prep']} />
            <ComingSoonCard name="MillPal" logo="/millpal-logo.png" tagline="AI field companion for millwrights & machinery mechanics" accent="#EF4444" bullets={['Vibration & alignment photo diagnosis', 'Bearing, gear & coupling troubleshooting', 'Millwright / IMM cert prep']} />
          </div>
        </div>
      </section>

      {/* ── FAQ ───────────────────────────────────────────────────── */}
      <section className="mx-auto max-w-3xl px-4 py-20">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Frequently asked <span className="text-[var(--color-primary)]">questions</span>.
          </h2>
        </div>
        <div className="space-y-6">
          <FAQ
            q="Does it work without cell signal?"
            a="Yes. You can take photos and queue them for analysis offline. When your phone reconnects — back at the truck, at lunch, wherever — the queue processes automatically and you get a notification when results are ready. Calculators and reference charts work fully offline too."
          />
          <FAQ
            q="Is the AI accurate enough to trust on the job?"
            a="The AI provides a ranked diagnosis with confidence levels and always recommends verification — test with a meter, check with a code book, inspect the part. It's a field assistant, not a replacement for your judgment. Think of it as a second opinion from a senior tech who's seen a lot of jobs."
          />
          <FAQ
            q="Who built this? Are you actually from the trades?"
            a="Every troubleshooting prompt, reference table, and code citation was built and verified with input from working tradespeople — not scraped from the internet. The AI prompts are written by people who know the difference between a gainer and a bad splice, between an RPZ and a PVB."
          />
          <FAQ
            q="What does the free tier include?"
            a="2 photo analyses, 2 troubleshoot sessions, and 5 AI reference lookups per month. All calculators, charts, and reference tables are always free with no limits. The free tier is enough to try it on a few jobs and see if it's useful for you."
          />
          <FAQ
            q="Can I use it for multiple trades?"
            a="Each Pal app is a separate subscription, purpose-built for that trade. If you do both electrical and plumbing, you'd use VoltPal and PipePal separately. We offer bundle pricing for multi-trade users and teams."
          />
          <FAQ
            q="Is my data private?"
            a="Your photos and analysis data are yours. We don't share them with other users, sell them to third parties, or use them to train AI models. Each app has a full privacy policy linked from its product page."
          />
        </div>
      </section>

      {/* ── Bottom CTA ────────────────────────────────────────────── */}
      <section className="bg-[#111114] border-t border-[var(--color-border)]">
        <div className="mx-auto max-w-3xl px-4 py-20 text-center">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Ready to work smarter?
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg mb-8">
            Pick your trade, sign up for free, and start diagnosing in the field today. No credit card required.
          </p>
          <div className="flex justify-center gap-4 flex-wrap">
            <Link
              to="/#apps"
              className="px-8 py-4 rounded-lg bg-[var(--color-primary)] text-white font-bold text-base hover:opacity-90 transition"
            >
              Get Started Free
            </Link>
            <a
              href="mailto:teams@tradepals.net"
              className="px-8 py-4 rounded-lg border border-[var(--color-border)] font-bold text-base hover:border-[var(--color-primary)] transition"
            >
              Team Pricing
            </a>
          </div>
        </div>
      </section>
    </div>
  )
}

/* ── Shared Components ────────────────────────────────────────────── */

function PricingSection() {
  const [annual, setAnnual] = useState(false)
  const monthlyPrice = 12.95
  const annualTotal = 89.95
  const annualMonthly = annualTotal / 12
  const price = annual ? annualMonthly : monthlyPrice
  const period = '/mo'
  const savings = Math.round((1 - annualMonthly / monthlyPrice) * 100)

  return (
    <section id="pricing" className="bg-[#111114] border-y border-[var(--color-border)]">
      <div className="mx-auto max-w-6xl px-4 py-20">
        <div className="text-center mb-8">
          <h2 className="text-3xl md:text-4xl font-extrabold mb-4">
            Simple <span className="text-[var(--color-primary)]">pricing</span>.
          </h2>
          <p className="text-[var(--color-muted-fg)] text-lg mb-6">
            Start free. Upgrade when you're ready. Cancel anytime.
          </p>

          {/* Billing toggle */}
          <div className="inline-flex items-center gap-3 bg-[var(--color-card)] border border-[var(--color-border)] rounded-full p-1">
            <button
              className={`px-4 py-2 rounded-full text-sm font-semibold transition ${!annual ? 'bg-[var(--color-primary)] text-white' : 'text-[var(--color-muted-fg)]'}`}
              onClick={() => setAnnual(false)}
            >
              Monthly
            </button>
            <button
              className={`px-4 py-2 rounded-full text-sm font-semibold transition ${annual ? 'bg-[var(--color-primary)] text-white' : 'text-[var(--color-muted-fg)]'}`}
              onClick={() => setAnnual(true)}
            >
              Annual <span className="text-[10px] ml-1 opacity-80">Save {savings}%</span>
            </button>
          </div>
        </div>

        <div className="grid gap-6 md:grid-cols-3 max-w-5xl mx-auto">
          {/* Free */}
          <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-7">
            <h3 className="text-lg font-bold text-white mb-1">Free</h3>
            <p className="text-3xl font-extrabold text-white mb-1">$0<span className="text-sm font-normal text-[var(--color-muted-fg)]"> /month</span></p>
            <p className="text-xs text-[var(--color-muted)] mb-5">Try it on a few jobs</p>
            <ul className="space-y-2.5 text-sm text-[var(--color-muted-fg)] mb-6">
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> 2 photo analyses / month</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> 2 troubleshoot sessions / month</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> 5 AI reference lookups / month</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> All calculators & charts</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Offline photo queue</li>
            </ul>
            <Link
              to="/#apps"
              className="block text-center py-3 rounded-lg border border-[var(--color-border)] font-semibold text-sm hover:border-[var(--color-primary)] transition"
            >
              Get Started
            </Link>
          </div>

          {/* Pro */}
          <div className="rounded-xl border-2 border-[var(--color-primary)] bg-[var(--color-card)] p-7 relative">
            <span className="absolute -top-3 left-1/2 -translate-x-1/2 bg-[var(--color-primary)] text-[#0D0D0F] text-[10px] font-bold uppercase px-3 py-1 rounded-full whitespace-nowrap">
              Most Popular
            </span>
            <h3 className="text-lg font-bold text-white mb-1">Pro</h3>
            <p className="text-3xl font-extrabold text-white mb-1">
              ${price.toFixed(2)}<span className="text-sm font-normal text-[var(--color-muted-fg)]"> {period}</span>
            </p>
            <p className="text-xs text-[var(--color-muted)] mb-5">
              {annual ? `$${annualTotal.toFixed(2)} billed annually` : 'per app, billed monthly'}
            </p>
            <ul className="space-y-2.5 text-sm text-[var(--color-muted-fg)] mb-6">
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Unlimited</strong> photo analyses</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Unlimited</strong> troubleshoot sessions</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> <strong className="text-white">Unlimited</strong> AI reference lookups</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Full training content + cert prep</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Priority processing + email alerts</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Full history (100+ entries)</li>
            </ul>
            <Link
              to="/#apps"
              className="block text-center py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
            >
              Get Started
            </Link>
          </div>

          {/* Crew / Enterprise */}
          <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-7">
            <h3 className="text-lg font-bold text-white mb-1">Crew</h3>
            <p className="text-3xl font-extrabold text-white mb-1">Custom</p>
            <p className="text-xs text-[var(--color-muted)] mb-5">For teams of 5+</p>
            <ul className="space-y-2.5 text-sm text-[var(--color-muted-fg)] mb-6">
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Everything in Pro</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Volume discounts per seat</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Multi-app bundles for your trade mix</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Team admin dashboard</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Onboarding + priority support</li>
              <li className="flex items-start gap-2"><span className="text-[var(--color-primary)]">&#10003;</span> Invoice billing (net 30)</li>
            </ul>
            <a
              href="mailto:teams@tradepals.net"
              className="block text-center py-3 rounded-lg border border-[var(--color-border)] font-semibold text-sm hover:border-[var(--color-primary)] transition"
            >
              Contact Sales
            </a>
          </div>
        </div>

        <div className="text-center text-[var(--color-muted)] text-xs mt-6 space-y-1">
          <p>Free tier included with every app. Upgrade to Pro anytime. Prices are per app.</p>
          <p>Sign up free in any Pal app first, then upgrade to Pro from your profile.</p>
          <p>Pro upgrades are managed as an in-app purchase within each Pal app.</p>
        </div>
      </div>
    </section>
  )
}

function FeatureCard({ emoji, title, desc }: { emoji: string; title: string; desc: string }) {
  return (
    <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-5">
      <div className="flex items-start gap-3">
        <span className="text-2xl">{emoji}</span>
        <div>
          <h3 className="font-bold text-white mb-1">{title}</h3>
          <p className="text-sm text-[var(--color-muted-fg)]">{desc}</p>
        </div>
      </div>
    </div>
  )
}

function TestimonialCard({ quote, name, role, trade }: { quote: string; name: string; role: string; trade: string }) {
  const app = APPS[trade as AppKey]
  return (
    <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
      <p className="text-[var(--color-muted-fg)] text-sm italic mb-4 leading-relaxed">"{quote}"</p>
      <div className="flex items-center gap-3">
        <div className="w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold" style={{ backgroundColor: app?.primary || '#333', color: '#0D0D0F' }}>
          {name[0]}
        </div>
        <div>
          <p className="text-white text-sm font-semibold">{name}</p>
          <p className="text-[var(--color-muted)] text-xs">{role}</p>
        </div>
      </div>
    </div>
  )
}

function FAQ({ q, a }: { q: string; a: string }) {
  return (
    <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
      <h3 className="font-bold text-white mb-2">{q}</h3>
      <p className="text-sm text-[var(--color-muted-fg)] leading-relaxed">{a}</p>
    </div>
  )
}

function ComingSoonCard({ name, logo, tagline, bullets, accent }: { name: string; logo?: string; tagline: string; bullets: string[]; accent: string }) {
  return (
    <div className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 relative opacity-80" aria-disabled="true">
      <span className="absolute top-4 right-4 text-[11px] font-bold uppercase tracking-wider px-2 py-1 rounded" style={{ backgroundColor: accent, color: '#0D0D0F' }}>Coming Soon</span>
      <div className="mb-3 flex items-center" style={{ height: 96, width: 240 }}>
        {logo ? <img src={logo} alt={name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} /> : <span className="text-3xl font-extrabold" style={{ color: accent }}>{name}</span>}
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4">{tagline}</p>
      <ul className="space-y-1 text-sm">{bullets.map((b) => <li key={b}>• {b}</li>)}</ul>
      <div className="mt-5 text-sm font-semibold text-[var(--color-muted)]">In development</div>
    </div>
  )
}

function QuickAppCard({ appKey, bullet }: { appKey: AppKey; bullet: string }) {
  const app = APPS[appKey]
  return (
    <Link
      to={`/${appKey}`}
      className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-4 flex flex-col items-center text-center transition-colors hover:border-opacity-100"
      style={{ borderColor: 'var(--color-border)' }}
      onMouseEnter={(e) => (e.currentTarget.style.borderColor = app.primary)}
      onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
    >
      <img src={app.logo} alt={app.name} style={{ height: 36, objectFit: 'contain' }} className="mb-2" />
      <p className="text-xs text-[var(--color-muted-fg)] leading-tight">{bullet}</p>
    </Link>
  )
}

function ProductCard({ appKey, tagline, bullets }: { appKey: AppKey; tagline: string; bullets: string[] }) {
  const app = APPS[appKey]
  return (
    <Link
      to={`/${appKey}`}
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 transition-colors"
      style={{ borderColor: 'var(--color-border)' }}
      onMouseEnter={(e) => (e.currentTarget.style.borderColor = app.primary)}
      onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
    >
      <div className="mb-3 flex items-center justify-start" style={{ height: 96, width: 240 }}>
        <img src={app.logo} alt={app.name} style={{ maxHeight: '100%', maxWidth: '100%', objectFit: 'contain' }} />
      </div>
      <p className="text-[var(--color-muted-fg)] mb-4 text-sm">{tagline}</p>
      <ul className="space-y-1 text-sm">{bullets.map((b) => <li key={b}>• {b}</li>)}</ul>
      <div className="mt-5 flex items-center gap-4">
        <span className="text-sm font-semibold" style={{ color: app.primary }}>Learn more →</span>
        {app.appUrl && (
          <a href={app.appUrl} className="text-sm font-semibold px-4 py-2 rounded-md" style={{ backgroundColor: app.primary, color: '#0D0D0F' }} onClick={(e) => e.stopPropagation()}>Launch</a>
        )}
      </div>
    </Link>
  )
}
