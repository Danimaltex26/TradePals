import { useState, useEffect, useCallback } from 'react'
import { useParams, useNavigate, useSearchParams } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

/* ── Cert-level exam config (mirrors server config) ── */

const EXAM_CONFIG: Record<string, { name: string; questions: number; minutes: number; pass: number }> = {
  FOT:    { name: 'FOT',    questions: 60,  minutes: 90,  pass: 70 },
  CFOT:   { name: 'CFOT',   questions: 100, minutes: 150, pass: 70 },
  CFOS_S: { name: 'CFOS/S', questions: 75,  minutes: 120, pass: 75 },
  CFOS_T: { name: 'CFOS/T', questions: 75,  minutes: 120, pass: 75 },
  CFOS_D: { name: 'CFOS/D', questions: 75,  minutes: 120, pass: 75 },
  CFOS_I: { name: 'CFOS/I', questions: 75,  minutes: 120, pass: 75 },
  RCDD:   { name: 'RCDD',   questions: 100, minutes: 150, pass: 75 },
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
  difficulty: string
}

/* ── Timer ── */

function Timer({ totalSeconds, onExpire, accent }: { totalSeconds: number; onExpire: () => void; accent: string }) {
  const [remaining, setRemaining] = useState(totalSeconds)
  const pct = totalSeconds > 0 ? remaining / totalSeconds : 1
  const color = pct <= 0.1 ? '#EF4444' : pct <= 0.25 ? '#F59E0B' : '#F5F5F5'

  useEffect(() => {
    if (remaining <= 0) { onExpire(); return }
    const id = setTimeout(() => setRemaining((r) => r - 1), 1000)
    return () => clearTimeout(id)
  }, [remaining, onExpire])

  const m = Math.floor(remaining / 60)
  const s = remaining % 60
  return (
    <span className="font-bold text-lg" style={{ color, fontVariantNumeric: 'tabular-nums' }}>
      {m}:{s.toString().padStart(2, '0')}
    </span>
  )
}

/* ── Progress dots ── */

function ProgressDots({ total, answers, flagged, current, onJump, accent }: {
  total: number; answers: Record<number, string>; flagged: Record<number, boolean>
  current: number; onJump: (i: number) => void; accent: string
}) {
  return (
    <div className="flex flex-wrap gap-1 py-2">
      {Array.from({ length: total }, (_, i) => {
        const isFlagged = flagged[i]
        const isAnswered = answers[i] != null
        let bg = 'var(--color-border)'
        if (isAnswered) bg = '#F5F5F5'
        if (isFlagged) bg = '#F59E0B'
        return (
          <button
            key={i}
            onClick={() => onJump(i)}
            className="rounded-full shrink-0"
            style={{
              width: 14, height: 14, backgroundColor: bg, padding: 0,
              border: i === current ? `2px solid ${accent}` : '1px solid var(--color-border)',
            }}
          />
        )
      })}
    </div>
  )
}

/* ── Exam Selection Page ── */

