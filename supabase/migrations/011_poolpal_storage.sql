-- 011_poolpal_storage.sql
-- Storage bucket for PoolPal image uploads.

insert into storage.buckets (id, name, public)
values ('poolpal-uploads', 'poolpal-uploads', false)
on conflict (id) do nothing;

create policy "poolpal users upload to own folder"
  on storage.objects for insert
  to authenticated
  with check (
    bucket_id = 'poolpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "poolpal users read own files"
  on storage.objects for select
  to authenticated
  using (
    bucket_id = 'poolpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );

create policy "poolpal users delete own files"
  on storage.objects for delete
  to authenticated
  using (
    bucket_id = 'poolpal-uploads'
    and (storage.foldername(name))[1] = auth.uid()::text
  );
