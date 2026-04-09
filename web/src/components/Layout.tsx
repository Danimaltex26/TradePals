import { Outlet, NavLink, Link } from 'react-router-dom'

export default function Layout() {
  return (
    <div className="min-h-screen flex flex-col">
      <header className="border-b border-[var(--color-border)] bg-[var(--color-bg)] sticky top-0 z-10">
        <div className="mx-auto max-w-6xl flex items-center justify-between px-4 py-3">
          <Link to="/" className="flex items-center">
            <img src="/tradepals-logo.png" alt="TradePals" style={{ height: 36, width: 'auto', objectFit: 'contain' }} />
          </Link>
          <nav className="flex items-center gap-5 text-sm">
            <NavLink to="/splicepal" className={({ isActive }) => isActive ? 'text-white' : 'text-[var(--color-muted-fg)] hover:text-white'}>
              SplicePal
            </NavLink>
            <NavLink to="/weldpal" className={({ isActive }) => isActive ? 'text-white' : 'text-[var(--color-muted-fg)] hover:text-white'}>
              WeldPal
            </NavLink>
            <NavLink to="/signin" className={({ isActive }) => isActive ? 'text-white' : 'text-[var(--color-muted-fg)] hover:text-white'}>
              Sign In
            </NavLink>
          </nav>
        </div>
      </header>

      <main className="flex-1">
        <Outlet />
      </main>

      <footer className="border-t border-[var(--color-border)] py-8 text-sm text-[var(--color-muted-fg)]">
        <div className="mx-auto max-w-6xl px-4 grid gap-6 md:grid-cols-3">
          <div>
            <div className="font-bold text-white mb-2">TradePals</div>
            <p>AI field companions for skilled trades.</p>
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
        </div>
        <div className="mx-auto max-w-6xl px-4 mt-6 text-xs text-[var(--color-muted)]">
          © {new Date().getFullYear()} TradePals. All rights reserved.
        </div>
      </footer>
    </div>
  )
}
