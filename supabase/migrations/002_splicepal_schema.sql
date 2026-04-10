-- 002_splicepal_schema.sql
-- All SplicePal-specific tables live in their own schema.
-- The SplicePal server uses `db: { schema: 'splicepal' }` so unqualified
-- `from('table_name')` calls resolve here.

create schema if not exists splicepal;

-- Allow the standard Supabase roles to use this schema.
grant usage on schema splicepal to anon, authenticated, service_role;
alter default privileges in schema splicepal
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema splicepal
  grant all on tables to service_role;
alter default privileges in schema splicepal
  grant usage, select on sequences to authenticated, service_role;

-- ── splicepal.user_preferences ────────────────────────────────────────────
-- App-specific profile fields (don't pollute public.profiles).

create table splicepal.user_preferences (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  splicer_models text[] default '{}' not null,
  certifications text[] default '{}' not null,
  updated_at timestamptz default now() not null
);

alter table splicepal.user_preferences enable row level security;

create policy "users read own splicepal prefs"
  on splicepal.user_preferences for select
  using (auth.uid() = user_id);

create policy "users insert own splicepal prefs"
  on splicepal.user_preferences for insert
  with check (auth.uid() = user_id);

create policy "users update own splicepal prefs"
  on splicepal.user_preferences for update
  using (auth.uid() = user_id);

create trigger splicepal_prefs_touch_updated
  before update on splicepal.user_preferences
  for each row execute function public.touch_updated_at();

-- ── splicepal.otdr_results ────────────────────────────────────────────────
-- OTDR trace analysis results. Schema preserved from old SplicePal project.

create table splicepal.otdr_results (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  image_urls text[],
  diagnosis text,
  recommended_action text,
  confidence text,
  full_response_json jsonb,
  saved boolean default false
);

alter table splicepal.otdr_results enable row level security;

create policy "users read own otdr results"
  on splicepal.otdr_results for select
  using (auth.uid() = user_id);

create policy "users insert own otdr results"
  on splicepal.otdr_results for insert
  with check (auth.uid() = user_id);

create policy "users update own otdr results"
  on splicepal.otdr_results for update
  using (auth.uid() = user_id);

-- ── splicepal.troubleshoot_sessions ───────────────────────────────────────

create table splicepal.troubleshoot_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  fiber_type text,
  splicer_model text,
  environment text,
  conversation_json jsonb[] default '{}',
  resolved boolean default false
);

alter table splicepal.troubleshoot_sessions enable row level security;

create policy "users read own splicepal troubleshoot"
  on splicepal.troubleshoot_sessions for select
  using (auth.uid() = user_id);

create policy "users insert own splicepal troubleshoot"
  on splicepal.troubleshoot_sessions for insert
  with check (auth.uid() = user_id);

create policy "users update own splicepal troubleshoot"
  on splicepal.troubleshoot_sessions for update
  using (auth.uid() = user_id);

-- ── splicepal.fiber_types ─────────────────────────────────────────────────
-- Self-growing community reference cache. Read by all authenticated users.

create table splicepal.fiber_types (
  id uuid primary key default gen_random_uuid(),
  fiber_name text,
  manufacturer text,
  fiber_type text,
  mfd_um numeric,
  clad_diameter_um numeric,
  coating_diameter_um numeric,
  arc_settings_json jsonb,
  compatibility_warnings text[] default '{}',
  otdr_notes text,
  source text default 'ai_generated',
  created_at timestamptz default now(),
  query_count integer default 1
);

alter table splicepal.fiber_types enable row level security;

create policy "authenticated read fiber types"
  on splicepal.fiber_types for select
  to authenticated
  using (true);

create policy "service role insert fiber types"
  on splicepal.fiber_types for insert
  to service_role
  with check (true);

create policy "service role update fiber types"
  on splicepal.fiber_types for update
  to service_role
  using (true);

-- ── splicepal.reference_queries ───────────────────────────────────────────
-- Per-user reference query log (for free tier limits).

create table splicepal.reference_queries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  query text not null,
  source text not null default 'database',
  created_at timestamptz default now() not null
);

create index splicepal_refq_user_created_idx
  on splicepal.reference_queries (user_id, created_at);

alter table splicepal.reference_queries enable row level security;

create policy "users read own splicepal ref queries"
  on splicepal.reference_queries for select
  using (auth.uid() = user_id);

create policy "users insert own splicepal ref queries"
  on splicepal.reference_queries for insert
  with check (auth.uid() = user_id);
