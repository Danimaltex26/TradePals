export default function About() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-16">
      <h1 className="text-4xl font-extrabold mb-6">About TradePals</h1>
      <p className="text-[var(--color-muted-fg)] text-lg mb-4">
        TradePals builds AI field companions for skilled trades — purpose-built mobile apps
        that put expert knowledge in your hand on the jobsite, backed by full training on the web.
      </p>
      <p className="text-[var(--color-muted-fg)] text-lg mb-4">
        Every Pal app pairs a focused mobile tool with long-form training content, so you can
        diagnose a problem in the field and deepen your craft between jobs.
      </p>
      <p className="text-[var(--color-muted-fg)] text-lg">
        Questions? Email{' '}
        <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">
          support@tradepals.net
        </a>
        .
      </p>
    </div>
  )
}
