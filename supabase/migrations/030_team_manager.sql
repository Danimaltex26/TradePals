-- 030_team_manager.sql
-- Team management infrastructure for all Pal apps.
-- Tables are app-agnostic — no app-specific columns on teams or team_members.
-- App context is handled at the query layer, not the schema layer.

-- ── public.teams ──────────────────────────────────────────────────────────────

CREATE TABLE public.teams (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  manager_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  team_name text NOT NULL,
  invite_code text UNIQUE NOT NULL DEFAULT substring(gen_random_uuid()::text, 1, 8),
  app_context text[] NOT NULL DEFAULT '{splicepal}',
  seats_purchased integer NOT NULL DEFAULT 5,
  seats_used integer NOT NULL DEFAULT 0,
  subscription_status text NOT NULL DEFAULT 'active'
    CHECK (subscription_status IN ('active', 'past_due', 'cancelled')),
  billing_interval text NOT NULL DEFAULT 'monthly'
    CHECK (billing_interval IN ('monthly', 'annual')),
  price_per_seat_cents integer NOT NULL DEFAULT 899,
  revenuecat_entitlement_id text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;

-- ── public.team_members ───────────────────────────────────────────────────────
-- Created before teams RLS policies because "members read their team" references this table.

CREATE TABLE public.team_members (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  invited_by uuid REFERENCES public.profiles(id),
  status text NOT NULL DEFAULT 'active'
    CHECK (status IN ('active', 'removed', 'pending')),
  joined_at timestamptz DEFAULT now(),
  removed_at timestamptz,
  UNIQUE(team_id, user_id)
);

ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;

-- ── public.team_invites ───────────────────────────────────────────────────────

CREATE TABLE public.team_invites (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id uuid NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  invite_code text NOT NULL,
  email text,
  status text NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending', 'accepted', 'expired')),
  expires_at timestamptz NOT NULL DEFAULT now() + interval '7 days',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE public.team_invites ENABLE ROW LEVEL SECURITY;

-- ── ALTER public.profiles ─────────────────────────────────────────────────────
-- Add role and team_id after teams table exists (FK dependency).

ALTER TABLE public.profiles
  ADD COLUMN role text NOT NULL DEFAULT 'tech'
    CHECK (role IN ('tech', 'manager', 'admin'));

ALTER TABLE public.profiles
  ADD COLUMN team_id uuid REFERENCES public.teams(id) ON DELETE SET NULL;

-- ── RLS policies ──────────────────────────────────────────────────────────────
-- All tables exist now, safe to create cross-referencing policies.

-- teams policies
CREATE POLICY "managers read own team"
  ON public.teams FOR SELECT
  USING (auth.uid() = manager_id);

CREATE POLICY "members read their team"
  ON public.teams FOR SELECT
  USING (
    id IN (
      SELECT team_id FROM public.team_members
      WHERE user_id = auth.uid() AND status = 'active'
    )
  );

CREATE POLICY "managers update own team"
  ON public.teams FOR UPDATE
  USING (auth.uid() = manager_id);

-- team_members policies
CREATE POLICY "managers read team members"
  ON public.team_members FOR SELECT
  USING (
    team_id IN (
      SELECT id FROM public.teams WHERE manager_id = auth.uid()
    )
  );

CREATE POLICY "members read own membership"
  ON public.team_members FOR SELECT
  USING (user_id = auth.uid());

-- team_invites policies
CREATE POLICY "managers read team invites"
  ON public.team_invites FOR SELECT
  USING (
    team_id IN (
      SELECT id FROM public.teams WHERE manager_id = auth.uid()
    )
  );

-- ── Indexes ───────────────────────────────────────────────────────────────────

CREATE INDEX team_members_team_idx ON public.team_members(team_id);
CREATE INDEX team_members_user_idx ON public.team_members(user_id);
CREATE INDEX team_invites_code_idx ON public.team_invites(invite_code);
CREATE INDEX profiles_team_idx ON public.profiles(team_id);

-- ── Trigger ───────────────────────────────────────────────────────────────────

CREATE TRIGGER teams_touch_updated
  BEFORE UPDATE ON public.teams
  FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();
