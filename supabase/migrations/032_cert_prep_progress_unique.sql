-- 032_cert_prep_progress_unique.sql
-- Add unique constraint on (user_id, cert_level) so upserts work correctly.

ALTER TABLE weldpal.cert_prep_progress
  ADD CONSTRAINT cert_prep_progress_user_cert_uq UNIQUE (user_id, cert_level);
