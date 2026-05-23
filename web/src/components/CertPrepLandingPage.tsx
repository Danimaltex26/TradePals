import { Link } from 'react-router-dom'
import type { AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import PageMeta from './PageMeta'

// One landing page per cert per app. Built to compete for high-intent search
// queries like "CFOT exam prep", "journeyman electrician practice test", etc.
// Drives traffic to the existing public practice quiz on the app subdomain.

type ExamDomain = {
  number: number
  name: string
  questionCount: number
  weightPercent: number
  topics?: string[]
}

type SampleQuestion = {
  text: string
  options: { key: string; text: string }[]
  correctAnswer: string
  explanation: string
  standardReference?: string
}

type SalaryBlock = {
  uncertifiedLabel: string
  uncertifiedRange: string
  certifiedLabel: string
  certifiedRange: string
  sourceLabel: string
  note: string
}

type Faq = { q: string; a: string }

export type CertPrepLandingPageProps = {
  /** App brand (drives accent color + logo). */
  app: AppKey
  /** Short cert code that goes in the URL, headings, and structured data. e.g. "CFOT". */
  certCode: string
  /** Full cert name. e.g. "Certified Fiber Optic Technician". */
  certName: string
  /** Issuing body. e.g. "Fiber Optic Association (FOA)". */
  certIssuer: string

  // ── SEO ───────────────────────────────────────────────────────────
  /** <title> for this cert-prep page. Lead with the cert code. */
  metaTitle: string
  /** Meta description. 140–160 chars. Mention the cert + benefit + app. */
  metaDescription: string
  /** Canonical path (e.g. "/splicepal/cfot"). */
  pathOverride: string

  // ── Hero ──────────────────────────────────────────────────────────
  /** ROI / outcome hook in the hero. e.g. "Pass CFOT on the first try." */
  hookHeadline: string
  /** Sub-headline / supporting line in accent color. */
  hookSubline?: string
  /** 1–2 paragraph overview of who the cert is for and why it matters. */
  overview: string

  // ── Exam info card ────────────────────────────────────────────────
  examInfo: {
    totalQuestions: number
    timeMinutes: number
    passPercent: number
    /** Cost range as a string. e.g. "$650–$2,000". */
    cost: string
    /** Renewal cycle string. e.g. "Every 3 years". */
    renewalCycle: string
  }
  /** Per-domain breakdown of the exam — what's actually tested. */
  domains: ExamDomain[]

  // ── Sample questions ──────────────────────────────────────────────
  sampleQuestions: SampleQuestion[]

  // ── Optional salary / ROI block ───────────────────────────────────
  salaryBlock?: SalaryBlock

  // ── Quiz CTA (the existing public practice quiz on the app subdomain) ──
  quizUrl: string
  /** Label for the primary CTA button. e.g. "Take the Free CFOT Practice Quiz →". */
  quizCtaLabel: string

  // ── Trial signup CTA (optional) ───────────────────────────────────
  signupUrl?: string
  signupCtaLabel?: string

  // ── FAQ ────────────────────────────────────────────────────────────
  faqs?: Faq[]
}

export default function CertPrepLandingPage({
  app,
  certCode,
  certName,
  certIssuer,
  metaTitle,
  metaDescription,
  pathOverride,
  hookHeadline,
  hookSubline,
  overview,
  examInfo,
  domains,
  sampleQuestions,
  salaryBlock,
  quizUrl,
  quizCtaLabel,
  signupUrl,
  signupCtaLabel,
  faqs,
}: CertPrepLandingPageProps) {
  const cfg = APPS[app]
  // VoltPal yellow needs dark text on the accent CTAs (WCAG)
  const onAccentText = app === 'voltpal' ? '#0f0f10' : '#ffffff'

  // Schema.org Course markup — eligible for course rich results in SERPs.
  const courseJsonLd: Record<string, unknown> = {
    '@context': 'https://schema.org',
    '@type': 'Course',
    name: `${certCode} Exam Prep — ${cfg.name}`,
    description: metaDescription,
    provider: { '@type': 'Organization', name: cfg.name, sameAs: cfg.appUrl },
    hasCourseInstance: {
      '@type': 'CourseInstance',
      courseMode: 'Online',
      courseWorkload: `PT${examInfo.timeMinutes}M`,
    },
    educationalCredentialAwarded: certName,
    teaches: domains.map((d) => d.name),
  }

  const faqJsonLd = faqs && faqs.length > 0 ? {
    '@context': 'https://schema.org',
    '@type': 'FAQPage',
    mainEntity: faqs.map((f) => ({
      '@type': 'Question',
      name: f.q,
      acceptedAnswer: { '@type': 'Answer', text: f.a },
    })),
  } : null

  return (
    <div>
      <PageMeta
        title={metaTitle}
        description={metaDescription}
        path={pathOverride}
        ogImage={cfg.logo}
        themeColor={cfg.primary}
        jsonLd={faqJsonLd ? [courseJsonLd, faqJsonLd] : courseJsonLd}
      />

      {/* ── Hero ─────────────────────────────────────────────────── */}
      <section className="mx-auto max-w-5xl px-4 pt-16 pb-10">
        <div className="text-center mb-8">
          <Link to={`/${app}`} className="inline-block mb-6">
            <img src={cfg.logo} alt={cfg.name} style={{ height: 56, objectFit: 'contain' }} />
          </Link>
          <p className="text-xs uppercase tracking-widest mb-3" style={{ color: cfg.primary }}>
            {certCode} Exam Prep · {certIssuer}
          </p>
          <h1 className="text-3xl md:text-5xl font-bold mb-3 text-white max-w-3xl mx-auto leading-tight">
            {hookHeadline}
          </h1>
          {hookSubline && (
            <p className="text-lg md:text-xl font-semibold mb-4 max-w-2xl mx-auto" style={{ color: cfg.primary }}>
              {hookSubline}
            </p>
          )}
          <p className="text-[var(--color-muted-fg)] text-base max-w-2xl mx-auto mb-6">
            {overview}
          </p>
          <div className="flex flex-col sm:flex-row gap-3 justify-center items-center">
            <a
              href={quizUrl}
              className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
              style={{ backgroundColor: cfg.primary, color: onAccentText }}
            >
              {quizCtaLabel}
            </a>
            {signupUrl && (
              <a
                href={signupUrl}
                className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
                style={{ border: `2px solid ${cfg.primary}`, color: cfg.primary }}
              >
                {signupCtaLabel || `Try ${cfg.name} Free`}
              </a>
            )}
          </div>
        </div>
      </section>

      {/* ── Exam info strip ──────────────────────────────────────── */}
      <section className="border-y border-[var(--color-border)]" style={{ backgroundColor: `${cfg.primary}06` }}>
        <div className="mx-auto max-w-5xl px-4 py-8">
          <div className="grid gap-6 grid-cols-2 md:grid-cols-5">
            <ExamFact label="Questions" value={String(examInfo.totalQuestions)} accent={cfg.primary} />
            <ExamFact label="Time limit" value={`${examInfo.timeMinutes} min`} accent={cfg.primary} />
            <ExamFact label="Pass mark" value={`${examInfo.passPercent}%`} accent={cfg.primary} />
            <ExamFact label="Typical cost" value={examInfo.cost} accent={cfg.primary} />
            <ExamFact label="Renewal" value={examInfo.renewalCycle} accent={cfg.primary} />
          </div>
        </div>
      </section>

      {/* ── What's on the exam (domains) ─────────────────────────── */}
      <section className="mx-auto max-w-5xl px-4 py-16">
        <h2 className="text-2xl font-bold mb-2 text-center">What's on the {certCode} exam</h2>
        <p className="text-[var(--color-muted-fg)] text-center max-w-2xl mx-auto mb-8">
          Domain breakdown by question count and weight. {cfg.name} mirrors this structure exactly so your study time maps to what's actually tested.
        </p>
        <div className="space-y-3">
          {domains.map((d) => (
            <div key={d.number} className="rounded-lg border border-[var(--color-border)] bg-[var(--color-card)] p-4">
              <div className="flex items-center justify-between gap-4 mb-2">
                <h3 className="text-base font-semibold text-white">
                  <span style={{ color: cfg.primary }}>{d.number}.</span> {d.name}
                </h3>
                <span className="text-xs text-[var(--color-muted-fg)] whitespace-nowrap">
                  {d.questionCount} questions · {d.weightPercent}%
                </span>
              </div>
              <div className="w-full h-1.5 bg-[#1F1F22] rounded overflow-hidden">
                <div className="h-full" style={{ width: `${d.weightPercent}%`, background: cfg.primary }} />
              </div>
              {d.topics && d.topics.length > 0 && (
                <p className="text-xs text-[var(--color-muted-fg)] mt-2">{d.topics.join(' · ')}</p>
              )}
            </div>
          ))}
        </div>
      </section>

      {/* ── Sample questions ─────────────────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-3xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-2 text-center">Sample {certCode} questions</h2>
          <p className="text-[var(--color-muted-fg)] text-center mb-10">
            Real-style questions at the level of difficulty you'll see on exam day. Try them, then take the full free practice quiz.
          </p>
          {sampleQuestions.map((q, i) => (
            <SampleQuestionCard key={i} q={q} index={i + 1} accent={cfg.primary} />
          ))}
          <div className="text-center mt-8">
            <a
              href={quizUrl}
              className="inline-block w-72 max-w-full px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
              style={{ backgroundColor: cfg.primary, color: onAccentText }}
            >
              {quizCtaLabel}
            </a>
          </div>
        </div>
      </section>

      {/* ── Salary / ROI block ───────────────────────────────────── */}
      {salaryBlock && (
        <section className="mx-auto max-w-5xl px-4 py-12">
          <h2 className="text-2xl font-bold mb-2 text-center">What {certCode} is worth</h2>
          <p className="text-[var(--color-muted-fg)] text-sm text-center max-w-2xl mx-auto mb-8">{salaryBlock.note}</p>
          <div className="grid gap-4 md:grid-cols-2 max-w-3xl mx-auto">
            <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 text-center">
              <p className="text-xs uppercase tracking-wider text-[var(--color-muted-fg)] mb-2">{salaryBlock.uncertifiedLabel}</p>
              <p className="text-2xl font-bold text-white">{salaryBlock.uncertifiedRange}</p>
            </div>
            <div className="rounded-xl p-6 text-center" style={{ border: `2px solid ${cfg.primary}`, backgroundColor: `${cfg.primary}10` }}>
              <p className="text-xs uppercase tracking-wider mb-2" style={{ color: cfg.primary }}>{salaryBlock.certifiedLabel}</p>
              <p className="text-2xl font-bold" style={{ color: cfg.primary }}>{salaryBlock.certifiedRange}</p>
            </div>
          </div>
          <p className="text-xs text-[var(--color-muted-fg)] text-center mt-4">Source: {salaryBlock.sourceLabel}</p>
        </section>
      )}

      {/* ── How CFOT prep fits in the app ────────────────────────── */}
      <section className="bg-[#111114] border-y border-[var(--color-border)]">
        <div className="mx-auto max-w-5xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-2 text-center">How {cfg.name} prepares you</h2>
          <p className="text-[var(--color-muted-fg)] text-center max-w-2xl mx-auto mb-10">
            Free public quiz to see where you stand, then unlimited timed mocks, weak-area drills, and per-domain readiness scoring inside the app.
          </p>
          <div className="grid gap-6 md:grid-cols-3 max-w-4xl mx-auto">
            <PrepStep number={1} title="Take the free practice quiz" body={`10 questions, 5 minutes. Get a snapshot of where you stand against the ${examInfo.passPercent}% pass mark and which domains need work.`} accent={cfg.primary} />
            <PrepStep number={2} title="Get your weak-area drills" body={`${cfg.name} routes you to targeted practice in the domains you scored lowest on — no time wasted reviewing what you already know.`} accent={cfg.primary} />
            <PrepStep number={3} title="Run full timed mocks" body={`Full ${examInfo.totalQuestions}-question, ${examInfo.timeMinutes}-minute simulations under exam conditions. Track your readiness score until you're consistently above the pass mark.`} accent={cfg.primary} />
          </div>
          <div className="text-center mt-10">
            <a
              href={quizUrl}
              className="inline-block w-72 max-w-full px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
              style={{ backgroundColor: cfg.primary, color: onAccentText }}
            >
              {quizCtaLabel}
            </a>
          </div>
        </div>
      </section>

      {/* ── FAQ ──────────────────────────────────────────────────── */}
      {faqs && faqs.length > 0 && (
        <section className="mx-auto max-w-3xl px-4 py-16">
          <h2 className="text-2xl font-bold mb-8 text-center">FAQs about the {certCode} exam</h2>
          <div className="space-y-4">
            {faqs.map((f, i) => (
              <div key={i} className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6">
                <h3 className="font-bold text-white mb-2">{f.q}</h3>
                <p className="text-sm text-[var(--color-muted-fg)] leading-relaxed">{f.a}</p>
              </div>
            ))}
          </div>
        </section>
      )}

      {/* ── Bottom CTA ───────────────────────────────────────────── */}
      <section className="border-t border-[var(--color-border)]" style={{ backgroundColor: `${cfg.primary}08` }}>
        <div className="mx-auto max-w-3xl px-4 py-16 text-center">
          <h2 className="text-2xl md:text-3xl font-bold mb-3">Start your {certCode} prep today</h2>
          <p className="text-[var(--color-muted-fg)] mb-6">Free practice quiz first. Full study tools, mock exams, and weak-area drills inside {cfg.name}.</p>
          <div className="flex flex-col sm:flex-row gap-3 justify-center items-center">
            <a
              href={quizUrl}
              className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
              style={{ backgroundColor: cfg.primary, color: onAccentText }}
            >
              {quizCtaLabel}
            </a>
            {signupUrl && (
              <a
                href={signupUrl}
                className="inline-block w-72 px-8 py-4 rounded-lg font-bold text-base text-center hover:opacity-90 transition"
                style={{ border: `2px solid ${cfg.primary}`, color: cfg.primary }}
              >
                {signupCtaLabel || `Try ${cfg.name} Free`}
              </a>
            )}
          </div>
          <p className="text-xs text-[var(--color-muted)] mt-6">
            ← <Link to={`/${app}`} className="hover:underline">Back to {cfg.name}</Link>
          </p>
        </div>
      </section>
    </div>
  )
}

function ExamFact({ label, value, accent }: { label: string; value: string; accent: string }) {
  return (
    <div className="text-center">
      <div className="text-2xl md:text-3xl font-bold mb-1" style={{ color: accent }}>{value}</div>
      <div className="text-xs text-[var(--color-muted-fg)] uppercase tracking-wider">{label}</div>
    </div>
  )
}

function SampleQuestionCard({ q, index, accent }: { q: SampleQuestion; index: number; accent: string }) {
  return (
    <div className="rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 mb-4">
      <p className="text-xs uppercase tracking-wider mb-3" style={{ color: accent }}>Question {index}</p>
      <p className="text-base text-white mb-4 leading-relaxed">{q.text}</p>
      <div className="space-y-2 mb-4">
        {q.options.map((o) => {
          const isCorrect = o.key === q.correctAnswer
          return (
            <div
              key={o.key}
              className="rounded-md border px-4 py-3 text-sm"
              style={{
                borderColor: isCorrect ? accent : 'var(--color-border)',
                backgroundColor: isCorrect ? `${accent}10` : 'transparent',
                color: isCorrect ? '#ffffff' : 'var(--color-muted-fg)',
              }}
            >
              <strong className="mr-2">{o.key}.</strong>
              {o.text}
              {isCorrect && <span className="ml-2 text-xs font-bold" style={{ color: accent }}>✓ Correct</span>}
            </div>
          )
        })}
      </div>
      <div className="rounded-md p-4 text-sm leading-relaxed" style={{ background: `${accent}08`, borderLeft: `3px solid ${accent}` }}>
        <p className="text-xs uppercase tracking-wider font-bold mb-1" style={{ color: accent }}>Why</p>
        <p className="text-[var(--color-muted-fg)]">{q.explanation}</p>
        {q.standardReference && (
          <p className="text-xs text-[var(--color-muted)] mt-2">Ref: {q.standardReference}</p>
        )}
      </div>
    </div>
  )
}

function PrepStep({ number, title, body, accent }: { number: number; title: string; body: string; accent: string }) {
  // VoltPal yellow needs dark text on the numbered badge
  const badgeText = accent === '#FACC15' ? '#0f0f10' : '#ffffff'
  return (
    <div>
      <div
        className="w-12 h-12 rounded-full font-bold text-lg flex items-center justify-center mb-3"
        style={{ backgroundColor: accent, color: badgeText }}
      >
        {number}
      </div>
      <h3 className="font-bold text-white mb-2">{title}</h3>
      <p className="text-sm text-[var(--color-muted-fg)] leading-relaxed">{body}</p>
    </div>
  )
}
