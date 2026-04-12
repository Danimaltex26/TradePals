import { useEffect, useRef, useState } from 'react'
import { Outlet, NavLink, Link, useLocation } from 'react-router-dom'

export default function Layout() {
  const [mobileOpen, setMobileOpen] = useState(false)
  const location = useLocation()

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
              src="/tradepals-logo.png"
              alt="TradePals"
              style={{ height: 43, width: 'auto', objectFit: 'contain' }}
            />
          </Link>

          {/* Desktop nav */}
          <nav className="hidden md:flex items-center gap-5 text-sm">
            <NavItem to="/about">About</NavItem>
            <PalAppsDropdown />
            <NavItem to="/training">Training</NavItem>
          </nav>

          {/* Mobile hamburger */}
          <button
            type="button"
            onClick={() => setMobileOpen((v) => !v)}
            className="md:hidden p-2 -mr-2 text-white"
            aria-label="Toggle menu"
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
              <MobileLink to="/about">About</MobileLink>
              <div className="px-3 py-2 text-xs uppercase tracking-wider text-[var(--color-muted)]">Pal Apps</div>
              <MobileLink to="/splicepal" indent>SplicePal</MobileLink>
              <MobileLink to="/weldpal" indent>WeldPal</MobileLink>
              <MobileLink to="/poolpal" indent>PoolPal</MobileLink>
              <MobileLink to="/voltpal" indent>VoltPal</MobileLink>
              <MobileLink to="/pipepal" indent>PipePal</MobileLink>
              <MobileLink to="/training">Training</MobileLink>
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
            <p className="text-xs text-[var(--color-muted)] mb-3">AI field companions for skilled trades.</p>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/about" className="hover:text-white transition">About</Link></li>
              <li><Link to="/training" className="hover:text-white transition">Training</Link></li>
              <li><a href="mailto:support@tradepals.net" className="hover:text-white transition">Contact</a></li>
            </ul>
          </div>

          {/* Live Apps */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">Live Apps</div>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/splicepal" className="hover:text-white transition">SplicePal</Link> <span className="text-[var(--color-muted)]">— Fiber</span></li>
              <li><Link to="/weldpal" className="hover:text-white transition">WeldPal</Link> <span className="text-[var(--color-muted)]">— Welding</span></li>
              <li><Link to="/poolpal" className="hover:text-white transition">PoolPal</Link> <span className="text-[var(--color-muted)]">— Pool & Spa</span></li>
              <li><Link to="/voltpal" className="hover:text-white transition">VoltPal</Link> <span className="text-[var(--color-muted)]">— Electrical</span></li>
              <li><Link to="/pipepal" className="hover:text-white transition">PipePal</Link> <span className="text-[var(--color-muted)]">— Plumbing</span></li>
            </ul>
          </div>

          {/* Coming Soon */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">Coming Soon</div>
            <ul className="space-y-1.5 text-xs text-[var(--color-muted)]">
              <li>LiftPal — Elevators</li>
              <li>WindPal — Wind Turbines</li>
              <li>MillPal — Millwrights</li>
            </ul>
          </div>

          {/* Legal */}
          <div>
            <div className="text-[10px] uppercase tracking-wider text-[var(--color-muted)] mb-3">Legal</div>
            <ul className="space-y-1.5 text-xs">
              <li><Link to="/splicepal/privacy" className="hover:text-white transition">Privacy Policy</Link></li>
              <li><Link to="/splicepal/terms" className="hover:text-white transition">Terms of Service</Link></li>
              <li><Link to="/splicepal/support" className="hover:text-white transition">Support</Link></li>
            </ul>
          </div>
        </div>

        {/* Bottom bar */}
        <div className="border-t border-[var(--color-border)]">
          <div className="mx-auto max-w-6xl px-4 py-4 flex flex-col md:flex-row items-center justify-between gap-2 text-xs text-[var(--color-muted)]">
            <p>&copy; {new Date().getFullYear()} TradePals, LLC. All rights reserved.</p>
            <p>Built for tradespeople, by tradespeople.</p>
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

function PalAppsDropdown() {
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
        Pal Apps
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
