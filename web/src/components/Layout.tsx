import { useEffect, useRef, useState } from 'react'
import { Outlet, NavLink, Link, useLocation } from 'react-router-dom'

// Detect display language from URL. Matches any /<app>/es route — currently
// only /voltpal/es exists, but additional Spanish landing pages will pick this
// up automatically. Defaults to English so every non-Spanish route is unaffected.
function detectLang(pathname: string): 'en' | 'es' {
  return /^\/[a-z]+\/es(?:$|\/)/.test(pathname) ? 'es' : 'en'
}

// Header + footer label set.
// TODO[native-speaker review]: all 'es' strings are Claude-drafted Mexican Spanish.
// Brand names (SplicePal, WeldPal, etc.) and "TradePals" stay English in both languages.
const LABELS = {
  en: {
    navAbout: 'About',
    navPalApps: 'Pal Apps',
    navTraining: 'Training',
    navPricing: 'Pricing',
    toggleMenu: 'Toggle menu',
    footerTagline: 'AI field companions for skilled trades.',
    footerContact: 'Contact',
    footerLiveApps: 'Live Apps',
    footerComingSoon: 'Coming Soon',
    footerLegal: 'Legal',
    footerPrivacy: 'Privacy Policy',
    footerTerms: 'Terms of Service',
    footerSupport: 'Support',
    footerRights: (year: number) => `© ${year} TradePals, LLC. All rights reserved.`,
    footerBuiltBy: 'Built for tradespeople, by tradespeople.',
    millpalDesc: 'Millwrights',
    appDescFiber: 'Fiber',
    appDescWelding: 'Welding',
    appDescPoolSpa: 'Pool & Spa',
    appDescElectrical: 'Electrical',
    appDescPlumbing: 'Plumbing',
    appDescWind: 'Wind Turbines',
    appDescElevators: 'Elevators & Lifts',
  },
  es: {
    navAbout: 'Acerca de',
    navPalApps: 'Apps Pal',
    navTraining: 'Entrenamiento',
    navPricing: 'Precios',
    toggleMenu: 'Mostrar/ocultar menú',
    footerTagline: 'Asistentes AI de campo para oficios especializados.',
    footerContact: 'Contacto',
    footerLiveApps: 'Apps Disponibles',
    footerComingSoon: 'Próximamente',
    footerLegal: 'Legal',
    footerPrivacy: 'Política de Privacidad',
    footerTerms: 'Términos del Servicio',
    footerSupport: 'Soporte',
    footerRights: (year: number) => `© ${year} TradePals, LLC. Todos los derechos reservados.`,
    footerBuiltBy: 'Hecho por gente del oficio, para gente del oficio.',
    millpalDesc: 'Mecánicos Industriales',
    appDescFiber: 'Fibra Óptica',
    appDescWelding: 'Soldadura',
    appDescPoolSpa: 'Alberca y Spa',
    appDescElectrical: 'Eléctrico',
    appDescPlumbing: 'Plomería',
    appDescWind: 'Turbinas Eólicas',
    appDescElevators: 'Elevadores',
  },
} as const

