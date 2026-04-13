import { useState, useEffect, useCallback } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, getTrainingSchema, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

/* ── Types ── */

type Section = {
  id: string
  section_number: number
  section_title: string
  content_type: string
  content_text: string
  standard_reference: string | null
  is_read: boolean
}

type Question = {
  id: string
  topic: string
  question_text: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: string
  explanation: string
  standard_reference: string | null
}

/* ── Section card ── */

const SECTION_BORDER: Record<string, string> = {
  example: '#F59E0B',
  formula: '#A0A0A8',
  code_reference: '#3B82F6',
  tip: '#33cc33',
}

const SECTION_LABEL: Record<string, string | null> = {
  example: 'Field Example',
  formula: 'Formula',
  code_reference: null,
  tip: 'Field Tip',
}

function SectionCard({ section, accent, onMarkRead }: {
  section: Section; accent: string; onMarkRead: (n: number) => void
}) {
  const borderColor = SECTION_BORDER[section.content_type]
  const label = section.content_type === 'code_reference'
    ? section.standard_reference
    : SECTION_LABEL[section.content_type]

  return (
    <div
      className="rounded-xl border p-5"
      style={{
        borderColor: 'var(--color-border)',
        backgroundColor: 'var(--color-card)',
        borderLeftWidth: borderColor ? 4 : 1,
        borderLeftColor: borderColor || 'var(--color-border)',
      }}
    >
      {label && (
        <p className="text-xs font-semibold uppercase tracking-wide mb-2" style={{
          color: SECTION_BORDER[section.content_type] || 'var(--color-muted)',
        }}>
          {label}
        </p>
      )}
      {section.section_title && <h3 className="font-bold mb-2">{section.section_title}</h3>}
      <div
        className="text-sm leading-relaxed"
        style={{
          whiteSpace: 'pre-wrap',
          color: '#D4D4D8',
          fontFamily: section.content_type === 'formula' ? 'monospace' : 'inherit',
        }}
      >
        {section.content_text}
      </div>
      {!section.is_read ? (
        <button
          className="mt-3 text-sm font-medium"
          style={{ color: accent }}
          onClick={() => onMarkRead(section.section_number)}
        >
          Mark as read
        </button>
      ) : (
        <span className="block mt-3 text-xs" style={{ color: 'var(--color-muted)' }}>Read</span>
      )}
    </div>
  )
}

/* ── Practice test ── */

