-- 033_splicepal_weldpal_training_tables.sql
-- Training tables for SplicePal and WeldPal.
-- These tables already exist in the live database (created manually).
-- This migration is kept as documentation only.
-- If running on a fresh DB, uncomment the CREATE statements below.

-- NOTE: Tables and policies for splicepal.training_* and weldpal.training_*
-- (modules, content, questions, progress, exam_attempts, test_sessions,
--  readiness, spaced_repetition) were created prior to this migration file.
-- Structure mirrors voltpal training tables (migration 020).

DO $$ BEGIN RAISE NOTICE 'Migration 033: SplicePal/WeldPal training tables already exist — skipping.'; END $$;
