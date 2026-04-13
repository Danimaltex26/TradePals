-- PoolPal Training Module — adds training tables to existing poolpal schema

CREATE TABLE poolpal.training_modules (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), cert_level text NOT NULL, module_number integer NOT NULL, title text NOT NULL, topic_list text[] NOT NULL, estimated_minutes integer NOT NULL, prerequisite_module_id uuid REFERENCES poolpal.training_modules(id), exam_domain_weight numeric, is_published boolean DEFAULT true, created_at timestamptz DEFAULT now());
CREATE INDEX poolpal_training_modules_cert_idx ON poolpal.training_modules(cert_level, module_number);
ALTER TABLE poolpal.training_modules ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON poolpal.training_modules FOR SELECT TO authenticated USING (is_published = true);

CREATE TABLE poolpal.training_content (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), module_id uuid REFERENCES poolpal.training_modules(id) NOT NULL, section_number integer NOT NULL, section_title text NOT NULL, content_type text NOT NULL, content_text text NOT NULL, standard_reference text, created_at timestamptz DEFAULT now());
CREATE INDEX poolpal_training_content_idx ON poolpal.training_content(module_id, section_number);
ALTER TABLE poolpal.training_content ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON poolpal.training_content FOR SELECT TO authenticated USING (true);

CREATE TABLE poolpal.training_questions (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), module_id uuid REFERENCES poolpal.training_modules(id) NOT NULL, cert_level text NOT NULL, topic text NOT NULL, question_text text NOT NULL, option_a text NOT NULL, option_b text NOT NULL, option_c text NOT NULL, option_d text NOT NULL, correct_answer text NOT NULL, explanation text NOT NULL, standard_reference text, difficulty text NOT NULL, is_dynamic boolean DEFAULT false, times_answered integer DEFAULT 0, times_correct integer DEFAULT 0, flagged_quality boolean DEFAULT false, created_at timestamptz DEFAULT now());
CREATE INDEX poolpal_training_questions_module_idx ON poolpal.training_questions(module_id, difficulty);
CREATE INDEX poolpal_training_questions_cert_idx ON poolpal.training_questions(cert_level, topic);
ALTER TABLE poolpal.training_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read" ON poolpal.training_questions FOR SELECT TO authenticated USING (flagged_quality = false);

CREATE TABLE poolpal.training_progress (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, module_id uuid REFERENCES poolpal.training_modules(id) NOT NULL, cert_level text NOT NULL, status text DEFAULT 'not_started', concept_sections_read integer DEFAULT 0, total_sections integer DEFAULT 0, questions_attempted integer DEFAULT 0, questions_correct integer DEFAULT 0, last_practice_score_percent numeric, last_session_at timestamptz, completed_at timestamptz, created_at timestamptz DEFAULT now(), UNIQUE(user_id, module_id));
ALTER TABLE poolpal.training_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON poolpal.training_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON poolpal.training_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON poolpal.training_progress FOR UPDATE USING (auth.uid() = user_id);

CREATE TABLE poolpal.training_exam_attempts (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, cert_level text NOT NULL, exam_mode text NOT NULL, attempt_number integer NOT NULL, total_questions integer NOT NULL, correct_count integer NOT NULL, score_percent numeric NOT NULL, passed boolean NOT NULL, pass_threshold numeric NOT NULL, domain_scores jsonb NOT NULL, time_taken_seconds integer, avg_seconds_per_question numeric, questions_detail jsonb NOT NULL, started_at timestamptz NOT NULL, completed_at timestamptz NOT NULL);
CREATE INDEX poolpal_exam_attempts_idx ON poolpal.training_exam_attempts(user_id, cert_level);
ALTER TABLE poolpal.training_exam_attempts ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON poolpal.training_exam_attempts FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON poolpal.training_exam_attempts FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE TABLE poolpal.training_test_sessions (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, module_id uuid REFERENCES poolpal.training_modules(id), cert_level text NOT NULL, session_type text NOT NULL, total_questions integer NOT NULL, correct_count integer NOT NULL, score_percent numeric NOT NULL, domain_scores jsonb, time_taken_seconds integer, started_at timestamptz NOT NULL, completed_at timestamptz NOT NULL);
CREATE INDEX poolpal_test_sessions_idx ON poolpal.training_test_sessions(user_id, cert_level);
ALTER TABLE poolpal.training_test_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON poolpal.training_test_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON poolpal.training_test_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE TABLE poolpal.training_readiness (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, cert_level text NOT NULL, overall_readiness_percent numeric DEFAULT 0, domain_readiness jsonb DEFAULT '{}', questions_attempted integer DEFAULT 0, sessions_count integer DEFAULT 0, estimated_pass boolean DEFAULT false, last_updated_at timestamptz DEFAULT now(), UNIQUE(user_id, cert_level));
ALTER TABLE poolpal.training_readiness ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON poolpal.training_readiness FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON poolpal.training_readiness FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON poolpal.training_readiness FOR UPDATE USING (auth.uid() = user_id);

CREATE TABLE poolpal.training_spaced_repetition (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid REFERENCES public.profiles(id) NOT NULL, question_id uuid REFERENCES poolpal.training_questions(id) NOT NULL, next_review_at timestamptz NOT NULL, interval_days integer DEFAULT 1, ease_factor numeric DEFAULT 2.5, repetitions integer DEFAULT 0, last_quality_rating integer, UNIQUE(user_id, question_id));
CREATE INDEX poolpal_sr_due_idx ON poolpal.training_spaced_repetition(user_id, next_review_at);
ALTER TABLE poolpal.training_spaced_repetition ENABLE ROW LEVEL SECURITY;
CREATE POLICY "read" ON poolpal.training_spaced_repetition FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "insert" ON poolpal.training_spaced_repetition FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "update" ON poolpal.training_spaced_repetition FOR UPDATE USING (auth.uid() = user_id);
