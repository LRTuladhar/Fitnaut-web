import { createServerClient } from "@supabase/ssr";
import type { NextRequest } from "next/server";
import type { Database } from "@/types/db";

export function createApiClient(request: NextRequest) {
  return createServerClient<Database>(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        getAll: () => request.cookies.getAll(),
        setAll: () => {},
      },
    }
  );
}
