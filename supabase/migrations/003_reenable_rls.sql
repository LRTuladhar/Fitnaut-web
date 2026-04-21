-- Re-enable RLS on all tables (was disabled during dev)
alter table public.exercises enable row level security;
alter table public.workout_sessions enable row level security;
alter table public.health_metrics enable row level security;
alter table public.user_preferences enable row level security;
alter table public.user_profiles enable row level security;
alter table public.user_api_keys enable row level security;
