-- 013_voltpal_schema.sql
-- All VoltPal-specific tables live in their own schema.
-- The VoltPal server uses `db: { schema: 'voltpal' }` so unqualified
-- `from('table_name')` calls resolve here.

create schema if not exists voltpal;

grant usage on schema voltpal to anon, authenticated, service_role;
alter default privileges in schema voltpal
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema voltpal
  grant all on tables to service_role;
alter default privileges in schema voltpal
  grant usage, select on sequences to authenticated, service_role;

-- ── voltpal.user_preferences ─────────────────────────────────────────────
create table voltpal.user_preferences (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  specialties text[] default '{}' not null,
  certifications text[] default '{}' not null,
  updated_at timestamptz default now() not null
);

alter table voltpal.user_preferences enable row level security;

create policy "users read own voltpal prefs"
  on voltpal.user_preferences for select
  using (auth.uid() = user_id);

create policy "users insert own voltpal prefs"
  on voltpal.user_preferences for insert
  with check (auth.uid() = user_id);

create policy "users update own voltpal prefs"
  on voltpal.user_preferences for update
  using (auth.uid() = user_id);

create trigger voltpal_prefs_touch_updated
  before update on voltpal.user_preferences
  for each row execute function public.touch_updated_at();

-- ── voltpal.electrical_analyses ─────────────────────────────────────────
create table voltpal.electrical_analyses (
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

alter table voltpal.electrical_analyses enable row level security;

create policy "users read own electrical analyses"
  on voltpal.electrical_analyses for select
  using (auth.uid() = user_id);

create policy "users insert own electrical analyses"
  on voltpal.electrical_analyses for insert
  with check (auth.uid() = user_id);

create policy "users update own electrical analyses"
  on voltpal.electrical_analyses for update
  using (auth.uid() = user_id);

-- ── voltpal.troubleshoot_sessions ───────────────────────────────────────
create table voltpal.troubleshoot_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  equipment_type text,
  equipment_brand text,
  voltage_system text,
  symptom text,
  environment text,
  conversation_json jsonb[] default '{}',
  resolved boolean default false,
  title text,
  notes text
);

alter table voltpal.troubleshoot_sessions enable row level security;

create policy "users read own voltpal troubleshoot"
  on voltpal.troubleshoot_sessions for select
  using (auth.uid() = user_id);

create policy "users insert own voltpal troubleshoot"
  on voltpal.troubleshoot_sessions for insert
  with check (auth.uid() = user_id);

create policy "users update own voltpal troubleshoot"
  on voltpal.troubleshoot_sessions for update
  using (auth.uid() = user_id);

-- ── voltpal.volt_reference ──────────────────────────────────────────────
create table voltpal.volt_reference (
  id uuid primary key default gen_random_uuid(),
  category text,
  title text,
  equipment_type text,
  voltage_class text,
  specification text,
  content_json jsonb,
  source text default 'verified',
  query_count integer default 1,
  created_at timestamptz default now()
);

alter table voltpal.volt_reference enable row level security;

create policy "authenticated read volt reference"
  on voltpal.volt_reference for select
  to authenticated
  using (true);

-- ── voltpal.reference_queries ───────────────────────────────────────────
create table voltpal.reference_queries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  query text not null,
  source text not null default 'database',
  created_at timestamptz default now() not null
);

create index voltpal_refq_user_created_idx
  on voltpal.reference_queries (user_id, created_at);

alter table voltpal.reference_queries enable row level security;

create policy "users read own voltpal ref queries"
  on voltpal.reference_queries for select
  using (auth.uid() = user_id);

create policy "users insert own voltpal ref queries"
  on voltpal.reference_queries for insert
  with check (auth.uid() = user_id);
