# Skill: `ai_new_draft_proposal`

## Purpose
Initiate an interactive or automated project intake, conduct the 20-question scoping interview, select the appropriate archetype template, calculate milestone fees, and produce a clean Markdown proposal draft with `[Choice A][Choice B]` bracket options.

---

## Inputs
- `projectName` (string; e.g. "Gardena Duplexes")
- `clientRfPath` (optional; path to client email, RFQ, or brief in `02_Projects/<Project_Name>/01_Intake/`)
- `projectArchetype` (optional: `"01_permit_led"` | `"02_full_design"` | `"03_tenant_improvement"` | `"04_planning_entitlement"` | `"05_asbuilt_feasibility"`)
- `autoPopulate` (boolean; default: false — if true, auto-infers answers from provided intake documents)

---

## Outputs
- Project directory structure under `02_Projects/<Project_Name>/` (`01_Intake`, `02_Drafts`, `03_Final`)
- Intake summary notes: `02_Projects/<Project_Name>/02_Drafts/intake_summary.md`
- Populated Markdown proposal: `02_Projects/<Project_Name>/02_Drafts/proposal_draft_v1.md`
- Estimated fee schedule: `02_Projects/<Project_Name>/02_Drafts/fee_estimate.md`

---

## 20-Question Intake Questionnaire

### Section 1: Client & Project Basics
1. Who is the Client / Owner entity and primary contact person?
2. What is the exact site address / APN and municipal jurisdiction?
3. What is the total lot size (SF/Acres) and existing building size (if applicable)?
4. What is the primary project goal (e.g. 12-unit duplex subdivision, custom residence, retail TI)?

### Section 2: Archetype & Design Path
5. Which project archetype best fits this work? (Permit-Led Builder's Set / Full Design / TI / Entitlement / As-Built)
6. Are floor plans new from scratch, or based on mirrored/repeated unit prototypes?
7. Are interior layouts and finishes selected by the Architect or owner/builder?
8. Is a concept or test-fit already provided by others?

### Section 3: Planning & Permitting Path
9. What is the planning/zoning pathway (Ministerial SB 684/SB 1123, Site Plan Review, Tract Map, CUP, or By-Right)?
10. Which municipal agencies have plan check jurisdiction (e.g. City Building & Safety, County Fire, Health Dept)?
11. Is a preliminary site/zoning code analysis memo required as a separate deliverable?
12. How many plan check backcheck revision cycles should be included (standard: 2)?

### Section 4: Consultant Scope & Exclusions
13. Which consultants will the Owner contract directly? (Civil, Structural, MEP, Landscape, Survey, Geotech)
14. Are fire sprinkler drawings to be excluded as a Design-Build / Deferred Submittal?
15. Is Construction Administration (CA) included, or excluded and offered as an hourly add-on?
16. Are plotting and reimbursable expenses billed separately at cost?

### Section 5: Fee Model, Milestones & Timeline
17. What is the target fee model (Fixed Fee with Milestones, Hourly, or Fee/SF)?
18. What is the proposed total fee amount and retainer deposit (standard: 5%–15%)?
19. What are the key milestone payment triggers (e.g. Deposit -> Planning Submittal -> Plan Check -> RTI)?
20. What is the target completion timeline and urgency?

---

## Steps Performed
1. Create folder structure in `02_Projects/<Project_Name>/`.
2. Present or auto-fill the 20-question intake interview.
3. Select the matching template from `01_Preparation/Templates/Proposal_Templates/`.
4. Populate the template with project specifics, bracketed options, milestone fees, and protective exclusions.
5. Save draft in `02_Projects/<Project_Name>/02_Drafts/proposal_draft_v1.md` and invite user to co-edit.

