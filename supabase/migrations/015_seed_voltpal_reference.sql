DO $$
DECLARE
  uid uuid;
BEGIN
  SELECT id INTO uid FROM auth.users WHERE email = 'danimaltex26@gmail.com' LIMIT 1;

  IF uid IS NULL THEN
    RAISE NOTICE 'User not found';
    RETURN;
  END IF;

  UPDATE public.profiles
  SET subscription_tier = 'pro'
  WHERE id = uid;

  RAISE NOTICE 'Updated user % to pro tier', uid;
END $$;
