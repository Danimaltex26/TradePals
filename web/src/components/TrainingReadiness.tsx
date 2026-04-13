import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, getTrainingSchema, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

const CERT_NAMES: Record<string, string> = {
  FOT: 'FOT', CFOT: 'CFOT', CFOS_S: 'CFOS/S', CFOS_T: 'CFOS/T',
  CFOS_D: 'CFOS/D', CFOS_I: 'CFOS/I', RCDD: 'RCDD',
  CW: 'CW', CAWI: 'CAWI', CWI: 'CWI', CWS: 'CWS', CRAW: 'CRAW',
  APPRENTICE: 'Apprentice', JOURNEYMAN: 'Journeyman', MASTER: 'Master', NFPA_70E: 'NFPA 70E',
}

/* ── Large readiness gauge ── */

function ReadinessGauge({ percent, accent }: { percent: number; accent: string }) {
  const size = 140, stroke = 10
  const radius = (size - stroke) / 2
  const circumference = 2 * Math.PI * radius
  const offset = circumference - (percent / 100) * circumference
  const color = percent >= 75 ? accent : percent >= 60 ? '#F59E0B' : '#EF4444'

  return (
    <div className="flex flex-col items-center">
      <svg width={size} height={size} style={{ transform: 'rotate(-90deg)' }}>
        <circle cx={size / 2} cy={size / 2} r={radius} fill="none" stroke="var(--color-border)" strokeWidth={stroke} />
        <circle
          cx={size / 2} cy={size / 2} r={radius} fill="none"
          stroke={color} strokeWidth={stroke}
          strokeDasharray={circumference} strokeDashoffset={offset}
          strokeLinecap="round" style={{ transition: 'stroke-dashoffset 0.8s ease' }}
        />
        <text
          x={size / 2} y={size / 2}
          textAnchor="middle" dominantBaseline="central"
          fill="#F5F5F5" fontSize={size * 0.22} fontWeight="700"
          style={{ transform: 'rotate(90deg)', transformOrigin: 'center' }}
        >
          {percent}%
        </text>
      </svg>
      <p className="text-sm mt-2" style={{ color: 'var(--color-muted-fg)' }}>Overall Readiness</p>
    </div>
  )
}

/* ── Domain progress bar ── */

function DomainBar({ domain, percent, accent }: { domain: string; percent: number; accent: string }) {
  const color = percent >= 75 ? accent : percent >= 60 ? '#F59E0B' : '#EF4444'

  return (
    <div className="py-2">
      <div className="flex justify-between mb-1">
        <span className="text-sm">{domain}</span>
        <span className="text-sm font-semibold" style={{ color }}>{percent}%</span>
      </div>
      <div className="h-1.5 rounded-full overflow-hidden" style={{ backgroundColor: 'var(--color-border)' }}>
        <div className="h-full rounded-full transition-all duration-500" style={{ width: `${percent}%`, backgroundColor: color }} />
      </div>
    </div>
  )
}

/* ── Main ── */

