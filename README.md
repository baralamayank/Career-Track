# CareerTrack — cloud web application

CareerTrack retains the original interface and adds real user accounts and private cloud storage using Supabase.

## Setup (about 15–30 minutes)
1. Create a Supabase project at https://supabase.com/dashboard.
2. Open **SQL Editor** and run the contents of `supabase-schema.sql`. This creates a private workspace table protected by row-level security.
3. In **Project Settings → API / Data API**, copy the project URL and **publishable** key (or legacy `anon` key). Paste them into `config.js`. **Never use `service_role` / secret keys in the browser.**
4. In **Authentication → Providers → Email**, choose whether signups require email confirmation. Keep email confirmation enabled for real users.
5. Deploy all files in this folder as a static website: Vercel, Netlify, or GitHub Pages. Set Supabase **Authentication → URL Configuration → Site URL** to the public URL and add the site URL to allowed redirect URLs (including the trailing-slash form if needed).
6. Visit the website, sign up, confirm your email if required, then log in. Add an application. Log in from another browser/device to verify cloud sync.

### Local testing
Run `python3 -m http.server 8000` in this folder, open http://localhost:8000 and add `http://localhost:8000/` under Supabase redirect URLs for local email confirmation. Do not use a `file://` URL for authentication.

## Notes
- All application data is stored per user in one Supabase `jsonb` workspace record, behind RLS policies.
- Supports dashboard, applications, interviews, contacts, reminders, analytics, and JSON backup import/export.
- Sample data is **fictional** and is only added if you choose Load sample data.
- Changes are saved automatically to Supabase. A notice appears if saving fails. Avoid editing the same account simultaneously on multiple tabs/devices; the current version uses last-write-wins cloud sync.
- For production at scale, split records into normalized tables and add conflict handling, password reset/update UX, validated permissions, account deletion, server-side monitoring, and security testing.
- To change the brand, edit the HTML; CareerTrack Innovators is the student project team, not the product name.
- A live URL cannot be created until you connect your own Supabase project and hosting account.
