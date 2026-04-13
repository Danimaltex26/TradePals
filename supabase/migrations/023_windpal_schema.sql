-- WindPal schema — AI field companion for wind turbine technicians

CREATE SCHEMA IF NOT EXISTS windpal;

-- User preferences
CREATE TABLE windpal.user_preferences (
  user_id uuid PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  turbine_models text[] DEFAULT '{}',
  certifications text[] DEFAULT '{}',
  specialties text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE windpal.user_preferences ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own prefs read" ON windpal.user_preferences FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own prefs insert" ON windpal.user_preferences FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own prefs update" ON windpal.user_preferences FOR UPDATE USING (auth.uid() = user_id);

-- Turbine inspection analyses
CREATE TABLE windpal.turbine_analyses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) NOT NULL,
  created_at timestamptz DEFAULT now(),
  image_urls text[],
  analysis_type text,
  diagnosis text,
  recommended_action text,
  confidence text,
  severity text,
  full_response_json jsonb,
  saved boolean DEFAULT false,
  title text,
  notes text
);
CREATE INDEX windpal_analyses_user_idx ON windpal.turbine_analyses(user_id, created_at DESC);
ALTER TABLE windpal.turbine_analyses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own analyses read" ON windpal.turbine_analyses FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own analyses insert" ON windpal.turbine_analyses FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own analyses update" ON windpal.turbine_analyses FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "users own analyses delete" ON windpal.turbine_analyses FOR DELETE USING (auth.uid() = user_id);

-- Troubleshoot sessions
CREATE TABLE windpal.troubleshoot_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) NOT NULL,
  created_at timestamptz DEFAULT now(),
  turbine_model text,
  component text,
  environment text,
  conversation_json jsonb[] DEFAULT '{}',
  resolved boolean DEFAULT false,
  title text,
  notes text
);
CREATE INDEX windpal_troubleshoot_user_idx ON windpal.troubleshoot_sessions(user_id, created_at DESC);
ALTER TABLE windpal.troubleshoot_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own sessions read" ON windpal.troubleshoot_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own sessions insert" ON windpal.troubleshoot_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own sessions update" ON windpal.troubleshoot_sessions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "users own sessions delete" ON windpal.troubleshoot_sessions FOR DELETE USING (auth.uid() = user_id);

-- Wind reference database
CREATE TABLE windpal.wind_reference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category text NOT NULL,
  title text NOT NULL,
  equipment_type text,
  system_type text,
  specification text,
  content_json jsonb NOT NULL,
  source text DEFAULT 'verified',
  query_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);
CREATE INDEX windpal_reference_cat_idx ON windpal.wind_reference(category, equipment_type);
ALTER TABLE windpal.wind_reference ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read reference" ON windpal.wind_reference FOR SELECT TO authenticated USING (true);

-- Reference query log
CREATE TABLE windpal.reference_queries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users NOT NULL,
  query text NOT NULL,
  source text DEFAULT 'database',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE windpal.reference_queries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own queries" ON windpal.reference_queries FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert queries" ON windpal.reference_queries FOR INSERT WITH CHECK (auth.uid() = user_id);

-- ── Training tables (same structure as other apps) ──────────────────────────

CREATE TABLE windpal.training_modules (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), cert_level text NOT NULL, module_number integer NOT NULL, title text NOT NULL, topic_list text[] NOT NULL, estimated_minutes integer NOT NULL, prerequisite_module_id uuid REFERENCES windpal.training_modules(id), exam_domain_weight numeric, is_published boolean DEFAULT true, created_at timestamptz DEFAULT now());
CREATE INDEX windpal_training_modules_cert_idx ON windpal.training_modules(cert_level, module_number);
ALTER TABLE windpal.training_modules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON windpal.training_modules FOR SELECT TO authenticated USING (is_published = true);

CREATE TABLE windpal.training_content (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), module_id uuid REFERENCES windpal.training_modules(id) NOT NULL, section_number integer NOT NULL, section_title text NOT NULL, content_type text NOT NULL, content_text text NOT NULL, standard_reference text, created_at timestamptz DEFAULT now());
CREATE INDEX windpal_training_content_idx ON windpal.training_content(module_id, section_number);
ALTER TABLE windpal.training_content ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON windpal.training_content FOR SELECT TO authenticated USING (true);

