-- Step 1: Create the test user via Supabase auth (run in SQL Editor)
-- This creates user with username=test, password=test
-- Internal email will be test@fitnaut.app

-- Create the auth user
insert into auth.users (
  id,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  role
) values (
  gen_random_uuid(),
  'test@fitnaut.app',
  crypt('test', gen_salt('bf')),
  now(),
  now(),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{}',
  false,
  'authenticated'
)
;

-- Step 2: Get the new user's UUID (run this after step 1)
-- select id from auth.users where email = 'test@fitnaut.app';

-- Step 3: Reassign existing data to the new user
-- Replace NEW_USER_UUID with the UUID from step 2,
-- and OLD_USER_UUID with: 311ebe23-03c6-4391-ac22-4822858aeb7c

-- update public.exercises       set user_id = 'NEW_USER_UUID' where user_id = '311ebe23-03c6-4391-ac22-4822858aeb7c';
-- update public.health_metrics  set user_id = 'NEW_USER_UUID' where user_id = '311ebe23-03c6-4391-ac22-4822858aeb7c';
-- update public.user_preferences set user_id = 'NEW_USER_UUID' where user_id = '311ebe23-03c6-4391-ac22-4822858aeb7c';
-- update public.user_profiles   set user_id = 'NEW_USER_UUID' where user_id = '311ebe23-03c6-4391-ac22-4822858aeb7c';
-- update public.user_api_keys   set user_id = 'NEW_USER_UUID' where user_id = '311ebe23-03c6-4391-ac22-4822858aeb7c';
