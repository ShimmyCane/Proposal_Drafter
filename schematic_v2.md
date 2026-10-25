# Proposal Drafter Schematic

Schematic version: V2.01 (plan agreed, not yet built)

Supersedes the V1.02 system map for the web tools. The folder map in `schematic.md` still describes the repository; this file describes how the web app works, who owns what, and the build plan.

## Decisions

| # | Question | Decision |
| --- | --- | --- |
| 1 | Sign-up | Open to anyone with an email. Revisit after about 10 users. |
| 2 | Export | No export feature yet. Users copy and paste output from the page into Word or Excel. |
| 3 | Templates | Each user gets their own copies and can edit them. |
| 4 | Sharing between users | None. Every user sees only their own data. |

Scale target: about 10 users. Keep the design simple.

## What changes from V1

| Area | V1 (today) | V2 |
| --- | --- | --- |
| Who can sign in | One email (`OWNER_EMAIL` in `assets/shared.js`) | Anyone, with a magic link to their own email |
| Who can read data | RLS checks for the owner's email | RLS checks `owner_id = auth.uid()` on every table |
| Templates | Repo files only (`01_Preparation/`) | Copied into each new account, then edited per user |
| Output | Shown in the browser | Shown in the browser, laid out to copy and paste cleanly |
| Where it runs | `localhost:3000` | A public URL, so other users can reach it |

## Users and access

- Magic-link sign-in to any email. Supabase creates the account on first sign-in.
- Every row has an owner. A user can read and change only their own rows.
- No admin role in V2.

## Data model (Supabase, public schema)

Every user-owned table gets `owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade`, plus one RLS policy for all actions: `owner_id = auth.uid()`.

| Table | Today | V2 change |
| --- | --- | --- |
| `projects` | Exists, 0 rows | Add `owner_id`; replace the email policy |
| `intake_answers` | Exists, 0 rows | Add `owner_id`; replace the email policy |
| `proposals` | Exists, 0 rows | Add `owner_id`; replace the email policy |
| `fee_milestones` | Exists, 0 rows | Add `owner_id`; replace the email policy |
| `lessons_learned` | Exists, 0 rows | Add `owner_id`; replace the email policy |
| `schedule_tasks` | New | `id`, `owner_id`, `project_id`, `sort_order`, `phase`, `task`, `duration_weeks`, `start_week`, `notes` |
| `templates` | New | `id`, `owner_id`, `kind` (`proposal`, `fee`, `schedule`, `intake`, `code_analysis`), `archetype`, `name`, `body`, `default_template_id`, `updated_at` |
| `default_templates` | New | `id`, `kind`, `archetype`, `name`, `body`, `source_path`. Read-only to users; filled from the repo. |

All existing tables are empty, so the migration moves no data.

### How a new user gets templates

