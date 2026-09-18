-- MIPS Mastery Lab cloud progress table
-- Run this once in Supabase -> SQL Editor.

create table if not exists public.mips_progress (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.mips_progress enable row level security;

drop policy if exists "read own progress" on public.mips_progress;
create policy "read own progress"
on public.mips_progress
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "insert own progress" on public.mips_progress;
create policy "insert own progress"
on public.mips_progress
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "update own progress" on public.mips_progress;
create policy "update own progress"
on public.mips_progress
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "delete own progress" on public.mips_progress;
create policy "delete own progress"
on public.mips_progress
for delete
to authenticated
using (auth.uid() = user_id);
