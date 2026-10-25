-- V2: every row belongs to the user who created it.
-- Replaces the single-owner email policies with owner_id = auth.uid().
-- All five existing tables were empty when this was written, so no data moves.

-- ---------------------------------------------------------------------------
-- Existing tables: add owner_id, drop S+Y-specific constraints
-- ---------------------------------------------------------------------------

alter table public.projects
  add column owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  add column fee_total numeric;
alter table public.projects drop constraint projects_archetype_check;
alter table public.projects rename column archetype to project_type;

alter table public.intake_answers
  add column owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  add column question text;
alter table public.intake_answers drop constraint intake_answers_question_no_check;
alter table public.intake_answers drop constraint intake_answers_project_id_question_no_key;
-- Questions are each user's own, so answers are keyed by the question text.
alter table public.intake_answers alter column question set not null;
alter table public.intake_answers add constraint intake_answers_project_id_question_key unique (project_id, question);

alter table public.proposals
  add column owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  add column template_id uuid;

alter table public.fee_milestones
  add column owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade;

alter table public.lessons_learned
  add column owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade;

-- ---------------------------------------------------------------------------
-- New tables
-- ---------------------------------------------------------------------------

create table public.profiles (
  id uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  display_name text,
  firm_name text,
  ai_review_opt_in boolean not null default false,
  ai_review_opt_in_at timestamptz,
  created_at timestamptz not null default now()
);

-- One row per user, kind and project type ('' = applies to every type).
create table public.templates (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  kind text not null check (kind in ('project_types', 'intake_questions', 'task_library', 'fee', 'schedule', 'proposal')),
  project_type text not null default '',
  body jsonb not null default '{}'::jsonb,
  -- user: written by the user. guide: started from a repo guide. ai: started from an AI suggestion.
  origin text not null default 'user' check (origin in ('user', 'guide', 'ai')),
  reviewed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (owner_id, kind, project_type)
);

-- Suggestions written by an AI review (see admin.add_ai_suggestion). Users read and dismiss them;
-- they never change a template until the user copies one in.
create table public.ai_suggestions (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('project_types', 'intake_questions', 'task_library', 'fee', 'schedule', 'proposal')),
  project_type text not null default '',
  title text not null,
  body jsonb not null,
  notes text,
  source text not null,
  created_at timestamptz not null default now(),
  dismissed_at timestamptz
);

create table public.past_proposals (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null,
  client_name text,
  year smallint,
  project_type text,
  file_path text,
  file_name text,
  body_text text,
  notes text,
  created_at timestamptz not null default now()
);

create table public.schedule_tasks (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  project_id uuid not null references public.projects(id) on delete cascade,
  sort_order smallint not null default 0,
  phase text,
  task text not null,
  weeks numeric,
  notes text,
  created_at timestamptz not null default now()
);

alter table public.proposals
  add constraint proposals_template_id_fkey foreign key (template_id) references public.templates(id) on delete set null;

-- ---------------------------------------------------------------------------
-- Indexes for owner and project lookups
-- ---------------------------------------------------------------------------

create index projects_owner_id_idx on public.projects (owner_id);
create index intake_answers_owner_id_idx on public.intake_answers (owner_id);
create index proposals_owner_id_idx on public.proposals (owner_id);
create index proposals_template_id_idx on public.proposals (template_id);
create index fee_milestones_owner_id_idx on public.fee_milestones (owner_id);
create index fee_milestones_project_id_idx on public.fee_milestones (project_id);
create index lessons_learned_owner_id_idx on public.lessons_learned (owner_id);
create index lessons_learned_project_id_idx on public.lessons_learned (project_id);
create index ai_suggestions_owner_id_idx on public.ai_suggestions (owner_id);
create index past_proposals_owner_id_idx on public.past_proposals (owner_id);
create index schedule_tasks_owner_id_idx on public.schedule_tasks (owner_id);
create index schedule_tasks_project_id_idx on public.schedule_tasks (project_id);

-- ---------------------------------------------------------------------------
-- Row level security: each user sees and changes only their own rows
-- ---------------------------------------------------------------------------

drop policy "owner full access" on public.projects;
drop policy "owner full access" on public.intake_answers;
drop policy "owner full access" on public.proposals;
drop policy "owner full access" on public.fee_milestones;
drop policy "owner full access" on public.lessons_learned;

alter table public.profiles enable row level security;
alter table public.templates enable row level security;
alter table public.ai_suggestions enable row level security;
alter table public.past_proposals enable row level security;
alter table public.schedule_tasks enable row level security;

create policy "own rows" on public.projects for all to authenticated
  using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));

create policy "own rows" on public.templates for all to authenticated
  using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));

create policy "own rows" on public.past_proposals for all to authenticated
  using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));

create policy "own profile" on public.profiles for all to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

-- Users read and dismiss suggestions; only admin.add_ai_suggestion creates them.
create policy "read own" on public.ai_suggestions for select to authenticated
  using (owner_id = (select auth.uid()));
create policy "dismiss own" on public.ai_suggestions for update to authenticated
  using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
create policy "delete own" on public.ai_suggestions for delete to authenticated
  using (owner_id = (select auth.uid()));

-- Rows that hang off a project must also point at one of the user's own projects.
create policy "own rows" on public.intake_answers for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid())
    and exists (select 1 from public.projects p where p.id = project_id and p.owner_id = (select auth.uid())));

create policy "own rows" on public.proposals for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid())
    and exists (select 1 from public.projects p where p.id = project_id and p.owner_id = (select auth.uid())));

create policy "own rows" on public.fee_milestones for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid())
    and exists (select 1 from public.projects p where p.id = project_id and p.owner_id = (select auth.uid())));

create policy "own rows" on public.schedule_tasks for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid())
    and exists (select 1 from public.projects p where p.id = project_id and p.owner_id = (select auth.uid())));

create policy "own rows" on public.lessons_learned for all to authenticated
  using (owner_id = (select auth.uid()))
  with check (owner_id = (select auth.uid())
    and (project_id is null
      or exists (select 1 from public.projects p where p.id = project_id and p.owner_id = (select auth.uid())))));

-- ---------------------------------------------------------------------------
-- Storage: private bucket for uploaded past proposals, one folder per user
-- ---------------------------------------------------------------------------

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'past-proposals', 'past-proposals', false, 20971520,
  array['application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'text/plain', 'text/markdown']
);

create policy "past proposals: own folder read" on storage.objects for select to authenticated
  using (bucket_id = 'past-proposals' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "past proposals: own folder insert" on storage.objects for insert to authenticated
  with check (bucket_id = 'past-proposals' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "past proposals: own folder delete" on storage.objects for delete to authenticated
  using (bucket_id = 'past-proposals' and (storage.foldername(name))[1] = (select auth.uid())::text);
