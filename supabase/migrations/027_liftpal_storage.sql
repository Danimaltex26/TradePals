-- 027_liftpal_storage.sql
-- Storage bucket for LiftPal photo uploads.

insert into storage.buckets (id, name, public)
values ('liftpal-uploads', 'liftpal-uploads', true)
on conflict (id) do nothing;

create policy "liftpal auth upload"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'liftpal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "liftpal auth read"
  on storage.objects for select
  to authenticated
  using (bucket_id = 'liftpal-uploads' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "liftpal public read"
  on storage.objects for select
  to anon
  using (bucket_id = 'liftpal-uploads');
