-- Enable pgcrypto for key encryption
create extension if not exists pgcrypto;

-- Exercise definitions (global seed table)
create table if not exists public.exercise_definitions (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  alternate_names text[] not null default '{}',
  type text not null,
  muscle_groups text[] not null default '{}',
  category text not null,
  expected_parameters text[] not null default '{}'
);

-- Allow all authenticated users to read exercise definitions
alter table public.exercise_definitions enable row level security;
create policy "Anyone can read exercise definitions"
  on public.exercise_definitions for select
  using (true);

-- Exercises (individual sets)
create table if not exists public.exercises (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  timestamp timestamptz not null default now(),
  exercise_definition_id uuid not null references public.exercise_definitions(id),
  reps integer,
  weight_kg numeric,
  distance_m numeric,
  duration_s numeric,
  notes text,
  session_id uuid
);

alter table public.exercises enable row level security;
create policy "Users can manage their own exercises"
  on public.exercises for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create index exercises_user_id_timestamp_idx on public.exercises(user_id, timestamp desc);

-- Workout sessions
create table if not exists public.workout_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  start_time timestamptz not null,
  end_time timestamptz not null,
  notes text
);

alter table public.workout_sessions enable row level security;
create policy "Users can manage their own sessions"
  on public.workout_sessions for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create index workout_sessions_user_id_start_time_idx on public.workout_sessions(user_id, start_time desc);

-- Health metrics
create table if not exists public.health_metrics (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  weight_kg numeric,
  heart_rate integer,
  systolic_bp integer,
  diastolic_bp integer,
  notes text,
  unique(user_id, date)
);

alter table public.health_metrics enable row level security;
create policy "Users can manage their own health metrics"
  on public.health_metrics for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- User preferences
create table if not exists public.user_preferences (
  user_id uuid primary key references auth.users(id) on delete cascade,
  weight_unit text not null default 'lbs',
  distance_unit text not null default 'mi',
  session_gap_seconds integer not null default 10800,
  default_time_range text not null default 'month',
  ai_provider text not null default 'openrouter',
  openrouter_model text
);

alter table public.user_preferences enable row level security;
create policy "Users can manage their own preferences"
  on public.user_preferences for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- User profiles
create table if not exists public.user_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  name text,
  year_of_birth integer,
  gender text,
  fitness_goals text[] not null default '{}'
);

alter table public.user_profiles enable row level security;
create policy "Users can manage their own profiles"
  on public.user_profiles for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- API keys (encrypted, service-role only for decrypt)
create table if not exists public.user_api_keys (
  user_id uuid primary key references auth.users(id) on delete cascade,
  openrouter_key_encrypted text,
  anthropic_key_encrypted text
);

alter table public.user_api_keys enable row level security;
create policy "Users can manage their own api keys"
  on public.user_api_keys for all
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Auto-create preferences + profile on user signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.user_preferences(user_id) values(new.id)
    on conflict(user_id) do nothing;
  insert into public.user_profiles(user_id) values(new.id)
    on conflict(user_id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
