-- 031_team_billing.sql
-- Add Stripe billing fields to teams table and update defaults for flat team plan.

-- Stripe identifiers for subscription lifecycle management
ALTER TABLE public.teams
  ADD COLUMN IF NOT EXISTS stripe_customer_id text,
  ADD COLUMN IF NOT EXISTS stripe_subscription_id text;

-- Flat plan: 5 members per team
ALTER TABLE public.teams ALTER COLUMN seats_purchased SET DEFAULT 5;

-- Teams start as 'pending' until Stripe confirms payment
ALTER TABLE public.teams ALTER COLUMN subscription_status SET DEFAULT 'pending';

-- Add 'pending' to the status check constraint
ALTER TABLE public.teams DROP CONSTRAINT IF EXISTS teams_subscription_status_check;
ALTER TABLE public.teams ADD CONSTRAINT teams_subscription_status_check
  CHECK (subscription_status IN ('pending', 'active', 'past_due', 'cancelled'));

-- Index for webhook lookups by Stripe subscription ID
CREATE INDEX IF NOT EXISTS teams_stripe_sub_idx ON public.teams(stripe_subscription_id);
