-- 017_pipepal_storage.sql
-- Storage bucket for PipePal photo uploads.

insert into storage.buckets (id, name, public)
values ('pipepal-uploads', 'pipepal-uploads', true)
on conflict (id) do nothing;

create policy "pipepal auth upload"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'pipepal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "pipepal auth read"
  on storage.objects for select
  to authenticated
  using (bucket_id = 'pipepal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "pipepal public read"
  on storage.objects for select
  to anon
  using (bucket_id = 'pipepal-uploads');