function PracticeTest({ app, moduleId, certLevel, accent }: { app: AppKey; moduleId: string; certLevel: string; accent: string }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const [questions, setQuestions] = useState<Question[]>([])
  const [current, setCurrent] = useState(0)
  const [answers, setAnswers] = useState<Record<number, string>>({})
  const [revealed, setRevealed] = useState<Record<number, boolean>>({})
  const [loading, setLoading] = useState(true)
  const [finished, setFinished] = useState(false)
  const [showMissed, setShowMissed] = useState(false)
  const [startTime] = useState(Date.now())

  useEffect(() => {
    if (!appAuth.user) return
    ;(client as any)
      .schema(getTrainingSchema(app))
      .from('training_questions')
      .select('id, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference')
      .eq('module_id', moduleId)
      .eq('flagged_quality', false)
      .then(({ data, error }: any) => {
        if (!error && data) {
          // Shuffle
          const shuffled = [...data].sort(() => Math.random() - 0.5)
          setQuestions(shuffled)
        }
        setLoading(false)
      })
  }, [moduleId, appAuth.user])

  function selectAnswer(idx: number, choice: string) {
    if (revealed[idx]) return
    setAnswers((prev) => ({ ...prev, [idx]: choice }))
    setRevealed((prev) => ({ ...prev, [idx]: true }))
  }

  async function finishTest() {
    setFinished(true)
    if (!appAuth.user) return

    const correctCount = questions.reduce((n, q, i) => n + (answers[i] === q.correct_answer ? 1 : 0), 0)
    const percent = Math.round((correctCount / questions.length) * 100)
    const elapsed = Math.round((Date.now() - startTime) / 1000)

    try {
      // Update module progress
      await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_progress')
        .upsert({
          user_id: appAuth.user.id,
          module_id: moduleId,
          cert_level: certLevel,
          questions_attempted: questions.length,
          questions_correct: correctCount,
          last_practice_score_percent: percent,
          status: percent >= 70 ? 'passed' : 'needs_review',
          last_session_at: new Date().toISOString(),
        }, { onConflict: 'user_id,module_id' })

      // Record test session
      await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_test_sessions')
        .insert({
          user_id: appAuth.user.id,
          module_id: moduleId,
          cert_level: certLevel,
          session_type: 'practice',
          total_questions: questions.length,
          correct_count: correctCount,
          score_percent: percent,
          time_taken_seconds: elapsed,
          started_at: new Date(startTime).toISOString(),
          completed_at: new Date().toISOString(),
        })

      // Recompute readiness for this cert level
      const { data: allProgress } = await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_progress')
        .select('last_practice_score_percent')
        .eq('user_id', appAuth.user.id)
        .eq('cert_level', certLevel)
        .not('last_practice_score_percent', 'is', null)

      if (allProgress && allProgress.length > 0) {
        const avgReadiness = Math.round(
          allProgress.reduce((sum: number, p: any) => sum + Number(p.last_practice_score_percent), 0) / allProgress.length
        )

        await (client as any)
          .schema(getTrainingSchema(app))
          .from('training_readiness')
          .upsert({
            user_id: appAuth.user.id,
            cert_level: certLevel,
            overall_readiness_percent: avgReadiness,
            questions_attempted: (allProgress.length * questions.length),
            sessions_count: allProgress.length,
            estimated_pass: avgReadiness >= 70,
            last_updated_at: new Date().toISOString(),
          }, { onConflict: 'user_id,cert_level' })
      }
    } catch (err) {
      console.error('Failed to save progress:', err)
    }
  }

  function reset() {
    setFinished(false)
    setAnswers({})
    setRevealed({})
    setCurrent(0)
    setShowMissed(false)
    setQuestions((prev) => [...prev].sort(() => Math.random() - 0.5))
  }

  if (loading) return <p className="text-center py-8" style={{ color: 'var(--color-muted-fg)' }}>Loading questions&hellip;</p>
  if (questions.length === 0) return <p className="text-center py-8" style={{ color: 'var(--color-muted-fg)' }}>No practice questions available yet.</p>

  // Score screen
  if (finished) {
    const correctCount = questions.reduce((n, q, i) => n + (answers[i] === q.correct_answer ? 1 : 0), 0)
    const percent = Math.round((correctCount / questions.length) * 100)
    const passed = percent >= 70
    const missedIndices = questions.map((_, i) => i).filter((i) => answers[i] !== questions[i].correct_answer)

    return (
      <div className="flex flex-col gap-4">
        <div className="rounded-xl border p-6 text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <p className="text-4xl font-bold" style={{ color: passed ? accent : '#F59E0B' }}>
            {correctCount} / {questions.length} &mdash; {percent}%
          </p>
          <span className="inline-block mt-2 px-3 py-1 rounded text-sm font-bold" style={{
            backgroundColor: passed ? `${accent}22` : 'rgba(245,158,11,0.15)',
            color: passed ? accent : '#F59E0B',
          }}>
            {passed ? 'PASSED' : 'NEEDS REVIEW'}
          </span>
        </div>

        <div className="flex flex-col gap-2">
          {missedIndices.length > 0 && (
            <button
              className="w-full h-11 rounded-lg font-semibold border"
              style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }}
              onClick={() => setShowMissed(!showMissed)}
            >
              {showMissed ? 'Hide' : 'Review'} missed questions ({missedIndices.length})
            </button>
          )}
          <button className="w-full h-11 rounded-lg font-semibold border" style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }} onClick={reset}>
            Retake test
          </button>
        </div>

        {showMissed && (
          <div className="flex flex-col gap-4">
            {missedIndices.map((i) => {
              const q = questions[i]
              const opts = [
                { key: 'A', text: q.option_a },
                { key: 'B', text: q.option_b },
                { key: 'C', text: q.option_c },
                { key: 'D', text: q.option_d },
              ]
              return (
                <div key={i} className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
                  <p className="text-xs mb-1" style={{ color: 'var(--color-muted)' }}>Q{i + 1} &middot; {q.topic}</p>
                  <p className="mb-3">{q.question_text}</p>
                  {opts.map((opt) => {
                    const isCorrect = opt.key === q.correct_answer
                    const wasSelected = opt.key === answers[i]
                    return (
                      <div key={opt.key} className="rounded-lg border px-3 py-2 mb-1 text-sm" style={{
                        borderColor: isCorrect ? accent : wasSelected ? '#EF4444' : 'var(--color-border)',
                        backgroundColor: isCorrect ? `${accent}11` : wasSelected ? 'rgba(239,68,68,0.1)' : 'transparent',
                      }}>
                        <strong>{opt.key}.</strong> {opt.text}
                      </div>
                    )
                  })}
                  {q.explanation && <p className="text-sm mt-2" style={{ color: 'var(--color-muted-fg)' }}>{q.explanation}</p>}
                </div>
              )
            })}
          </div>
        )}
      </div>
    )
  }

  // Question view
  const q = questions[current]
  const isRevealed = revealed[current]
  const selected = answers[current]
  const allAnswered = Object.keys(answers).length === questions.length
  const opts = [
    { key: 'A', text: q.option_a },
    { key: 'B', text: q.option_b },
    { key: 'C', text: q.option_c },
    { key: 'D', text: q.option_d },
  ]

  return (
    <div className="flex flex-col gap-4">
      <div className="flex justify-between text-xs" style={{ color: 'var(--color-muted)' }}>
        <span>Question {current + 1} of {questions.length}</span>
        <span>{Object.keys(answers).length} answered</span>
      </div>

      <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <p className="text-xs mb-1" style={{ color: 'var(--color-muted)' }}>{q.topic}</p>
        <p className="mb-4 leading-relaxed">{q.question_text}</p>

        <div className="flex flex-col gap-2">
          {opts.map((opt) => {
            let bg = 'transparent'
            let border = 'var(--color-border)'
            if (isRevealed) {
              if (opt.key === q.correct_answer) { bg = `${accent}11`; border = accent }
              else if (opt.key === selected) { bg = 'rgba(239,68,68,0.1)'; border = '#EF4444' }
            } else if (opt.key === selected) {
              bg = `${accent}0a`; border = accent
            }

            return (
              <button
                key={opt.key}
                className="w-full text-left rounded-lg border px-4 py-3 text-sm transition-colors"
                style={{ borderColor: border, backgroundColor: bg, cursor: isRevealed ? 'default' : 'pointer' }}
                onClick={() => selectAnswer(current, opt.key)}
                disabled={isRevealed}
              >
                <strong>{opt.key}.</strong> {opt.text}
              </button>
            )
          })}
        </div>

        {isRevealed && q.explanation && (
          <div className="mt-4 rounded-lg p-4 text-sm leading-relaxed" style={{
            backgroundColor: `${accent}08`,
            borderLeft: `3px solid ${accent}`,
            color: '#D4D4D8',
          }}>
            <p className="text-xs font-semibold mb-1" style={{ color: 'var(--color-muted)' }}>Explanation</p>
            {q.explanation}
            {q.standard_reference && (
              <p className="text-xs mt-2" style={{ color: 'var(--color-muted)' }}>Ref: {q.standard_reference}</p>
            )}
          </div>
        )}
      </div>

      <div className="flex justify-between">
        <button
          className="text-sm"
          style={{ color: current === 0 ? 'var(--color-muted)' : 'var(--color-muted-fg)' }}
          onClick={() => setCurrent((c) => Math.max(0, c - 1))}
          disabled={current === 0}
        >
          &larr; Previous
        </button>
        {current < questions.length - 1 ? (
          <button className="text-sm" style={{ color: 'var(--color-muted-fg)' }} onClick={() => setCurrent((c) => c + 1)}>
            Next &rarr;
          </button>
        ) : allAnswered ? (
          <button className="text-sm font-semibold" style={{ color: accent }} onClick={() => finishTest()}>
            See Score
          </button>
        ) : (
          <span className="text-sm" style={{ color: 'var(--color-muted)' }}>Answer all to finish</span>
        )}
      </div>
    </div>
  )
}

