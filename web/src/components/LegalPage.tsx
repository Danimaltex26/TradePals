import type { ReactNode } from 'react'

export default function LegalPage({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div className="mx-auto max-w-3xl px-4 py-16">
      <h1 className="text-3xl font-extrabold mb-6">{title}</h1>
      <div className="space-y-4 text-[var(--color-muted-fg)] leading-relaxed">{children}</div>
    </div>
  )
}
