-- 008_splicepal_per_entry_notes.sql
-- Port of mobile migration 009: per-entry title/notes on history rows.
-- Also updates handle_new_user trigger to copy display_name from user_metadata
-- so signup with a Name field populates public.profiles.display_name automatically.

alter table splicepal.otdr_results
  add column if not exists title text,
  add column if not exists notes text;

alter table splicepal.troubleshoot_sessions
  add column if not exists title text,
  add column if not exists notes text;

-- Same for weldpal so it stays consistent across apps.
alter table weldpal.weld_analyses
  add column if not exists title text,
  add column if not exists notes text;

alter table weldpal.troubleshoot_sessions
  add column if not exists title text,
  add column if not exists notes text;

-- Replace the auto-create-profile trigger to read display_name from user_metadata.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, email, display_name)
  values (
    new.id,
    new.email,
    nullif(new.raw_user_meta_data->>'display_name', '')
  );
  return new;
end;
$$;
