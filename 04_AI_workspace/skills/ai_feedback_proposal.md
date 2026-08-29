# Skill: `ai_feedback_proposal`

## Purpose
Compare an AI-generated proposal draft against the client’s actual executed proposal or project narrative, note differences in scope, assumptions, pricing, exclusions, and tone, ask clarifying questions, and update the `01_Preparation` workflow files and templates so future drafts match real projects.

---

## Inputs
- `projectFolder` (optional; default: current repo root)
- `draftProposalPath` (optional; path to the AI-generated proposal or draft)
- `clientProposalPath` (optional; path to the client-authored proposal text or project notes)
- `reviewMode` (optional: `"compare"` | `"edit"` | `"both"`)
- `applyEdits` (boolean; default: false) — when true, updates `01_Preparation` workflow and template files
- `projectPath` (optional: `"full design"` | `"permit-led"` | `"planning support"` | `"hybrid"`)

---

## Outputs
- Difference summary between the AI draft and the actual proposal
- List of clarifying questions to close gaps in scope, fee logic, or assumptions
- Revised workflow guidance in `01_Preparation` and updated proposal template language
- Short recommendations for the next proposal iteration
- Post-mortem record saved to `03_Feedback/project_postmortems/`

---

## Steps Performed
1. Compare the draft proposal against the real project narrative or client-authored text.
2. Identify mismatches in project description, scope, phase structure, exclusions, billing, and legal terms.
3. Ask for missing facts that change the actual scope, consultant responsibilities, or permit path.
4. Prompt user to identify the applicable project path before drafting or revising scope.
5. Update the `01_Preparation` proposal framework, workflow notes, and templates.
6. Produce a concise feedback summary and post-mortem.

