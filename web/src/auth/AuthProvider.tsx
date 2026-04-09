import { createContext, useContext, useEffect, useState, type ReactNode } from 'react'
import type { Session, User } from '@supabase/supabase-js'
import { splicepalClient, weldpalClient, type AppKey } from '../lib/supabase'

type AppAuthState = {
  user: User | null
  session: Session | null
  loading: boolean
}

type AuthContextValue = {
  splicepal: AppAuthState
  weldpal: AppAuthState
  signIn: (app: AppKey, email: string, password: string) => Promise<void>
  signInWithMagicLink: (app: AppKey, email: string) => Promise<void>
  signOut: (app: AppKey) => Promise<void>
}

const AuthContext = createContext<AuthContextValue | null>(null)

function useAppAuth(client: typeof splicepalClient): AppAuthState {
  const [state, setState] = useState<AppAuthState>({
    user: null,
    session: null,
    loading: true,
  })

  useEffect(() => {
    let mounted = true
    client.auth.getSession().then(({ data: { session } }) => {
      if (!mounted) return
      setState({ user: session?.user ?? null, session, loading: false })
    })
    const { data: { subscription } } = client.auth.onAuthStateChange((_event, session) => {
      setState({ user: session?.user ?? null, session, loading: false })
    })
    return () => {
      mounted = false
      subscription.unsubscribe()
    }
  }, [client])

  return state
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const splicepal = useAppAuth(splicepalClient)
  const weldpal = useAppAuth(weldpalClient)

  async function signIn(app: AppKey, email: string, password: string) {
    const client = app === 'splicepal' ? splicepalClient : weldpalClient
    const { error } = await client.auth.signInWithPassword({ email, password })
    if (error) throw error
  }

  async function signInWithMagicLink(app: AppKey, email: string) {
    const client = app === 'splicepal' ? splicepalClient : weldpalClient
    const { error } = await client.auth.signInWithOtp({ email })
    if (error) throw error
  }

  async function signOut(app: AppKey) {
    const client = app === 'splicepal' ? splicepalClient : weldpalClient
    const { error } = await client.auth.signOut()
    if (error) throw error
  }

  return (
    <AuthContext.Provider value={{ splicepal, weldpal, signIn, signInWithMagicLink, signOut }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
