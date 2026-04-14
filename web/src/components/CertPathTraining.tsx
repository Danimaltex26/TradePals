import { useState, useEffect } from 'react'
import { useAuth } from '../auth/AuthProvider'
import { getClient, getTrainingSchema, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

/* ── Static cert-level definitions (mirrors server/routes/training/path.js) ── */

type CertDef = {
  key: string
  name: string
  fullTitle: string
  questionCount: number
  timeMinutes: number
  passPercent: number
}

const SPLICEPAL_CERTS: CertDef[] = [
  { key: 'FOT',    name: 'FOT',    fullTitle: 'Fiber Optic Technician',                          questionCount: 60,  timeMinutes: 90,  passPercent: 70 },
  { key: 'CFOT',   name: 'CFOT',   fullTitle: 'Certified Fiber Optic Technician',                questionCount: 100, timeMinutes: 150, passPercent: 70 },
  { key: 'CFOS_S', name: 'CFOS/S', fullTitle: 'Certified Fiber Optic Specialist — Splicing',     questionCount: 75,  timeMinutes: 120, passPercent: 75 },
  { key: 'CFOS_T', name: 'CFOS/T', fullTitle: 'Certified Fiber Optic Specialist — Testing',      questionCount: 75,  timeMinutes: 120, passPercent: 75 },
  { key: 'CFOS_D', name: 'CFOS/D', fullTitle: 'Certified Fiber Optic Specialist — Design',       questionCount: 75,  timeMinutes: 120, passPercent: 75 },
  { key: 'CFOS_I', name: 'CFOS/I', fullTitle: 'Certified Fiber Optic Specialist — Inspection',   questionCount: 75,  timeMinutes: 120, passPercent: 75 },
  { key: 'RCDD',   name: 'RCDD',   fullTitle: 'Registered Communications Distribution Designer', questionCount: 100, timeMinutes: 150, passPercent: 75 },
]

const WELDPAL_CERTS: CertDef[] = [
  { key: 'CW',   name: 'CW',   fullTitle: 'Certified Welder',                     questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'CAWI', name: 'CAWI', fullTitle: 'Certified Associate Welding Inspector', questionCount: 75,  timeMinutes: 120, passPercent: 72 },
  { key: 'CWI',  name: 'CWI',  fullTitle: 'Certified Welding Inspector',           questionCount: 100, timeMinutes: 150, passPercent: 72 },
  { key: 'CWS',  name: 'CWS',  fullTitle: 'Certified Welding Supervisor',          questionCount: 75,  timeMinutes: 120, passPercent: 72 },
  { key: 'CRAW', name: 'CRAW', fullTitle: 'Certified Robotic Arc Welding',         questionCount: 75,  timeMinutes: 120, passPercent: 72 },
]

const VOLTPAL_CERTS: CertDef[] = [
  { key: 'APPRENTICE',  name: 'Apprentice',       fullTitle: 'Electrical Apprentice',          questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'JOURNEYMAN',  name: 'Journeyman',       fullTitle: 'Journeyman Electrician',         questionCount: 80,  timeMinutes: 120, passPercent: 70 },
  { key: 'MASTER',       name: 'Master',            fullTitle: 'Master Electrician',             questionCount: 100, timeMinutes: 150, passPercent: 75 },
  { key: 'NFPA_70E',    name: 'NFPA 70E',         fullTitle: 'NFPA 70E Electrical Safety',     questionCount: 60,  timeMinutes: 90,  passPercent: 70 },
]

const POOLPAL_CERTS: CertDef[] = [
  { key: 'CPO',         name: 'CPO',          fullTitle: 'Certified Pool Operator',          questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'CST',         name: 'CST',          fullTitle: 'Certified Service Technician',     questionCount: 60,  timeMinutes: 90,  passPercent: 70 },
  { key: 'RESIDENTIAL', name: 'Residential',   fullTitle: 'Residential Pool Specialist',      questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'COMMERCIAL',  name: 'Commercial',    fullTitle: 'Commercial Pool Specialist',       questionCount: 75,  timeMinutes: 120, passPercent: 72 },
]

const PIPEPAL_CERTS: CertDef[] = [
  { key: 'APPRENTICE',   name: 'Apprentice',    fullTitle: 'Plumbing Apprentice',              questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'JOURNEYMAN',   name: 'Journeyman',    fullTitle: 'Journeyman Plumber',               questionCount: 80,  timeMinutes: 120, passPercent: 70 },
  { key: 'MASTER',        name: 'Master',         fullTitle: 'Master Plumber',                   questionCount: 100, timeMinutes: 150, passPercent: 75 },
  { key: 'MEDICAL_GAS',  name: 'Medical Gas',   fullTitle: 'Medical Gas Installer (ASSE 6010)', questionCount: 60,  timeMinutes: 90,  passPercent: 75 },
]

const WINDPAL_CERTS: CertDef[] = [
  { key: 'GWO_BST',     name: 'GWO BST',       fullTitle: 'GWO Basic Safety Training',           questionCount: 50,  timeMinutes: 75,  passPercent: 70 },
  { key: 'GWO_BTT',     name: 'GWO BTT',       fullTitle: 'GWO Basic Technical Training',        questionCount: 60,  timeMinutes: 90,  passPercent: 70 },
  { key: 'ACP_TECH',    name: 'ACP Wind Tech',  fullTitle: 'ACP Wind Turbine Service Technician', questionCount: 80,  timeMinutes: 120, passPercent: 72 },
  { key: 'SENIOR_TECH', name: 'Senior Tech',    fullTitle: 'Senior Wind Turbine Technician',      questionCount: 100, timeMinutes: 150, passPercent: 75 },
]

// Per-app cert definitions and schema name
const APP_CERTS: Partial<Record<AppKey, CertDef[]>> = {
  splicepal: SPLICEPAL_CERTS,
  weldpal: WELDPAL_CERTS,
  voltpal: VOLTPAL_CERTS,
  poolpal: POOLPAL_CERTS,
  pipepal: PIPEPAL_CERTS,
  windpal: WINDPAL_CERTS,
}

/* ── Types ── */

type CertLevel = CertDef & {
  moduleCount: number
  estimatedHours: number
  readiness: number
  locked: boolean
  inProgress: boolean
}

/* ── Circular progress ring ── */

function CircularProgress({ size = 56, stroke = 5, percent = 0, accent }: {
  size?: number; stroke?: number; percent?: number; accent: string
}) {
  const radius = (size - stroke) / 2
  const circumference = 2 * Math.PI * radius
  const offset = circumference - (percent / 100) * circumference
  const color = percent >= 75 ? accent : percent >= 50 ? '#F59E0B' : '#EF4444'

  return (
    <svg width={size} height={size} style={{ transform: 'rotate(-90deg)', flexShrink: 0 }}>
      <circle cx={size / 2} cy={size / 2} r={radius} fill="none" stroke="var(--color-border)" strokeWidth={stroke} />
      <circle
        cx={size / 2} cy={size / 2} r={radius} fill="none"
        stroke={color} strokeWidth={stroke}
        strokeDasharray={circumference} strokeDashoffset={offset}
        strokeLinecap="round" style={{ transition: 'stroke-dashoffset 0.6s ease' }}
      />
      <text
        x={size / 2} y={size / 2}
        textAnchor="middle" dominantBaseline="central"
        fill="#F5F5F5" fontSize={size * 0.24} fontWeight="700"
        transform={`rotate(90 ${size / 2} ${size / 2})`}
      >
        {percent}%
      </text>
    </svg>
  )
}

/* ── Lock icon ── */

function LockIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--color-muted)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
    </svg>
  )
}

