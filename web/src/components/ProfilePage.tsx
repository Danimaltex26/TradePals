import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { useEntitlement } from '../hooks/useEntitlement'
import { getClient, getTrainingSchema, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

/* ── Per-app profile configuration ── */

type UsageLimitConfig = {
  label: string
  table: string
  limit: number
}

type AppProfileConfig = {
  equipmentLabel: string
  equipmentColumn: string
  equipmentOptions: string[]
  specialties: string[]
  certifications: string[]
  industries: string[]
  experienceLevels: string[]
  usageLimits: UsageLimitConfig[]
}

const APP_PROFILE: Record<AppKey, AppProfileConfig> = {
  splicepal: {
    equipmentLabel: 'Splicer Models',
    equipmentColumn: 'splicer_models',
    equipmentOptions: ['Fujikura 90S+', 'Fujikura 70S+', 'Fujikura 41S', 'Sumitomo T-72C+', 'Sumitomo T-602S', 'INNO View 7+', 'FITEL S179A', 'FITEL S185PM'],
    specialties: ['OSP Construction', 'ISP / Premises', 'FTTH / PON', 'Data Center', 'Aerial', 'Underground', 'MDU / Riser', 'Long Haul'],
    certifications: ['FOT', 'CFOT', 'CFOS/S', 'CFOS/T', 'CFOS/D', 'CFOS/I', 'RCDD'],
    industries: ['Telecom / ISP', 'Data Center', 'Construction / GC', 'Government / DOT', 'Utility', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'AI Splice Analyses', table: 'otdr_results', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  weldpal: {
    equipmentLabel: 'Welding Processes',
    equipmentColumn: 'welding_processes',
    equipmentOptions: ['SMAW (Stick)', 'GMAW (MIG)', 'GTAW (TIG)', 'FCAW', 'SAW', 'Oxy-Fuel', 'Plasma Cutting', 'Robotic Welding'],
    specialties: ['Structural Steel', 'Pipe Welding', 'Pressure Vessels', 'Shipbuilding', 'Aerospace', 'Maintenance & Repair', 'Fabrication', 'Field Welding'],
    certifications: ['CW', 'CAWI', 'CWI', 'CWS', 'CRAW'],
    industries: ['Construction', 'Manufacturing', 'Oil & Gas', 'Shipyard', 'Aerospace', 'Power Generation', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Weld Analyses', table: 'weld_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  poolpal: {
    equipmentLabel: 'Service Specialties',
    equipmentColumn: 'service_specialties',
    equipmentOptions: ['Residential Pools', 'Commercial Pools', 'Spas / Hot Tubs', 'Water Features', 'Salt Systems', 'Automation', 'Plumbing / Hydraulics', 'Heater Service'],
    specialties: ['Weekly Service', 'Repair & Renovation', 'New Construction', 'Commercial Operations', 'Equipment Installation', 'Water Chemistry Consulting'],
    certifications: ['CPO', 'CST', 'Residential Specialist', 'Commercial Specialist'],
    industries: ['Pool Service Company', 'Pool Builder', 'Property Management', 'Municipal / Government', 'Hotel / Resort', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Pool Analyses', table: 'pool_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  voltpal: {
    equipmentLabel: 'Specialties',
    equipmentColumn: 'specialties',
    equipmentOptions: ['Residential Wiring', 'Commercial Wiring', 'Industrial Controls', 'Motor Controls / VFDs', 'PLC / Automation', 'Fire Alarm', 'Low Voltage / Data', 'Solar / Renewables'],
    specialties: ['New Construction', 'Maintenance & Repair', 'Service Calls', 'Industrial Maintenance', 'Controls Integration', 'Testing & Commissioning'],
    certifications: ['Apprentice', 'Journeyman', 'Master', 'NFPA 70E'],
    industries: ['Electrical Contractor', 'Industrial Plant', 'Commercial Property', 'Government / Military', 'Utility', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Electrical Analyses', table: 'electrical_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  pipepal: {
    equipmentLabel: 'Specialties',
    equipmentColumn: 'specialties',
    equipmentOptions: ['Residential Plumbing', 'Commercial Plumbing', 'Gas Piping', 'Medical Gas', 'Steamfitting', 'Sprinkler / Fire Protection', 'Backflow Prevention', 'Hydronic Heating'],
    specialties: ['New Construction', 'Service & Repair', 'Remodel / Renovation', 'Commercial TI', 'Industrial Piping', 'Underground Utilities'],
    certifications: ['Apprentice', 'Journeyman', 'Master', 'Medical Gas (ASSE 6010)'],
    industries: ['Plumbing Contractor', 'Mechanical Contractor', 'General Contractor', 'Property Management', 'Government / Municipal', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Plumbing Analyses', table: 'plumbing_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  windpal: {
    equipmentLabel: 'Turbine Models',
    equipmentColumn: 'turbine_models',
    equipmentOptions: ['Vestas V90', 'Vestas V110', 'Vestas V150', 'Siemens Gamesa SG 5.8', 'GE Haliade-X', 'Nordex N163', 'Enercon E-138', 'Goldwind GW155'],
    specialties: ['Blade Inspection', 'Gearbox Service', 'Electrical Systems', 'Hydraulic Systems', 'Yaw & Pitch', 'Tower Internals', 'Commissioning', 'Decommissioning'],
    certifications: ['GWO BST', 'GWO BTT', 'ACP Wind Tech', 'Senior Tech'],
    industries: ['Wind Farm Operator', 'OEM Service', 'ISP (Independent Service Provider)', 'Utility', 'Offshore Wind', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Turbine Analyses', table: 'turbine_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
  liftpal: {
    equipmentLabel: 'Equipment Types',
    equipmentColumn: 'equipment_types',
    equipmentOptions: ['Traction (Geared)', 'Traction (Gearless)', 'Hydraulic', 'MRL', 'Escalator', 'Moving Walk', 'Dumbwaiter', 'Freight'],
    specialties: ['Installation', 'Maintenance', 'Modernization', 'Inspection', 'Repair / Troubleshooting', 'Fire Service', 'ADA Compliance', 'Controls'],
    certifications: ['CET', 'QEI', 'CAT', 'Senior Tech'],
    industries: ['Elevator Company (OEM)', 'Independent Elevator Co.', 'Property Management', 'Government / AHJ', 'Consulting / Inspection', 'Independent Contractor'],
    experienceLevels: ['< 1 year', '1-3 years', '3-5 years', '5-10 years', '10+ years'],
    usageLimits: [
      { label: 'Lift Analyses', table: 'lift_analyses', limit: 2 },
      { label: 'Troubleshoot Sessions', table: 'troubleshoot_sessions', limit: 2 },
      { label: 'Reference Lookups', table: 'reference_queries', limit: 5 },
    ],
  },
}

/* ── Usage bar ── */

function UsageBar({ used, limit, accent }: { used: number; limit: number; accent: string }) {
  const pct = Math.min((used / limit) * 100, 100)
  const color = pct >= 100 ? '#EF4444' : pct >= 75 ? '#F59E0B' : accent
  return (
    <div className="flex items-center gap-3">
      <div className="flex-1 h-2 rounded-full" style={{ backgroundColor: '#2A2A2E' }}>
        <div className="h-full rounded-full transition-all" style={{ width: `${pct}%`, backgroundColor: color }} />
      </div>
      <span className="text-xs font-semibold shrink-0" style={{ color, minWidth: 40, textAlign: 'right' }}>
        {used}/{limit}
      </span>
    </div>
  )
}

/* ── Profile view ── */

function ProfileView({ app, accent }: { app: AppKey; accent: string }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const ent = useEntitlement(app)
  const client = getClient(app)
  const schema = getTrainingSchema(app)
  const cfg = APPS[app]
  const profileCfg = APP_PROFILE[app]

  const [profile, setProfile] = useState<any>(null)
  const [prefs, setPrefs] = useState<any>(null)
  const [usage, setUsage] = useState<Record<string, number>>({})
  const [team, setTeam] = useState<any>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!appAuth.user) return
    loadProfile()
  }, [appAuth.user])

  async function loadProfile() {
    try {
      const userId = appAuth.user!.id

      // Profile
      const { data: profileData } = await client
        .from('profiles')
        .select('display_name, email, role, team_id')
        .eq('id', userId)
        .single()
      setProfile(profileData)

      // Preferences (may fail if schema not exposed — graceful)
      try {
        const { data: prefsData } = await (client as any)
          .schema(schema)
          .from('user_preferences')
          .select('*')
          .eq('user_id', userId)
          .single()
        setPrefs(prefsData)
      } catch { /* schema may not be exposed */ }

      // Usage counts (this month) for free tier
      if (!ent.active) {
        const startOfMonth = new Date()
        startOfMonth.setDate(1)
        startOfMonth.setHours(0, 0, 0, 0)

        const counts: Record<string, number> = {}
        for (const u of profileCfg.usageLimits) {
          try {
            const { count } = await (client as any)
              .schema(schema)
              .from(u.table)
              .select('*', { count: 'exact', head: true })
              .eq('user_id', userId)
              .gte('created_at', startOfMonth.toISOString())
            counts[u.table] = count || 0
          } catch { /* table may not exist */ }
        }
        setUsage(counts)
      }

      // Team
      if (profileData?.team_id) {
        try {
          const { data: teamData } = await client
            .from('teams')
            .select('team_name, manager_id, subscription_status')
            .eq('id', profileData.team_id)
            .single()
          setTeam(teamData)
        } catch { /* team query failed */ }
      }
    } catch {
      // Profile load failed entirely — still show the page
    } finally {
      setLoading(false)
    }
  }

  if (loading) return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Loading profile&hellip;</p>

  const isPro = ent.active
  const isManager = team && team.manager_id === appAuth.user?.id

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <h1 className="text-2xl font-extrabold mb-6">Profile</h1>

      <div className="flex flex-col gap-4">
        {/* ── User Info ── */}
        <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <div className="flex justify-between items-start">
            <div>
              <h3 className="font-bold text-lg">{profile?.display_name || appAuth.user?.email}</h3>
              <p className="text-sm" style={{ color: 'var(--color-muted)' }}>{appAuth.user?.email}</p>
            </div>
            <span className="px-3 py-1 rounded-full text-xs font-bold" style={{
              backgroundColor: isPro ? `${accent}22` : '#2A2A2E',
              color: isPro ? accent : '#A0A0A8',
            }}>
              {isPro ? 'PRO' : 'Free'}
            </span>
          </div>
        </div>

        {/* ── Usage Limits (free tier only) ── */}
        {!isPro && (
          <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
            <h3 className="font-bold mb-3">Monthly Usage</h3>
            <div className="flex flex-col gap-3">
              {profileCfg.usageLimits.map(u => (
                <div key={u.table}>
                  <div className="flex justify-between text-sm mb-1">
                    <span>{u.label}</span>
                    <span style={{ color: 'var(--color-muted)' }}>this month</span>
                  </div>
                  <UsageBar used={usage[u.table] || 0} limit={u.limit} accent={accent} />
                </div>
              ))}
            </div>
          </div>
        )}

        {/* ── Upgrade to Pro (free tier — directs to app) ── */}
        {!isPro && (
          <div className="rounded-xl border p-5" style={{ borderColor: accent, backgroundColor: `${accent}08` }}>
            <h3 className="font-bold mb-2">Upgrade to Pro</h3>
            <p className="text-sm mb-3" style={{ color: 'var(--color-muted-fg)' }}>
              Unlimited analyses, troubleshooting, training exams, and spaced repetition.
            </p>
            <ul className="text-sm mb-4 space-y-1" style={{ color: 'var(--color-muted-fg)' }}>
              <li>&#10003; Unlimited AI analyses</li>
              <li>&#10003; Unlimited troubleshoot sessions</li>
              <li>&#10003; Full exam access with score tracking</li>
              <li>&#10003; Spaced repetition review</li>
            </ul>
            {cfg.appUrl ? (
              <a
                href={cfg.appUrl}
                target="_blank"
                rel="noopener"
                className="block w-full h-11 rounded-lg font-semibold text-white text-center leading-[44px]"
                style={{ backgroundColor: accent }}
              >
                Upgrade in {cfg.name}
              </a>
            ) : (
              <p className="text-sm" style={{ color: 'var(--color-muted)' }}>
                Open the {cfg.name} app to subscribe.
              </p>
            )}
          </div>
        )}

        {/* ── Subscription (Pro users) ── */}
        {isPro && (
          <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
            <div className="flex justify-between items-center mb-2">
              <h3 className="font-bold">Subscription</h3>
              <span className="px-2 py-0.5 rounded text-xs font-bold" style={{ backgroundColor: `${accent}22`, color: accent }}>Active</span>
            </div>
            <p className="text-sm" style={{ color: 'var(--color-muted-fg)' }}>
              {ent.tier === 'team' ? 'Team Pro — managed by your team' : `${cfg.name} Pro`}
            </p>
            {ent.expiresAt && (
              <p className="text-xs mt-1" style={{ color: 'var(--color-muted)' }}>
                Renews {new Date(ent.expiresAt).toLocaleDateString()}
              </p>
            )}
          </div>
        )}

        {/* ── Team ── */}
        {team && (
          <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
            <div className="flex justify-between items-center mb-2">
              <h3 className="font-bold">Team</h3>
              <span className="px-2 py-0.5 rounded text-xs font-bold" style={{
                backgroundColor: isManager ? `${accent}22` : '#2A2A2E',
                color: isManager ? accent : '#A0A0A8',
              }}>
                {isManager ? 'Manager' : 'Member'}
              </span>
            </div>
            <p className="text-sm font-semibold">{team.team_name}</p>
            {team.subscription_status === 'past_due' && (
              <p className="text-xs mt-1" style={{ color: '#F59E0B' }}>Payment past due</p>
            )}
            <Link
              to={`/${app}/team`}
              className="inline-block mt-3 px-4 py-2 rounded-md text-sm font-semibold"
              style={{ border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }}
            >
              {isManager ? 'Team Dashboard' : 'View Team'}
            </Link>
          </div>
        )}

        {!team && isPro && (
          <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
            <h3 className="font-bold mb-2">Start a Team</h3>
            <p className="text-sm mb-3" style={{ color: 'var(--color-muted-fg)' }}>
              Give your crew Pro access. Manage training, track progress, and monitor cert readiness from one dashboard.
            </p>
            <p className="text-sm font-semibold mb-3" style={{ color: accent }}>$49.95/month &middot; up to 5 members</p>
            <Link
              to={`/${app}/team`}
              className="inline-block px-4 py-2 rounded-md text-sm font-semibold text-white"
              style={{ backgroundColor: accent }}
            >
              Create Team
            </Link>
          </div>
        )}

        {/* ── Equipment / Models ── */}
        <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h3 className="font-bold mb-3">{profileCfg.equipmentLabel}</h3>
          <div className="flex flex-wrap gap-2">
            {(prefs?.[profileCfg.equipmentColumn] || []).length > 0
              ? (prefs[profileCfg.equipmentColumn] as string[]).map((item: string) => (
                  <span key={item} className="px-3 py-1 rounded-full text-xs font-semibold" style={{ backgroundColor: `${accent}22`, color: accent }}>
                    {item}
                  </span>
                ))
              : <p className="text-sm" style={{ color: 'var(--color-muted)' }}>None set — update in the {cfg.name} app</p>
            }
          </div>
        </div>

        {/* ── Certifications ── */}
        <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h3 className="font-bold mb-3">Certifications</h3>
          <div className="flex flex-wrap gap-2">
            {(prefs?.certifications || []).length > 0
              ? (prefs.certifications as string[]).map((cert: string) => (
                  <span key={cert} className="px-3 py-1 rounded-full text-xs font-semibold" style={{ backgroundColor: '#2A2A2E', color: '#F5F5F5' }}>
                    {cert}
                  </span>
                ))
              : <p className="text-sm" style={{ color: 'var(--color-muted)' }}>None set — update in the {cfg.name} app</p>
            }
          </div>
        </div>

        {/* ── Quick Links ── */}
        <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h3 className="font-bold mb-3">Quick Links</h3>
          <div className="flex flex-col gap-2">
            <Link to={`/${app}/training`} className="text-sm font-semibold" style={{ color: accent }}>
              Training &amp; Cert Prep &rarr;
            </Link>
            <Link to={`/${app}/certprep`} className="text-sm font-semibold" style={{ color: accent }}>
              Quick Practice Questions &rarr;
            </Link>
            {cfg.appUrl && (
              <a href={cfg.appUrl} target="_blank" rel="noopener" className="text-sm font-semibold" style={{ color: accent }}>
                Open {cfg.name} App &rarr;
              </a>
            )}
          </div>
        </div>

        {/* ── Sign Out ── */}
        <button
          onClick={() => auth.signOut(app)}
          className="w-full h-11 rounded-lg font-semibold text-sm"
          style={{ border: '1px solid var(--color-border)', color: '#EF4444' }}
        >
          Sign Out of {cfg.name}
        </button>
      </div>
    </div>
  )
}

/* ── Exported ── */

export default function ProfilePageWrapper({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  return (
    <TrainingGate app={app}>
      <ProfileView app={app} accent={cfg.primary} />
    </TrainingGate>
  )
}
