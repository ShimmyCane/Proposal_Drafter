# S+Y Studio Proposal Drafter — File Tree Manifest & Operational Index

This document is the internal reference guide for AI agents and automation tools operating within this repository. It defines the purpose of each file and directory, input/output relationships, and operational rules.

---

## 1. Directory Tree & Roles

```
Proposal_Drafter/
├── Plan_v1.md                          # Master project roadmap and philosophy (Step A -> Step B -> Step C -> Step D)
├── schematic.md                        # Studio architecture overview and versioning tracker
├── Skills.md                           # AI skill definitions and operational protocols
├── todo.md                             # Active tracking tasks
├── anonymize_proposals.py              # Utility script to sanitize past client names/addresses in precedent files
│
├── 00_S+Y profile/
│   └── studio identity.md             # Core S+Y principles, tone, revision philosophy (2 rounds), and billing posture
│
├── 01_Preparation/                     # Knowledge base, templates, and baseline drafting tools
│   ├── architectural tasks.md          # Comprehensive library of subtasks, standard deliverables, and exclusions
│   ├── proposal consideration.md       # Project intake checklist and scope decision logic
│   ├── proposal_flowchart_template.html# Visual/interactive flowchart for project scoping
│   ├── Past Proposals/
│   │   └── 260723_Combined Proposals.htm # Anonymized past proposal examples for precedent and phrasing
│   ├── Proposal Framework/
│   │   ├── S+Y_Studio_Proposal_Framework.md # Comprehensive proposal structure guide and drafting notes
│   │   └── proposal_template.json     # JSON representation of proposal sections
│   └── Templates/
│       ├── fee_schedule_data.json      # Structured fee data (rates, subtask hours, phase breakdowns)
│       ├── fee_schedule_template_2026.html # Interactive HTML fee calculator with export capabilities
│       ├── project_schedule_template.md # Standard milestone and phase duration schedule
│       ├── S+Y_Studio_Proposal_Template.html # Interactive HTML proposal drafter
│       ├── Code Analysis/              # Reusable code analysis templates (HTML, JSON, MD)
│       └── Proposal_Templates/         # 5 Core Project Archetype Templates (Markdown with [Options])
│           ├── 01_permit_led_builder_set.md
│           ├── 02_full_architectural_design.md
│           ├── 03_tenant_improvement_remodel.md
│           ├── 04_planning_entitlement_support.md
│           └── 05_asbuilt_feasibility_code.md
│
├── 02_Projects/                        # Active and archived project folders
│   └── <Project_Name>/                 # Dedicated folder per project (e.g., Gardena)
│       ├── 01_Intake/                  # RFQ/RFP text, client emails, reference drawings, PDF examples
│       ├── 02_Drafts/                  # Working proposal drafts (.md, .docx), fee estimates (.xlsx, .json), schedules
│       └── 03_Final/                   # Signed/final proposals, executed agreements, export PDFs
│
├── 03_Feedback/                        # Human-readable lessons learned and process improvement hub
│   ├── lessons_learned_summary.md      # Studio-level insights (scope traps, fee calibrations, exclusions)
│   ├── template_refinements.md         # Audit log connecting project lessons to specific template updates
│   └── project_postmortems/            # Per-project post-mortems (e.g., Gardena_Postmortem.md)
│
└── 04_AI_workspace/                    # Internal AI state, versioning logs, agent instructions, and stubs
    ├── file_tree_manifest.md           # This document (AI operational manifest)
    ├── ai_wrap_up.md                   # Wrap-up logs and milestone state summaries
    ├── schematic.md                    # Technical AI workspace architecture
    ├── schematic_view.html             # Visual diagram of AI workspace
    ├── agents/                         # Agent persona and instruction guidelines
    ├── instructions/                   # Step-by-step workflow SOPs (Intake, Preparation, Feedback)
    ├── lessons_learned/                # Working AI lessons learned logs (mirrored to 03_Feedback)
    ├── notes/                          # AI working notes and component breakdowns
    ├── skills/                         # Skill UI views
    └── versions/                       # Version audit trail (V1.0.1, V1.02, version_log.md)
```

---

## 2. Operational Rules for AI

1. **Intake & Path Detection**:
   - Never assume a full architectural design scope by default.
   - When a new project arrives, always execute the 20-question intake questionnaire (or extract answers from provided RFQ materials) to select the correct archetype template from `01_Preparation/Templates/Proposal_Templates/`.

2. **Drafting Format Priority**:
   - Draft first in Markdown (`.md`) inside the project's `02_Drafts/` folder using `[Choice A][Choice B]` bracket options.
   - User reviews, selects options, and copies/exports to Word (`.docx`) or PDF.

3. **Pricing & Fee Consistency**:
   - Ground all fees in milestone structures (Deposit, Planning/Submittal, Plan Check, RTI) rather than broad ranges.
   - Verify hours and rates against `01_Preparation/Templates/fee_schedule_data.json` ($150–$175/hr standard S+Y rate).

4. **Preserving Exclusions**:
   - Explicitly list exclusions (Structural, MEP, Civil, Landscape, Survey/Soils, Fire Sprinklers as deferred submittal, Full CA, Plotting reimbursement) in all builder-set and limited-service proposals.

