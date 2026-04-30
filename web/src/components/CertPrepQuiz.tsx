import { useState, useEffect } from 'react'
import { useAuth } from '../auth/AuthProvider'
import { getClient, getTrainingSchema, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

/* ── Per-app cert levels & question categories ── */

type CertOption = { key: string; label: string }
type CategoryOption = { key: string; label: string }

const APP_CERTS: Partial<Record<AppKey, CertOption[]>> = {
  splicepal: [
    { key: 'FOT', label: 'FOT' },
    { key: 'CFOT', label: 'CFOT' },
    { key: 'CFOS_S', label: 'CFOS/S' },
    { key: 'CFOS_T', label: 'CFOS/T' },
  ],
  weldpal: [
    { key: 'CW', label: 'CW' },
    { key: 'CAWI', label: 'CAWI' },
    { key: 'CWI', label: 'CWI' },
    { key: 'CWS', label: 'CWS' },
    { key: 'CRAW', label: 'CRAW' },
  ],
  poolpal: [
    { key: 'CPO', label: 'CPO' },
    { key: 'CST', label: 'CST' },
    { key: 'RESIDENTIAL', label: 'Residential' },
    { key: 'COMMERCIAL', label: 'Commercial' },
  ],
  voltpal: [
    { key: 'APPRENTICE', label: 'Apprentice' },
    { key: 'JOURNEYMAN', label: 'Journeyman' },
    { key: 'MASTER', label: 'Master' },
    { key: 'NFPA_70E', label: 'NFPA 70E' },
  ],
  pipepal: [
    { key: 'APPRENTICE', label: 'Apprentice' },
    { key: 'JOURNEYMAN', label: 'Journeyman' },
    { key: 'MASTER', label: 'Master' },
    { key: 'MEDICAL_GAS', label: 'Medical Gas' },
  ],
  windpal: [
    { key: 'GWO_BST', label: 'GWO BST' },
    { key: 'GWO_BTT', label: 'GWO BTT' },
    { key: 'ACP_TECH', label: 'ACP Tech' },
    { key: 'SENIOR_TECH', label: 'Senior Tech' },
  ],
  liftpal: [
    { key: 'CET', label: 'CET' },
    { key: 'QEI', label: 'QEI' },
    { key: 'CAT', label: 'CAT' },
    { key: 'SENIOR_TECH', label: 'Senior Tech' },
  ],
}

const APP_CATEGORIES: Partial<Record<AppKey, CategoryOption[]>> = {
  splicepal: [
    { key: '', label: 'All' },
    { key: 'fiber_fundamentals', label: 'Fiber Fundamentals' },
    { key: 'splicing', label: 'Splicing' },
    { key: 'otdr', label: 'OTDR' },
    { key: 'testing', label: 'Testing' },
    { key: 'osp', label: 'OSP' },
    { key: 'isp', label: 'ISP' },
    { key: 'standards', label: 'Standards' },
    { key: 'safety', label: 'Safety' },
  ],
  weldpal: [
    { key: '', label: 'All' },
    { key: 'visual_inspection', label: 'Visual Inspection' },
    { key: 'codes_standards', label: 'Codes & Standards' },
    { key: 'weld_symbols', label: 'Weld Symbols' },
    { key: 'metallurgy', label: 'Metallurgy' },
    { key: 'processes', label: 'Processes' },
    { key: 'safety', label: 'Safety' },
    { key: 'ndt', label: 'NDT' },
  ],
  poolpal: [
    { key: '', label: 'All' },
    { key: 'water_chemistry', label: 'Water Chemistry' },
    { key: 'filtration', label: 'Filtration' },
    { key: 'pumps_motors', label: 'Pumps & Motors' },
    { key: 'heating', label: 'Heating' },
    { key: 'safety', label: 'Safety' },
    { key: 'codes_standards', label: 'Codes & Standards' },
    { key: 'maintenance', label: 'Maintenance' },
  ],
  voltpal: [
    { key: '', label: 'All' },
    { key: 'nec_code', label: 'NEC Code' },
    { key: 'circuits', label: 'Circuits' },
    { key: 'motors_drives', label: 'Motors & Drives' },
    { key: 'grounding', label: 'Grounding' },
    { key: 'safety', label: 'Safety' },
    { key: 'transformers', label: 'Transformers' },
    { key: 'controls', label: 'Controls' },
  ],
  pipepal: [
    { key: '', label: 'All' },
    { key: 'code_compliance', label: 'Code Compliance' },
    { key: 'drainage', label: 'Drainage' },
    { key: 'water_supply', label: 'Water Supply' },
    { key: 'gas_piping', label: 'Gas Piping' },
    { key: 'fixtures', label: 'Fixtures' },
    { key: 'safety', label: 'Safety' },
    { key: 'medical_gas', label: 'Medical Gas' },
  ],
  windpal: [
    { key: '', label: 'All' },
    { key: 'safety', label: 'Safety' },
    { key: 'electrical', label: 'Electrical' },
    { key: 'mechanical', label: 'Mechanical' },
    { key: 'hydraulics', label: 'Hydraulics' },
    { key: 'composites', label: 'Composites' },
    { key: 'regulations', label: 'Regulations' },
  ],
  liftpal: [
    { key: '', label: 'All' },
    { key: 'codes_standards', label: 'Codes & Standards' },
    { key: 'electrical', label: 'Electrical' },
    { key: 'mechanical', label: 'Mechanical' },
    { key: 'hydraulic', label: 'Hydraulic' },
    { key: 'safety', label: 'Safety' },
    { key: 'inspection', label: 'Inspection' },
    { key: 'accessibility', label: 'Accessibility' },
  ],
}

/* ── Types ── */

type CertQuestion = {
  id: string
  cert_level: string
  category: string
  question: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: string
  explanation: string
  code_reference: string | null
  difficulty: string
}

type CertProgress = {
  cert_level: string
  questions_attempted: number
  questions_correct: number
  weak_categories: string[]
  strong_categories: string[]
}

/* ── Main view ── */

function CertPrepView({ app, accent }: { app: AppKey; accent: string }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const schema = getTrainingSchema(app)

  const certs = APP_CERTS[app] || []
  const categories = APP_CATEGORIES[app] || [{ key: '', label: 'All' }]

  const [cert, setCert] = useState(certs[0]?.key || '')
  const [category, setCategory] = useState('')
  const [questions, setQuestions] = useState<CertQuestion[]>([])
  const [idx, setIdx] = useState(0)
  const [selected, setSelected] = useState<string | null>(null)
  const [feedback, setFeedback] = useState<{
    correct: boolean
    correct_answer: string
    explanation: string
    code_reference: string | null
  } | null>(null)
  const [loading, setLoading] = useState(false)
  const [progress, setProgress] = useState<CertProgress[]>([])
  const [streak, setStreak] = useState(0)
  const [err, setErr] = useState('')

  useEffect(() => {
    if (appAuth.user) loadProgress()
  }, [appAuth.user])

  async function loadProgress() {
    const { data } = await (client as any)
      .schema(schema)
      .from('cert_prep_progress')
      .select('cert_level, questions_attempted, questions_correct, weak_categories, strong_categories')
      .eq('user_id', appAuth.user!.id)
    setProgress(data || [])
  }

  async function startSession() {
    setLoading(true)
    setErr('')
    setQuestions([])
    setIdx(0)
    setFeedback(null)
    setSelected(null)

    let query = (client as any)
      .schema(schema)
      .from('cert_prep_questions')
      .select('*')
      .eq('cert_level', cert)

    if (category) query = query.eq('category', category)

    const { data, error } = await query
    if (error) { setErr(error.message); setLoading(false); return }
    if (!data || data.length === 0) {
      setErr('No questions in this bank yet. Try a different category.')
      setLoading(false)
      return
    }

    // Shuffle and take 10
    const shuffled = [...data].sort(() => Math.random() - 0.5).slice(0, 10)
    setQuestions(shuffled)
    setLoading(false)
  }

  async function submitAnswer(letter: string) {
    if (feedback) return
    setSelected(letter)

    const q = questions[idx]
    const isCorrect = letter === q.correct_answer
    setFeedback({
      correct: isCorrect,
      correct_answer: q.correct_answer,
      explanation: q.explanation,
      code_reference: q.code_reference,
    })
    setStreak(s => isCorrect ? s + 1 : 0)

    // Upsert progress
    if (!appAuth.user) return
    const existing = progress.find(p => p.cert_level === cert)
    const attempted = (existing?.questions_attempted || 0) + 1
    const correct = (existing?.questions_correct || 0) + (isCorrect ? 1 : 0)

    // Track category performance for weak/strong
    const catKey = q.category
    let weak = [...(existing?.weak_categories || [])]
    let strong = [...(existing?.strong_categories || [])]
    if (isCorrect) {
      weak = weak.filter(c => c !== catKey)
      if (!strong.includes(catKey)) strong.push(catKey)
    } else {
      strong = strong.filter(c => c !== catKey)
      if (!weak.includes(catKey)) weak.push(catKey)
    }

    await (client as any)
      .schema(schema)
      .from('cert_prep_progress')
      .upsert({
        user_id: appAuth.user.id,
        cert_level: cert,
        questions_attempted: attempted,
        questions_correct: correct,
        weak_categories: weak,
        strong_categories: strong,
        last_session_at: new Date().toISOString(),
      }, { onConflict: 'user_id,cert_level' })

    // Update local state
    setProgress(prev => {
      const rest = prev.filter(p => p.cert_level !== cert)
      return [...rest, { cert_level: cert, questions_attempted: attempted, questions_correct: correct, weak_categories: weak, strong_categories: strong }]
    })
  }

  function nextQuestion() {
    setSelected(null)
    setFeedback(null)
    if (idx + 1 < questions.length) {
      setIdx(idx + 1)
    } else {
      setQuestions([])
      setIdx(0)
    }
  }

  const currentProgress = progress.find(p => p.cert_level === cert)

  // ── Setup screen ──
  if (questions.length === 0 && !loading) {
    return (
      <div className="mx-auto max-w-2xl px-4 py-12">
        <h1 className="text-2xl font-extrabold mb-1">Cert Prep</h1>
        <p className="text-sm mb-8" style={{ color: 'var(--color-muted-fg)' }}>
          Quick-fire practice questions for your next certification exam.
        </p>

        <div className="flex flex-col gap-5">
          <div>
            <p className="text-xs font-semibold uppercase tracking-wider mb-2" style={{ color: 'var(--color-muted)' }}>
              Certification
            </p>
            <div className="flex flex-wrap gap-2">
              {certs.map(c => (
                <button key={c.key}
                  className="px-4 py-2 rounded-lg text-sm font-semibold transition-colors"
                  style={cert === c.key
                    ? { backgroundColor: accent, color: 'white' }
                    : { border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }
                  }
                  onClick={() => setCert(c.key)}
                >
                  {c.label}
                </button>
              ))}
            </div>
          </div>

          <div>
            <p className="text-xs font-semibold uppercase tracking-wider mb-2" style={{ color: 'var(--color-muted)' }}>
              Category
            </p>
            <div className="flex flex-wrap gap-2">
              {categories.map(c => (
                <button key={c.label}
                  className="px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors"
                  style={category === c.key
                    ? { backgroundColor: accent, color: 'white' }
                    : { border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }
                  }
                  onClick={() => setCategory(c.key)}
                >
                  {c.label}
                </button>
              ))}
            </div>
          </div>

          {currentProgress && (
            <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <h3 className="font-bold mb-2">Your {cert} Progress</h3>
              <div className="flex gap-6 text-sm">
                <div>
                  <span style={{ color: 'var(--color-muted)' }}>Attempted:</span>{' '}
                  <strong>{currentProgress.questions_attempted}</strong>
                </div>
                <div>
                  <span style={{ color: 'var(--color-muted)' }}>Correct:</span>{' '}
                  <strong>{currentProgress.questions_correct}</strong>
                  <span className="ml-1" style={{ color: 'var(--color-muted)' }}>
                    ({currentProgress.questions_attempted
                      ? Math.round((currentProgress.questions_correct / currentProgress.questions_attempted) * 100)
                      : 0}%)
                  </span>
                </div>
              </div>
              {currentProgress.weak_categories.length > 0 && (
                <p className="text-xs mt-2" style={{ color: '#F59E0B' }}>
                  Needs work: {currentProgress.weak_categories.map(c => c.replace(/_/g, ' ')).join(', ')}
                </p>
              )}
            </div>
          )}

          {err && (
            <div className="rounded-lg border px-4 py-3 text-sm" style={{ borderColor: '#EF4444', backgroundColor: 'rgba(239,68,68,0.1)', color: '#FCA5A5' }}>
              {err}
            </div>
          )}

          <button
            className="w-full h-12 rounded-lg font-semibold text-white"
            style={{ backgroundColor: accent }}
            onClick={startSession}
          >
            Start Practice
          </button>
        </div>
      </div>
    )
  }

  // ── Loading ──
  if (loading) {
    return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Loading questions&hellip;</p>
  }

  // ── Question view ──
  const q = questions[idx]

  return (
    <div className="mx-auto max-w-2xl px-4 py-8">
      <div className="flex justify-between items-center mb-3">
        <span className="text-xs" style={{ color: 'var(--color-muted)' }}>
          Question {idx + 1} of {questions.length}
        </span>
        <span className="px-2 py-0.5 rounded text-xs font-semibold" style={{ backgroundColor: `${accent}22`, color: accent }}>
          {(q.category || '').replace(/_/g, ' ')}
        </span>
      </div>

      <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <p className="mb-4 leading-relaxed">{q.question}</p>

        <div className="flex flex-col gap-2">
          {(['A', 'B', 'C', 'D'] as const).map(letter => {
            const opt = q[`option_${letter.toLowerCase()}` as keyof CertQuestion] as string
            const isCorrect = feedback && letter === feedback.correct_answer
            const isWrong = feedback && letter === selected && !feedback.correct

            let bg = 'transparent'
            let border = 'var(--color-border)'
            if (isCorrect) { bg = `${accent}11`; border = accent }
            else if (isWrong) { bg = 'rgba(239,68,68,0.1)'; border = '#EF4444' }
            else if (!feedback && letter === selected) { bg = `${accent}0a`; border = accent }

            return (
              <button key={letter}
                className="w-full text-left rounded-lg border px-4 py-3 text-sm transition-colors"
                style={{ borderColor: border, backgroundColor: bg, cursor: feedback ? 'default' : 'pointer' }}
                onClick={() => submitAnswer(letter)}
                disabled={!!feedback}
              >
                <strong>{letter}.</strong> {opt}
              </button>
            )
          })}
        </div>

        {feedback && (
          <div className="mt-4 rounded-lg p-4 text-sm leading-relaxed"
            style={{
              backgroundColor: feedback.correct ? `${accent}08` : 'rgba(239,68,68,0.06)',
              borderLeft: `3px solid ${feedback.correct ? accent : '#EF4444'}`,
              color: '#D4D4D8',
            }}
          >
            <p className="font-semibold mb-1" style={{ color: feedback.correct ? accent : '#FCA5A5' }}>
              {feedback.correct ? 'Correct' : 'Incorrect'}
            </p>
            <p>{feedback.explanation}</p>
            {feedback.code_reference && (
              <p className="text-xs mt-2" style={{ color: 'var(--color-muted)' }}>Ref: {feedback.code_reference}</p>
            )}
          </div>
        )}
      </div>

      {feedback && (
        <button
          className="w-full h-11 rounded-lg font-semibold text-white mt-4"
          style={{ backgroundColor: accent }}
          onClick={nextQuestion}
        >
          {idx + 1 < questions.length ? 'Next Question' : 'Finish Session'}
        </button>
      )}

      <p className="text-center text-sm mt-3" style={{ color: 'var(--color-muted)' }}>
        Streak: {streak}
      </p>
    </div>
  )
}

/* ── Exported component ── */

export default function CertPrepQuiz({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  return (
    <TrainingGate app={app}>
      <CertPrepView app={app} accent={cfg.primary} />
    </TrainingGate>
  )
}