1. `default_templates` holds the repo's templates, loaded by a migration.
2. A database trigger on new sign-ups copies every default into that user's `templates`.
3. A one-time backfill runs the same copy for accounts that already exist (for example the studio's own account).
4. Users edit their copies. "Reset to default" copies the default back over their version.

Doing the copy in the database means it runs exactly once per user, without depending on the browser.

### Seed sources in the repo

| Kind | Repo file(s) |
| --- | --- |
| `proposal` (5 archetypes) | `01_Preparation/Templates/Proposal_Templates/01_…05_*.md` |
| `proposal` (framework) | `01_Preparation/Proposal Framework/S+Y_Studio_Proposal_Framework.md` |
| `fee` | `01_Preparation/Templates/fee_schedule_data.json` |
| `schedule` | `01_Preparation/Templates/project_schedule_template.md` |
| `code_analysis` | `01_Preparation/Templates/Code Analysis/code_analysis_template.md` |

A small script (`scripts/build-template-seed.mjs`) reads these files and writes the seed migration. Re-run it when the repo templates change.

## Repository structure

The repo holds code and default content. User data stays in the database.

```
Proposal_Drafter/
├── index.html              # Home page; lists the tools
├── assets/
│   ├── shared.js           # Supabase client, sign-in gate, esc()
│   └── shared.css
├── tools/
│   ├── intake.html         # 1. Project intake (built)
│   ├── fee.html            # 2. Fee schedule
│   ├── schedule.html       # 3. Project schedule
│   ├── proposal.html       # 4. Proposal draft
│   ├── lessons.html        # 5. Lessons learned
│   └── templates.html      # Edit my templates
├── scripts/
│   └── build-template-seed.mjs
├── supabase/
│   └── migrations/         # Every schema change, in order
├── 01_Preparation/         # Default templates (seed source)
├── 02_Projects/            # Past studio projects (reference only)
├── 03_Feedback/
└── 04_AI_workspace/
```

## Copy and paste output

There's no export step. Each tool shows its result in a form that pastes cleanly:

- **Proposal draft:** formatted text with headings and lists. Select it and paste into Word; headings and bullets carry over.
- **Fee schedule and project schedule:** an HTML table. Paste it into Excel and each cell lands in its own cell.
- Each result gets a **Copy** button that copies the whole block, so nothing is missed when selecting by hand.

## Build plan

Each phase is one pull request, tested before the next phase starts.

### Phase 0: Finish what is open
- Merge PR #3 (clear message when a sign-in link has expired).
- Merge PR #4 (this schematic).

### Phase 1: Reachable by other users
1. **Hosting:** publish the site at a public URL (see open item A).
2. **Supabase Auth settings** (dashboard, done by you):
   - Site URL = the public URL.
   - Redirect URLs = the public URL and `http://localhost:3000/**` for local work.
   - Sign-ups enabled.
3. **Email delivery:** set up a custom SMTP provider in Supabase (see open item B). Supabase's built-in sender is rate-limited and is meant for testing only, so it isn't reliable for magic links to other people's addresses.

Check: someone outside the studio can request a link, receive it, and sign in.

### Phase 2: Per-user data
1. Migration `supabase/migrations/…_multi_user.sql`:
   - Add `owner_id` to the five tables.
   - Drop the `owner full access` email policies and create the `owner_id` policies in the same migration, so there is no gap.
   - Create `schedule_tasks`, `templates`, and `default_templates`, with RLS.
2. `assets/shared.js`:
   - Remove `OWNER_EMAIL` and the email check.
   - Leave the email field empty.
   - Show the signed-in email and a Sign out button on every page.
3. `tools/intake.html`: no change needed. `owner_id` fills itself from the signed-in user.

Check, with two test accounts:
- A cannot see B's projects or answers.
- A cannot change B's rows.
- A signed-out page reads nothing.

### Phase 3: Templates
1. `scripts/build-template-seed.mjs` and the seed migration for `default_templates`.
2. Sign-up trigger and one-time backfill.
3. `tools/templates.html`: list my templates by kind, edit and save, "Reset to default".

Check:
- A new account has all defaults.
- One user's edits don't touch another's.
- Reset restores the default.

### Phase 4: Fee schedule (tool 2)
- Pick a project, start from my `fee` template for the project's archetype, and edit milestones (label, percent, amount, trigger).
- Totals and percentage checks (percentages add up to 100).
- Show the result as a table with a Copy button for Excel.

### Phase 5: Project schedule (tool 3)
- Start from my `schedule` template, then edit phases, tasks, and durations in `schedule_tasks`.
- Show the result as a table (with a simple week bar) and a Copy button.

### Phase 6: Proposal draft (tool 4)
- Combine the intake answers, fee schedule, schedule, and my proposal template for the archetype.
- Fill in `[Choice A][Choice B]` options: the user picks one per option.
- Save each version in `proposals`.
- Show formatted text with a Copy button for Word.
- How the text is written depends on open item C.

### Phase 7: Lessons learned (tool 5)
- Log observations per project or overall.
- List and filter my lessons.
- Later: use them to suggest fee and schedule adjustments.

## Security notes

- The publishable key in `assets/shared.js` is public by design. RLS is the only protection, so every table needs RLS and the `owner_id` policy before other users sign up.
- `default_templates` is read-only for users. Only migrations write to it.
- The sign-up trigger function runs with elevated rights. Keep it to the template copy and nothing else.

## Open items

- **A. Hosting.** Where should the public site live?
  - GitHub Pages: free if the repo is public.
  - Netlify or Vercel: free tiers; work with a private repo.
  - Recommendation: Netlify or Vercel, unless you're happy making the repo public.
- **B. Email sender.** Custom SMTP needs an account with an email provider (for example Resend, Postmark, or your domain's mail service) and ideally a sending address on the studio's domain. Which do you have or prefer?
- **C. Proposal writing.** How should tool 4 produce the text?
  - Template fill: no AI; the user picks the options.
  - AI draft with Claude, through a Supabase Edge Function. This needs an Anthropic API key and has a per-use cost.
  - Recommendation: template fill first, then add AI drafting once the rest works.
- **D. Default content.** The repo templates are written for S+Y Studio (name, fees, wording). New users would start with S+Y's text and edit it. Is that acceptable, or should there be a generic default set?