function ExamSelectionView({ app, certLevel, accent }: { app: AppKey; certLevel: string; accent: string }) {
  const navigate = useNavigate()
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const config = EXAM_CONFIG[certLevel]
  const [attempts, setAttempts] = useState<any[]>([])
  const [bestScore, setBestScore] = useState<number | null>(null)

  useEffect(() => {
    if (!appAuth.user) return
    ;(client as any)
      .schema('splicepal')
      .from('training_exam_attempts')
      .select('id, attempt_number, score_percent, passed, completed_at')
      .eq('user_id', appAuth.user.id)
      .eq('cert_level', certLevel)
      .order('completed_at', { ascending: false })
      .limit(10)
      .then(({ data }: any) => {
        if (data) {
          setAttempts(data)
          const best = data.reduce((max: number, a: any) => Math.max(max, Number(a.score_percent)), 0)
          if (data.length > 0) setBestScore(best)
        }
      })
  }, [appAuth.user])

  function start(mode: string) {
    navigate(`/${app}/training/${certLevel}/exam/run?mode=${mode}`)
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <button className="text-sm mb-4 block" style={{ color: accent }} onClick={() => navigate(`/${app}/training/${certLevel}`)}>
        &larr; Back to {config?.name}
      </button>
      <h1 className="text-2xl font-extrabold mb-6">Exams & Practice</h1>

      <div className="flex flex-col gap-4">
        <p className="text-xs font-semibold uppercase tracking-wider" style={{ color: 'var(--color-muted)' }}>Full Exam Practice</p>

        <Card accent={accent} title="Timed Exam" subtitle={`Simulates real ${config?.name} exam conditions`}
          stats={[`${config?.questions} questions`, `${config?.minutes} min`, bestScore != null ? `Best: ${bestScore}%` : 'No attempts']}
          buttonLabel="Start Timed Exam" onClick={() => start('timed')} filled />

        <Card accent={accent} title="Untimed Exam" subtitle="Full exam without time pressure"
          stats={[`${config?.questions} questions`, 'No time limit']}
          buttonLabel="Start Untimed Exam" onClick={() => start('untimed')} />

        <p className="text-xs font-semibold uppercase tracking-wider mt-2" style={{ color: 'var(--color-muted)' }}>Focused Practice</p>

        <Card accent={accent} title="Practice Mode" subtitle="Answer questions with immediate feedback"
          buttonLabel="Start Practice" onClick={() => start('practice')} />

        <Card accent={accent} title="Study Mode" subtitle="View questions and explanations — no scoring"
          buttonLabel="Start Studying" onClick={() => start('study')} />

        <p className="text-xs font-semibold uppercase tracking-wider mt-2" style={{ color: 'var(--color-muted)' }}>Daily Review</p>

        <Card accent={accent} title="Spaced Repetition" subtitle="Review cards based on your memory strength"
          buttonLabel="Start Review" onClick={() => navigate(`/${app}/training/sr`)} />

        {attempts.length > 0 && (
          <>
            <p className="text-xs font-semibold uppercase tracking-wider mt-2" style={{ color: 'var(--color-muted)' }}>Exam History</p>
            <div className="rounded-xl border p-4" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              {attempts.map((a, i) => (
                <div key={a.id} className="flex justify-between items-center py-2" style={{ borderBottom: i < attempts.length - 1 ? '1px solid var(--color-border)' : 'none' }}>
                  <div>
                    <span className="text-sm">Attempt {a.attempt_number || i + 1}</span>
                    <span className="text-xs ml-2" style={{ color: 'var(--color-muted)' }}>{new Date(a.completed_at).toLocaleDateString()}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="text-sm font-bold" style={{ color: a.passed ? accent : '#F59E0B' }}>{Math.round(Number(a.score_percent))}%</span>
                    <span className="px-2 py-0.5 rounded text-xs font-bold" style={{
                      backgroundColor: a.passed ? `${accent}22` : 'rgba(239,68,68,0.15)',
                      color: a.passed ? accent : '#EF4444',
                    }}>{a.passed ? 'PASS' : 'FAIL'}</span>
                  </div>
                </div>
              ))}
            </div>
          </>
        )}
      </div>
    </div>
  )
}

function Card({ accent, title, subtitle, stats, buttonLabel, onClick, filled }: {
  accent: string; title: string; subtitle?: string; stats?: string[]
  buttonLabel: string; onClick: () => void; filled?: boolean
}) {
  return (
    <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
      <h3 className="font-bold mb-1">{title}</h3>
      {subtitle && <p className="text-sm mb-2" style={{ color: 'var(--color-muted-fg)' }}>{subtitle}</p>}
      {stats && (
        <div className="flex flex-wrap gap-3 mb-3 text-xs" style={{ color: 'var(--color-muted)' }}>
          {stats.map((s, i) => <span key={i}>{s}</span>)}
        </div>
      )}
      <button
        className="w-full h-11 rounded-lg font-semibold"
        style={filled
          ? { backgroundColor: accent, color: 'white' }
          : { border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }
        }
        onClick={onClick}
      >
        {buttonLabel}
      </button>
    </div>
  )
}

/* ── Exam Engine ── */

