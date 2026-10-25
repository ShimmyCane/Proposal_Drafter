# TODO — S+Y Studio Proposal Drafter

## V1.03 — Review and Cleanup (completed 2026-10-23)

- [x] Full review of repository files; findings in `Claude/observations_2026-10-23.md`
- [x] Created `Claude/` observation folder
- [x] Delinked absolute Windows `file:///` links (`Skills.md`, `03_Feedback/lessons_learned_summary.md`) and replaced Windows paths in `ai_wrap_up.md`
- [x] Refreshed AI workspace schematic, root schematic, file tree manifest, and version log
- [x] Refreshed stale status fields (preparation guide, feedback process, proposal components, template versions)
- [x] Corrected the Box-clause claim in `03_Feedback/template_refinements.md`
- [x] Deleted empty local `Proposal-Helper` clone (GitHub repo still exists)

## V1.04 — Next Increment

### Time-sensitive
- [ ] Test `ai_new_draft_proposal` end-to-end on the new test project (user is addressing this about 12 hours after 2026-10-23). Check intake → archetype → `proposal_draft_v1.md` → `fee_estimate.md`, and compare the result against `01_permit_led_builder_set.md`.

### Decisions needed from user
- [ ] Choose one milestone percentage standard and apply it to `03_Feedback/lessons_learned_summary.md` §1B, `instructions/new_project_workflow.md` Step 3, and `skills/ai_new_draft_proposal.md` Q18–19 (observation 1).
- [ ] Decide how to handle client details in Gardena files: names, email, and phone in `RFQ text.txt`, and names in the post-mortem (observation 2).
- [ ] Decide the version numbering scheme (V1.0.x vs V1.0x) and whether to reconcile the 2026-07-23 rows in `version_log.md` (observation 4).
- [ ] Decide whether `version_control/skills_history.md` should be rewritten. It references `/learn` and 2023 examples that don't match the current skills (observation 6).
- [ ] Decide whether `Plan_v1.md` tracking line (V1.02) should be updated. The AI is not permitted to edit it (observation 8).

### Repository fixes
- [ ] Replace or remove the placeholder stubs in `02_Projects/Gardena/RFP/` (`proposal.docx`, `fee schedule.xlsx`, `project schedule.mpp`). The real draft is in `Human/` (observation 3).
- [ ] Fill the `XXXX sf` lot size placeholder in the Gardena drafts once the user confirms the value (observation 5).
- [ ] Retitle `04_AI_workspace/skills/skills.html` to "AI Skills Index" and confirm `02_Projects/Gardena/RFP/gardena_fee_schedule.htm` is filled in and not the blank template.
- [ ] Add the 30-day validity clause to `04_Planning` and `05_AsBuilt` templates, or confirm they should not have one (observation 7).
- [ ] Create `anonymize_proposals.py` if it is still wanted, or remove it from any references (already removed from the manifest).

### Build work
- [ ] Build the HTML/JSON `[choice]` export (Step A deliverable).
- [ ] Implement `agents/preparation_agent.md` and `agents/feedback_analyzer_agent.md` (both marked "Not yet implemented").
- [ ] Gather Step C data: staffing and calendar availability, and actual task hours from Gardena to calibrate time estimates.

### Git
- [ ] Review the uncommitted V1.03 changes and, when approved, commit them and open a draft PR.
