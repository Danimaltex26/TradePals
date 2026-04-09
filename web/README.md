# TradePals

Marketing + training site for the TradePals family of apps (SplicePal, WeldPal).

## Stack
Vite + React 19 + TypeScript + Tailwind v4 + React Router + Supabase + Vercel Analytics. Deploys to Vercel.

## Architecture
- **Two Supabase clients** — one per app project (`src/lib/supabase.ts`). Each app stores its session in its own storage key so a user can be signed into both at the same time.
- **`useEntitlement(app)`** reads `subscription_tier` and `subscription_expires_at` from the user's profile row.
- **`<TrainingGate>`** wraps any subscriber-only content. RLS on Supabase is the real gate; the component is for UX.
- **No web signup, no payments.** Subscriptions originate in the iOS app via RevenueCat. The web is sign-in + training only.

## Routes
- `/` — landing
- `/splicepal`, `/splicepal/training`, `/splicepal/training/:slug`, `/splicepal/privacy`, `/splicepal/support`
- `/weldpal`, `/weldpal/training`, `/weldpal/training/:slug`, `/weldpal/privacy`, `/weldpal/support`
- `/signin`, `/account`

## Local dev
```
cp .env.example .env
# fill in both Supabase URLs and anon keys
npm install
npm run dev
```

## Deploy
1. Push to GitHub.
2. Vercel → New Project → import the repo (Vite auto-detected).
3. Settings → Environment Variables → paste the four `VITE_*` Supabase vars.
4. Settings → Domains → add `tradepals.com`.