/* ── Connector line between cert cards ── */

function Connector() {
  return (
    <div className="flex justify-center">
      <div className="w-0.5 h-6" style={{ backgroundColor: 'var(--color-border)' }} />
    </div>
  )
}

/* ── Cert card ── */

function CertCard({ cert, accent, app }: { cert: CertLevel; accent: string; app: AppKey }) {
  const examReady = !cert.locked && cert.readiness >= cert.passPercent
  const href = `/${app}/training/${cert.key}`

  return (
    <div
      className="rounded-xl border p-5 transition-opacity"
      style={{
        borderColor: 'var(--color-border)',
        backgroundColor: 'var(--color-card)',
        opacity: cert.locked ? 0.55 : 1,
      }}
    >
      <div className="flex items-center justify-between gap-4">
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            {cert.locked && <LockIcon />}
            <span className="font-bold text-base">{cert.name}</span>
          </div>
          <p className="text-sm" style={{ color: 'var(--color-muted-fg)' }}>
            {cert.moduleCount} modules &middot; ~{cert.estimatedHours} hours
          </p>
          {examReady && (
            <span
              className="inline-block mt-2 px-2 py-0.5 rounded text-xs font-bold"
              style={{ backgroundColor: `${accent}22`, color: accent }}
            >
              EXAM READY
            </span>
          )}
        </div>
        <CircularProgress percent={cert.readiness} accent={accent} />
      </div>

      {!cert.locked && (
        <div style={{ marginTop: 12, position: 'relative', zIndex: 10 }}>
          <a
            href={href}
            style={{
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              width: '100%',
              height: 44,
              borderRadius: 8,
              fontWeight: 600,
              textDecoration: 'none',
              cursor: 'pointer',
              backgroundColor: cert.readiness === 0 && !cert.inProgress ? accent : cert.inProgress ? accent : 'transparent',
              color: cert.readiness === 0 && !cert.inProgress ? 'white' : cert.inProgress ? 'white' : 'var(--color-muted-fg)',
              border: cert.readiness > 0 && !cert.inProgress ? '1px solid var(--color-border)' : 'none',
            }}
          >
            {cert.readiness === 0 && !cert.inProgress
              ? 'Start'
              : cert.inProgress
              ? 'Continue — ' + cert.readiness + '% ready'
              : 'View Modules'}
          </a>
        </div>
      )}
    </div>
  )
}

