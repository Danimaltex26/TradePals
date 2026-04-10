-- 010_poolpal_schema.sql
-- All PoolPal-specific tables live in their own schema.
-- The PoolPal server uses `db: { schema: 'poolpal' }` so unqualified
-- `from('table_name')` calls resolve here.

create schema if not exists poolpal;

grant usage on schema poolpal to anon, authenticated, service_role;
alter default privileges in schema poolpal
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema poolpal
  grant all on tables to service_role;
alter default privileges in schema poolpal
  grant usage, select on sequences to authenticated, service_role;

-- ── poolpal.user_preferences ─────────────────────────────────────────────
create table poolpal.user_preferences (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  service_specialties text[] default '{}' not null,
  certifications text[] default '{}' not null,
  updated_at timestamptz default now() not null
);

alter table poolpal.user_preferences enable row level security;

create policy "users read own poolpal prefs"
  on poolpal.user_preferences for select
  using (auth.uid() = user_id);

create policy "users insert own poolpal prefs"
  on poolpal.user_preferences for insert
  with check (auth.uid() = user_id);

create policy "users update own poolpal prefs"
  on poolpal.user_preferences for update
  using (auth.uid() = user_id);

create trigger poolpal_prefs_touch_updated
  before update on poolpal.user_preferences
  for each row execute function public.touch_updated_at();

-- ── poolpal.pool_analyses ────────────────────────────────────────────────
create table poolpal.pool_analyses (
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

alter table poolpal.pool_analyses enable row level security;

create policy "users read own pool analyses"
  on poolpal.pool_analyses for select
  using (auth.uid() = user_id);

create policy "users insert own pool analyses"
  on poolpal.pool_analyses for insert
  with check (auth.uid() = user_id);

create policy "users update own pool analyses"
  on poolpal.pool_analyses for update
  using (auth.uid() = user_id);

-- ── poolpal.troubleshoot_sessions ────────────────────────────────────────
create table poolpal.troubleshoot_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  equipment_type text,
  equipment_brand text,
  pool_type text,
  symptom text,
  environment text,
  conversation_json jsonb[] default '{}',
  resolved boolean default false,
  title text,
  notes text
);

alter table poolpal.troubleshoot_sessions enable row level security;

create policy "users read own poolpal troubleshoot"
  on poolpal.troubleshoot_sessions for select
  using (auth.uid() = user_id);

create policy "users insert own poolpal troubleshoot"
  on poolpal.troubleshoot_sessions for insert
  with check (auth.uid() = user_id);

create policy "users update own poolpal troubleshoot"
  on poolpal.troubleshoot_sessions for update
  using (auth.uid() = user_id);

-- ── poolpal.pool_reference ───────────────────────────────────────────────
create table poolpal.pool_reference (
  id uuid primary key default gen_random_uuid(),
  category text,
  title text,
  equipment_type text,
  pool_type text,
  specification text,
  content_json jsonb,
  source text default 'verified',
  query_count integer default 1,
  created_at timestamptz default now()
);

alter table poolpal.pool_reference enable row level security;

create policy "authenticated read pool reference"
  on poolpal.pool_reference for select
  to authenticated
  using (true);

-- ── poolpal.reference_queries ────────────────────────────────────────────
create table poolpal.reference_queries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  query text not null,
  source text not null default 'database',
  created_at timestamptz default now() not null
);

create index poolpal_refq_user_created_idx
  on poolpal.reference_queries (user_id, created_at);

alter table poolpal.reference_queries enable row level security;

create policy "users read own poolpal ref queries"
  on poolpal.reference_queries for select
  using (auth.uid() = user_id);

create policy "users insert own poolpal ref queries"
  on poolpal.reference_queries for insert
  with check (auth.uid() = user_id);
