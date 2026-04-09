import { Link } from 'react-router-dom'

export default function Home() {
  return (
    <div className="mx-auto max-w-6xl px-4 py-16">
      <section className="text-center mb-20">
        <h1 className="text-4xl md:text-6xl font-extrabold tracking-tight">
          AI field companions for <span className="text-[var(--color-primary)]">skilled trades</span>.
        </h1>
        <p className="mt-5 text-lg text-[var(--color-muted-fg)] max-w-2xl mx-auto">
          Purpose-built mobile apps that put expert knowledge in your hand on the jobsite — and full training at your desk.
        </p>
      </section>

      <section className="grid gap-6 md:grid-cols-2">
        <ProductCard
          name="SplicePal"
          tagline="AI assistant for fiber splicers"
          bullets={[
            'OTDR trace analysis',
            'Splice troubleshooting',
            'Reference library + cert prep',
          ]}
          href="/splicepal"
        />
        <ProductCard
          name="WeldPal"
          tagline="AI field companion for welders & CWIs"
          bullets={[
            'Visual weld defect analysis',
            'Troubleshooting guides',
            'AWS / API / ASME cert prep',
          ]}
          href="/weldpal"
        />
      </section>
    </div>
  )
}

function ProductCard({
  name,
  tagline,
  bullets,
  href,
}: {
  name: string
  tagline: string
  bullets: string[]
  href: string
}) {
  return (
    <Link
      to={href}
      className="block rounded-xl border border-[var(--color-border)] bg-[var(--color-card)] p-6 hover:border-[var(--color-primary)] transition-colors"
    >
      <div className="text-2xl font-bold mb-1">{name}</div>
      <p className="text-[var(--color-muted-fg)] mb-4">{tagline}</p>
      <ul className="space-y-1 text-sm">
        {bullets.map((b) => (
          <li key={b}>• {b}</li>
        ))}
      </ul>
      <div className="mt-5 text-sm text-[var(--color-primary)] font-semibold">Learn more →</div>
    </Link>
  )
}
