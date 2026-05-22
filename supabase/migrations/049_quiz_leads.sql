-- Public cert-prep quiz leads
-- Captures email + score from unauthenticated quizzes (CFOT, NEC, CWI, etc.) across all Pal apps.
-- One row per quiz attempt; same email may appear multiple times (across apps or retakes).

create table if not exists public.quiz_leads (
  id            uuid primary key default gen_random_uuid(),
  email         text not null,
  source        text not null,                -- e.g. 'splicepal_cfot', 'voltpal_journeyman'
  score         integer,                      -- 0..total_questions (nullable; gate hits before completion)
  total         integer,                      -- total questions in this quiz (snapshot)
  ip            inet,
  user_agent    text,
  referrer      text,
  utm           jsonb,                        -- {source, medium, campaign, content, term}
  captured_at   timestamptz not null default now()
);

create index if not exists quiz_leads_email_idx     on public.quiz_leads (lower(email));
create index if not exists quiz_leads_source_idx    on public.quiz_leads (source);
create index if not exists quiz_leads_captured_idx  on public.quiz_leads (captured_at desc);

-- Service role writes; no anon access (route is server-only).
alter table public.quiz_leads enable row level security;
