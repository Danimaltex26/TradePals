-- LiftPal schema — AI field companion for elevator & lift technicians

CREATE SCHEMA IF NOT EXISTS liftpal;

-- User preferences
CREATE TABLE liftpal.user_preferences (
  user_id uuid PRIMARY KEY REFERENCES public.profiles(id) ON DELETE CASCADE,
  equipment_types text[] DEFAULT '{}',
  certifications text[] DEFAULT '{}',
  specialties text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE liftpal.user_preferences ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own prefs read" ON liftpal.user_preferences FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own prefs insert" ON liftpal.user_preferences FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own prefs update" ON liftpal.user_preferences FOR UPDATE USING (auth.uid() = user_id);

-- Lift inspection analyses
CREATE TABLE liftpal.lift_analyses (
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
CREATE INDEX liftpal_analyses_user_idx ON liftpal.lift_analyses(user_id, created_at DESC);
ALTER TABLE liftpal.lift_analyses ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own analyses read" ON liftpal.lift_analyses FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own analyses insert" ON liftpal.lift_analyses FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own analyses update" ON liftpal.lift_analyses FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "users own analyses delete" ON liftpal.lift_analyses FOR DELETE USING (auth.uid() = user_id);

-- Troubleshoot sessions
CREATE TABLE liftpal.troubleshoot_sessions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES public.profiles(id) NOT NULL,
  created_at timestamptz DEFAULT now(),
  equipment_type text,
  component text,
  environment text,
  conversation_json jsonb[] DEFAULT '{}',
  resolved boolean DEFAULT false,
  title text,
  notes text
);
CREATE INDEX liftpal_troubleshoot_user_idx ON liftpal.troubleshoot_sessions(user_id, created_at DESC);
ALTER TABLE liftpal.troubleshoot_sessions ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own sessions read" ON liftpal.troubleshoot_sessions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users own sessions insert" ON liftpal.troubleshoot_sessions FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users own sessions update" ON liftpal.troubleshoot_sessions FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "users own sessions delete" ON liftpal.troubleshoot_sessions FOR DELETE USING (auth.uid() = user_id);

-- Lift reference database
CREATE TABLE liftpal.lift_reference (
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
CREATE INDEX liftpal_reference_cat_idx ON liftpal.lift_reference(category, equipment_type);
ALTER TABLE liftpal.lift_reference ENABLE ROW LEVEL SECURITY;
CREATE POLICY "auth read reference" ON liftpal.lift_reference FOR SELECT TO authenticated USING (true);

-- Reference query log
CREATE TABLE liftpal.reference_queries (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users NOT NULL,
  query text NOT NULL,
  source text DEFAULT 'database',
  created_at timestamptz DEFAULT now()
);
ALTER TABLE liftpal.reference_queries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "users own queries" ON liftpal.reference_queries FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "users insert queries" ON liftpal.reference_queries FOR INSERT WITH CHECK (auth.uid() = user_id);
