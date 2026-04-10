-- 009_weldpal_reference_queries.sql
-- Per-user reference query log for WeldPal (mirrors splicepal.reference_queries).
-- Used for free-tier monthly quota enforcement.

create table weldpal.reference_queries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade not null,
  query text not null,
  source text not null default 'database',
  created_at timestamptz default now() not null
);

create index weldpal_refq_user_created_idx
  on weldpal.reference_queries (user_id, created_at);

alter table weldpal.reference_queries enable row level security;

create policy "users read own weldpal ref queries"
  on weldpal.reference_queries for select
  using (auth.uid() = user_id);

create policy "users insert own weldpal ref queries"
  on weldpal.reference_queries for insert
  with check (auth.uid() = user_id);
