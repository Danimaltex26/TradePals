import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
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

// Per-app cert definitions and schema name
const APP_CERTS: Partial<Record<AppKey, CertDef[]>> = {
  splicepal: SPLICEPAL_CERTS,
  weldpal: WELDPAL_CERTS,
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
        style={{ transform: 'rotate(90deg)', transformOrigin: 'center' }}
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
  const navigate = useNavigate()
  const examReady = !cert.locked && cert.readiness >= cert.passPercent

  function go() {
    navigate(`/${app}/training/${cert.key}`)
  }

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
        <div className="mt-3">
          {cert.readiness === 0 && !cert.inProgress ? (
            <button
              className="w-full h-11 rounded-lg font-semibold text-white"
              style={{ backgroundColor: accent }}
              onClick={go}
            >
              Start
            </button>
          ) : cert.inProgress ? (
            <button
              className="w-full h-11 rounded-lg font-semibold text-white"
              style={{ backgroundColor: accent }}
              onClick={go}
            >
              Continue &mdash; {cert.readiness}% ready
            </button>
          ) : (
            <button
              className="w-full h-11 rounded-lg font-semibold border"
              style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }}
              onClick={go}
            >
              View Modules
            </button>
          )}
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