/* ── Main module content view ── */

export default function TrainingModuleContent({ app }: { app: AppKey }) {
  const { certLevel, moduleId } = useParams<{ certLevel: string; moduleId: string }>()
  const navigate = useNavigate()
  const cfg = APPS[app]
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const [title, setTitle] = useState('')
  const [sections, setSections] = useState<Section[]>([])
  const [sectionsRead, setSectionsRead] = useState(0)
  const [activeTab, setActiveTab] = useState<'learn' | 'test'>('learn')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const fetchModule = useCallback(async () => {
    if (!appAuth.user || !moduleId) return

    try {
      // Fetch module info
      const { data: mod, error: modErr } = await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_modules')
        .select('title')
        .eq('id', moduleId)
        .single()

      if (modErr) throw modErr
      setTitle(mod.title)

      // Fetch content sections
      const { data: content, error: cntErr } = await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_content')
        .select('id, section_number, section_title, content_type, content_text, standard_reference')
        .eq('module_id', moduleId)
        .order('section_number')

      if (cntErr) throw cntErr

      // Fetch user progress for this module
      const { data: progress } = await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_progress')
        .select('concept_sections_read')
        .eq('user_id', appAuth.user!.id)
        .eq('module_id', moduleId)
        .maybeSingle()

      const read = progress?.concept_sections_read || 0
      setSectionsRead(read)

      // Mark first N sections as read based on progress
      setSections(
        (content || []).map((s: any, i: number) => ({
          ...s,
          is_read: i < read,
        })),
      )

      setError(null)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load module')
    } finally {
      setLoading(false)
    }
  }, [moduleId, appAuth.user, appAuth.loading])

  useEffect(() => {
    if (!appAuth.loading && appAuth.user) fetchModule()
  }, [fetchModule, appAuth.loading])

  async function markRead(sectionNumber: number) {
    // Optimistic update
    setSections((prev) => prev.map((s) => s.section_number === sectionNumber ? { ...s, is_read: true } : s))
    const newCount = sectionsRead + 1
    setSectionsRead(newCount)

    // Upsert progress
    try {
      await (client as any)
        .schema(getTrainingSchema(app))
        .from('training_progress')
        .upsert({
          user_id: appAuth.user!.id,
          module_id: moduleId,
          cert_level: certLevel,
          concept_sections_read: newCount,
          total_sections: sections.length,
          status: newCount >= sections.length ? 'sections_complete' : 'in_progress',
          last_session_at: new Date().toISOString(),
        }, { onConflict: 'user_id,module_id' })
    } catch {
      // Revert on failure
      setSections((prev) => prev.map((s) => s.section_number === sectionNumber ? { ...s, is_read: false } : s))
      setSectionsRead(sectionsRead)
    }
  }

  const allRead = sectionsRead >= sections.length && sections.length > 0
  const progressPercent = sections.length > 0 ? (sectionsRead / sections.length) * 100 : 0

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <TrainingGate app={app}>
        <button
          className="text-sm mb-4 block"
          style={{ color: cfg.primary }}
          onClick={() => navigate(`/${app}/training/${certLevel}`)}
        >
          &larr; Back to modules
        </button>

        {loading ? (
          <p className="text-center py-12" style={{ color: 'var(--color-muted-fg)' }}>Loading module&hellip;</p>
        ) : error ? (
          <p className="text-center py-12 text-red-400">{error}</p>
        ) : (
          <>
            <h1 className="text-xl font-extrabold mb-4">{title}</h1>

            {/* Tab toggle */}
            <div className="flex rounded-lg border overflow-hidden mb-6" style={{ borderColor: 'var(--color-border)' }}>
              <button
                className="flex-1 h-10 text-sm font-semibold transition-colors"
                style={{
                  backgroundColor: activeTab === 'learn' ? cfg.primary : 'transparent',
                  color: activeTab === 'learn' ? 'white' : 'var(--color-muted-fg)',
                }}
                onClick={() => setActiveTab('learn')}
              >
                Learn
              </button>
              <button
                className="flex-1 h-10 text-sm font-semibold transition-colors"
                style={{
                  backgroundColor: activeTab === 'test' ? cfg.primary : 'transparent',
                  color: activeTab === 'test' ? 'white' : 'var(--color-muted-fg)',
                }}
                onClick={() => setActiveTab('test')}
              >
                Practice Test
              </button>
            </div>

            {activeTab === 'learn' && (
              <>
                {/* Progress bar */}
                <div className="mb-6">
                  <div className="flex justify-between mb-1">
                    <span className="text-sm" style={{ color: 'var(--color-muted-fg)' }}>
                      {sectionsRead} of {sections.length} sections read
                    </span>
                    {allRead && (
                      <button className="text-sm font-medium" style={{ color: cfg.primary }} onClick={() => setActiveTab('test')}>
                        Take Practice Test &rarr;
                      </button>
                    )}
                  </div>
                  <div className="h-1 rounded-full overflow-hidden" style={{ backgroundColor: 'var(--color-border)' }}>
                    <div className="h-full rounded-full transition-all duration-300" style={{ width: `${progressPercent}%`, backgroundColor: cfg.primary }} />
                  </div>
                </div>

                <div className="flex flex-col gap-4">
                  {sections.map((section) => (
                    <SectionCard key={section.id} section={section} accent={cfg.primary} onMarkRead={markRead} />
                  ))}
                  {sections.length === 0 && (
                    <p className="text-center py-8" style={{ color: 'var(--color-muted-fg)' }}>
                      Content coming soon for this module.
                    </p>
                  )}
                </div>
              </>
            )}

            {activeTab === 'test' && (
              <PracticeTest app={app} moduleId={moduleId!} certLevel={certLevel!} accent={cfg.primary} />
            )}
          </>
        )}
      </TrainingGate>
    </div>
  )
}
