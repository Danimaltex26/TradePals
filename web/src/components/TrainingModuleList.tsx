import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

type Module = {
  id: string
  module_number: number
  title: string
  estimated_minutes: number
  topic_list: string[]
  sectionsRead: number
  sectionsTotal: number
  status: string
  lastScore: number | null
}

function StatusBadge({ status, score }: { status: string; score: number | null }) {
  if (status === 'passed') return <span className="inline-block px-2 py-0.5 rounded text-xs font-bold bg-green-500/15 text-green-400">Passed</span>
  if (status === 'needs_review') return <span className="inline-block px-2 py-0.5 rounded text-xs font-bold bg-red-500/15 text-red-400">Needs Review</span>
  if (status === 'in_progress') return <span className="inline-block px-2 py-0.5 rounded text-xs font-bold bg-amber-500/15 text-amber-400">In Progress</span>
  return <span className="inline-block px-2 py-0.5 rounded text-xs font-bold bg-zinc-500/15 text-zinc-400">Not Started</span>
}

function LockIcon() {
  return (
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--color-muted)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" className="shrink-0">
      <rect x="3" y="11" width="18" height="11" rx="2" ry="2" />
      <path d="M7 11V7a5 5 0 0 1 10 0v4" />
    </svg>
  )
}

const CERT_NAMES: Record<string, string> = {
  FOT: 'Fiber Optic Technician (FOT)',
  CFOT: 'Certified Fiber Optic Technician (CFOT)',
  CFOS_S: 'CFOS — Splicing',
  CFOS_T: 'CFOS — Testing',
  CFOS_D: 'CFOS — Design',
  CFOS_I: 'CFOS — Inspection',
  RCDD: 'Registered Communications Distribution Designer (RCDD)',
}

export default function TrainingModuleList({ app }: { app: AppKey }) {
  const { certLevel } = useParams<{ certLevel: string }>()
  const navigate = useNavigate()
  const cfg = APPS[app]
  const auth = useAuth()
  const appAuth = auth[app]
  const [modules, setModules] = useState<Module[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    if (appAuth.loading || !appAuth.user || !certLevel) return

    let cancelled = false
    const client = getClient(app)

    async function load() {
      try {
        // Fetch modules for this cert level
        const { data: mods, error: modErr } = await (client as any)
          .schema('splicepal')
          .from('training_modules')
          .select('id, module_number, title, estimated_minutes, topic_list')
          .eq('cert_level', certLevel)
          .eq('is_published', true)
          .order('module_number')

        if (modErr) throw modErr

        // Fetch content section counts per module
        const moduleIds = (mods || []).map((m: any) => m.id)
        const { data: contentCounts, error: cntErr } = await (client as any)
          .schema('splicepal')
          .from('training_content')
          .select('module_id')
          .in('module_id', moduleIds)

        if (cntErr) throw cntErr

        const sectionTotals: Record<string, number> = {}
        for (const c of contentCounts || []) {
          sectionTotals[c.module_id] = (sectionTotals[c.module_id] || 0) + 1
        }

        // Fetch user progress
        const { data: progressRows } = await (client as any)
          .schema('splicepal')
          .from('training_progress')
          .select('module_id, status, concept_sections_read, last_practice_score_percent')
          .eq('user_id', appAuth.user!.id)
          .in('module_id', moduleIds)

        const progressMap: Record<string, any> = {}
        for (const p of progressRows || []) {
          progressMap[p.module_id] = p
        }

        if (cancelled) return

        setModules(
          (mods || []).map((m: any) => {
            const prog = progressMap[m.id]
            return {
              id: m.id,
              module_number: m.module_number,
              title: m.title,
              estimated_minutes: m.estimated_minutes,
              topic_list: m.topic_list || [],
              sectionsRead: prog?.concept_sections_read || 0,
              sectionsTotal: sectionTotals[m.id] || 0,
              status: prog?.status || 'not_started',
              lastScore: prog?.last_practice_score_percent != null ? Number(prog.last_practice_score_percent) : null,
            }
          }),
        )
        setError(null)
      } catch (err) {
        if (!cancelled) setError(err instanceof Error ? err.message : 'Failed to load modules')
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    load()
    return () => { cancelled = true }
  }, [app, certLevel, appAuth.user, appAuth.loading])

  const certName = CERT_NAMES[certLevel || ''] || certLevel || ''

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <div className="flex items-center gap-4 mb-1">
        <img src={cfg.logo} alt={cfg.name} style={{ height: 48, width: 'auto', objectFit: 'contain' }} />
        <h1 className="text-2xl font-extrabold">{certName}</h1>
      </div>

      <TrainingGate app={app}>
        <div className="flex justify-between items-center mb-6 mt-2">
          <button className="text-sm" style={{ color: cfg.primary }}
            onClick={() => navigate(`/${app}/training`)}>
            &larr; Back to Training
          </button>
          <button className="text-sm" style={{ color: cfg.primary }}
            onClick={() => navigate(`/${app}/training/${certLevel}/readiness`)}>
            Readiness &rarr;
          </button>
        </div>

        {loading ? (
          <p className="text-center py-12" style={{ color: 'var(--color-muted-fg)' }}>Loading modules&hellip;</p>
        ) : error ? (
          <p className="text-center py-12 text-red-400">{error}</p>
        ) : modules.length === 0 ? (
          <p className="text-center py-12" style={{ color: 'var(--color-muted-fg)' }}>No modules available yet for this certification.</p>
        ) : (
          <div className="flex flex-col gap-3">
            {modules.map((mod, i) => (
              <button
                key={mod.id}
                className="block w-full text-left rounded-xl border p-5 transition-colors"
                style={{
                  borderColor: 'var(--color-border)',
                  backgroundColor: 'var(--color-card)',
                  cursor: 'pointer',
                }}
                onMouseEnter={(e) => (e.currentTarget.style.borderColor = cfg.primary)}
                onMouseLeave={(e) => (e.currentTarget.style.borderColor = 'var(--color-border)')}
                onClick={() => navigate(`/${app}/training/${certLevel}/${mod.id}`)}
              >
                <div className="flex items-center justify-between mb-2">
                  <span className="text-xs font-semibold" style={{ color: 'var(--color-muted)' }}>
                    Module {i + 1}
                  </span>
                  <StatusBadge status={mod.status} score={mod.lastScore} />
                </div>
                <h3 className="font-bold mb-2">{mod.title}</h3>
                <div className="flex gap-4 flex-wrap text-xs" style={{ color: 'var(--color-muted)' }}>
                  <span>~{mod.estimated_minutes} min</span>
                  <span>{mod.topic_list.length} topics</span>
                  <span>{mod.sectionsRead}/{mod.sectionsTotal} sections</span>
                  {mod.lastScore != null && (
                    <span style={{ color: 'var(--color-muted-fg)' }}>Last: {Math.round(mod.lastScore)}%</span>
                  )}
                </div>
              </button>
            ))}
          </div>
        )}

        {!loading && !error && modules.length > 0 && (
          <button
            className="w-full h-11 rounded-lg font-semibold border mt-4"
            style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }}
            onClick={() => navigate(`/${app}/training/${certLevel}/exam`)}
          >
            Exams & Practice
          </button>
        )}
      </TrainingGate>
    </div>
  )
}