function ExamEngineView({ app, certLevel, accent }: { app: AppKey; certLevel: string; accent: string }) {
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const mode = searchParams.get('mode') || 'practice'
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const config = EXAM_CONFIG[certLevel]

  const [questions, setQuestions] = useState<Question[]>([])
  const [current, setCurrent] = useState(0)
  const [answers, setAnswers] = useState<Record<number, string>>({})
  const [flagged, setFlagged] = useState<Record<number, boolean>>({})
  const [revealed, setRevealed] = useState<Record<number, boolean>>({})
  const [loading, setLoading] = useState(true)
  const [showReview, setShowReview] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)
  const [finished, setFinished] = useState(false)
  const [scoreData, setScoreData] = useState<any>(null)
  const [startTime] = useState(Date.now())
  const [showMissed, setShowMissed] = useState(false)

  const isExamMode = mode === 'timed' || mode === 'untimed'
  const isPractice = mode === 'practice'
  const isStudy = mode === 'study'
  const isTimed = mode === 'timed'

  // Load questions from Supabase
  useEffect(() => {
    if (!appAuth.user) return
    ;(async () => {
      const { data, error } = await (client as any)
        .schema('splicepal')
        .from('training_questions')
        .select('id, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference, difficulty')
        .eq('cert_level', certLevel)
        .eq('flagged_quality', false)

      if (error || !data) { setLoading(false); return }

      // Shuffle and limit to exam question count
      const shuffled = [...data].sort(() => Math.random() - 0.5)
      const limit = isExamMode ? (config?.questions || data.length) : Math.min(20, data.length)
      setQuestions(shuffled.slice(0, limit))
      setLoading(false)
    })()
  }, [appAuth.user])

  const handleExpire = useCallback(() => {
    submitExam()
  }, [answers, questions])

  function selectAnswer(idx: number, choice: string) {
    if (isExamMode) {
      setAnswers((prev) => ({ ...prev, [idx]: choice }))
      return
    }
    if (revealed[idx]) return
    setAnswers((prev) => ({ ...prev, [idx]: choice }))
    if (isPractice) {
      setRevealed((prev) => ({ ...prev, [idx]: true }))
    }
  }

  async function submitExam() {
    if (!appAuth.user) return
    const correctCount = questions.reduce((n, q, i) => n + (answers[i] === q.correct_answer ? 1 : 0), 0)
    const percent = Math.round((correctCount / questions.length) * 100)
    const elapsed = Math.round((Date.now() - startTime) / 1000)
    const passed = percent >= (config?.pass || 70)

    // Build domain scores
    const domainMap: Record<string, { correct: number; total: number }> = {}
    questions.forEach((q, i) => {
      if (!domainMap[q.topic]) domainMap[q.topic] = { correct: 0, total: 0 }
      domainMap[q.topic].total++
      if (answers[i] === q.correct_answer) domainMap[q.topic].correct++
    })

    const domainScores = Object.entries(domainMap).map(([topic, v]) => ({
      topic, correct: v.correct, total: v.total, percent: Math.round((v.correct / v.total) * 100),
    }))

    setScoreData({ correct: correctCount, total: questions.length, percent, passed, elapsed, domainScores })
    setFinished(true)

    // Get attempt number
    const { count } = await (client as any)
      .schema('splicepal')
      .from('training_exam_attempts')
      .select('*', { count: 'exact', head: true })
      .eq('user_id', appAuth.user.id)
      .eq('cert_level', certLevel)

    // Save attempt
    try {
      await (client as any)
        .schema('splicepal')
        .from('training_exam_attempts')
        .insert({
          user_id: appAuth.user.id,
          cert_level: certLevel,
          exam_mode: mode,
          attempt_number: (count || 0) + 1,
          total_questions: questions.length,
          correct_count: correctCount,
          score_percent: percent,
          passed,
          pass_threshold: config?.pass || 70,
          domain_scores: domainScores,
          time_taken_seconds: elapsed,
          avg_seconds_per_question: Math.round(elapsed / questions.length),
          questions_detail: questions.map((q, i) => ({ question_id: q.id, selected: answers[i] || null, correct: answers[i] === q.correct_answer })),
          started_at: new Date(startTime).toISOString(),
          completed_at: new Date().toISOString(),
        })

      // Update readiness
      await (client as any)
        .schema('splicepal')
        .from('training_readiness')
        .upsert({
          user_id: appAuth.user.id,
          cert_level: certLevel,
          overall_readiness_percent: percent,
          questions_attempted: questions.length,
          sessions_count: (count || 0) + 1,
          estimated_pass: passed,
          last_updated_at: new Date().toISOString(),
        }, { onConflict: 'user_id,cert_level' })
    } catch (err) {
      console.error('Failed to save exam attempt:', err)
    }
  }

  if (loading) return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Preparing questions&hellip;</p>
  if (questions.length === 0) return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>No questions available.</p>

  // Score screen
  if (finished && scoreData) {
    const missedIndices = questions.map((_, i) => i).filter((i) => answers[i] !== questions[i].correct_answer)
    const m = Math.floor(scoreData.elapsed / 60)
    const s = scoreData.elapsed % 60

    return (
      <div className="mx-auto max-w-2xl px-4 py-12">
        <div className="flex flex-col gap-4">
          <div className="rounded-xl border p-6 text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
            <p className="text-4xl font-bold" style={{ color: scoreData.passed ? accent : '#F59E0B' }}>
              {scoreData.correct} / {scoreData.total} &mdash; {scoreData.percent}%
            </p>
            <span className="inline-block mt-2 px-3 py-1 rounded text-sm font-bold" style={{
              backgroundColor: scoreData.passed ? `${accent}22` : 'rgba(245,158,11,0.15)',
              color: scoreData.passed ? accent : '#F59E0B',
            }}>
              {scoreData.passed ? 'PASSED' : 'NEEDS REVIEW'}
            </span>
            <p className="text-sm mt-2" style={{ color: 'var(--color-muted)' }}>Time: {m}:{s.toString().padStart(2, '0')}</p>
          </div>

          {scoreData.domainScores.length > 0 && (
            <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <h3 className="font-bold mb-3">Topic Breakdown</h3>
              {scoreData.domainScores.map((d: any) => (
                <div key={d.topic} className="flex justify-between py-1.5 text-sm" style={{ borderBottom: '1px solid var(--color-border)' }}>
                  <span>{d.topic}</span>
                  <span style={{ color: d.percent >= 70 ? accent : '#F59E0B' }}>{d.correct}/{d.total} ({d.percent}%)</span>
                </div>
              ))}
            </div>
          )}

          <div className="flex flex-col gap-2">
            {missedIndices.length > 0 && (
              <button className="w-full h-11 rounded-lg font-semibold border" style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }}
                onClick={() => setShowMissed(!showMissed)}>
                {showMissed ? 'Hide' : 'Review'} missed questions ({missedIndices.length})
              </button>
            )}
            <button className="w-full h-11 rounded-lg font-semibold" style={{ backgroundColor: accent, color: 'white' }}
              onClick={() => navigate(`/${app}/training/${certLevel}/exam`)}>
              Back to Exams
            </button>
          </div>

          {showMissed && (
            <div className="flex flex-col gap-4">
              {missedIndices.map((i) => {
                const q = questions[i]
                const opts = [
                  { key: 'A', text: q.option_a }, { key: 'B', text: q.option_b },
                  { key: 'C', text: q.option_c }, { key: 'D', text: q.option_d },
                ]
                return (
                  <div key={i} className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
                    <p className="text-xs mb-1" style={{ color: 'var(--color-muted)' }}>Q{i + 1} &middot; {q.topic}</p>
                    <p className="mb-3">{q.question_text}</p>
                    {opts.map((opt) => (
                      <div key={opt.key} className="rounded-lg border px-3 py-2 mb-1 text-sm" style={{
                        borderColor: opt.key === q.correct_answer ? accent : opt.key === answers[i] ? '#EF4444' : 'var(--color-border)',
                        backgroundColor: opt.key === q.correct_answer ? `${accent}11` : opt.key === answers[i] ? 'rgba(239,68,68,0.1)' : 'transparent',
                      }}>
                        <strong>{opt.key}.</strong> {opt.text}
                      </div>
                    ))}
                    {q.explanation && <p className="text-sm mt-2" style={{ color: 'var(--color-muted-fg)' }}>{q.explanation}</p>}
                  </div>
                )
              })}
            </div>
          )}
        </div>
      </div>
    )
  }

  // Review grid (exam modes)
  if (showReview && isExamMode) {
    const unanswered = questions.filter((_, i) => answers[i] == null).length
    return (
      <div className="mx-auto max-w-2xl px-4 py-12">
        <h2 className="text-xl font-bold mb-4">Review Answers</h2>
        <div className="grid gap-1.5 mb-6" style={{ gridTemplateColumns: 'repeat(auto-fill, minmax(44px, 1fr))' }}>
          {questions.map((_, i) => {
            const isAnswered = answers[i] != null
            const isFl = flagged[i]
            let bg = '#EF4444'
            if (isAnswered && !isFl) bg = '#F5F5F5'
            if (isFl) bg = '#F59E0B'
            return (
              <button key={i} onClick={() => { setCurrent(i); setShowReview(false) }}
                className="rounded-md flex items-center justify-center text-xs font-bold"
                style={{ aspectRatio: '1', backgroundColor: bg, color: bg === '#F5F5F5' ? '#0D0D0F' : '#fff' }}>
                {i + 1}
              </button>
            )
          })}
        </div>
        <div className="flex gap-3 text-xs mb-5">
          <span className="flex items-center gap-1"><span className="inline-block w-3 h-3 rounded-sm" style={{ backgroundColor: '#F5F5F5' }} /> Answered</span>
          <span className="flex items-center gap-1"><span className="inline-block w-3 h-3 rounded-sm" style={{ backgroundColor: '#F59E0B' }} /> Flagged</span>
          <span className="flex items-center gap-1"><span className="inline-block w-3 h-3 rounded-sm" style={{ backgroundColor: '#EF4444' }} /> Skipped</span>
        </div>
        {unanswered > 0 && <p className="text-sm mb-3 text-amber-400">{unanswered} unanswered question{unanswered !== 1 ? 's' : ''}</p>}
        <button className="w-full h-11 rounded-lg font-semibold text-white" style={{ backgroundColor: accent }} onClick={() => setShowConfirm(true)}>
          Submit Exam
        </button>
      </div>
    )
  }

  // Confirm dialog
  if (showConfirm) {
    return (
      <div className="mx-auto max-w-md px-4 py-24 text-center">
        <div className="rounded-xl border p-6" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h2 className="text-xl font-bold mb-2">Submit Exam?</h2>
          <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>This cannot be undone.</p>
          <div className="flex flex-col gap-2">
            <button className="w-full h-11 rounded-lg font-semibold text-white" style={{ backgroundColor: accent }} onClick={submitExam}>
              Yes, Submit
            </button>
            <button className="w-full h-11 rounded-lg font-semibold border" style={{ borderColor: 'var(--color-border)', color: 'var(--color-muted-fg)' }}
              onClick={() => setShowConfirm(false)}>
              Go Back
            </button>
          </div>
        </div>
      </div>
    )
  }

  // Question view
  const q = questions[current]
  const isRevealed = revealed[current]
  const selected = answers[current]
  const opts = [
    { key: 'A', text: q.option_a }, { key: 'B', text: q.option_b },
    { key: 'C', text: q.option_c }, { key: 'D', text: q.option_d },
  ]

  return (
    <div className="mx-auto max-w-2xl px-4 py-8">
      {/* Top bar */}
      <div className="flex justify-between items-center mb-3">
        <button className="text-sm" style={{ color: 'var(--color-muted-fg)' }} onClick={() => {
          if (isExamMode) setShowReview(true)
          else navigate(`/${app}/training/${certLevel}/exam`)
        }}>
          {isExamMode ? 'Review' : '\u2190 Back'}
        </button>
        <div className="flex items-center gap-3">
          {isPractice && (
            <span className="text-sm" style={{ color: 'var(--color-muted)' }}>
              {Object.values(answers).filter((a, i) => a === questions[i]?.correct_answer).length}/{Object.keys(revealed).length}
            </span>
          )}
          {isTimed && <Timer totalSeconds={(config?.minutes || 90) * 60} onExpire={handleExpire} accent={accent} />}
        </div>
      </div>

      {isExamMode && (
        <ProgressDots total={questions.length} answers={answers} flagged={flagged} current={current} onJump={setCurrent} accent={accent} />
      )}

      <div className="rounded-xl border p-5 mt-2" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <div className="flex justify-between items-center mb-2">
          <span className="text-xs" style={{ color: 'var(--color-muted)' }}>
            {isExamMode ? `Q${current + 1} of ${questions.length}` : `Question ${current + 1}`}
            {q.topic && ` \u00B7 ${q.topic}`}
          </span>
          {isExamMode && (
            <button className="text-xs" style={{ color: flagged[current] ? '#F59E0B' : 'var(--color-muted)' }}
              onClick={() => setFlagged((prev) => ({ ...prev, [current]: !prev[current] }))}>
              {flagged[current] ? '\u2691 Flagged' : '\u2690 Flag'}
            </button>
          )}
        </div>

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
              <button key={opt.key}
                className="w-full text-left rounded-lg border px-4 py-3 text-sm transition-colors"
                style={{ borderColor: border, backgroundColor: bg, cursor: isRevealed ? 'default' : 'pointer' }}
                onClick={() => selectAnswer(current, opt.key)}
                disabled={isRevealed || isStudy}>
                <strong>{opt.key}.</strong> {opt.text}
              </button>
            )
          })}
        </div>

        {/* Study mode: show explanation immediately */}
        {isStudy && q.explanation && (
          <div className="mt-4 rounded-lg p-4 text-sm leading-relaxed" style={{ backgroundColor: `${accent}08`, borderLeft: `3px solid ${accent}`, color: '#D4D4D8' }}>
            <p className="text-xs font-semibold mb-1" style={{ color: 'var(--color-muted)' }}>Explanation</p>
            {q.explanation}
          </div>
        )}

        {/* Practice feedback */}
        {isPractice && isRevealed && q.explanation && (
          <div className="mt-4 rounded-lg p-4 text-sm leading-relaxed" style={{ backgroundColor: `${accent}08`, borderLeft: `3px solid ${accent}`, color: '#D4D4D8' }}>
            <p className="text-xs font-semibold mb-1" style={{ color: 'var(--color-muted)' }}>Explanation</p>
            {q.explanation}
            {q.standard_reference && <p className="text-xs mt-2" style={{ color: 'var(--color-muted)' }}>Ref: {q.standard_reference}</p>}
          </div>
        )}
      </div>

      {/* Navigation */}
      <div className="flex justify-between mt-4">
        <button className="text-sm" style={{ color: current === 0 ? 'var(--color-muted)' : 'var(--color-muted-fg)' }}
          onClick={() => setCurrent((c) => Math.max(0, c - 1))} disabled={current === 0}>
          &larr; Previous
        </button>
        {current < questions.length - 1 ? (
          <button className="text-sm" style={{ color: 'var(--color-muted-fg)' }} onClick={() => setCurrent((c) => c + 1)}>
            Next &rarr;
          </button>
        ) : isExamMode ? (
          <button className="text-sm font-semibold" style={{ color: accent }} onClick={() => setShowReview(true)}>
            Review & Submit
          </button>
        ) : (
          <button className="text-sm" style={{ color: 'var(--color-muted-fg)' }}
            onClick={() => navigate(`/${app}/training/${certLevel}/exam`)}>
            End Session
          </button>
        )}
      </div>
    </div>
  )
}

/* ── Exported components ── */

export function TrainingExamSelection({ app }: { app: AppKey }) {
  const { certLevel } = useParams<{ certLevel: string }>()
  const cfg = APPS[app]
  return (
    <TrainingGate app={app}>
      <ExamSelectionView app={app} certLevel={certLevel!} accent={cfg.primary} />
    </TrainingGate>
  )
}

export function TrainingExamEngine({ app }: { app: AppKey }) {
  const { certLevel } = useParams<{ certLevel: string }>()
  const cfg = APPS[app]
  return (
    <TrainingGate app={app}>
      <ExamEngineView app={app} certLevel={certLevel!} accent={cfg.primary} />
    </TrainingGate>
  )
}
