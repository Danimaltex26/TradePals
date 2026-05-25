-- VoltPal training_module_content — study content per module section
--
-- This table holds the per-section teaching content that lives INSIDE each
-- training_modules row (which itself only carries title + topic_list metadata).
--
-- Schema designed to be replayable for the other 6 Pal apps (SplicePal,
-- WeldPal, PoolPal, PipePal, WindPal, LiftPal) — same shape, different
-- per-app schema namespace. This is the platform standard now.
--
-- Spanish localization (content_es) is included from day 1 so we don't need
-- another migration when VoltPal Phase 3 / SplicePal Phase 2 ship Spanish.

create table if not exists voltpal.training_module_content (
  id                    uuid primary key default gen_random_uuid(),
  module_id             uuid not null references voltpal.training_modules(id) on delete cascade,
  section_number        int not null,
  section_title         text not null,
  section_type          text not null check (section_type in (
                          'overview', 'concept', 'code_reference',
                          'worked_example', 'common_pitfalls', 'self_check'
                        )),
  content_markdown      text not null,
  estimated_read_minutes int,
  -- Spanish translation overlay. Shape mirrors the English fields:
  --   { "section_title": "...", "content_markdown": "..." }
  -- Per-field fallback to English when an es key is absent.
  content_es            jsonb,
  -- Optional metadata for the integration / QA pipeline
  generation_source     text,     -- 'opus_2026_05_24' or 'sme_review_2026_06_15' etc.
  requires_sme_check    boolean not null default false,
  flagged_quality       boolean not null default false,  -- mirrors training_questions semantic
  verification_notes    text,                            -- what the Opus session sourced from
  created_at            timestamptz not null default now(),
  updated_at            timestamptz not null default now(),
  unique (module_id, section_number)
);

-- Lookups by module are the dominant access pattern
create index if not exists training_module_content_module_id_idx
  on voltpal.training_module_content (module_id, section_number);

-- Partial index for production-ready content (most reads filter these out)
create index if not exists training_module_content_published_idx
  on voltpal.training_module_content (module_id)
  where flagged_quality = false and requires_sme_check = false;

-- Partial index for the QA queue
create index if not exists training_module_content_sme_queue_idx
  on voltpal.training_module_content (module_id)
  where requires_sme_check = true;

-- Auto-bump updated_at on row updates
create or replace function voltpal.training_module_content_set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists training_module_content_updated_at on voltpal.training_module_content;
create trigger training_module_content_updated_at
  before update on voltpal.training_module_content
  for each row execute function voltpal.training_module_content_set_updated_at();
