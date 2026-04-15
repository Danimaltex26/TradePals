import { useState, useEffect } from 'react'
import { createClient } from '@supabase/supabase-js'
import {
  LineChart, Line, BarChart, Bar, PieChart, Pie, Cell,
  XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend
} from 'recharts'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || import.meta.env.VITE_SPLICEPAL_SUPABASE_URL || ''
const serviceRoleKey = import.meta.env.VITE_ADMIN_SERVICE_ROLE_KEY || ''

const supabase = serviceRoleKey
  ? createClient(supabaseUrl, serviceRoleKey)
  : null

const APP_COLORS: Record<string, string> = {
  splicepal: '#33cc33',
  weldpal: '#F97316',
  poolpal: '#14B8A6',
  voltpal: '#FACC15',
  pipepal: '#3B82F6',
  windpal: '#22D3EE',
  liftpal: '#A855F7',
}

const FEATURE_COLORS: Record<string, string> = {
  photo_diagnosis: '#EF4444',
  complex_troubleshoot: '#F97316',
  simple_troubleshoot: '#FACC15',
  code_citation: '#3B82F6',
  reference_lookup: '#14B8A6',
  question_generation: '#A855F7',
  cert_prep_delivery: '#22D3EE',
}

type Stats = {
  totalUsers: number
  signupsToday: number
  signupsWeek: number
  signupsMonth: number
  activeUsers7d: number
  usersByApp: { app: string; count: number }[]
  signupsByDay: { day: string; count: number }[]
  signupsByWeek: { week: string; count: number }[]
  recentUsers: { id: string; email: string; created_at: string; last_sign_in_at: string; display_name: string }[]
  aiCallsByDay: { day: string; count: number; cost: number }[]
  aiCallsByFeature: { feature: string; count: number; cost: number }[]
  aiCallsByModel: { model: string; count: number; cost: number }[]
  aiTotalCost: number
  aiTotalCalls: number
}

