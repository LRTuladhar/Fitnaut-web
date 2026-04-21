-- Test data for analytics. User ID: 311ebe23-03c6-4391-ac22-4822858aeb7c
-- Covers 4 weeks of workouts: strength, cardio, flexibility

insert into public.exercises (user_id, exercise_definition_id, exercise_name, timestamp, reps, weight_kg, distance_m, duration_s, notes) values

-- Week 4 ago - Monday (chest/shoulders)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '28 days' + interval '9 hours',  8,  83.9, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '28 days' + interval '9 hours 5 minutes',  8,  83.9, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '28 days' + interval '9 hours 10 minutes', 6,  88.5, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'overhead-press',     'Overhead Press',     now() - interval '28 days' + interval '9 hours 20 minutes', 10, 52.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'overhead-press',     'Overhead Press',     now() - interval '28 days' + interval '9 hours 25 minutes', 10, 52.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'tricep-pushdown',    'Tricep Pushdown',    now() - interval '28 days' + interval '9 hours 35 minutes', 12, 27.2, null, null, null),

-- Week 4 ago - Wednesday (legs)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '26 days' + interval '18 hours',            5,  100.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '26 days' + interval '18 hours 6 minutes',   5,  100.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '26 days' + interval '18 hours 12 minutes',  5,  104.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'romanian-deadlift',  'Romanian Deadlift',  now() - interval '26 days' + interval '18 hours 22 minutes', 10,  79.4, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'romanian-deadlift',  'Romanian Deadlift',  now() - interval '26 days' + interval '18 hours 28 minutes', 10,  79.4, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'leg-press',          'Leg Press',          now() - interval '26 days' + interval '18 hours 38 minutes', 12, 120.2, null, null, null),

-- Week 4 ago - Friday (cardio)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'running',            'Running',            now() - interval '24 days' + interval '7 hours', null, null, 4828, 1800, 'Morning run'),

-- Week 3 ago - Monday (back/biceps)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '21 days' + interval '18 hours',            5,  120.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '21 days' + interval '18 hours 8 minutes',   5,  120.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '21 days' + interval '18 hours 16 minutes',  3,  127.6, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '21 days' + interval '18 hours 26 minutes',  8,  null,  null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '21 days' + interval '18 hours 31 minutes',  7,  null,  null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'barbell-row',        'Barbell Row',        now() - interval '21 days' + interval '18 hours 41 minutes', 10,  70.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'barbell-row',        'Barbell Row',        now() - interval '21 days' + interval '18 hours 47 minutes', 10,  70.3, null, null, null),

-- Week 3 ago - Thursday (chest)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '18 days' + interval '9 hours',  8,  86.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '18 days' + interval '9 hours 6 minutes',  8,  86.2, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '18 days' + interval '9 hours 12 minutes', 6,  90.7, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'incline-bench-press','Incline Bench Press',now() - interval '18 days' + interval '9 hours 22 minutes', 10,  70.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'incline-bench-press','Incline Bench Press',now() - interval '18 days' + interval '9 hours 28 minutes', 10,  70.3, null, null, null),

-- Week 3 ago - Saturday (cardio + flexibility)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'cycling',            'Cycling',            now() - interval '16 days' + interval '10 hours', null, null, 16093, 3600, 'Long ride'),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'yoga',               'Yoga',               now() - interval '16 days' + interval '11 hours 30 minutes', null, null, null, 2700, 'Post-ride stretch'),

-- Week 2 ago - Monday (legs)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '14 days' + interval '18 hours',            5,  104.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '14 days' + interval '18 hours 6 minutes',   5,  104.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '14 days' + interval '18 hours 12 minutes',  3,  109.8, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'leg-curl',           'Leg Curl',           now() - interval '14 days' + interval '18 hours 22 minutes', 12,  45.4, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'leg-curl',           'Leg Curl',           now() - interval '14 days' + interval '18 hours 28 minutes', 12,  45.4, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'calf-raise',         'Calf Raise',         now() - interval '14 days' + interval '18 hours 38 minutes', 15,  61.2, null, null, null),

-- Week 2 ago - Wednesday (back)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '12 days' + interval '18 hours',            5,  125.0, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '12 days' + interval '18 hours 8 minutes',   3,  132.5, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '12 days' + interval '18 hours 20 minutes',  9,  null,  null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '12 days' + interval '18 hours 25 minutes',  8,  null,  null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'cable-row',          'Cable Row',          now() - interval '12 days' + interval '18 hours 35 minutes', 12,  63.5, null, null, null),

-- Week 2 ago - Friday (cardio)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'running',            'Running',            now() - interval '10 days' + interval '7 hours', null, null, 6437, 2100, 'Tempo run'),

-- Last week - Tuesday (chest/shoulders)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '7 days' + interval '9 hours',  8,  88.5, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '7 days' + interval '9 hours 6 minutes',  8,  88.5, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '7 days' + interval '9 hours 12 minutes', 5,  93.0, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'overhead-press',     'Overhead Press',     now() - interval '7 days' + interval '9 hours 22 minutes', 10, 54.4, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'overhead-press',     'Overhead Press',     now() - interval '7 days' + interval '9 hours 28 minutes', 8,  56.7, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'lateral-raise',      'Lateral Raise',      now() - interval '7 days' + interval '9 hours 38 minutes', 15, 11.3, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'lateral-raise',      'Lateral Raise',      now() - interval '7 days' + interval '9 hours 43 minutes', 15, 11.3, null, null, null),

-- Last week - Thursday (legs)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '4 days' + interval '18 hours',            5,  109.8, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '4 days' + interval '18 hours 6 minutes',   5,  109.8, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'squat',              'Squat',              now() - interval '4 days' + interval '18 hours 12 minutes',  3,  115.7, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'romanian-deadlift',  'Romanian Deadlift',  now() - interval '4 days' + interval '18 hours 22 minutes', 10,  83.9, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'romanian-deadlift',  'Romanian Deadlift',  now() - interval '4 days' + interval '18 hours 28 minutes', 10,  83.9, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'leg-press',          'Leg Press',          now() - interval '4 days' + interval '18 hours 38 minutes', 15, 127.0, null, null, null),

-- Last week - Saturday (cardio)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'running',            'Running',            now() - interval '2 days' + interval '8 hours', null, null, 8046, 2700, 'Long run'),

-- Yesterday (full body)
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '1 day' + interval '17 hours',            5,  127.6, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'deadlift',           'Deadlift',           now() - interval '1 day' + interval '17 hours 8 minutes',   3,  134.8, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '1 day' + interval '17 hours 20 minutes',  5,  93.0, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'bench-press',        'Bench Press',        now() - interval '1 day' + interval '17 hours 26 minutes',  5,  93.0, null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '1 day' + interval '17 hours 36 minutes', 10,  null,  null, null, null),
('311ebe23-03c6-4391-ac22-4822858aeb7c', 'pull-up',            'Pull-Up',            now() - interval '1 day' + interval '17 hours 41 minutes', 10,  null,  null, null, null);