CREATE TABLE windpal.training_questions (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), module_id uuid REFERENCES windpal.training_modules(id) NOT NULL, cert_level text NOT NULL, topic text NOT NULL, question_text text NOT NULL, option_a text NOT NULL, option_b text NOT NULL, option_c text NOT NULL, option_d text NOT NULL, correct_answer text NOT NULL, explanation text NOT NULL, standard_reference text, difficulty text NOT NULL, is_dynamic boolean DEFAULT false, times_answered integer DEFAULT 0, times_correct integer DEFAULT 0, flagged_quality boolean DEFAULT false, created_at timestamptz DEFAULT now());
CREATE INDEX windpal_training_questions_module_idx ON windpal.training_questions(module_id, difficulty);
ALTER TABLE windpal.training_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON windpal.training_questions FOR SELECT TO authenticated USING (flagged_quality = false);

CREATE TABLE windpal.training_progress (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, module_id uuid REFERENCES windpal.training_modules(id) NOT NULL, cert_level text NOT NULL, status text DEFAULT 'not_started', concept_sections_read integer DEFAULT 0, total_sections integer DEFAULT 0, questions_attempted integer DEFAULT 0, questions_correct integer DEFAULT 0, last_practice_score_percent numeric, last_session_at timestamptz, completed_at timestamptz, created_at timestamptz DEFAULT now(), UNIQUE(user_id, module_id));
ALTER TABLE windpal.training_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON windpal.training_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON windpal.training_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON windpal.training_progress FOR UPDATE USING (auth.uid() = user_id);

CREATE TABLE windpal.training_exam_attempts (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, cert_level text NOT NULL, exam_mode text NOT NULL, attempt_number integer NOT NULL, total_questions integer NOT NULL, correct_count integer NOT NULL, score_percent numeric NOT NULL, passed boolean NOT NULL, pass_threshold numeric NOT NULL, domain_scores jsonb NOT NULL, time_taken_seconds integer, avg_seconds_per_question numeric, questions_detail jsonb NOT NULL, started_at timestamptz NOT NULL, completed_at timestamptz NOT NULL);
CREATE INDEX windpal_exam_attempts_idx ON windpal.training_exam_attempts(user_id, cert_level);
ALTER TABLE windpal.training_exam_attempts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON windpal.training_exam_attempts FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON windpal.training_exam_attempts FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE TABLE windpal.training_test_sessions (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, module_id uuid REFERENCES windpal.training_modules(id), cert_level text NOT NULL, session_type text NOT NULL, total_questions integer NOT NULL, correct_count integer NOT NULL, score_percent numeric NOT NULL, domain_scores jsonb, time_taken_seconds integer, started_at timestamptz NOT NULL, completed_at timestamptz NOT NULL);
CREATE INDEX windpal_test_sessions_idx ON windpal.training_test_sessions(user_id, cert_level);
ALTER TABLE windpal.training_test_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON windpal.training_test_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON windpal.training_test_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE TABLE windpal.training_readiness (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, cert_level text NOT NULL, overall_readiness_percent numeric DEFAULT 0, domain_readiness jsonb DEFAULT '{}', questions_attempted integer DEFAULT 0, sessions_count integer DEFAULT 0, estimated_pass boolean DEFAULT false, last_updated_at timestamptz DEFAULT now(), UNIQUE(user_id, cert_level));
ALTER TABLE windpal.training_readiness ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON windpal.training_readiness FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON windpal.training_readiness FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON windpal.training_readiness FOR UPDATE USING (auth.uid() = user_id);

CREATE TABLE windpal.training_spaced_repetition (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, question_id uuid REFERENCES windpal.training_questions(id) NOT NULL, next_review_at timestamptz NOT NULL, interval_days integer DEFAULT 1, ease_factor numeric DEFAULT 2.5, repetitions integer DEFAULT 0, last_quality_rating integer, UNIQUE(user_id, question_id));
CREATE INDEX windpal_sr_due_idx ON windpal.training_spaced_repetition(user_id, next_review_at);
ALTER TABLE windpal.training_spaced_repetition ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON windpal.training_spaced_repetition FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON windpal.training_spaced_repetition FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON windpal.training_spaced_repetition FOR UPDATE USING (auth.uid() = user_id);
