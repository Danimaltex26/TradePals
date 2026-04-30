import { useState, useEffect } from 'react'
import { useAuth } from '../auth/AuthProvider'
import { getClient, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'
import TrainingGate from './TrainingGate'

type Team = {
  id: string
  team_name: string
  invite_code: string
  seats_purchased: number
  seats_used: number
  subscription_status: string
  manager_id: string
}

type Member = {
  user_id: string
  status: string
  joined_at: string
  profiles: { display_name: string | null; email: string } | null
}

/* ── Dashboard view ── */

function DashboardView({ app, accent }: { app: AppKey; accent: string }) {
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)

  const [team, setTeam] = useState<Team | null>(null)
  const [members, setMembers] = useState<Member[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  // Invite
  const [showInvite, setShowInvite] = useState(false)
  const [inviteEmail, setInviteEmail] = useState('')
  const [inviting, setInviting] = useState(false)
  const [inviteResult, setInviteResult] = useState<{ code: string; expires: string } | null>(null)
  const [copied, setCopied] = useState(false)

  useEffect(() => {
    if (!appAuth.user) return
    loadDashboard()
  }, [appAuth.user])

  async function loadDashboard() {
    const userId = appAuth.user!.id

    // Get team where user is manager
    const { data: teamData } = await client
      .from('teams')
      .select('*')
      .eq('manager_id', userId)
      .single()

    if (!teamData) {
      // Check if user is a member of a team
      const { data: membership } = await client
        .from('team_members')
        .select('team_id')
        .eq('user_id', userId)
        .eq('status', 'active')
        .single()

      if (membership) {
        const { data: memberTeam } = await client
          .from('teams')
          .select('*')
          .eq('id', membership.team_id)
          .single()
        if (memberTeam) {
          setTeam(memberTeam)
          await loadMembers(memberTeam.id)
        }
      } else {
        setError('No team found. Create a team in your app to manage crew here.')
      }
      setLoading(false)
      return
    }

    setTeam(teamData)
    await loadMembers(teamData.id)
    setLoading(false)
  }

  async function loadMembers(teamId: string) {
    const { data: memberData } = await client
      .from('team_members')
      .select('user_id, status, joined_at, profiles(display_name, email)')
      .eq('team_id', teamId)
      .eq('status', 'active')

    setMembers((memberData as any[]) || [])
  }

  async function handleInvite() {
    if (!team) return
    setInviting(true)

    const code = Math.random().toString(36).substring(2, 10)
    const expiresAt = new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString()

    const { error: insertErr } = await client
      .from('team_invites')
      .insert({
        team_id: team.id,
        invite_code: code,
        email: inviteEmail.trim() || null,
        status: 'pending',
        expires_at: expiresAt,
      })

    if (insertErr) {
      setError(insertErr.message)
    } else {
      setInviteResult({ code, expires: expiresAt })
      setInviteEmail('')
    }
    setInviting(false)
  }

  function copyText(text: string) {
    navigator.clipboard.writeText(text).then(() => {
      setCopied(true)
      setTimeout(() => setCopied(false), 2000)
    })
  }

  if (loading) return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Loading team dashboard&hellip;</p>

  if (!team) {
    return (
      <div className="mx-auto max-w-2xl px-4 py-12 text-center">
        <h1 className="text-2xl font-extrabold mb-2">Team Dashboard</h1>
        <p className="text-[var(--color-muted-fg)] mb-6">{error || 'No team found.'}</p>
      </div>
    )
  }

  const isManager = team.manager_id === appAuth.user?.id

  return (
    <div className="mx-auto max-w-2xl px-4 py-12">
      {/* Header */}
      <div className="flex justify-between items-center mb-6">
        <div>
          <h1 className="text-2xl font-extrabold">{team.team_name}</h1>
          <p className="text-sm" style={{ color: 'var(--color-muted)' }}>
            {members.length} member{members.length !== 1 ? 's' : ''} &middot; {team.seats_used} of {team.seats_purchased} seats
          </p>
        </div>
      </div>

      {error && (
        <div className="rounded-lg border px-4 py-3 text-sm mb-4" style={{ borderColor: '#EF4444', backgroundColor: 'rgba(239,68,68,0.1)', color: '#FCA5A5' }}>
          {error}
        </div>
      )}

      {/* Billing warnings */}
      {team.subscription_status === 'past_due' && (
        <div className="rounded-lg border px-4 py-3 text-sm mb-4" style={{ borderColor: '#F59E0B', backgroundColor: 'rgba(245,158,11,0.1)', color: '#FDE68A' }}>
          Payment failed — update your payment method to keep your team active.
        </div>
      )}
      {team.subscription_status === 'cancelled' && (
        <div className="rounded-lg border px-4 py-3 text-sm mb-4" style={{ borderColor: '#EF4444', backgroundColor: 'rgba(239,68,68,0.1)', color: '#FCA5A5' }}>
          Team subscription cancelled. Members no longer have Pro access.
        </div>
      )}

      {/* Stats */}
      <div className="grid grid-cols-2 gap-3 mb-6">
        <div className="rounded-xl border p-4 text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <p className="text-2xl font-bold">{members.length}</p>
          <p className="text-xs" style={{ color: 'var(--color-muted)' }}>Total Crew</p>
        </div>
        <div className="rounded-xl border p-4 text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <p className="text-2xl font-bold" style={{ color: accent }}>{team.seats_purchased - team.seats_used}</p>
          <p className="text-xs" style={{ color: 'var(--color-muted)' }}>Seats Available</p>
        </div>
      </div>

      {/* Invite (manager only) */}
      {isManager && (
        <>
          <button
            className="w-full h-11 rounded-lg font-semibold text-white mb-4"
            style={{ backgroundColor: accent }}
            onClick={() => setShowInvite(!showInvite)}
          >
            {showInvite ? 'Close' : 'Add Crew Member'}
          </button>

          {showInvite && (
            <div className="rounded-xl border p-5 mb-4" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
              <h3 className="font-bold mb-3">Invite a crew member</h3>
              {team.seats_used >= team.seats_purchased ? (
                <p className="text-sm" style={{ color: 'var(--color-muted)' }}>No seats available.</p>
              ) : (
                <>
                  <div className="flex gap-2 mb-3">
                    <input
                      type="email"
                      className="flex-1 h-10 px-3 rounded-md bg-[var(--color-card)] border border-[var(--color-border)] text-white text-sm"
                      placeholder="Email (optional)"
                      value={inviteEmail}
                      onChange={e => setInviteEmail(e.target.value)}
                      onKeyDown={e => e.key === 'Enter' && handleInvite()}
                    />
                    <button
                      className="h-10 px-4 rounded-md font-semibold text-sm shrink-0"
                      style={{ border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }}
                      onClick={handleInvite}
                      disabled={inviting}
                    >
                      {inviting ? 'Sending...' : 'Invite'}
                    </button>
                  </div>

                  {inviteResult && (
                    <div className="rounded-lg p-3 text-sm" style={{ backgroundColor: `${accent}08`, borderLeft: `3px solid ${accent}` }}>
                      <p className="mb-2"><strong>Invite code:</strong></p>
                      <div className="flex gap-2">
                        <input
                          className="flex-1 h-9 px-3 rounded-md bg-[var(--color-card)] border border-[var(--color-border)] text-white text-xs font-mono"
                          readOnly
                          value={inviteResult.code}
                        />
                        <button
                          className="h-9 px-3 rounded-md text-xs font-semibold shrink-0"
                          style={{ border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }}
                          onClick={() => copyText(inviteResult.code)}
                        >
                          {copied ? 'Copied' : 'Copy'}
                        </button>
                      </div>
                      <p className="text-xs mt-2" style={{ color: 'var(--color-muted)' }}>
                        Expires {new Date(inviteResult.expires).toLocaleDateString()}
                      </p>
                    </div>
                  )}
                </>
              )}
            </div>
          )}
        </>
      )}

      {/* Team invite code */}
      <div className="rounded-xl border p-5 mb-4" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <h3 className="font-bold mb-2">Team Invite Code</h3>
        <div className="flex gap-2">
          <input
            className="flex-1 h-9 px-3 rounded-md bg-[var(--color-card)] border border-[var(--color-border)] text-white text-sm font-mono tracking-wider"
            readOnly
            value={team.invite_code}
          />
          <button
            className="h-9 px-3 rounded-md text-xs font-semibold shrink-0"
            style={{ border: '1px solid var(--color-border)', color: 'var(--color-muted-fg)' }}
            onClick={() => copyText(team.invite_code)}
          >
            {copied ? 'Copied' : 'Copy'}
          </button>
        </div>
      </div>

      {/* Crew list */}
      <div className="rounded-xl border p-5" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <h3 className="font-bold mb-3">Crew</h3>
        <div className="flex flex-col gap-2">
          {members.length === 0 && (
            <p className="text-sm" style={{ color: 'var(--color-muted)' }}>No crew members yet. Send an invite to get started.</p>
          )}
          {members.map(m => {
            const name = m.profiles?.display_name || m.profiles?.email || 'Unknown'
            const email = m.profiles?.email || ''
            const isTeamManager = m.user_id === team.manager_id

            return (
              <div key={m.user_id} className="flex justify-between items-center py-2" style={{ borderBottom: '1px solid var(--color-border)' }}>
                <div className="flex items-center gap-3">
                  <div className="w-9 h-9 rounded-full flex items-center justify-center text-sm font-bold shrink-0"
                    style={{ backgroundColor: '#2A2A2E', color: '#A0A0A8' }}>
                    {name[0].toUpperCase()}
                  </div>
                  <div>
                    <p className="text-sm font-semibold">
                      {name}
                      {isTeamManager && (
                        <span className="ml-2 px-2 py-0.5 rounded text-[10px] font-bold" style={{ backgroundColor: `${accent}22`, color: accent }}>
                          Manager
                        </span>
                      )}
                    </p>
                    <p className="text-xs" style={{ color: 'var(--color-muted)' }}>
                      {email} &middot; Joined {new Date(m.joined_at).toLocaleDateString()}
                    </p>
                  </div>
                </div>
              </div>
            )
          })}
        </div>
      </div>
    </div>
  )
}

/* ── Exported component ── */

export default function TeamDashboard({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  return (
    <TrainingGate app={app}>
      <DashboardView app={app} accent={cfg.primary} />
    </TrainingGate>
  )
}