export default function TrainingReadiness({ app }: { app: AppKey }) {
  const { certLevel } = useParams<{ certLevel: string }>()
  const navigate = useNavigate()
  const cfg = APPS[app]
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)

  const [readiness, setReadiness] = useState(0)
  const [estimatedPass, setEstimatedPass] = useState(false)
  const [domains, setDomains] = useState<{ domain: string; percent: number }[]>([])
  const [sessionCount, setSessionCount] = useState(0)
  const [lastSession, setLastSession] = useState<string | null>(null)
  const [moduleProgress, setModuleProgress] = useState<{ title: string; score: number | null; status: string }[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (appAuth.loading || !appAuth.user || !certLevel) return

    let cancelled = false

    async function load() {
      try {
        // Fetch readiness data
        const { data: readinessData } = await (client as any)
          .schema(getTrainingSchema(app))
          .from('training_readiness')
          .select('overall_readiness_percent, domain_readiness, sessions_count, estimated_pass, last_updated_at')
          .eq('user_id', appAuth.user!.id)
          .eq('cert_level', certLevel)
          .maybeSingle()

        if (readinessData && !cancelled) {
          setReadiness(Math.round(Number(readinessData.overall_readiness_percent) || 0))
          setEstimatedPass(readinessData.estimated_pass || false)
          setSessionCount(readinessData.sessions_count || 0)
          setLastSession(readinessData.last_updated_at || null)

          const domainMap = readinessData.domain_readiness || {}
          setDomains(
            Object.entries(domainMap)
              .map(([domain, pct]) => ({ domain, percent: Math.round(Number(pct) || 0) }))
              .sort((a, b) => a.percent - b.percent)
          )
        }

        // Fetch per-module progress
        const { data: modules } = await (client as any)
          .schema(getTrainingSchema(app))
          .from('training_modules')
          .select('id, title, module_number')
          .eq('cert_level', certLevel)
          .eq('is_published', true)
          .order('module_number')

        if (modules && !cancelled) {
          const moduleIds = modules.map((m: any) => m.id)
          const { data: progress } = await (client as any)
            .schema(getTrainingSchema(app))
            .from('training_progress')
            .select('module_id, status, last_practice_score_percent')
            .eq('user_id', appAuth.user!.id)
            .in('module_id', moduleIds)

          const progressMap: Record<string, any> = {}
          for (const p of progress || []) progressMap[p.module_id] = p

          setModuleProgress(
            modules.map((m: any) => ({
              title: m.title,
              score: progressMap[m.id]?.last_practice_score_percent != null
                ? Math.round(Number(progressMap[m.id].last_practice_score_percent))
                : null,
              status: progressMap[m.id]?.status || 'not_started',
            }))
          )
        }
      } catch {
        // silently fail — readiness is informational
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()
    return () => { cancelled = true }
  }, [app, certLevel, appAuth.user, appAuth.loading])

  const certName = CERT_NAMES[certLevel || ''] || certLevel || ''
  const weakest = domains.length > 0 ? domains[0] : null

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <TrainingGate app={app}>
        <button className="text-sm mb-4 block" style={{ color: cfg.primary }}
          onClick={() => navigate(`/${app}/training/${certLevel}`)}>
          &larr; Back to {certName}
        </button>
        <h1 className="text-2xl font-extrabold mb-6">Readiness</h1>

        {loading ? (
          <p className="text-center py-12" style={{ color: 'var(--color-muted-fg)' }}>Loading&hellip;</p>
        ) : (
          <div className="flex flex-col gap-4">
            {/* Gauge */}
            <div className="rounded-xl border p-6 text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <ReadinessGauge percent={readiness} accent={cfg.primary} />
              {estimatedPass && (
                <div className="mt-4 px-4 py-2.5 rounded-lg text-sm font-bold" style={{
                  backgroundColor: `${cfg.primary}18`, border: `1px solid ${cfg.primary}44`, color: cfg.primary,
                }}>
                  EXAM READY
                </div>
              )}
            </div>

            {/* Domain breakdown */}
            <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <h3 className="font-bold mb-3">Domain Breakdown</h3>
              {domains.length > 0 ? (
                domains.map((d) => <DomainBar key={d.domain} domain={d.domain} percent={d.percent} accent={cfg.primary} />)
              ) : (
                <p className="text-center py-4 text-sm" style={{ color: 'var(--color-muted)' }}>
                  Complete some practice to see domain breakdown.
                </p>
              )}
            </div>

            {/* Module scores */}
            {moduleProgress.length > 0 && (
              <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
                <h3 className="font-bold mb-3">Module Scores</h3>
                {moduleProgress.map((m) => (
                  <div key={m.title} className="flex justify-between py-1.5 text-sm" style={{ borderBottom: '1px solid var(--color-border)' }}>
                    <span>{m.title}</span>
                    {m.score != null ? (
                      <span className="font-semibold" style={{ color: m.score >= 70 ? cfg.primary : '#F59E0B' }}>{m.score}%</span>
                    ) : (
                      <span style={{ color: 'var(--color-muted)' }}>&mdash;</span>
                    )}
                  </div>
                ))}
              </div>
            )}

            {/* Stats */}
            <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <h3 className="font-bold mb-3">Study Stats</h3>
              <div className="flex flex-col gap-2">
                <div className="flex justify-between text-sm">
                  <span style={{ color: 'var(--color-muted-fg)' }}>Sessions completed</span>
                  <span className="font-semibold">{sessionCount}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span style={{ color: 'var(--color-muted-fg)' }}>Last session</span>
                  <span className="font-semibold">{lastSession ? new Date(lastSession).toLocaleDateString() : '\u2014'}</span>
                </div>
              </div>
            </div>

            {/* Recommended action */}
            {weakest && weakest.percent < 75 && (
              <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
                <h3 className="font-bold mb-2">Recommended Next</h3>
                <p className="text-sm mb-3" style={{ color: 'var(--color-muted-fg)' }}>
                  Focus on <strong>{weakest.domain}</strong> ({weakest.percent}%)
                </p>
                <button className="w-full h-11 rounded-lg font-semibold text-white"
                  style={{ backgroundColor: cfg.primary }}
                  onClick={() => navigate(`/${app}/training/${certLevel}/exam/run?mode=practice`)}>
                  Start Practice
                </button>
              </div>
            )}
          </div>
        )}
      </TrainingGate>
    </div>
  )
}
