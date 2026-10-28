-- Run once in Supabase > SQL Editor. Each account has its own private workspace.
create table if not exists public.workspaces (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{"applications":[],"interviews":[],"contacts":[],"reminders":[]}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.workspaces enable row level security;
revoke all on table public.workspaces from anon;
grant select, insert, update, delete on table public.workspaces to authenticated;
drop policy if exists "Read own workspace" on public.workspaces;
create policy "Read own workspace" on public.workspaces for select to authenticated using ((select auth.uid()) = user_id);
drop policy if exists "Insert own workspace" on public.workspaces;
create policy "Insert own workspace" on public.workspaces for insert to authenticated with check ((select auth.uid()) = user_id);
drop policy if exists "Update own workspace" on public.workspaces;
create policy "Update own workspace" on public.workspaces for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
drop policy if exists "Delete own workspace" on public.workspaces;
create policy "Delete own workspace" on public.workspaces for delete to authenticated using ((select auth.uid()) = user_id);
