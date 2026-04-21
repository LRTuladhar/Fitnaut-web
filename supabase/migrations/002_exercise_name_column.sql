-- Drop FK constraint and change exercise_definition_id to text so we can use name-based IDs
-- without requiring the exercise_definitions table to be seeded first.
-- We'll add a proper FK later once the seed is in place.

alter table public.exercises
  drop constraint if exists exercises_exercise_definition_id_fkey;

alter table public.exercises
  alter column exercise_definition_id type text using exercise_definition_id::text;

-- Add a display name column for fast rendering without a join
alter table public.exercises
  add column if not exists exercise_name text not null default '';
