# Claude — Observation Folder

This folder holds the AI assistant's review notes for the Proposal Drafter repository. Each review gets its own dated observations file. Use it to keep:

- findings from file reviews, with the file and line where they apply
- decisions the user still needs to make
- what was changed during a review and what was deliberately left alone

## Files

| File | Purpose |
| :--- | :--- |
| `observations_2026-10-23.md` | Full review of all tracked files (V1.03). Numbered findings referenced from `todo.md`. |

## Ground rules

- `Plan_v1.md` is not edited by the AI (its own rule). Suggested changes go here or in `todo.md`.
- Studio-authored content (`00_S+Y profile/`, `01_Preparation/`) is verified and flagged here, not rewritten.
- Binary files (PDF, DOCX, XLSX, MPP) are noted by type and size; contents are only sampled.
- Changes stay uncommitted until the user approves a commit.
