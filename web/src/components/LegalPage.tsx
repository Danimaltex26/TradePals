import type { ReactNode } from 'react'
import { useLocation } from 'react-router-dom'
import PageMeta from './PageMeta'

type LegalPageProps = {
  title: string
  /** Optional override for the meta description. Defaults to a generic line based on title. */
  description?: string
  children: ReactNode
}

export default function LegalPage({ title, description, children }: LegalPageProps) {
  const { pathname } = useLocation()
  const metaDescription =
    description || `${title} — operated by TradePals, LLC. Read our policy and terms of use.`

  return (
    <>
      <PageMeta title={`${title} — TradePals`} description={metaDescription} path={pathname} />
      <div className="mx-auto max-w-3xl px-4 py-16">
        <h1 className="text-3xl font-extrabold mb-6">{title}</h1>
        <div className="space-y-4 text-[var(--color-muted-fg)] leading-relaxed">{children}</div>
      </div>
    </>
  )
}
