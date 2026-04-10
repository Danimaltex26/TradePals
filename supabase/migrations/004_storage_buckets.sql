-- 004_storage_buckets.sql
-- Per-app storage buckets. Each user's uploads live in a folder named with
-- their auth.uid(), enforced by the RLS policies below.

insert into storage.buckets (id, name, public)
values
  ('splicepal-uploads', 'splicepal-uploads', false),
  ('weldpal-uploads',   'weldpal-uploads',   false)
on conflict (id) do nothing;

-- ── splicepal-uploads ──────────────────────────────────────────────────────

create policy "splicepal users upload to own folder"
  on storage.objects for insert
  to authenticated
  with check (
    bucket_id = 'splicepal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "splicepal users read own files"
  on storage.objects for select
  to authenticated
  using (
    bucket_id = 'splicepal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "splicepal users delete own files"
  on storage.objects for delete
  to authenticated
  using (
    bucket_id = 'splicepal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

-- ── weldpal-uploads ────────────────────────────────────────────────────────

create policy "weldpal users upload to own folder"
  on storage.objects for insert
  to authenticated
  with check (
    bucket_id = 'weldpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "weldpal users read own files"
  on storage.objects for select
  to authenticated
  using (
    bucket_id = 'weldpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "weldpal users delete own files"
  on storage.objects for delete
  to authenticated
  using (
    bucket_id = 'weldpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );
