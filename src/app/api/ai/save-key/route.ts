import { NextResponse, type NextRequest } from "next/server";
import { createServiceClient } from "@/lib/supabase/service";
import { createApiClient } from "@/lib/supabase/api";

export async function POST(request: NextRequest) {
  const supabase = createApiClient(request);
  const { data: { user } } = await supabase.auth.getUser();
  if (!user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { provider, key } = await request.json();
  const service = createServiceClient();

  const { error } = await service
    .from("user_api_keys")
    .upsert(
      provider === "anthropic"
        ? { user_id: user.id, anthropic_key_encrypted: key }
        : { user_id: user.id, openrouter_key_encrypted: key },
      { onConflict: "user_id" }
    );

  if (error) return NextResponse.json({ error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true });
}
