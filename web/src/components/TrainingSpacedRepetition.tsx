import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

type SRQuestion = {
  sr_id: string
  question_id: string
  topic: string
  question_text: string
  option_a: string
  option_b: string
  option_c: string
  option_d: string
  correct_answer: string
  explanation: string
  standard_reference: string | null
  ease_factor: number
  interval_days: number
  repetitions: number
}

/* ── SM-2 Algorithm ── */

function sm2(quality: number, easeFactor: number, interval: number, repetitions: number) {
  // quality: 1=Again, 2=Hard, 3=Okay, 4=Good, 5=Easy
  let newEF = easeFactor
  let newInterval: number
  let newReps: number

  if (quality < 3) {
    // Failed — reset
    newInterval = 1
    newReps = 0
  } else {
    if (repetitions === 0) newInterval = 1
    else if (repetitions === 1) newInterval = 6
    else newInterval = Math.round(interval * easeFactor)
    newReps = repetitions + 1
  }

  // Update ease factor (minimum 1.3)
  newEF = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
  if (newEF < 1.3) newEF = 1.3

  const nextReviewAt = new Date()
  nextReviewAt.setDate(nextReviewAt.getDate() + newInterval)

  return {
    ease_factor: Math.round(newEF * 100) / 100,
    interval_days: newInterval,
    repetitions: newReps,
    next_review_at: nextReviewAt.toISOString(),
    last_quality_rating: quality,
  }
}

/* ── Confidence buttons ── */

function ConfidenceButtons({ onRate, accent }: { onRate: (q: number) => void; accent: string }) {
  const labels = ['Again', 'Hard', 'Okay', 'Good', 'Easy']
  return (
    <div className="flex gap-1.5 mt-3">
      {labels.map((label, i) => (
        <button
          key={i}
          className="flex-1 h-11 rounded-lg text-xs font-semibold border transition-colors"
          style={{
            borderColor: i >= 3 ? accent : 'var(--color-border)',
            color: i >= 3 ? accent : 'var(--color-muted-fg)',
            backgroundColor: i === 4 ? `${accent}11` : 'transparent',
          }}
          onClick={() => onRate(i + 1)}
        >
          {label}
        </button>
      ))}
    </div>
  )
}

/* ── Main component ── */

