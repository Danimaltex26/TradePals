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
            <NavItem to="/signin">Sign In</NavItem>
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
              <MobileLink to="/training">Training</MobileLink>
              <MobileLink to="/signin">Sign In</MobileLink>
            </nav>
          </div>
        )}
      </header>

      <main className="flex-1">
        <Outlet />
      </main>

      <footer className="border-t border-[var(--color-border)] py-8 text-sm text-[var(--color-muted-fg)]">
        <div className="mx-auto max-w-6xl px-4 grid gap-10 md:grid-cols-[1fr_2fr]">
          <div>
            <div className="font-bold text-white mb-2">TradePals</div>
            <p>AI field companions for skilled trades.</p>
            <ul className="space-y-1 mt-3">
              <li><Link to="/about">About</Link></li>
              <li><Link to="/training">Training</Link></li>
              <li><Link to="/signin">Sign In</Link></li>
            </ul>
          </div>
          <div>
            <div className="text-xs uppercase tracking-wider text-[var(--color-muted)] mb-3">
              Pal Apps
            </div>
            <div className="grid gap-6 grid-cols-2 md:grid-cols-3">
              <div>
                <div className="font-semibold text-white mb-2">SplicePal</div>
                <ul className="space-y-1">
                  <li><Link to="/splicepal">Overview</Link></li>
                  <li><Link to="/splicepal/training">Training</Link></li>
                  <li><Link to="/splicepal/support">Support</Link></li>
                  <li><Link to="/splicepal/privacy">Privacy</Link></li>
                </ul>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">WeldPal</div>
                <ul className="space-y-1">
                  <li><Link to="/weldpal">Overview</Link></li>
                  <li><Link to="/weldpal/training">Training</Link></li>
                  <li><Link to="/weldpal/support">Support</Link></li>
                  <li><Link to="/weldpal/privacy">Privacy</Link></li>
                </ul>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">WindPal</div>
                <p className="text-xs uppercase tracking-wider text-[var(--color-muted)]">Coming soon</p>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">LiftPal</div>
                <p className="text-xs uppercase tracking-wider text-[var(--color-muted)]">Coming soon</p>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">PipePal</div>
                <p className="text-xs uppercase tracking-wider text-[var(--color-muted)]">Coming soon</p>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">MillPal</div>
                <p className="text-xs uppercase tracking-wider text-[var(--color-muted)]">Coming soon</p>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">VoltPal</div>
                <ul className="space-y-1">
                  <li><Link to="/voltpal">Overview</Link></li>
                  <li><Link to="/voltpal/training">Training</Link></li>
                  <li><Link to="/voltpal/support">Support</Link></li>
                  <li><Link to="/voltpal/privacy">Privacy</Link></li>
                </ul>
              </div>
              <div>
                <div className="font-semibold text-white mb-2">PoolPal</div>
                <ul className="space-y-1">
                  <li><Link to="/poolpal">Overview</Link></li>
                  <li><Link to="/poolpal/training">Training</Link></li>
                  <li><Link to="/poolpal/support">Support</Link></li>
                  <li><Link to="/poolpal/privacy">Privacy</Link></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div className="mx-auto max-w-6xl px-4 mt-6 text-xs text-[var(--color-muted)]">
          © {new Date().getFullYear()} TradePals. All rights reserved.
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
