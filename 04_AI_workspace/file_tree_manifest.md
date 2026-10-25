# S+Y Studio Proposal Drafter — File Tree Manifest & Operational Index

This document is the internal reference guide for AI agents and automation tools operating within this repository. It defines the purpose of each file and directory, input/output relationships, and operational rules. Last updated: V1.03 (2026-10-23).

---

## 1. Directory Tree & Roles

```
Proposal_Drafter/
├── Claude/                             # AI observation log for repository reviews (start with README.md)
├── Plan_v1.md                          # Master roadmap (AI must not edit it; see its own rules)
├── schematic.md                        # Studio architecture overview and version tracker
├── Skills.md                           # Index of AI skills (details in 04_AI_workspace/skills/)
├── todo.md                             # Active tasks and next increment
├── Proposal_Drafter.code-workspace     # VS Code workspace file
│
├── 00_S+Y profile/
│   └── studio identity.md              # Studio principles, tone, revision policy, billing posture
│
├── 01_Preparation/                     # Knowledge base, templates, and drafting tools
│   ├── architectural tasks.md          # Library of subtasks, deliverables, and exclusions
│   ├── proposal consideration.md       # Project intake checklist and scope logic
│   ├── proposal_flowchart_template.html
│   ├── Past Proposals/
│   │   └── 260723_Combined Proposals.htm   # Past proposal examples (precedent and phrasing)
│   ├── Proposal Framework/
│   │   ├── S+Y_Studio_Proposal_Framework.md
│   │   └── proposal_template.json
│   └── Templates/
│       ├── fee_schedule_data.json
│       ├── fee_schedule_template_2026.html
│       ├── project_schedule_template.md
│       ├── S+Y_Studio_Proposal_Template.html
│       ├── Code Analysis/              # code_analysis_template (HTML, JSON, MD)
│       └── Proposal_Templates/         # Five archetype templates with [Choice] options
│           ├── 01_permit_led_builder_set.md
│           ├── 02_full_architectural_design.md
│           ├── 03_tenant_improvement_remodel.md
│           ├── 04_planning_entitlement_support.md
│           └── 05_asbuilt_feasibility_code.md
│
├── 02_Projects/
│   └── Gardena/                        # Example active project (layout predates the standard below)
│       ├── Example Duplex.pdf          # Reference project (not the subject project)
│       ├── RFQ text.txt                # Client RFQ text (contains client contact details)
│       ├── Human/                      # Human-written drafts sent to client (docx, pdf)
│       ├── RFP/                        # Proposal HTML, code analysis, fee estimate JSON; stub files (see todo)
│       └── AI_workspace/plan.md        # Project-level AI notes
│
├── 03_Feedback/
│   ├── lessons_learned_summary.md      # Studio-level rules, fee ranges, exclusions
│   ├── template_refinements.md         # Audit log: lessons → template changes
│   ├── 260829_Gardena/                 # Client-final proposal text
│   └── project_postmortems/
│       └── Gardena_Postmortem.md
│
└── 04_AI_workspace/                    # AI state, logs, agent instructions, skill definitions
    ├── file_tree_manifest.md           # This document
    ├── ai_wrap_up.md                   # Wrap-up log (2026-08-18)
    ├── schematic.md                    # AI workspace architecture
    ├── schematic_view.html             # Visual diagram
    ├── agents/                         # Agent role definitions
    ├── instructions/                   # Step-by-step SOPs (intake, preparation, feedback)
    ├── lessons_learned/                # AI-side lessons (mirrored to 03_Feedback)
    ├── notes/                          # Project requirements and proposal components
    ├── skills/                         # Skill definitions and skills.html view
    ├── version_control/
    │   └── skills_history.md           # Skill change history
    └── versions/                       # Release entries (V1.0.1, V1.02, V1.03) and version_log.md
```

---

## 2. Operational Rules for AI

1. **Intake & Path Detection**
   - Never assume a full architectural design scope by default.
   - For a new project, run the 20-question intake (or extract answers from RFQ materials) and select an archetype from `01_Preparation/Templates/Proposal_Templates/`.

2. **Project Folder Layout**
   - Standard layout for new projects: `02_Projects/<Project_Name>/` with `01_Intake/`, `02_Drafts/`, `03_Final/`, as set by the `new_project` skill.
   - Gardena predates this layout and uses `Human/`, `RFP/`, and `AI_workspace/`. Do not move its files without asking.

3. **Drafting Format Priority**
   - Draft first in Markdown (`.md`) with `[Choice A][Choice B]` options.
   - The user reviews, selects options, and exports to Word (`.docx`) or PDF.

4. **Pricing & Fee Consistency**
   - Ground fees in milestone structures (Deposit, Planning/Submittal, Plan Check, RTI).
   - Verify hours and rates against `01_Preparation/Templates/fee_schedule_data.json` ($150–$175/hr add-on rate).
   - Milestone percentage ranges differ between documents. See `Claude/observations_2026-10-23.md` (item 1) before quoting a range.

5. **Preserving Exclusions**
   - List exclusions (Structural, MEP, Civil, Landscape, Survey/Soils, Fire Sprinklers as deferred submittal, Full CA, Plotting reimbursement) in builder-set and limited-service proposals.

---

## 3. Known Gaps (2026-10-23)

- `anonymize_proposals.py` was referenced in earlier versions but is not in the repository.
- `04_AI_workspace/schematic.md` previously pointed to `version_control/version_log.md`. The log is `versions/version_log.md`.
- `skills/skills.html` carries the title "AI Workspace Schematic". It should be "AI Skills Index".
- `02_Projects/Gardena/RFP/` holds stub files (`proposal.docx`, `fee schedule.xlsx`, `project schedule.mpp`) that are plain text, not Office files.
