-- AI usage tracking table — logs every Claude API call across all Pal apps
-- Used by admin dashboard for cost monitoring and usage analytics

CREATE TABLE public.ai_usage_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  app_name text NOT NULL,
  feature text NOT NULL,
  model text NOT NULL,
  is_sonnet boolean NOT NULL,
  input_tokens integer NOT NULL,
  output_tokens integer NOT NULL,
  estimated_cost_usd numeric NOT NULL,
  user_id uuid REFERENCES public.profiles(id),
  created_at timestamptz DEFAULT now()
);

CREATE INDEX ai_usage_log_app_idx ON public.ai_usage_log(app_name, created_at DESC);
CREATE INDEX ai_usage_log_created_idx ON public.ai_usage_log(created_at DESC);
CREATE INDEX ai_usage_log_feature_idx ON public.ai_usage_log(feature);

-- Service role only can insert; no RLS needed for user access
ALTER TABLE public.ai_usage_log ENABLE ROW LEVEL SECURITY;
CREATE POLICY "service role insert" ON public.ai_usage_log FOR INSERT TO service_role WITH CHECK (true);
CREATE POLICY "service role read" ON public.ai_usage_log FOR SELECT TO service_role USING (true);

-- Summary view for dashboard
CREATE OR REPLACE VIEW public.ai_cost_by_feature AS
SELECT
  app_name,
  feature,
  model,
  COUNT(*) as call_count,
  SUM(input_tokens) as total_input_tokens,
  SUM(output_tokens) as total_output_tokens,
  SUM(estimated_cost_usd) as total_cost_usd,
  AVG(estimated_cost_usd) as avg_cost_per_call,
  DATE_TRUNC('day', created_at) as day
FROM public.ai_usage_log
GROUP BY app_name, feature, model, DATE_TRUNC('day', created_at)
ORDER BY day DESC, total_cost_usd DESC;
