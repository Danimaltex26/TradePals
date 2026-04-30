-- 034_cert_prep_all_apps.sql
-- Add cert_prep_questions and cert_prep_progress tables to all 6 app schemas
-- (WeldPal already has these tables)

-- ============================================================
-- SPLICEPAL
-- ============================================================

CREATE TABLE splicepal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE splicepal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON splicepal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE splicepal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE splicepal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON splicepal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON splicepal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON splicepal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================
-- POOLPAL
-- ============================================================

CREATE TABLE poolpal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE poolpal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON poolpal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE poolpal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE poolpal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON poolpal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON poolpal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON poolpal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================
-- VOLTPAL
-- ============================================================

CREATE TABLE voltpal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE voltpal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON voltpal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE voltpal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE voltpal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON voltpal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON voltpal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON voltpal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================
-- PIPEPAL
-- ============================================================

CREATE TABLE pipepal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE pipepal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON pipepal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE pipepal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE pipepal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON pipepal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON pipepal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON pipepal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================
-- WINDPAL
-- ============================================================

CREATE TABLE windpal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE windpal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON windpal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE windpal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE windpal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON windpal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON windpal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON windpal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);

-- ============================================================
-- LIFTPAL
-- ============================================================

CREATE TABLE liftpal.cert_prep_questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  cert_level text,
  category text,
  question text,
  option_a text,
  option_b text,
  option_c text,
  option_d text,
  correct_answer text,
  explanation text,
  code_reference text,
  difficulty text,
  created_at timestamptz DEFAULT now()
);
ALTER TABLE liftpal.cert_prep_questions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "authenticated read cert questions" ON liftpal.cert_prep_questions FOR SELECT TO authenticated USING (true);

CREATE TABLE liftpal.cert_prep_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  cert_level text,
  questions_attempted integer DEFAULT 0,
  questions_correct integer DEFAULT 0,
  weak_categories text[] DEFAULT '{}',
  strong_categories text[] DEFAULT '{}',
  bookmarked_question_ids uuid[] DEFAULT '{}',
  last_session_at timestamptz,
  created_at timestamptz DEFAULT now(),
  UNIQUE(user_id, cert_level)
);
ALTER TABLE liftpal.cert_prep_progress ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users read own cert progress" ON liftpal.cert_prep_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert own cert progress" ON liftpal.cert_prep_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users update own cert progress" ON liftpal.cert_prep_progress FOR UPDATE USING (auth.uid() = user_id);
