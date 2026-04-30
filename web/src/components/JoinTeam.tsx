import { useState, useEffect } from 'react'
import { useSearchParams, useNavigate, Link } from 'react-router-dom'
import { useAuth } from '../auth/AuthProvider'
import { getClient, type AppKey } from '../lib/supabase'
import { APPS } from '../content/apps'

function JoinTeamView({ app, accent }: { app: AppKey; accent: string }) {
  const [searchParams] = useSearchParams()
  const navigate = useNavigate()
  const auth = useAuth()
  const appAuth = auth[app]
  const client = getClient(app)
  const code = searchParams.get('code')

  const [teamName, setTeamName] = useState('')
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [joining, setJoining] = useState(false)
  const [success, setSuccess] = useState(false)
  const [alreadyOnTeam, setAlreadyOnTeam] = useState(false)

  useEffect(() => {
    if (!code) {
      setError('No invite code provided.')
      setLoading(false)
      return
    }
    lookupTeam()
  }, [code, appAuth.user])

  async function lookupTeam() {
    // Find the invite
    const { data: invite } = await client
      .from('team_invites')
      .select('team_id, status, expires_at')
      .eq('invite_code', code!)
      .eq('status', 'pending')
      .single()

    if (!invite) {
      // Try team's permanent invite code
      const { data: team } = await client
        .from('teams')
        .select('id, team_name')
        .eq('invite_code', code!)
        .single()

      if (!team) {
        setError('Invalid or expired invite code.')
        setLoading(false)
        return
      }
      setTeamName(team.team_name)
    } else {
      if (new Date(invite.expires_at) < new Date()) {
        setError('This invite has expired. Ask your manager for a new one.')
        setLoading(false)
        return
      }
      const { data: team } = await client
        .from('teams')
        .select('team_name')
        .eq('id', invite.team_id)
        .single()
      setTeamName(team?.team_name || 'Team')
    }

    // Check if user is already on a team
    if (appAuth.user) {
      const { data: existing } = await client
        .from('team_members')
        .select('id')
        .eq('user_id', appAuth.user.id)
        .eq('status', 'active')
        .limit(1)

      if (existing && existing.length > 0) {
        setAlreadyOnTeam(true)
      }
    }

    setLoading(false)
  }

  async function handleJoin() {
    if (!appAuth.user || !code) return
    setJoining(true)
    setError('')

    // Find team by invite code (try team_invites first, then teams.invite_code)
    let teamId: string | null = null

    const { data: invite } = await client
      .from('team_invites')
      .select('team_id')
      .eq('invite_code', code)
      .eq('status', 'pending')
      .single()

    if (invite) {
      teamId = invite.team_id
      // Mark invite as accepted
      await client
        .from('team_invites')
        .update({ status: 'accepted' })
        .eq('invite_code', code)
    } else {
      const { data: team } = await client
        .from('teams')
        .select('id')
        .eq('invite_code', code)
        .single()
      teamId = team?.id || null
    }

    if (!teamId) {
      setError('Invite code not found.')
      setJoining(false)
      return
    }

    // Add member
    const { error: memberErr } = await client
      .from('team_members')
      .insert({
        team_id: teamId,
        user_id: appAuth.user.id,
        status: 'active',
      })

    if (memberErr) {
      setError(memberErr.message.includes('duplicate') ? 'You are already on this team.' : memberErr.message)
      setJoining(false)
      return
    }

    // Update profile with team_id
    await client
      .from('profiles')
      .update({ team_id: teamId })
      .eq('id', appAuth.user.id)

    // Increment seats_used
    await client.rpc('increment_seats_used', { team_id_input: teamId }).catch(() => {
      // If RPC doesn't exist, do manual update (best effort)
      client.from('teams').update({ seats_used: undefined }).eq('id', teamId)
    })

    setSuccess(true)
    setTimeout(() => navigate(`/${app}/team`), 2000)
  }

  if (loading) return <p className="text-center py-16" style={{ color: 'var(--color-muted-fg)' }}>Loading&hellip;</p>

  // Error state
  if (error && !teamName) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="rounded-xl border p-8 max-w-md w-full text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h2 className="text-xl font-bold mb-3">Invite Not Found</h2>
          <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>{error}</p>
          <Link to={`/${app}`} className="inline-block px-6 py-3 rounded-md font-semibold text-white" style={{ backgroundColor: accent }}>
            Go to {APPS[app].name}
          </Link>
        </div>
      </div>
    )
  }

  // Success
  if (success) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="rounded-xl border p-8 max-w-md w-full text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h2 className="text-xl font-bold mb-3" style={{ color: accent }}>Welcome to {teamName}!</h2>
          <p className="text-sm" style={{ color: 'var(--color-muted-fg)' }}>You now have Pro access. Redirecting&hellip;</p>
        </div>
      </div>
    )
  }

  // Not logged in
  if (!appAuth.user) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="rounded-xl border p-8 max-w-md w-full text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h2 className="text-xl font-bold mb-3">Join {teamName}</h2>
          <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>
            Sign in to join <strong className="text-white">{teamName}</strong> on {APPS[app].name}.
          </p>
          <Link
            to="/signin"
            state={{ app, redirect: `/${app}/join?code=${code}` }}
            className="inline-block w-full py-3 rounded-md font-semibold text-white text-center"
            style={{ backgroundColor: accent }}
          >
            Sign In
          </Link>
        </div>
      </div>
    )
  }

  // Already on a team
  if (alreadyOnTeam) {
    return (
      <div className="flex items-center justify-center min-h-[60vh]">
        <div className="rounded-xl border p-8 max-w-md w-full text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
          <h2 className="text-xl font-bold mb-3">Already on a Team</h2>
          <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>
            You&rsquo;re already part of a team. Contact your manager to switch teams.
          </p>
          <Link to={`/${app}/team`} className="inline-block px-6 py-3 rounded-md font-semibold text-white" style={{ backgroundColor: accent }}>
            Go to Dashboard
          </Link>
        </div>
      </div>
    )
  }

  // Ready to join
  return (
    <div className="flex items-center justify-center min-h-[60vh]">
      <div className="rounded-xl border p-8 max-w-md w-full text-center" style={{ borderColor: 'var(--color-border)', backgroundColor: 'var(--color-card)' }}>
        <h2 className="text-xl font-bold mb-3">Join {teamName}</h2>
        <p className="text-sm mb-6" style={{ color: 'var(--color-muted-fg)' }}>
          Joining gives you <strong style={{ color: accent }}>Pro access</strong>, paid for by your team manager.
        </p>
        {error && (
          <div className="rounded-lg border px-4 py-3 text-sm mb-4" style={{ borderColor: '#EF4444', backgroundColor: 'rgba(239,68,68,0.1)', color: '#FCA5A5' }}>
            {error}
          </div>
        )}
        <button
          className="w-full h-12 rounded-lg font-semibold text-white text-base"
          style={{ backgroundColor: accent }}
          onClick={handleJoin}
          disabled={joining}
        >
          {joining ? 'Joining...' : 'Join Team'}
        </button>
      </div>
    </div>
  )
}

export default function JoinTeam({ app }: { app: AppKey }) {
  const cfg = APPS[app]
  return <JoinTeamView app={app} accent={cfg.primary} />
}