function fmtDate(d: string) {
  return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

function fmtDateTime(d: string) {
  return new Date(d).toLocaleDateString('en-US', { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })
}

export default function AdminDashboard() {
  const [stats, setStats] = useState<Stats | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [authed, setAuthed] = useState(false)
  const [password, setPassword] = useState('')

  function handleAuth(e: React.FormEvent) {
    e.preventDefault()
    if (password === 'tradepals2026') {
      setAuthed(true)
    } else {
      setError('Wrong password')
    }
  }

  useEffect(() => {
    if (!authed || !supabase) return
    fetchStats()
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [authed])

  async function fetchStats() {
    if (!supabase) return
    setLoading(true)
    setError('')
    try {
      const now = new Date()
      const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate()).toISOString()
      const startOfWeek = new Date(now.getTime() - 7 * 86400000).toISOString()
      const startOfMonth = new Date(now.getFullYear(), now.getMonth(), 1).toISOString()
      const thirtyDaysAgo = new Date(now.getTime() - 30 * 86400000).toISOString()
      const twelveWeeksAgo = new Date(now.getTime() - 84 * 86400000).toISOString()

      const { data: authUsers, error: authErr } = await supabase.auth.admin.listUsers({ perPage: 1000 })
      if (authErr) throw authErr

      const users = authUsers?.users || []
      const totalUsers = users.length
      const signupsToday = users.filter(u => u.created_at >= startOfDay).length
      const signupsWeek = users.filter(u => u.created_at >= startOfWeek).length
      const signupsMonth = users.filter(u => u.created_at >= startOfMonth).length
      const activeUsers7d = users.filter(u => u.last_sign_in_at && u.last_sign_in_at >= startOfWeek).length

      // Signups by day (last 30 days)
      const dayMap: Record<string, number> = {}
      for (let i = 29; i >= 0; i--) {
        const d = new Date(now.getTime() - i * 86400000)
        dayMap[d.toISOString().slice(0, 10)] = 0
      }
      users.forEach(u => {
        const day = u.created_at.slice(0, 10)
        if (dayMap[day] !== undefined) dayMap[day]++
      })
      const signupsByDay = Object.entries(dayMap).map(([day, count]) => ({ day, count }))

      // Signups by week (last 12 weeks)
      const weekMap: Record<string, number> = {}
      for (let i = 11; i >= 0; i--) {
        const d = new Date(now.getTime() - i * 7 * 86400000)
        weekMap[d.toISOString().slice(0, 10)] = 0
      }
      users.forEach(u => {
        if (u.created_at < twelveWeeksAgo) return
        const weekKeys = Object.keys(weekMap)
        for (let i = weekKeys.length - 1; i >= 0; i--) {
          if (u.created_at >= weekKeys[i]) { weekMap[weekKeys[i]]++; break }
        }
      })
      const signupsByWeek = Object.entries(weekMap).map(([week, count]) => ({ week, count }))

      // Users by app
      const { data: subs } = await supabase.from('subscriptions').select('app_key')
      const appCount: Record<string, number> = {}
      for (const s of (subs || []) as { app_key: string }[]) {
        appCount[s.app_key] = (appCount[s.app_key] || 0) + 1
      }
      const usersByApp = Object.entries(appCount).map(([app, count]) => ({ app, count }))

      // Recent users
      const recentUsers = users
        .sort((a, b) => new Date(b.created_at).getTime() - new Date(a.created_at).getTime())
        .slice(0, 20)
        .map(u => ({
          id: u.id,
          email: u.email || '',
          created_at: u.created_at,
          last_sign_in_at: u.last_sign_in_at || '',
          display_name: (u.user_metadata as Record<string, string>)?.display_name || '',
        }))

      // AI usage stats
      let aiCallsByDay: Stats['aiCallsByDay'] = []
      let aiCallsByFeature: Stats['aiCallsByFeature'] = []
      let aiCallsByModel: Stats['aiCallsByModel'] = []
      let aiTotalCost = 0
      let aiTotalCalls = 0

      const { data: aiLogs } = await supabase
        .from('ai_usage_log')
        .select('*')
        .gte('created_at', thirtyDaysAgo)
        .order('created_at', { ascending: true })

      if (aiLogs && aiLogs.length > 0) {
        aiTotalCalls = aiLogs.length
        aiTotalCost = aiLogs.reduce((sum, l) => sum + Number(l.estimated_cost_usd), 0)

        const aiDayMap: Record<string, { count: number; cost: number }> = {}
        for (const l of aiLogs) {
          const day = (l.created_at as string).slice(0, 10)
          if (!aiDayMap[day]) aiDayMap[day] = { count: 0, cost: 0 }
          aiDayMap[day].count++
          aiDayMap[day].cost += Number(l.estimated_cost_usd)
        }
        aiCallsByDay = Object.entries(aiDayMap).map(([day, v]) => ({ day, ...v }))

        const featureMap: Record<string, { count: number; cost: number }> = {}
        for (const l of aiLogs) {
          const f = l.feature as string
          if (!featureMap[f]) featureMap[f] = { count: 0, cost: 0 }
          featureMap[f].count++
          featureMap[f].cost += Number(l.estimated_cost_usd)
        }
        aiCallsByFeature = Object.entries(featureMap)
          .map(([feature, v]) => ({ feature, ...v }))
          .sort((a, b) => b.cost - a.cost)

        const modelMap: Record<string, { count: number; cost: number }> = {}
        for (const l of aiLogs) {
          const label = l.is_sonnet ? 'Sonnet' : 'Haiku'
          if (!modelMap[label]) modelMap[label] = { count: 0, cost: 0 }
          modelMap[label].count++
          modelMap[label].cost += Number(l.estimated_cost_usd)
        }
        aiCallsByModel = Object.entries(modelMap).map(([model, v]) => ({ model, ...v }))
      }

      setStats({
        totalUsers, signupsToday, signupsWeek, signupsMonth, activeUsers7d,
        usersByApp, signupsByDay, signupsByWeek, recentUsers,
        aiCallsByDay, aiCallsByFeature, aiCallsByModel, aiTotalCost, aiTotalCalls,
      })
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load stats')
    } finally {
      setLoading(false)
    }
  }

  if (!serviceRoleKey) {
    return <div style={{ padding: 40, textAlign: 'center', color: '#EF4444' }}>VITE_ADMIN_SERVICE_ROLE_KEY not configured.</div>
  }

  if (!authed) {
    return (
      <div style={{ maxWidth: 360, margin: '120px auto', padding: '0 20px' }}>
        <h1 style={{ fontSize: 24, fontWeight: 700, marginBottom: 16, textAlign: 'center' }}>Admin Dashboard</h1>
        {error && <div style={{ color: '#EF4444', marginBottom: 12, textAlign: 'center', fontSize: 14 }}>{error}</div>}
        <form onSubmit={handleAuth}>
          <input type="password" placeholder="Admin password" value={password} onChange={e => setPassword(e.target.value)}
            style={{ width: '100%', height: 44, padding: '0 12px', background: '#1A1A1E', border: '1px solid #2A2A2E', borderRadius: 8, color: '#F5F5F5', fontSize: 16, marginBottom: 12 }} />
          <button type="submit" style={{ width: '100%', height: 44, background: '#4B9CD3', color: '#fff', fontWeight: 600, borderRadius: 8, border: 'none', cursor: 'pointer' }}>Enter</button>
        </form>
      </div>
    )
  }

  if (loading) return <div style={{ padding: 40, textAlign: 'center', color: '#A0A0A8' }}>Loading dashboard...</div>

  if (error) {
    return (
      <div style={{ padding: 40, textAlign: 'center', color: '#EF4444' }}>
        {error}<br />
        <button onClick={fetchStats} style={{ marginTop: 12, color: '#4B9CD3', background: 'none', border: 'none', cursor: 'pointer' }}>Retry</button>
      </div>
    )
  }

  if (!stats) return null

  const tooltipStyle = { background: '#1A1A1E', border: '1px solid #2A2A2E', borderRadius: 8 }

  return (
    <div style={{ maxWidth: 1200, margin: '0 auto', padding: '24px 16px' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 24 }}>
        <h1 style={{ fontSize: 28, fontWeight: 700 }}>TradePals Admin</h1>
        <button onClick={fetchStats} style={{ padding: '8px 16px', background: '#1A1A1E', border: '1px solid #2A2A2E', borderRadius: 8, color: '#A0A0A8', cursor: 'pointer', fontSize: 13 }}>Refresh</button>
      </div>

      {/* Overview Cards */}
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(180px, 1fr))', gap: 12, marginBottom: 32 }}>
        <StatCard label="Total Users" value={stats.totalUsers} />
        <StatCard label="Signups Today" value={stats.signupsToday} />
        <StatCard label="Signups This Week" value={stats.signupsWeek} />
        <StatCard label="Signups This Month" value={stats.signupsMonth} />
        <StatCard label="Active (7d)" value={stats.activeUsers7d} />
        <StatCard label="AI Calls (30d)" value={stats.aiTotalCalls} />
        <StatCard label="AI Cost (30d)" value={'$' + stats.aiTotalCost.toFixed(2)} />
      </div>

      {/* Signups Over Time */}
      <ChartCard title="Signups — Last 30 Days">
        <ResponsiveContainer width="100%" height={250}>
          <BarChart data={stats.signupsByDay}>
            <CartesianGrid strokeDasharray="3 3" stroke="#2A2A2E" />
            <XAxis dataKey="day" tick={{ fill: '#6B6B73', fontSize: 10 }} tickFormatter={(v: string) => fmtDate(v)} interval={4} />
            <YAxis tick={{ fill: '#6B6B73', fontSize: 11 }} allowDecimals={false} />
            <Tooltip contentStyle={tooltipStyle} labelFormatter={(v: string) => fmtDate(v)} />
            <Bar dataKey="count" fill="#4B9CD3" radius={[4, 4, 0, 0] as [number, number, number, number]} />
          </BarChart>
        </ResponsiveContainer>
      </ChartCard>

      {/* Signups by Week */}
      <ChartCard title="Signups — Last 12 Weeks">
        <ResponsiveContainer width="100%" height={250}>
          <BarChart data={stats.signupsByWeek}>
            <CartesianGrid strokeDasharray="3 3" stroke="#2A2A2E" />
            <XAxis dataKey="week" tick={{ fill: '#6B6B73', fontSize: 10 }} tickFormatter={(v: string) => fmtDate(v)} />
            <YAxis tick={{ fill: '#6B6B73', fontSize: 11 }} allowDecimals={false} />
            <Tooltip contentStyle={tooltipStyle} labelFormatter={(v: string) => fmtDate(v)} />
            <Bar dataKey="count" fill="#14B8A6" radius={[4, 4, 0, 0] as [number, number, number, number]} />
          </BarChart>
        </ResponsiveContainer>
      </ChartCard>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16, marginBottom: 16 }}>
        {/* Users by App */}
        <ChartCard title="Users by App">
          {stats.usersByApp.length > 0 ? (
            <ResponsiveContainer width="100%" height={250}>
              <PieChart>
                <Pie data={stats.usersByApp} dataKey="count" nameKey="app" cx="50%" cy="50%" outerRadius={90}
                  label={(props: { app?: string; count?: number; name?: string }) => `${props.app || props.name || ''} (${props.count || 0})`}>
                  {stats.usersByApp.map((entry) => (
                    <Cell key={entry.app} fill={APP_COLORS[entry.app] || '#6B6B73'} />
                  ))}
                </Pie>
                <Tooltip contentStyle={tooltipStyle} />
              </PieChart>
            </ResponsiveContainer>
          ) : (
            <div style={{ height: 250, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#6B6B73' }}>No subscription data yet</div>
          )}
        </ChartCard>

        {/* AI Calls by Feature */}
        <ChartCard title="AI Calls by Feature (30d)">
          {stats.aiCallsByFeature.length > 0 ? (
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={stats.aiCallsByFeature} layout="vertical">
                <CartesianGrid strokeDasharray="3 3" stroke="#2A2A2E" />
                <XAxis type="number" tick={{ fill: '#6B6B73', fontSize: 11 }} />
                <YAxis type="category" dataKey="feature" tick={{ fill: '#A0A0A8', fontSize: 10 }} width={130} />
                <Tooltip contentStyle={tooltipStyle} />
                <Bar dataKey="count" radius={[0, 4, 4, 0] as [number, number, number, number]}>
                  {stats.aiCallsByFeature.map((entry) => (
                    <Cell key={entry.feature} fill={FEATURE_COLORS[entry.feature] || '#6B6B73'} />
                  ))}
                </Bar>
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <div style={{ height: 250, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#6B6B73' }}>No AI usage data yet</div>
          )}
        </ChartCard>
      </div>

      {/* AI Cost Over Time */}
      <ChartCard title="AI Cost — Last 30 Days">
        {stats.aiCallsByDay.length > 0 ? (
          <ResponsiveContainer width="100%" height={250}>
            <LineChart data={stats.aiCallsByDay}>
              <CartesianGrid strokeDasharray="3 3" stroke="#2A2A2E" />
              <XAxis dataKey="day" tick={{ fill: '#6B6B73', fontSize: 10 }} tickFormatter={(v: string) => fmtDate(v)} />
              <YAxis yAxisId="cost" tick={{ fill: '#6B6B73', fontSize: 11 }} tickFormatter={(v: string | number) => '$' + Number(v).toFixed(2)} />
              <YAxis yAxisId="calls" orientation="right" tick={{ fill: '#6B6B73', fontSize: 11 }} />
              <Tooltip contentStyle={tooltipStyle} labelFormatter={(v: string) => fmtDate(v)} />
              <Line yAxisId="cost" type="monotone" dataKey="cost" stroke="#EF4444" strokeWidth={2} dot={false} name="Cost ($)" />
              <Line yAxisId="calls" type="monotone" dataKey="count" stroke="#4B9CD3" strokeWidth={2} dot={false} name="Calls" />
              <Legend />
            </LineChart>
          </ResponsiveContainer>
        ) : (
          <div style={{ height: 250, display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#6B6B73' }}>No AI usage data yet</div>
        )}
      </ChartCard>

      {/* AI Model Split */}
      {stats.aiCallsByModel.length > 0 && (
        <ChartCard title="Sonnet vs Haiku (30d)">
          <div style={{ display: 'flex', gap: 24, padding: '16px 0' }}>
            {stats.aiCallsByModel.map(m => (
              <div key={m.model} style={{ flex: 1, textAlign: 'center' }}>
                <div style={{ fontSize: 28, fontWeight: 700, color: m.model === 'Sonnet' ? '#F97316' : '#14B8A6' }}>{m.count}</div>
                <div style={{ fontSize: 13, color: '#A0A0A8' }}>{m.model} calls</div>
                <div style={{ fontSize: 13, color: '#6B6B73', marginTop: 4 }}>${m.cost.toFixed(4)}</div>
              </div>
            ))}
          </div>
        </ChartCard>
      )}

      {/* Recent Signups */}
      <ChartCard title="Recent Signups">
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', fontSize: 13, borderCollapse: 'collapse' }}>
            <thead>
              <tr style={{ borderBottom: '1px solid #2A2A2E' }}>
                <th style={{ padding: '8px 12px', textAlign: 'left', color: '#6B6B73', fontWeight: 500 }}>Email</th>
                <th style={{ padding: '8px 12px', textAlign: 'left', color: '#6B6B73', fontWeight: 500 }}>Name</th>
                <th style={{ padding: '8px 12px', textAlign: 'left', color: '#6B6B73', fontWeight: 500 }}>Signed Up</th>
                <th style={{ padding: '8px 12px', textAlign: 'left', color: '#6B6B73', fontWeight: 500 }}>Last Sign In</th>
              </tr>
            </thead>
            <tbody>
              {stats.recentUsers.map(u => (
                <tr key={u.id} style={{ borderBottom: '1px solid #1A1A1E' }}>
                  <td style={{ padding: '8px 12px', color: '#F5F5F5' }}>{u.email}</td>
                  <td style={{ padding: '8px 12px', color: '#A0A0A8' }}>{u.display_name || '—'}</td>
                  <td style={{ padding: '8px 12px', color: '#A0A0A8' }}>{fmtDateTime(u.created_at)}</td>
                  <td style={{ padding: '8px 12px', color: '#A0A0A8' }}>{u.last_sign_in_at ? fmtDateTime(u.last_sign_in_at) : '—'}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </ChartCard>
    </div>
  )
}

function StatCard({ label, value }: { label: string; value: number | string }) {
  return (
    <div style={{ background: '#1A1A1E', border: '1px solid #2A2A2E', borderRadius: 12, padding: '16px 20px' }}>
      <div style={{ fontSize: 11, color: '#6B6B73', marginBottom: 4, textTransform: 'uppercase', letterSpacing: '0.05em' }}>{label}</div>
      <div style={{ fontSize: 28, fontWeight: 700, color: '#F5F5F5' }}>{value}</div>
    </div>
  )
}

function ChartCard({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div style={{ background: '#1A1A1E', border: '1px solid #2A2A2E', borderRadius: 12, padding: 20, marginBottom: 16 }}>
      <h3 style={{ fontSize: 15, fontWeight: 600, color: '#F5F5F5', marginBottom: 16 }}>{title}</h3>
      {children}
    </div>
  )
}
