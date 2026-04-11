import { Link } from 'react-router-dom'

export default function About() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-16">
      <h1 className="text-4xl font-extrabold mb-8">About TradePals</h1>

      <div className="space-y-6 text-lg text-[var(--color-muted-fg)] leading-relaxed">
        <p>
          TradePals builds AI-powered field companions for skilled tradespeople — electricians, plumbers, fiber splicers, welders, pool techs, and more. Each app is purpose-built for a specific trade, not a generic chatbot wrapped in a different skin.
        </p>

        <h2 className="text-2xl font-bold text-white pt-4">The problem we're solving</h2>
        <p>
          The skilled trades are facing a generational crisis. Over 650,000 construction jobs in the U.S. sit unfilled. The average master electrician is 53 years old. When those experienced hands retire, decades of field knowledge walk out the door with them.
        </p>
        <p>
          At the same time, demand is surging. The $1.2 trillion infrastructure bill is funding fiber buildouts, grid upgrades, water system overhauls, and clean energy installations coast to coast. The work is there. The workers aren't — yet.
        </p>

        <h2 className="text-2xl font-bold text-white pt-4">Accelerating the apprentice-to-journeyman path</h2>
        <p>
          The traditional apprenticeship model works. A junior tech rides alongside a veteran for years, absorbing knowledge one job at a time. But that model breaks down when there aren't enough mentors to go around — and when the complexity of modern systems (VFDs, PLCs, SWGs, OTDR traces) outpaces what any one mentor can cover.
        </p>
        <p>
          TradePals doesn't replace the apprenticeship. It accelerates it. An apprentice with a Pal app gets instant AI feedback on their work, structured troubleshooting when they're stuck, and code references and calculators in their pocket instead of in a truck manual. They learn from every job — even the ones they work alone.
        </p>
        <p>
          Journeymen and masters use it too. Not because they need help with the basics, but because the edge cases — the unusual equipment, the code section they see once a year, the motor nameplate in a language they don't read — happen to everyone. The goal isn't to replace expertise. It's to make expertise available everywhere.
        </p>

        <h2 className="text-2xl font-bold text-white pt-4">How it works</h2>
        <p>
          Every Pal app has the same core structure, tailored to its trade:
        </p>
        <ul className="list-disc pl-6 space-y-2">
          <li>
            <strong className="text-white">Photo analysis</strong> — snap a picture of a weld, a panel, a pool, or a pipe joint. The AI identifies issues, ranks severity, and suggests next steps with code references.
          </li>
          <li>
            <strong className="text-white">Troubleshooting wizard</strong> — describe the symptom, pick the equipment, and get a structured diagnosis. Probable causes ranked by likelihood, step-by-step fix instructions, and clear escalation criteria.
          </li>
          <li>
            <strong className="text-white">Reference library + calculators</strong> — wire sizing, chemical dosing, pipe sizing, loss budgets, motor FLA tables, conduit fill — the actual reference data tradespeople use, always in their pocket.
          </li>
          <li>
            <strong className="text-white">Offline mode</strong> — no signal in the basement? Take your photos anyway. They queue locally and process automatically when you reconnect.
          </li>
          <li>
            <strong className="text-white">Training content</strong> — certification prep, code deep-dives, and practical guides for each trade, built for working tradespeople, not college students.
          </li>
        </ul>

        <h2 className="text-2xl font-bold text-white pt-4">For employers and contractors</h2>
        <p>
          TradePals isn't just for individual techs. Contractors and service companies use Pal apps to reduce callbacks, speed up onboarding for new hires, and give junior crews the confidence to handle more jobs independently. When your newest apprentice has a master-level reference tool in their pocket, your whole operation runs smoother.
        </p>

        <h2 className="text-2xl font-bold text-white pt-4">Built by tradespeople, for tradespeople</h2>
        <p>
          Every troubleshooting prompt, every reference table, every code citation in TradePals was written and verified with input from working tradespeople — not scraped from the internet. We build tools for the jobsite, not the classroom.
        </p>

        <div className="pt-8 border-t border-[var(--color-border)] mt-8">
          <p className="text-base">
            Questions, feedback, or partnership inquiries:{' '}
            <a className="text-[var(--color-primary)]" href="mailto:support@tradepals.net">
              support@tradepals.net
            </a>
          </p>
          <div className="mt-4">
            <Link
              to="/"
              className="inline-block px-6 py-3 rounded-lg bg-[var(--color-primary)] text-white font-semibold text-sm hover:opacity-90 transition"
            >
              Explore the Pal Apps
            </Link>
          </div>
        </div>
      </div>
    </div>
  )
}
