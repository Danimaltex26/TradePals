import { useEffect, useRef, useState } from 'react'
import { Outlet, NavLink, Link } from 'react-router-dom'

export default function Layout() {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="border-b border-[var(--color-border)] bg-[var(--color-bg)] sticky top-0 z-10">
        <div className="mx-auto max-w-6xl flex items-center justify-between px-4 py-3">
          <Link to="/" className="flex items-center">
            <img
              src="/tradepals-logo.png"
              alt="TradePals"
              style={{ height: 43, width: 'auto', objectFit: 'contain' }}
            />
          </Link>
          <nav className="flex items-center gap-5 text-sm">
            <NavItem to="/about">About</NavItem>
            <PalAppsDropdown />
            <NavItem to="/training">Training</NavItem>
            <NavItem to="/signin">Sign In</NavItem>
          </nav>
        </div>
      </header>

      <main className="flex-1">
        <Outlet />
      </main>

      <footer className="border-t border-[var(--color-border)] py-8 text-sm text-[var(--color-muted-fg)]">
        <div className="mx-auto max-w-6xl px-4 grid gap-6 md:grid-cols-5">
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
