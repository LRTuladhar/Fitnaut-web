"use client";

import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { createClient } from "@/lib/supabase/client";
import { getUserId } from "@/lib/getUser";
import type { ExerciseDefinition } from "@/lib/exerciseParser";

export function useExerciseDefinitions() {
  return useQuery({
    queryKey: ["exercise-definitions"],
    queryFn: async (): Promise<ExerciseDefinition[]> => {
      const res = await fetch("/exercise-library.json");
      const data = await res.json();
      // JSON uses camelCase — map to snake_case
      return data.exercises.map((e: any) => ({
        id: (e.name as string).toLowerCase().replace(/\s+/g, "-"),
        name: e.name,
        alternate_names: e.alternateNames ?? [],
        type: e.type,
        muscle_groups: e.muscleGroups ?? [],
        category: e.category ?? "",
        expected_parameters: e.expectedParameters ?? [],
      }));
    },
    staleTime: Infinity,
  });
}

export interface LogExerciseInput {
  exercise_definition_id: string;
  exercise_name: string;
  reps?: number;
  weight_kg?: number;
  distance_m?: number;
  duration_s?: number;
  notes?: string;
}

export function useLogExercise() {
  const queryClient = useQueryClient();
  const supabase = createClient();

  return useMutation({
    mutationFn: async (input: LogExerciseInput) => {
      const userId = await getUserId();

      const { data, error } = await supabase
        .from("exercises")
        .insert({
          user_id: userId,
          exercise_definition_id: input.exercise_definition_id,
          exercise_name: input.exercise_name,
          timestamp: new Date().toISOString(),
          reps: input.reps ?? null,
          weight_kg: input.weight_kg ?? null,
          distance_m: input.distance_m ?? null,
          duration_s: input.duration_s ?? null,
          notes: input.notes ?? null,
        })
        .select()
        .single();

      if (error) throw error;
      return data;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["exercises"] });
    },
  });
}

export interface UpdateExerciseInput {
  id: string;
  reps?: number | null;
  weight_kg?: number | null;
  distance_m?: number | null;
  duration_s?: number | null;
  notes?: string | null;
}

export function useUpdateExercise() {
  const queryClient = useQueryClient();
  const supabase = createClient();
  return useMutation({
    mutationFn: async (input: UpdateExerciseInput) => {
      const { id, ...fields } = input;
      const { error } = await supabase.from("exercises").update(fields).eq("id", id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["exercises"] });
    },
  });
}

export function useDeleteExercise() {
  const queryClient = useQueryClient();
  const supabase = createClient();
  return useMutation({
    mutationFn: async (id: string) => {
      const { error } = await supabase.from("exercises").delete().eq("id", id);
      if (error) throw error;
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["exercises"] });
    },
  });
}

export function useLastExerciseSet(exerciseName: string | null) {
  const supabase = createClient();
  return useQuery({
    queryKey: ["last-set", exerciseName],
    enabled: !!exerciseName,
    staleTime: 0,
    queryFn: async () => {
      const userId = await getUserId();
      const { data } = await supabase
        .from("exercises")
        .select("reps, weight_kg, distance_m, duration_s")
        .eq("user_id", userId)
        .eq("exercise_name", exerciseName!)
        .order("timestamp", { ascending: false })
        .limit(1)
        .single();
      return data ?? null;
    },
  });
}

export function useRecentExercises() {
  const supabase = createClient();
  return useQuery({
    queryKey: ["exercises", "recent"],
    queryFn: async () => {
      const { data, error } = await supabase
        .from("exercises")
        .select("exercise_definition_id, timestamp")
        .order("timestamp", { ascending: false })
        .limit(100);
      if (error) throw error;

      const counts = new Map<string, number>();
      for (const row of data ?? []) {
        counts.set(row.exercise_definition_id, (counts.get(row.exercise_definition_id) ?? 0) + 1);
      }
      return [...counts.entries()]
        .sort((a, b) => b[1] - a[1])
        .slice(0, 6)
        .map(([id]) => id);
    },
  });
}
