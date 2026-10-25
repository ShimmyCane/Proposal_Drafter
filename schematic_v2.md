# Proposal Drafter Schematic

Schematic version: V2.00 (draft for review)

Supersedes the V1.02 system map for the web tools. The folder map in `schematic.md` still describes the repository; this file describes how the web app works and who owns what.

## What changes from V1

| Area | V1 (today) | V2 (proposed) |
| --- | --- | --- |
| Who can sign in | One email (`OWNER_EMAIL` in `assets/shared.js`) | Any email with a magic link. Each person gets their own account. |
| Who can read data | RLS policies check for the owner's email | RLS policies check `owner_id = auth.uid()` on every table |
| Templates | Live only in the repo (`01_Preparation/`) | Seeded from the repo into each user's account on first sign-in, then editable per user |
| Projects, answers, fees, lessons | Single owner | Owned by the user who created them |
| Output | Shown in the browser only | Exportable as text files (Markdown, CSV, JSON) for Word, Excel, and VS Code |

Scale target: about 10 users. Keep the design simple. Revisit if the user count grows.

## Users and access

- **Sign-in:** magic link to any email address. No allowlist for now.
- **Account creation:** automatic on first successful sign-in (Supabase creates the user).
- **Isolation:** a user sees only rows where `owner_id` matches their own user ID. No sharing between users in V2.
- **Admin:** the repo owner has no special access in V2. If an admin view is needed later, add a role claim, not an email check.

Open decision: should sign-up stay open, or should the Supabase project be switched to invite-only once the first 10 users are in? Recommendation: keep it open until the 10 users are in, then close signups in the Supabase Auth settings.

## Data model (Supabase, public schema)

Every user-owned table gets an `owner_id uuid references auth.users(id) default auth.uid()` column. RLS on each table: `owner_id = auth.uid()` for select, insert, update, and delete.

| Table | Status | V2 change |
| --- | --- | --- |
| `projects` | Exists, 0 rows | Add `owner_id`. Replace the email policy with the `owner_id` policy. |
| `intake_answers` | Exists, 0 rows | Add `owner_id`. Same policy change. |
| `proposals` | Exists, 0 rows | Add `owner_id`. Same policy change. |
| `fee_milestones` | Exists, 0 rows | Add `owner_id`. Same policy change. |
| `lessons_learned` | Exists, 0 rows | Add `owner_id`. Same policy change. |
| `templates` | New | `id`, `owner_id`, `kind` (`proposal`, `fee`, `schedule`, `intake`), `archetype`, `name`, `body` (text or JSON), `source_path` (repo path it was seeded from, nullable), `created_at`, `updated_at` |

Because all five tables are empty, the migration is low risk: add the column, change the policy, no data move.

Tables keep their existing columns and checks. Only ownership is added.

## Templates: repo to account

- The repo stays the source of default templates (`01_Preparation/Proposal Framework/` and `01_Preparation/Templates/`).
- On a user's first sign-in, the app copies the default templates into their `templates` rows (one-time seed, marked by `source_path`).
- After seeding, each user edits their own copies. Editing a user's copy never changes the repo or other users' copies.
- To refresh defaults later, add a "Reset to default" action per template. Do not auto-overwrite.

## Repository structure

The repo holds code and default content. User data never goes into the repo.

```
Proposal_Drafter/
├── index.html              # Home page; lists the tools
├── assets/
│   ├── shared.js           # Supabase client, sign-in gate (no email check in V2), esc()
│   └── shared.css
├── tools/
│   ├── intake.html         # 1. Project intake (done)
│   ├── fee.html            # 2. Fee schedule (next)
│   ├── schedule.html       # 3. Project schedule
│   ├── proposal.html       # 4. Proposal draft
│   └── lessons.html        # 5. Lessons learned
├── supabase/
│   └── migrations/         # SQL for V2 (owner_id, RLS, templates table)
├── 01_Preparation/         # Default templates and framework (seed source)
├── 02_Projects/            # Example projects from the studio's past work (reference only)
├── 03_Feedback/
└── 04_AI_workspace/
```

Notes:
- Add `supabase/migrations/` so schema changes are versioned in git.
- `02_Projects/` stays as reference material. New projects live in the database, not in these folders.

## Workflow in the app

1. Sign in with email → account created, default templates seeded.
2. Intake (20 questions) → creates a `projects` row with `owner_id`.
3. Fee schedule → rows in `fee_milestones` for that project.
4. Project schedule → stored with the project.
5. Proposal draft → `proposals` rows, one per version.
6. Lessons learned → `lessons_learned` rows, optionally linked to a project.

Every step writes to the database and shows what is saved.

## Getting the output into Word, Excel, and VS Code

The web app cannot write into the repo folder on your computer, so the workflow is export and open:

- **Each tool has an Export button** that downloads:
  - Proposal draft → `.md` (opens in VS Code side by side, and pastes into Word cleanly)
  - Fee schedule → `.csv` (opens directly in Excel)
  - Schedule and lessons → `.csv` or `.md`
  - Whole project → `.json` (backup and re-import later)
- **Suggested local folder:** `02_Projects/<project name>/` in your repo clone. Save downloads there, then open them in VS Code next to the app.

Open question: is that enough, or do you want the app to save the export directly into a chosen local folder (browser folder access)? Recommendation: start with downloads. It works in every browser and needs no extra permissions.

## Security notes

- The publishable key in `assets/shared.js` is public by design. RLS is the only protection, so every table must have RLS enabled and the `owner_id` policy before V2 goes live.
- Before inviting users, test with two accounts: user A must not see user B's projects, answers, templates, or exports.
- The current email-based policies must be dropped in the same migration that adds the `owner_id` policies, so there is no gap.

## Next steps (proposed order)

1. Review this schematic and answer the open decisions below.
2. Migration: add `owner_id` to the five tables, add `templates`, replace the policies. Commit under `supabase/migrations/`.
3. Update `assets/shared.js`: remove `OWNER_EMAIL`; `requireSignIn` accepts any signed-in user.
4. Add first-sign-in template seeding.
5. Test with two accounts (isolation check above).
6. Build the Export buttons, starting with intake and the fee schedule.
7. Continue with tools 2–5.

## Open decisions

1. **Sign-up:** open to anyone for now, or invite-only from the start?
2. **Export:** downloads only, or save into a chosen local folder?
3. **Templates:** should users be able to add brand-new templates, or only edit the seeded ones in V2?
4. **Shared data:** is there any need for two users to share a project in V2? (Default: no.)
