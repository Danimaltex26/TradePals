-- 003_weldpal_schema.sql
-- All WeldPal-specific tables live in their own schema.
-- The WeldPal server uses `db: { schema: 'weldpal' }`.

create schema if not exists weldpal;

grant usage on schema weldpal to anon, authenticated, service_role;
alter default privileges in schema weldpal
  grant select, insert, update, delete on tables to authenticated;
alter default privileges in schema weldpal
  grant all on tables to service_role;
alter default privileges in schema weldpal
  grant usage, select on sequences to authenticated, service_role;

-- ── weldpal.user_preferences ──────────────────────────────────────────────

create table weldpal.user_preferences (
  user_id uuid primary key references public.profiles(id) on delete cascade,
  welding_processes text[] default '{}' not null,
  certifications text[] default '{}' not null,
  primary_industry text,
  experience_level text,
  updated_at timestamptz default now() not null
);

alter table weldpal.user_preferences enable row level security;

create policy "users read own weldpal prefs"
  on weldpal.user_preferences for select
  using (auth.uid() = user_id);

create policy "users insert own weldpal prefs"
  on weldpal.user_preferences for insert
  with check (auth.uid() = user_id);

create policy "users update own weldpal prefs"
  on weldpal.user_preferences for update
  using (auth.uid() = user_id);

create trigger weldpal_prefs_touch_updated
  before update on weldpal.user_preferences
  for each row execute function public.touch_updated_at();

-- ── weldpal.weld_analyses ─────────────────────────────────────────────────

create table weldpal.weld_analyses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  image_urls text[],
  weld_process text,
  base_material text,
  code_standard text,
  defects_identified jsonb[] default '{}',
  overall_assessment text, -- 'accept' | 'reject' | 'repair' | 'further_inspection_required'
  code_reference text,
  confidence text, -- 'high' | 'medium' | 'low'
  full_response_json jsonb,
  saved boolean default false,
  job_reference text
);

alter table weldpal.weld_analyses enable row level security;

create policy "users read own weld analyses"
  on weldpal.weld_analyses for select
  using (auth.uid() = user_id);

create policy "users insert own weld analyses"
  on weldpal.weld_analyses for insert
  with check (auth.uid() = user_id);

create policy "users update own weld analyses"
  on weldpal.weld_analyses for update
  using (auth.uid() = user_id);

-- ── weldpal.troubleshoot_sessions ─────────────────────────────────────────

create table weldpal.troubleshoot_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  created_at timestamptz default now(),
  weld_process text,
  base_material text,
  filler_metal text,
  position text, -- 1F, 2F, 3F, 4F, 1G, 2G, 3G, 4G, 5G, 6G
  symptom text,
  environment text,
  already_tried text[] default '{}',
  current_parameters text,
  conversation_json jsonb[] default '{}',
  resolved boolean default false
);

alter table weldpal.troubleshoot_sessions enable row level security;

create policy "users read own weldpal troubleshoot"
  on weldpal.troubleshoot_sessions for select
  using (auth.uid() = user_id);

create policy "users insert own weldpal troubleshoot"
  on weldpal.troubleshoot_sessions for insert
  with check (auth.uid() = user_id);

create policy "users update own weldpal troubleshoot"
  on weldpal.troubleshoot_sessions for update
  using (auth.uid() = user_id);

-- ── weldpal.weld_reference ────────────────────────────────────────────────
-- Self-growing reference DB. Authenticated read; service-role writes.

create table weldpal.weld_reference (
  id uuid primary key default gen_random_uuid(),
  category text,         -- filler_metal | wps | preheat | defect_guide | code_requirement | weld_symbol | safety
  title text,
  process text,          -- MIG, TIG, Stick, FCAW, SAW
  base_material text,
  specification text,    -- AWS D1.1, API 1104, ASME IX, AWS D1.2
  content_json jsonb,
  source text default 'verified',  -- 'verified' | 'ai_generated'
  query_count integer default 1,
  created_at timestamptz default now()
);

alter table weldpal.weld_reference enable row level security;

create policy "authenticated read weld reference"
  on weldpal.weld_reference for select
  to authenticated
  using (true);

-- inserts/updates: service role only (bypasses RLS, no policy needed)

-- ── weldpal.cert_prep_questions ───────────────────────────────────────────

create table weldpal.cert_prep_questions (
  id uuid primary key default gen_random_uuid(),
  cert_level text,    -- 'CW' | 'CAWI' | 'CWI' | 'CWS' | 'CRAW'
  category text,      -- 'visual_inspection' | 'codes_standards' | 'weld_symbols' | 'metallurgy' | 'processes' | 'safety' | 'ndt'
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text, -- 'A' | 'B' | 'C' | 'D'
  explanation text,
  code_reference text,
  difficulty text,    -- 'easy' | 'medium' | 'hard'
  created_at timestamptz default now()
);

alter table weldpal.cert_prep_questions enable row level security;

create policy "authenticated read cert questions"
  on weldpal.cert_prep_questions for select
  to authenticated
  using (true);

-- ── weldpal.cert_prep_progress ────────────────────────────────────────────

create table weldpal.cert_prep_progress (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  cert_level text,
  questions_attempted integer default 0,
  questions_correct integer default 0,
  weak_categories text[] default '{}',
  strong_categories text[] default '{}',
  bookmarked_question_ids uuid[] default '{}',
  last_session_at timestamptz,
  created_at timestamptz default now()
);

alter table weldpal.cert_prep_progress enable row level security;

create policy "users read own cert progress"
  on weldpal.cert_prep_progress for select
  using (auth.uid() = user_id);

create policy "users insert own cert progress"
  on weldpal.cert_prep_progress for insert
  with check (auth.uid() = user_id);

create policy "users update own cert progress"
  on weldpal.cert_prep_progress for update
  using (auth.uid() = user_id);