export default function Layout() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const location = useLocation()
  const lang = detectLang(location.pathname)
  const L = LABELS[lang]

  // Close mobile menu on route change
  useEffect(() => {
    setMobileOpen(false)
  }, [location.pathname])

  return (
    <div className="min-h-screen flex flex-col">
      <header className="border-b border-[var(--color-border)] bg-[var(--color-bg)] sticky top-0 z-20">
        <div className="mx-auto max-w-6xl flex items-center justify-between px-4 py-3">
          <Link to="/" className="flex items-center">
            <img
              src="/tradepals-logo.webp"
              alt="TradePals"
              style={{ height: 43, width: 'auto', objectFit: 'contain' }}
            />
          </Link>

          {/* Desktop nav */}
          <nav className="hidden md:flex items-center gap-5 text-sm">
            <NavItem to="/about">{L.navAbout}</NavItem>
            <PalAppsDropdown label={L.navPalApps} />
            <NavItem to="/signin">{L.navTraining}</NavItem>
            <NavItem to="/#pricing">{L.navPricing}</NavItem>
          </nav>

          {/* Mobile hamburger */}
          <button
            type="button"
            onClick={() => setMobileOpen((v) => !v)}
            className="md:hidden p-2 -mr-2 text-white"
            aria-label={L.toggleMenu}
            aria-expanded={mobileOpen}
          >
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
              {mobileOpen ? (
                <>
                  <line x1="18" y1="6" x2="6" y2="18" />
                  <line x1="6" y1="6" x2="18" y2="18" />
                </>
              ) : (
                <>
                  <line x1="3" y1="6" x2="21" y2="6" />
                  <line x1="3" y1="12" x2="21" y2="12" />
                  <line x1="3" y1="18" x2="21" y2="18" />
                </>
              )}
            </svg>
          </button>
        </div>

        {/* Mobile menu panel */}
        {mobileOpen && (
          <div className="md:hidden border-t border-[var(--color-border)] bg-[var(--color-bg)]">
            <nav className="flex flex-col px-4 py-3 gap-1 text-base">
              <MobileLink to="/about">{L.navAbout}</MobileLink>
              <div className="px-3 py-2 text-xs uppercase tracking-wider text-[var(--color-muted)]">{L.navPalApps}</div>
              <MobileLink to="/splicepal" indent>SplicePal</MobileLink>
              <MobileLink to="/weldpal" indent>WeldPal</MobileLink>
              <MobileLink to="/poolpal" indent>PoolPal</MobileLink>
              <MobileLink to="/voltpal" indent>VoltPal</MobileLink>
              <MobileLink to="/pipepal" indent>PipePal</MobileLink>
              <MobileLink to="/windpal" indent>WindPal</MobileLink>
              <MobileLink to="/liftpal" indent>LiftPal</MobileLink>
              <MobileLink to="/signin">{L.navTraining}</MobileLink>
              <MobileLink to="/#pricing">{L.navPricing}</MobileLink>
            </nav>
          </div>
        )}
      </header>

      <main className="flex-1">
        <Outlet />
      </main>

      <footer className="border-t border-[var(--color-border)] bg-[#0a0a0c] text-sm text-[var(--color-muted-fg)]">
        <div className="mx-auto max-w-6xl px-4 py-10 grid gap-8 md:grid-cols-4">
          {/* Brand */}
          <div>
            <div className="font-bold text-white text-base mb-2">TradePals</div>
            <p className="text-xs text-[var(--color-muted)] mb-3">{L.footerTagline}</p>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/about" className="hover:text-white transition">{L.navAbout}</Link></li>
              <li><Link to="/signin" className="hover:text-white transition">{L.navTraining}</Link></li>
              <li><Link to="/#pricing" className="hover:text-white transition">{L.navPricing}</Link></li>
              <li><a href="mailto:support@tradepals.net" className="hover:text-white transition">{L.footerContact}</a></li>
            </ul>
          </div>

          {/* Live Apps */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">{L.footerLiveApps}</div>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/splicepal" className="hover:text-white transition">SplicePal</Link> <span className="text-[var(--color-muted)]">— {L.appDescFiber}</span></li>
              <li><Link to="/weldpal" className="hover:text-white transition">WeldPal</Link> <span className="text-[var(--color-muted)]">— {L.appDescWelding}</span></li>
              <li><Link to="/poolpal" className="hover:text-white transition">PoolPal</Link> <span className="text-[var(--color-muted)]">— {L.appDescPoolSpa}</span></li>
              <li><Link to="/voltpal" className="hover:text-white transition">VoltPal</Link> <span className="text-[var(--color-muted)]">— {L.appDescElectrical}</span></li>
              <li><Link to="/pipepal" className="hover:text-white transition">PipePal</Link> <span className="text-[var(--color-muted)]">— {L.appDescPlumbing}</span></li>
              <li><Link to="/windpal" className="hover:text-white transition">WindPal</Link> <span className="text-[var(--color-muted)]">— {L.appDescWind}</span></li>
              <li><Link to="/liftpal" className="hover:text-white transition">LiftPal</Link> <span className="text-[var(--color-muted)]">— {L.appDescElevators}</span></li>
            </ul>
          </div>

          {/* Coming Soon */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">{L.footerComingSoon}</div>
            <ul className="space-y-1.5 text-xs text-[var(--color-muted)]">
              <li>MillPal — {L.millpalDesc}</li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">{L.footerLegal}</div>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/splicepal/privacy" className="hover:text-white transition">{L.footerPrivacy}</Link></li>
              <li><Link to="/splicepal/terms" className="hover:text-white transition">{L.footerTerms}</Link></li>
              <li><Link to="/splicepal/support" className="hover:text-white transition">{L.footerSupport}</Link></li>
            </ul>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="border-t border-[var(--color-border)]">
          <div className="mx-auto max-w-6xl px-4 py-4 flex flex-col md:flex-row items-center justify-between gap-2 text-xs text-[var(--color-muted)]">
            <p>{L.footerRights(new Date().getFullYear())}</p>
            <p>{L.footerBuiltBy}</p>
          </div>
        </div>
      </footer>
    </div>
  )
}

function NavItem({ to, children }: { to: string; children: React.ReactNode }) {
  return (
    <NavLink
      to={to}
      className={({ isActive }) =>
        isActive ? 'text-white' : 'text-[var(--color-muted-fg)] hover:text-white'
      }
    >
      {children}
    </NavLink>
  )
}

function MobileLink({
  to,
  indent,
  children,
}: {
  to: string
  indent?: boolean
  children: React.ReactNode
}) {
  return (
    <NavLink
      to={to}
      className={({ isActive }) =>
        `${indent ? 'pl-6' : 'px-3'} py-3 rounded-md ${
          isActive ? 'text-white bg-[var(--color-card)]' : 'text-[var(--color-muted-fg)]'
        }`
      }
    >
      {children}
    </NavLink>
  )
}

function PalAppsDropdown({ label }: { label: string }) {
  const [open, setOpen] = useState(false)
  const ref = useRef<HTMLDivElement>(null)

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  return (
    <div className="relative" ref={ref}>
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="flex items-center gap-1 text-[var(--color-muted-fg)] hover:text-white"
      >
        {label}
        <svg width="10" height="10" viewBox="0 0 10 10" fill="currentColor" aria-hidden="true">
          <path d="M1 3l4 4 4-4z" />
        </svg>
      </button>
      {open && (
        <div className="absolute right-0 mt-2 w-44 rounded-md border border-[var(--color-border)] bg-[var(--color-card)] shadow-lg overflow-hidden">
          <DropdownLink to="/splicepal" onClick={() => setOpen(false)}>SplicePal</DropdownLink>
          <DropdownLink to="/weldpal" onClick={() => setOpen(false)}>WeldPal</DropdownLink>
          <DropdownLink to="/poolpal" onClick={() => setOpen(false)}>PoolPal</DropdownLink>
          <DropdownLink to="/voltpal" onClick={() => setOpen(false)}>VoltPal</DropdownLink>
          <DropdownLink to="/pipepal" onClick={() => setOpen(false)}>PipePal</DropdownLink>
          <DropdownLink to="/windpal" onClick={() => setOpen(false)}>WindPal</DropdownLink>
          <DropdownLink to="/liftpal" onClick={() => setOpen(false)}>LiftPal</DropdownLink>
        </div>
      )}
    </div>
  )
}

function DropdownLink({
  to,
  onClick,
  children,
}: {
  to: string
  onClick: () => void
  children: React.ReactNode
}) {
  return (
    <Link
      to={to}
      onClick={onClick}
      className="block px-4 py-2 text-[var(--color-muted-fg)] hover:bg-[var(--color-border)] hover:text-white"
    >
      {children}
    </Link>
  )
}
