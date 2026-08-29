# New Project Proposal Workflow SOP

This Standard Operating Procedure (SOP) governs how new project proposals are drafted from initial intake through final sign-off.

---

## Step 1: Project Setup & Intake
1. Create a dedicated project directory: `02_Projects/<Project_Name>/` with subfolders:
   - `01_Intake/` (client emails, RFP text, drawings, zoning notes)
   - `02_Drafts/` (working proposal drafts, fee schedules, notes)
   - `03_Final/` (final client-facing documents)
2. Run the **20-Question Intake Questionnaire** (defined in `Skills.md`). If intake documents are already present, auto-populate known fields and present remaining questions for user confirmation.

---

## Step 2: Archetype Selection & Template Matching
Select the appropriate archetype template from `01_Preparation/Templates/Proposal_Templates/`:
- **01_permit_led_builder_set.md**: Multi-unit subdivisions, builder's permit sets, mirrored floor plans, plan check focus.
- **02_full_architectural_design.md**: Custom residential/commercial, schematic design through CA.
- **03_tenant_improvement_remodel.md**: Interior commercial/residential TI, field measure, ADA/CBC Title 24 compliance.
- **04_planning_entitlement_support.md**: Zoning feasibility, site plan reviews, vesting tract maps, CUP/variances.
- **05_asbuilt_feasibility_code.md**: Field verification, CAD/BIM modeling, code analysis memos.

---

## Step 3: Fee & Schedule Formulation
1. Align fee milestones with project phases:
   - Deposit / Retainer (5%–15%)
   - Planning / Conceptual Sign-off (20%–30%)
   - Plan Check Submittal (35%–50%)
   - RTI Permit Ready (15%–25%)
2. Embed the standard project timeline assumptions from `01_Preparation/Templates/project_schedule_template.md`.

---

## Step 4: Markdown Proposal Draft Generation
1. Write the initial proposal to `02_Projects/<Project_Name>/02_Drafts/proposal_draft_v1.md`.
2. Format customizable choices using `[Choice A][Choice B]` bracket notation.
3. Verify that all standard studio exclusions and terms are present.

---

## Step 5: Interactive Co-Editing & Final Export
1. Review the draft with the user to select preferred bracket options and fine-tune fee milestones.
2. User copies Markdown text or converts to `.docx` / `.pdf` for client delivery.
3. Save final signed/delivered proposal in `02_Projects/<Project_Name>/03_Final/`.
