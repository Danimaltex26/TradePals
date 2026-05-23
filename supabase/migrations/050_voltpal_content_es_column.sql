-- Add Spanish content column to VoltPal training questions.
-- Mirrors the existing English columns; nullable so any subset of the bank can
-- have a translation. Shape of JSONB payload:
--   {
--     "question_text": "...",
--     "option_a": "...", "option_b": "...", "option_c": "...", "option_d": "...",
--     "explanation": "..."
--   }
-- correct_answer ("A"/"B"/"C"/"D"), standard_reference, AWG sizes, NEC code refs,
-- and cert names (Journeyman, NEC, IBEW, OSHA) stay in English regardless of lang.

alter table voltpal.training_questions
  add column if not exists content_es jsonb;

-- Partial index so the public quiz route can efficiently filter to translated questions only
create index if not exists training_questions_content_es_idx
  on voltpal.training_questions ((content_es is not null))
  where content_es is not null;
