# Observations — Repository Review (2026-10-23, V1.03)

Scope: all 68 tracked files. Markdown and HTML were read or checked for titles and links. JSON was validated. Office and PDF files were checked for type and sampled for first-page text. Nothing was committed.

---

## A. Needs a decision from the user

### 1. Milestone percentage ranges disagree across four documents
| Source | Deposit | Planning / Site Plan | Plan Check | RTI |
| :--- | :--- | :--- | :--- | :--- |
| `03_Feedback/lessons_learned_summary.md` §1B | 5–15% | 20–25% | 40–50% | 20–25% |
| `04_AI_workspace/instructions/new_project_workflow.md` Step 3 | 5–15% | 20–30% | 35–50% | 15–25% |
| `04_AI_workspace/skills/ai_new_draft_proposal.md` Q18–19 | 5–15% | (not stated) | (not stated) | (not stated) |
| Gardena actual ($65k fixed; `03_Feedback/project_postmortems/Gardena_Postmortem.md`) | ~8% ($5k) | ~23% ($15k) | ~46% ($30k) | ~23% ($15k) |

The Gardena actuals fall inside the lessons-learned ranges, so that document looks like the right anchor. **Decision:** which ranges become the standard?

### 2. Client personal data in project files
- `02_Projects/Gardena/RFQ text.txt` includes the client contact's phone number and the sender's first name.
- The Gardena post-mortem and the Gardena drafts name the client and their company.
- `01_Preparation/Past Proposals/` is labeled anonymized, but the Gardena files are not.

**Decision:** anonymize the Gardena files, or keep them as they are? I changed nothing here.

### 3. Placeholder files in `02_Projects/Gardena/RFP/`
- `proposal.docx`, `fee schedule.xlsx`, and `project schedule.mpp` are plain-text stubs. They are not Office files. Each says "Replace with…".
- The real draft is `02_Projects/Gardena/Human/260825_Gardena Duplexes Proposal.docx` (a valid Word file) and its PDF.
- **Decision:** replace the stubs with real files, or delete them?

### 4. Version numbering is inconsistent
- `versions/` uses `V1.0.1` (2026-08-18) and `V1.02` (2026-08-29).
- `versions/version_log.md` also lists `V1.0.2` and `V1.0.3` dated 2026-07-23, which predates both.
- `Plan_v1.md` tracks `V1.02`.
- I used `V1.03` as the next increment. **Decision:** choose a scheme and whether the July rows are real.

### 5. `XXXX` placeholders remain in the Gardena drafts
- The lot size is still `XXXX sf` in the Human draft and in the post-mortem's source text.
- `RFP/proposal.html` says "Replace placeholders before final submission."
- **Decision:** provide the lot size or confirm the placeholder stays.

### 6. `version_control/skills_history.md` looks carried over from another project
- It documents `/learn`, `/new_project`, and `/refine` as versions 1.0–1.2. `/learn` is not a current skill.
- Its example entry is dated 2023.
- **Decision:** rewrite it for the current skills, or delete it?

### 7. Validity and Box clauses are not consistent across the archetype templates
- The Box document-sharing clause is only in `01_permit_led_builder_set.md`. `03_Feedback/template_refinements.md` said it was in all five. I added a correction there.
- The 30-day validity clause is in `01` and `02`. `03` has a short note. `04` and `05` have no validity clause.
- **Decision:** should all five carry the same standard clauses?

### 8. `Plan_v1.md` is out of date, and the AI must not edit it
- Its tracking line says `V1.02 - update 8/29/26`.
- Its own rules say the AI reads it but does not change it. I followed that.
- **Decision:** update it yourself, or lift the restriction?

---

## B. Fixed in this review

| # | File | Issue | Fix |
| :--- | :--- | :--- | :--- |
| 9 | `Skills.md` (9 links), `03_Feedback/lessons_learned_summary.md` (3 links) | Absolute `file:///c:/Users/shiju/...` links that break outside the original machine | Replaced with repo-relative paths |
| 10 | `04_AI_workspace/ai_wrap_up.md` | Windows `c:\...` paths in the change list | Replaced with repo-relative paths |
| 11 | `04_AI_workspace/schematic.md` | Tree pointed to `version_control/version_log.md`, which doesn't exist; no version line; missing skill definitions | Rewritten to match actual files; version set to V1.03 |
| 12 | `04_AI_workspace/file_tree_manifest.md` | Referenced `anonymize_proposals.py` (not in the repo); tree did not match the actual Gardena layout; `Templates/Templates` typo | Rewritten; missing script listed under known gaps |
| 13 | `schematic.md` (root) | Version V1.02; no mention of `Claude/` | Version V1.03; V1.03 update section added |
| 14 | `04_AI_workspace/instructions/preparation_guide.md` | Status "Not yet started" although templates exist | Status "In progress" with done and open items |
| 15 | `04_AI_workspace/instructions/feedback_process.md` | Status "Pending" although a post-mortem exists | Status "Started" with done and open items |
| 16 | `04_AI_workspace/notes/proposal_components.md`, `versions/template_versions.md` | "To be populated" placeholders | Populated with current state; template version table added |
| 17 | `03_Feedback/project_postmortems/Gardena_Postmortem.md` | `$\rightarrow$` (LaTeX) does not render in Markdown | Replaced with `→` |
| 18 | `03_Feedback/template_refinements.md` | Box-clause claim was wrong | Correction note added; original line kept |
| 19 | `versions/version_log.md`, `versions/V1.03.md` | No entry for this review | V1.03 row and release file added |

---

## C. Still open (not changed)

- **`04_AI_workspace/skills/skills.html`** has the title "AI Workspace Schematic", the same as `schematic_view.html`. It should be "AI Skills Index." I did not edit the HTML this pass.
- **`02_Projects/Gardena/RFP/gardena_fee_schedule.htm`** is titled as the generic 2026 fee template. I did not confirm whether it has Gardena values.
- **`02_Projects/Gardena/RFP/Fee Estimate 1.json`** is valid JSON. I did not check its values against the fee schedule.
- **`04_AI_workspace/agents/*.md`**: two agents are "Not yet implemented". Status left as is.
- **`04_AI_workspace/lessons_learned/staffing_insights.md`, `time_estimates.md`**: awaiting data. Status left as is.
- **`04_AI_workspace/instructions/new_project_workflow.md`** expects `02_Drafts/` files. The Gardena project has none of them. Future projects should follow it; Gardena predates it.
- **Binary files**: PDFs and the Human DOCX were sampled only. The `Past Proposals` HTM (168 KB) was not read in full. Its anonymization was not verified.

---

## D. Verified OK

- All JSON files parse: `fee_schedule_data.json`, `proposal_template.json`, `code_analysis_template.json`, `Fee Estimate 1.json`.
- `Proposal_Drafter.code-workspace` is valid.
- No `file:///` or Windows links remain in the repository after the fixes in section B.
- Templates contain bracketed `[Choice]` and `[XXXX]` options as the AI workspace expects.
- The five archetype templates match the list in `file_tree_manifest.md`, `new_project_workflow.md`, and the agent definitions.
- Studio exclusions (structural, MEP, civil, landscape, soils, fire sprinklers deferred, full CA, plotting) are consistent across the templates, `lessons_learned_summary.md`, and `file_tree_manifest.md`.
- The hourly rate ($150–$175, $150 in Gardena) and the 2-round revision default are consistent across `studio identity.md`, the agent definitions, and the lessons summary.

---

## E. Session notes

- `Proposal-Helper` was deleted locally. Its GitHub repo still exists and must be removed in GitHub settings.
- All changes are uncommitted in the working tree.