export default function TrainingSpacedRepetition({ app }: { app: AppKey }) {
  const navigate = useNavigate()
  const cfg = APPS[app]
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)

  const [questions, setQuestions] = useState<SRQuestion[]>([])
  const [current, setCurrent] = useState(0)
  const [selected, setSelected] = useState<string | null>(null)
  const [revealed, setRevealed] = useState(false)
  const [reviewedCount, setReviewedCount] = useState(0)
  const [loading, setLoading] = useState(true)
  const [done, setDone] = useState(false)

  useEffect(() => {
    if (appAuth.loading || !appAuth.user) return

    async function loadQueue() {
      try {
        // Get SR cards due for review (next_review_at <= now)
        const { data: srCards } = await (client as any)
          .schema('splicepal')
          .from('training_spaced_repetition')
          .select('id, question_id, ease_factor, interval_days, repetitions')
          .eq('user_id', appAuth.user!.id)
          .lte('next_review_at', new Date().toISOString())
          .order('next_review_at')
          .limit(20)

        if (!srCards || srCards.length === 0) {
          // No SR cards yet — seed from recently answered questions
          // Find questions from practice tests the user has taken
          const { data: sessions } = await (client as any)
            .schema('splicepal')
            .from('training_test_sessions')
            .select('module_id')
            .eq('user_id', appAuth.user!.id)
            .order('completed_at', { ascending: false })
            .limit(10)

          if (sessions && sessions.length > 0) {
            const moduleIds = [...new Set(sessions.map((s: any) => s.module_id))]
            const { data: qs } = await (client as any)
              .schema('splicepal')
              .from('training_questions')
              .select('id, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference')
              .in('module_id', moduleIds)
              .eq('flagged_quality', false)
              .limit(40)

            if (qs && qs.length > 0) {
              // Create SR entries for these questions
              const now = new Date().toISOString()
              const srRows = qs.map((q: any) => ({
                user_id: appAuth.user!.id,
                question_id: q.id,
                next_review_at: now,
                interval_days: 1,
                ease_factor: 2.5,
                repetitions: 0,
              }))

              // Upsert to avoid duplicates
              await (client as any)
                .schema('splicepal')
                .from('training_spaced_repetition')
                .upsert(srRows, { onConflict: 'user_id,question_id', ignoreDuplicates: true })

              // Now fetch the queue
              const { data: newCards } = await (client as any)
                .schema('splicepal')
                .from('training_spaced_repetition')
                .select('id, question_id, ease_factor, interval_days, repetitions')
                .eq('user_id', appAuth.user!.id)
                .lte('next_review_at', new Date().toISOString())
                .order('next_review_at')
                .limit(20)

              if (newCards && newCards.length > 0) {
                await loadQuestionDetails(newCards)
                return
              }
            }
          }

          setDone(true)
          setLoading(false)
          return
        }

        await loadQuestionDetails(srCards)
      } catch (err) {
        console.error('SR load error:', err)
        setDone(true)
        setLoading(false)
      }
    }

    async function loadQuestionDetails(srCards: any[]) {
      const qIds = srCards.map((c: any) => c.question_id)
      const { data: qs } = await (client as any)
        .schema('splicepal')
        .from('training_questions')
        .select('id, topic, question_text, option_a, option_b, option_c, option_d, correct_answer, explanation, standard_reference')
        .in('id', qIds)

      const qMap: Record<string, any> = {}
      for (const q of qs || []) qMap[q.id] = q

      const merged: SRQuestion[] = srCards
        .filter((c: any) => qMap[c.question_id])
        .map((c: any) => ({
          sr_id: c.id,
          question_id: c.question_id,
          ease_factor: Number(c.ease_factor) || 2.5,
          interval_days: c.interval_days || 1,
          repetitions: c.repetitions || 0,
          ...qMap[c.question_id],
        }))

      // Shuffle
      merged.sort(() => Math.random() - 0.5)
      setQuestions(merged)
      if (merged.length === 0) setDone(true)
      setLoading(false)
    }

    loadQueue()
  }, [appAuth.user, appAuth.loading])

  function selectAnswer(choice: string) {
    if (revealed) return
    setSelected(choice)
    setRevealed(true)
  }

  async function handleConfidence(rating: number) {
    const q = questions[current]

    // Compute SM-2 update
    const update = sm2(rating, q.ease_factor, q.interval_days, q.repetitions)

    // Save to Supabase
    try {
      await (client as any)
        .schema('splicepal')
        .from('training_spaced_repetition')
        .update(update)
        .eq('id', q.sr_id)
    } catch (err) {
      console.error('SR update error:', err)
    }

    setReviewedCount((c) => c + 1)

    if (current < questions.length - 1) {
      setCurrent((c) => c + 1)
      setSelected(null)
      setRevealed(false)
    } else {
      setDone(true)
    }
  }

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      <TrainingGate app={app}>
        {loading ? (
          <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Loading review queue&hellip;</p>
        ) : done ? (
          <div className="text-center py-16">
            <div className="rounded-xl border p-8" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <p className="text-5xl font-bold mb-2" style={{ color: cfg.primary }}>
                {reviewedCount > 0 ? reviewedCount : 0}
              </p>
              <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>
                {reviewedCount > 0 ? 'cards reviewed \u2014 nice work!' : 'No cards due for review right now.'}
              </p>
              {reviewedCount === 0 && (
                <p className="text-xs mb-4" style={{ color: 'var(--color-muted)' }}>
                  Complete some practice tests first to build your review queue.
                </p>
              )}
              <button className="w-full h-11 rounded-lg font-semibold text-white"
                style={{ backgroundColor: cfg.primary }}
                onClick={() => navigate(`/${app}/training`)}>
                Back to Training
              </button>
            </div>
          </div>
        ) : (
          <>
            {/* Header */}
            <div className="flex justify-between items-center mb-2">
              <button className="text-sm" style={{ color: cfg.primary }}
                onClick={() => navigate(`/${app}/training`)}>
                &larr; Back
              </button>
              <span className="text-sm" style={{ color: 'var(--color-muted)' }}>
                {reviewedCount} of {questions.length} reviewed
              </span>
            </div>
            <h1 className="text-xl font-extrabold mb-4">Spaced Repetition</h1>

            {/* Question card */}
            {(() => {
              const q = questions[current]
              const opts = [
                { key: 'A', text: q.option_a }, { key: 'B', text: q.option_b },
                { key: 'C', text: q.option_c }, { key: 'D', text: q.option_d },
              ]

              return (
                <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
                  <p className="text-xs mb-1" style={{ color: 'var(--color-muted)' }}>{q.topic}</p>
                  <p className="mb-4 leading-relaxed">{q.question_text}</p>

                  <div className="flex flex-col gap-2">
                    {opts.map((opt) => {
                      let bg = 'transparent'
                      let border = 'var(--color-border)'

                      if (revealed) {
                        if (opt.key === q.correct_answer) { bg = `${cfg.primary}11`; border = cfg.primary }
                        else if (opt.key === selected) { bg = 'rgba(239,68,68,0.1)'; border = '#EF4444' }
                      }

                      return (
                        <button key={opt.key}
                          className="w-full text-left rounded-lg border px-4 py-3 text-sm transition-colors"
                          style={{ borderColor: border, backgroundColor: bg, cursor: revealed ? 'default' : 'pointer' }}
                          onClick={() => selectAnswer(opt.key)}
                          disabled={revealed}>
                          <strong>{opt.key}.</strong> {opt.text}
                        </button>
                      )
                    })}
                  </div>

                  {revealed && q.explanation && (
                    <div className="mt-4 rounded-lg p-4 text-sm leading-relaxed" style={{
                      backgroundColor: `${cfg.primary}08`, borderLeft: `3px solid ${cfg.primary}`, color: '#D4D4D8',
                    }}>
                      {q.explanation}
                      {q.standard_reference && (
                        <p className="text-xs mt-2" style={{ color: 'var(--color-muted)' }}>Ref: {q.standard_reference}</p>
                      )}
                    </div>
                  )}

                  {revealed && <ConfidenceButtons onRate={handleConfidence} accent={cfg.primary} />}
                </div>
              )
            })()}
          </>
        )}
      </TrainingGate>
    </div>
  )
}
