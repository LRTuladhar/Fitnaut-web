"use client";

import { useState } from "react";
import { createClient } from "@/lib/supabase/client";
import { Button } from "@/components/ui/button";
import { Dumbbell, Eye, EyeOff } from "lucide-react";
import { useRouter } from "next/navigation";

type Mode = "login" | "register";

function toAuthEmail(login: string) {
  return `${login.trim().toLowerCase()}@fitnaut.app`;
}

export default function LoginPage() {
  const [mode, setMode] = useState<Mode>("login");
  const [login, setLogin] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const router = useRouter();

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (!login.trim() || !password) return;
    if (mode === "register" && password.length < 6) {
      setError("Password must be at least 6 characters.");
      return;
    }
    setLoading(true);
    setError(null);

    const supabase = createClient();
    const authEmail = toAuthEmail(login);

    if (mode === "register") {
      const { error } = await supabase.auth.signUp({
        email: authEmail,
        password,
        options: { data: { username: login.trim(), contact_email: email.trim() || undefined } },
      });
      if (error) { setError(error.message); setLoading(false); return; }
      const { error: signInError } = await supabase.auth.signInWithPassword({ email: authEmail, password });
      if (signInError) { setError(signInError.message); setLoading(false); return; }
    } else {
      const { error } = await supabase.auth.signInWithPassword({ email: authEmail, password });
      if (error) {
        setError(error.message === "Invalid login credentials" ? "Incorrect login or password." : error.message);
        setLoading(false);
        return;
      }
    }

    router.push("/workout");
    router.refresh();
  }

  return (
    <div className="flex flex-col items-center justify-center min-h-screen px-6 gap-8">
      <div className="flex flex-col items-center gap-3">
        <div className="w-16 h-16 rounded-2xl bg-primary/15 flex items-center justify-center">
          <Dumbbell className="w-8 h-8 text-primary" strokeWidth={1.8} />
        </div>
        <h1 className="text-3xl font-bold tracking-tight">Fitnaut</h1>
        <p className="text-sm text-muted-foreground">Track every rep, everywhere.</p>
      </div>

      {/* Mode toggle */}
      <div className="flex bg-secondary rounded-xl p-1 gap-1 w-full max-w-xs">
        <button
          type="button"
          onClick={() => { setMode("login"); setError(null); }}
          className={`flex-1 py-2 rounded-lg text-sm font-semibold transition-all ${mode === "login" ? "bg-card text-foreground shadow" : "text-muted-foreground"}`}
        >
          Sign In
        </button>
        <button
          type="button"
          onClick={() => { setMode("register"); setError(null); }}
          className={`flex-1 py-2 rounded-lg text-sm font-semibold transition-all ${mode === "register" ? "bg-card text-foreground shadow" : "text-muted-foreground"}`}
        >
          Register
        </button>
      </div>

      <form onSubmit={handleSubmit} className="flex flex-col gap-3 w-full max-w-xs">
        <div className="space-y-2">
          <label className="text-xs font-semibold text-muted-foreground uppercase tracking-widest">Login</label>
          <input
            type="text"
            required
            autoCapitalize="none"
            autoCorrect="off"
            placeholder="e.g. johndoe"
            value={login}
            onChange={(e) => setLogin(e.target.value)}
            className="w-full rounded-xl bg-secondary border-0 px-4 py-3.5 text-base focus:outline-none focus:ring-2 focus:ring-primary"
          />
        </div>

        {mode === "register" && (
          <div className="space-y-2">
            <label className="text-xs font-semibold text-muted-foreground uppercase tracking-widest">Email (optional)</label>
            <input
              type="text"
              autoCapitalize="none"
              autoCorrect="off"
              placeholder="you@example.com"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full rounded-xl bg-secondary border-0 px-4 py-3.5 text-base focus:outline-none focus:ring-2 focus:ring-primary"
            />
          </div>
        )}

        <div className="space-y-2">
          <label className="text-xs font-semibold text-muted-foreground uppercase tracking-widest">Password</label>
          <div className="relative">
            <input
              type={showPassword ? "text" : "password"}
              required
              placeholder={mode === "register" ? "Min. 6 characters" : "••••••••"}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full rounded-xl bg-secondary border-0 px-4 py-3.5 pr-12 text-base focus:outline-none focus:ring-2 focus:ring-primary"
            />
            <button type="button" onClick={() => setShowPassword((v) => !v)}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-muted-foreground p-1">
              {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
            </button>
          </div>
        </div>

        {error && <p className="text-destructive text-sm text-center">{error}</p>}

        <Button type="submit" disabled={loading}
          className="w-full h-13 text-base font-semibold rounded-xl bg-primary shadow-lg shadow-blue-500/20 mt-1">
          {loading ? "Please wait…" : mode === "login" ? "Sign In" : "Create Account"}
        </Button>
      </form>
    </div>
  );
}
