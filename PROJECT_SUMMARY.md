# Proposal Drafter: Project Summary

Status as of 2026-10-26. This summarizes the work so far and the decisions behind it.

## Purpose

A website that helps a small architecture studio build its own proposals. The studio's logic stays in its own hands. The site gives structure and checklists, and it labels clearly anywhere AI is involved. The website itself never calls an AI model.

## Who uses it

About 10 people. Each person has their own account, sign-in by email and password, and sees only their own projects, templates and uploaded past proposals.

## What exists today

| Area | State |
| --- | --- |
| Sign-in (magic link) | Working on the current site. A clear message now shows when a link has expired (PR #3). |
| Project intake (20 questions) | Built on the current site. Saves to the database. Questions are fixed; the goal is per-user questions. |
| Database (Supabase) | Five tables, empty, locked to one owner email. |
| V2 migration files | Written and committed (`supabase/migrations/`). **Not applied** to the database. The apply step timed out waiting for a confirmation. |
| Fee, schedule, proposal, lessons tools | Not built. |
| Repo | Private. Holds client documents (Gardena RFP/RFQ, proposals, fee files), studio profile, and personal contact details in the proposal templates. |

## Decisions

1. **Login:** email and password. The studio owner creates each user's account, through the Supabase dashboard or the `admin.create_user` SQL helper. Sign-up through the site is off. No email is sent for sign-in.
2. **Per-user data:** every table gets an `owner_id`. Row-level security limits each user to their own rows. Projects that hang off other rows must also belong to the same user.
3. **Templates:** each account starts empty. The repo's templates are shown as generic guides, with no studio names, fees or wording. Users build their own project types, intake questions, task library, and fee, schedule and proposal templates.
4. **Copy and paste, no export:** each tool shows its output ready to paste. Tables paste into Excel. Formatted text pastes into Word. A Copy button sits beside each output.
5. **AI, clearly labelled:**
   - Any guide drafted by AI says so.
   - Any template started from a guide or AI suggestion shows a warning until the user marks it reviewed.
   - AI review of uploaded past proposals runs in a Claude Code session, and only for users who opt in on their account page.
   - Its output lands as a separate suggestion. The user can copy it in or dismiss it. It never changes their templates on its own.
6. **Hosting:** GitHub Pages is enough, because the site is plain HTML talking to Supabase.
7. **Public repo:** making the current repo public would expose client documents and personal details, including old versions in git history. The plan is a clean, new public repo holding only the website code and generic guides. The current repo stays private.

## Open items

- Apply the V2 migration to the database (needs a confirmation in the Supabase connector).
- Turn off public sign-up in the Supabase Auth settings.
- Set the Supabase Auth Site URL and redirect URLs for the GitHub Pages address.
- Decide the name of the new public repo.
- Write the generic guides (drafted by AI, labelled as such).
- Build fee, schedule, proposal and lessons tools.

## Files in this repo

- `index.html`, `tools/intake.html`: the current site.
- `assets/shared.js`, `assets/shared.css`: sign-in and shared styles. `shared.js` still has the single-owner email check; V2 removes it.
- `supabase/migrations/`: V2 database changes (not applied yet) and admin helpers.
- `schematic.md`: V1 repo map. `schematic_v2.md`: V2 design and build plan.
- `Plan_v1.md`, `todo.md`, `Skills.md`, `Proposal_Drafter.code-workspace`: earlier planning files.
- `01_Preparation/`, `02_Projects/`, `03_Feedback/`, `04_AI_workspace/`, `00_S+Y profile/`: studio reference material. Keep this private.
