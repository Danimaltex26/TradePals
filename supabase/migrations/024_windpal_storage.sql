-- 024_windpal_storage.sql
-- Storage bucket for WindPal photo uploads.

insert into storage.buckets (id, name, public)
values ('windpal-uploads', 'windpal-uploads', true)
on conflict (id) do nothing;

-- Authenticated users can upload into their own folder.
create policy "windpal auth upload"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'windpal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

-- Authenticated users can read their own uploads.
create policy "windpal auth read"
  on storage.objects for select
  to authenticated
  using (bucket_id = 'windpal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

-- Public read for sharing analysis results.
create policy "windpal public read"
  on storage.objects for select
  to anon
  using (bucket_id = 'windpal-uploads');
