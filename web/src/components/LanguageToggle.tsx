import { Link, useLocation } from 'react-router-dom'

type Props = {
  /** Path to the English variant of this page, e.g. '/voltpal'. */
  enPath: string
  /** Path to the Spanish variant, e.g. '/voltpal/es'. */
  esPath: string
  /** Which language is currently being displayed — drives the active pill state. */
  currentLang: 'en' | 'es'
  /** App accent color (per-Pal brand). Used for the active pill background. */
  accentColor: string
  /** Optional override: dark text on light accent colors. Yellow (#FACC15) needs dark text for WCAG contrast. */
  accentTextColor?: string
}

/**
 * Two-pill language switcher with a globe icon. Renders as a compact bar
 * the user can place anywhere — currently used at the top of VoltPal hub
 * product pages (/voltpal and /voltpal/es).
 *
 * Preserves the current search string when switching so UTM tags + other
 * query params survive language toggles (important for paid-traffic attribution).
 */
export default function LanguageToggle({ enPath, esPath, currentLang, accentColor, accentTextColor = '#0f0f10' }: Props) {
  const { search } = useLocation()
  const activeStyle = { backgroundColor: accentColor, color: accentTextColor }
  const inactiveStyle = { color: 'var(--color-muted-fg)' }

  return (
    <div className="flex justify-center pt-6 pb-2">
      <nav
        aria-label="Language"
        className="inline-flex items-center gap-1 rounded-full border border-[var(--color-border)] bg-[var(--color-card)] p-1 text-xs"
      >
        <span className="pl-2 pr-1 text-[var(--color-muted-fg)]" aria-hidden="true">🌐</span>
        <Link
          to={`${enPath}${search}`}
          aria-current={currentLang === 'en' ? 'page' : undefined}
          className="px-3 py-1 rounded-full font-semibold transition"
          style={currentLang === 'en' ? activeStyle : inactiveStyle}
        >
          English
        </Link>
        <Link
          to={`${esPath}${search}`}
          aria-current={currentLang === 'es' ? 'page' : undefined}
          className="px-3 py-1 rounded-full font-semibold transition"
          style={currentLang === 'es' ? activeStyle : inactiveStyle}
        >
          Español
        </Link>
      </nav>
    </div>
  )
}
