-- 016_pipepal_schema.sql
-- All PipePal-specific tables live in their own schema.
-- The PipePal server uses `db: { schema: 'pipepal' }` so unqualified
-- `from('table_name')` calls resolve here.

create schema if not exists pipepal;

grant usage on schema pipepal to anon, authenticated, service_role;
alter default privileges in schema pipepal
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema pipepal
  grant all on tables to service_role;
alter default privileges in schema pipepal
  grant usage, select on sequences to authenticated, service_role;

-- ── pipepal.user_preferences ─────────────────────────────────────────────
create table pipepal.user_preferences (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  specialties text[] default '{}' not null,
  certifications text[] default '{}' not null,
  updated_at timestamptz default now() not null
);

alter table pipepal.user_preferences enable row level security;

create policy "users read own pipepal prefs"
  on pipepal.user_preferences for select
  using (auth.uid() = user_id);

create policy "users insert own pipepal prefs"
  on pipepal.user_preferences for insert
  with check (auth.uid() = user_id);

create policy "users update own pipepal prefs"
  on pipepal.user_preferences for update
  using (auth.uid() = user_id);

create trigger pipepal_prefs_touch_updated
  before update on pipepal.user_preferences
  for each row execute function public.touch_updated_at();

-- ── pipepal.plumbing_analyses ───────────────────────────────────────────
create table pipepal.plumbing_analyses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  image_urls text[],
  analysis_type text,
  diagnosis text,
  recommended_action text,
  confidence text,
  full_response_json jsonb,
  saved boolean default false,
  title text,
  notes text
);

alter table pipepal.plumbing_analyses enable row level security;

create policy "users read own plumbing analyses"
  on pipepal.plumbing_analyses for select
  using (auth.uid() = user_id);

create policy "users insert own plumbing analyses"
  on pipepal.plumbing_analyses for insert
  with check (auth.uid() = user_id);

create policy "users update own plumbing analyses"
  on pipepal.plumbing_analyses for update
  using (auth.uid() = user_id);

-- ── pipepal.troubleshoot_sessions ───────────────────────────────────────
create table pipepal.troubleshoot_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  equipment_type text,
  equipment_brand text,
  system_type text,
  symptom text,
  environment text,
  conversation_json jsonb[] default '{}',
  resolved boolean default false,
  title text,
  notes text
);

alter table pipepal.troubleshoot_sessions enable row level security;

create policy "users read own pipepal troubleshoot"
  on pipepal.troubleshoot_sessions for select
  using (auth.uid() = user_id);

create policy "users insert own pipepal troubleshoot"
  on pipepal.troubleshoot_sessions for insert
  with check (auth.uid() = user_id);

create policy "users update own pipepal troubleshoot"
  on pipepal.troubleshoot_sessions for update
  using (auth.uid() = user_id);

-- ── pipepal.pipe_reference ──────────────────────────────────────────────
create table pipepal.pipe_reference (
  id uuid primary key default gen_random_uuid(),
  category text,
  title text,
  equipment_type text,
  system_type text,
  specification text,
  content_json jsonb,
  source text default 'verified',
  query_count integer default 1,
  created_at timestamptz default now()
);

alter table pipepal.pipe_reference enable row level security;

create policy "authenticated read pipe reference"
  on pipepal.pipe_reference for select
  to authenticated
  using (true);

-- ── pipepal.reference_queries ───────────────────────────────────────────
create table pipepal.reference_queries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  query text not null,
  source text not null default 'database',
  created_at timestamptz default now() not null
);

create index pipepal_refq_user_created_idx
  on pipepal.reference_queries (user_id, created_at);

alter table pipepal.reference_queries enable row level security;

create policy "users read own pipepal ref queries"
  on pipepal.reference_queries for select
  using (auth.uid() = user_id);

create policy "users insert own pipepal ref queries"
  on pipepal.reference_queries for insert
  with check (auth.uid() = user_id);
