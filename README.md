# MIPS Mastery Lab — Personal Cloud Edition

A single-user MIPS training site designed for GitHub + Vercel. It keeps the original interactive mastery lab, adds a private login, and syncs progress across laptop and phone through Supabase.

## What is included

- R-type, I-type, J-type practice
- Intention -> assembly practice
- 32-bit binary encoding drills
- Register / opcode / funct code tables
- Decimal-to-binary converter
- XP, streaks, achievements, adaptive Smart Mix
- Local cache for fast/offline-ish use
- Supabase email/password login
- Cloud progress sync across devices
- Export/import progress backup

## One-time setup (about 10 minutes)

### 1. Create a free Supabase project

Go to Supabase and create a project.

### 2. Create the progress table

Open **SQL Editor** in Supabase and run the full contents of:

`supabase/setup.sql`

This enables Row Level Security so a signed-in user can only read/write their own progress row.

### 3. Create only your account

In Supabase:

**Authentication -> Users -> Add user**

Create your own email + password account.

For a personal-only site, also open the Supabase Authentication settings and disable public user sign-ups. The website itself has no sign-up button.

### 4. Put this folder on GitHub

Create a new GitHub repository and upload/push all files in this ZIP.

### 5. Import the GitHub repo into Vercel

Create a new Vercel project from the repo.

No build command is required; this is a static site with one small serverless config endpoint.

### 6. Add Vercel environment variables

In **Vercel -> Project -> Settings -> Environment Variables**, add:

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

You can find both in your Supabase project settings / API section.

Redeploy after adding them.

### 7. Sign in

Open your Vercel URL on laptop or phone and log in with the Supabase account you created.

Progress is saved locally immediately and then synced to the cloud. When you sign in on another device, the newer progress copy wins automatically.

## Notes

- The Supabase anon key is designed to be used by browser apps. Security comes from Supabase Row Level Security, not from hiding that key.
- Do not add a public sign-up flow unless you actually want other users.
- If the device temporarily loses internet, practice progress is still cached locally and syncs again when the connection returns.
- The original local storage key is preserved (`mipsMasteryLab_v1`) so existing progress from an earlier version can merge into the cloud the first time you log in on that same browser.

## Local development

Because `/api/config` is a Vercel serverless endpoint, the easiest full local test is with the Vercel CLI:

```bash
npm i -g vercel
vercel dev
```

Create `.env.local` from `.env.example` first.

For simple UI-only editing, you can still open `index.html` with Live Server, but cloud login will require the `/api/config` endpoint.