/* ── Main component ── */

export default function CertPathTraining({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  const auth = useAuth()
  const appAuth = auth[app]
  const [levels, setLevels] = useState<CertLevel[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const certDefs = APP_CERTS[app]
  const schema = getTrainingSchema(app)

  useEffect(() => {
    if (appAuth.loading || !appAuth.user || !certDefs || !schema) return

    let cancelled = false
    const client = getClient(app)

    async function load() {
      try {
        // Fetch published module counts and hours
        const { data: modules, error: modErr } = await (client as any)
          .schema(schema)
          .from('training_modules')
          .select('cert_level, estimated_minutes')
          .eq('is_published', true)

        if (modErr) throw modErr

        // Fetch user readiness
        const { data: readinessRows, error: readErr } = await (client as any)
          .schema(schema)
          .from('training_readiness')
          .select('cert_level, overall_readiness_percent')
          .eq('user_id', appAuth.user!.id)

        if (readErr) throw readErr

        // Build lookups
        const moduleCounts: Record<string, number> = {}
        const estHours: Record<string, number> = {}
        for (const m of modules || []) {
          moduleCounts[m.cert_level] = (moduleCounts[m.cert_level] || 0) + 1
          estHours[m.cert_level] = (estHours[m.cert_level] || 0) + m.estimated_minutes
        }

        const readinessMap: Record<string, number> = {}
        for (const r of readinessRows || []) {
          readinessMap[r.cert_level] = Number(r.overall_readiness_percent) || 0
        }

        // Determine lock status (app-specific unlock logic)
        function isUnlocked(key: string) {
          if (app === 'splicepal') {
            const fotReady = readinessMap['FOT'] || 0
            const cfotReady = readinessMap['CFOT'] || 0
            const anyCfosReady = Math.max(
              readinessMap['CFOS_S'] || 0, readinessMap['CFOS_T'] || 0,
              readinessMap['CFOS_D'] || 0, readinessMap['CFOS_I'] || 0,
            )
            if (key === 'FOT') return true
            if (key === 'CFOT') return fotReady >= 80
            if (key.startsWith('CFOS_')) return cfotReady >= 80
            if (key === 'RCDD') return anyCfosReady >= 80
          } else if (app === 'weldpal') {
            const cwReady = readinessMap['CW'] || 0
            const cawiReady = readinessMap['CAWI'] || 0
            const cwiReady = readinessMap['CWI'] || 0
            if (key === 'CW') return true
            if (key === 'CAWI') return cwReady >= 80
            if (key === 'CWI') return cawiReady >= 80
            if (key === 'CWS') return cwiReady >= 80
            if (key === 'CRAW') return cwReady >= 80
          } else if (app === 'voltpal') {
            const appReady = readinessMap['APPRENTICE'] || 0
            const jourReady = readinessMap['JOURNEYMAN'] || 0
            if (key === 'APPRENTICE') return true
            if (key === 'JOURNEYMAN') return appReady >= 80
            if (key === 'MASTER') return jourReady >= 80
            if (key === 'NFPA_70E') return true
          } else if (app === 'poolpal') {
            const cpoReady = readinessMap['CPO'] || 0
            if (key === 'CPO') return true
            if (key === 'CST') return cpoReady >= 80
            if (key === 'RESIDENTIAL') return cpoReady >= 80
            if (key === 'COMMERCIAL') return cpoReady >= 80
          } else if (app === 'pipepal') {
            const appReady = readinessMap['APPRENTICE'] || 0
            const jourReady = readinessMap['JOURNEYMAN'] || 0
            if (key === 'APPRENTICE') return true
            if (key === 'JOURNEYMAN') return appReady >= 80
            if (key === 'MASTER') return jourReady >= 80
            if (key === 'MEDICAL_GAS') return jourReady >= 80
          } else if (app === 'windpal') {
            const bstReady = readinessMap['GWO_BST'] || 0
            const bttReady = readinessMap['GWO_BTT'] || 0
            const acpReady = readinessMap['ACP_TECH'] || 0
            if (key === 'GWO_BST') return true
            if (key === 'GWO_BTT') return bstReady >= 80
            if (key === 'ACP_TECH') return bttReady >= 80
            if (key === 'SENIOR_TECH') return acpReady >= 80
          }
          // Default: first cert unlocked, rest locked
          if (certDefs && certDefs[0]?.key === key) return true
          return false
        }

        if (cancelled) return

        setLevels(
          certDefs!.map((def) => ({
            ...def,
            moduleCount: moduleCounts[def.key] || 0,
            estimatedHours: Math.round(((estHours[def.key] || 0) / 60) * 10) / 10,
            readiness: readinessMap[def.key] || 0,
            locked: !isUnlocked(def.key),
            inProgress: (readinessMap[def.key] || 0) > 0 && (readinessMap[def.key] || 0) < (def.passPercent),
          })),
        )
        setError(null)
      } catch (err) {
        if (!cancelled) setError(err instanceof Error ? err.message : 'Failed to load certification path')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()
    return () => { cancelled = true }
  }, [app, appAuth.user, appAuth.loading])

  // App-specific subtitles
  const APP_SUBTITLE: Partial<Record<AppKey, string>> = {
    splicepal: 'Fiber optic certification paths',
    weldpal: 'AWS welding certification paths',
    voltpal: 'Electrical licensing certification paths',
    poolpal: 'Pool & spa certification paths',
    pipepal: 'Plumbing certification paths',
    windpal: 'Wind turbine technician certification paths',
  }

  // App-specific cert path layouts
  function renderCertPath() {
    if (app === 'splicepal') {
      const fot = levels.find((c) => c.key === 'FOT')
      const cfot = levels.find((c) => c.key === 'CFOT')
      const cfosSpecialties = levels.filter((c) => c.key.startsWith('CFOS_'))
      const rcdd = levels.find((c) => c.key === 'RCDD')
      return (
        <>
          {fot && <CertCard cert={fot} accent={cfg.primary} app={app} />}
          {cfot && <><Connector /><CertCard cert={cfot} accent={cfg.primary} app={app} /></>}
          {cfosSpecialties.length > 0 && (
            <>
              <Connector />
              <p className="text-center text-sm font-medium" style={{ color: 'var(--color-muted)' }}>
                CFOS Specialties (choose track)
              </p>
              <div className="grid grid-cols-2 gap-3">
                {cfosSpecialties.map((cert) => (
                  <CertCard key={cert.key} cert={cert} accent={cfg.primary} app={app} />
                ))}
              </div>
            </>
          )}
          {rcdd && <><Connector /><CertCard cert={rcdd} accent={cfg.primary} app={app} /></>}
        </>
      )
    }

    if (app === 'weldpal') {
      const cw = levels.find((c) => c.key === 'CW')
      const cawi = levels.find((c) => c.key === 'CAWI')
      const cwi = levels.find((c) => c.key === 'CWI')
      const cws = levels.find((c) => c.key === 'CWS')
      const craw = levels.find((c) => c.key === 'CRAW')
      return (
        <>
          {cw && <CertCard cert={cw} accent={cfg.primary} app={app} />}
          {cawi && <><Connector /><CertCard cert={cawi} accent={cfg.primary} app={app} /></>}
          {cwi && <><Connector /><CertCard cert={cwi} accent={cfg.primary} app={app} /></>}
          {(cws || craw) && (
            <>
              <Connector />
              <p className="text-center text-sm font-medium" style={{ color: 'var(--color-muted)' }}>
                Advanced Tracks
              </p>
              <div className="grid grid-cols-2 gap-3">
                {cws && <CertCard cert={cws} accent={cfg.primary} app={app} />}
                {craw && <CertCard cert={craw} accent={cfg.primary} app={app} />}
              </div>
            </>
          )}
        </>
      )
    }

    if (app === 'voltpal') {
      const apprentice = levels.find((c) => c.key === 'APPRENTICE')
      const journeyman = levels.find((c) => c.key === 'JOURNEYMAN')
      const master = levels.find((c) => c.key === 'MASTER')
      const nfpa = levels.find((c) => c.key === 'NFPA_70E')
      return (
        <>
          {apprentice && <CertCard cert={apprentice} accent={cfg.primary} app={app} />}
          {journeyman && <><Connector /><CertCard cert={journeyman} accent={cfg.primary} app={app} /></>}
          {master && <><Connector /><CertCard cert={master} accent={cfg.primary} app={app} /></>}
          {nfpa && (
            <>
              <Connector />
              <p className="text-center text-sm font-medium" style={{ color: 'var(--color-muted)' }}>
                Safety Certification
              </p>
              <CertCard cert={nfpa} accent={cfg.primary} app={app} />
            </>
          )}
        </>
      )
    }

    if (app === 'poolpal') {
      const cpo = levels.find((c) => c.key === 'CPO')
      const cst = levels.find((c) => c.key === 'CST')
      const residential = levels.find((c) => c.key === 'RESIDENTIAL')
      const commercial = levels.find((c) => c.key === 'COMMERCIAL')
      return (
        <>
          {cpo && <CertCard cert={cpo} accent={cfg.primary} app={app} />}
          {(cst || residential || commercial) && (
            <>
              <Connector />
              <p className="text-center text-sm font-medium" style={{ color: 'var(--color-muted)' }}>
                Specializations
              </p>
              <div className="grid grid-cols-2 gap-3">
                {cst && <CertCard cert={cst} accent={cfg.primary} app={app} />}
                {residential && <CertCard cert={residential} accent={cfg.primary} app={app} />}
              </div>
              {commercial && <CertCard cert={commercial} accent={cfg.primary} app={app} />}
            </>
          )}
        </>
      )
    }

    if (app === 'pipepal') {
      const apprentice = levels.find((c) => c.key === 'APPRENTICE')
      const journeyman = levels.find((c) => c.key === 'JOURNEYMAN')
      const master = levels.find((c) => c.key === 'MASTER')
      const medGas = levels.find((c) => c.key === 'MEDICAL_GAS')
      return (
        <>
          {apprentice && <CertCard cert={apprentice} accent={cfg.primary} app={app} />}
          {journeyman && <><Connector /><CertCard cert={journeyman} accent={cfg.primary} app={app} /></>}
          {master && <><Connector /><CertCard cert={master} accent={cfg.primary} app={app} /></>}
          {medGas && (
            <>
              <Connector />
              <p className="text-center text-sm font-medium" style={{ color: 'var(--color-muted)' }}>
                Specialty Certification
              </p>
              <CertCard cert={medGas} accent={cfg.primary} app={app} />
            </>
          )}
        </>
      )
    }

    // Default: linear layout for any other app
    return (
      <>
        {levels.map((cert, i) => (
          <div key={cert.key}>
            {i > 0 && <Connector />}
            <CertCard cert={cert} accent={cfg.primary} app={app} />
          </div>
        ))}
      </>
    )
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <div className="flex items-center gap-4 mb-1">
        <img src={cfg.logo} alt={cfg.name} style={{ height: 48, width: 'auto', objectFit: 'contain' }} />
        <h1 className="text-3xl font-extrabold">Training</h1>
      </div>
      <p className="text-sm mb-8" style={{ color: 'var(--color-muted-fg)' }}>
        {APP_SUBTITLE[app] || 'Certification training'}
      </p>

      <TrainingGate app={app}>
        {loading ? (
          <p className="text-center py-12" style={{ color: 'var(--color-muted-fg)' }}>
            Loading certification paths&hellip;
          </p>
        ) : error ? (
          <div className="text-center py-12">
            <p className="text-red-400 mb-2">{error}</p>
            <button
              className="text-sm underline"
              style={{ color: 'var(--color-muted-fg)' }}
              onClick={() => window.location.reload()}
            >
              Retry
            </button>
          </div>
        ) : (
          <div className="flex flex-col gap-3">
            {renderCertPath()}
          </div>
        )}
      </TrainingGate>
    </div>
  )
}
