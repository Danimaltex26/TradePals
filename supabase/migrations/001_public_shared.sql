-- 001_public_shared.sql
-- Shared identity + entitlements for the unified TradePals database.
-- Every Pal app reads from public.profiles and public.subscriptions.

-- ── Enums ──────────────────────────────────────────────────────────────────

create type public.subscription_tier as enum ('free', 'pro');

create type public.subscription_app as enum (
  'splicepal',
  'weldpal',
  'windpal',
  'liftpal',
  'voltpal',
  'poolpal'
);

create type public.entitlement_source as enum (
  'app_store',
  'play_store',
  'stripe',
  'bundle',
  'manual'
);

-- ── public.profiles ────────────────────────────────────────────────────────
-- One row per user. App-agnostic identity only.

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  display_name text,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

alter table public.profiles enable row level security;

create policy "users read own profile"
  on public.profiles for select
  using (auth.uid() = id);

create policy "users update own profile"
  on public.profiles for update
  using (auth.uid() = id);

-- Auto-create a profile row when a new auth user is inserted.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email)
  values (new.id, new.email);
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Keep updated_at fresh on edits.
create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_touch_updated
  before update on public.profiles
  for each row execute function public.touch_updated_at();

-- ── public.subscriptions ───────────────────────────────────────────────────
-- One row per (user, app). Pal Pro bundle = 6 rows tagged source='bundle'.

create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles(id) on delete cascade,
  app public.subscription_app not null,
  tier public.subscription_tier not null default 'free',
  source public.entitlement_source,
  expires_at timestamptz,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null,
  unique (user_id, app)
);

create index subscriptions_user_id_idx on public.subscriptions (user_id);
create index subscriptions_active_idx on public.subscriptions (app, tier)
  where tier <> 'free';

alter table public.subscriptions enable row level security;

create policy "users read own subscriptions"
  on public.subscriptions for select
  using (auth.uid() = user_id);

-- Writes are service-role only (Apple webhook, Stripe webhook, manual grants).
-- No insert/update/delete policies for authenticated users.

create trigger subscriptions_touch_updated
  before update on public.subscriptions
  for each row execute function public.touch_updated_at();
