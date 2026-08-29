# Skill: `ai_code_analysis`

## Purpose
Perform an architectural code analysis referencing the RFQ/RFP and `01_Preparation/Templates/Code Analysis/code_analysis_template.md`.

---

## Inputs
- `projectFolder` (optional; default: repository root)
- `sourceFiles` (optional; list of file paths to include in analysis — if omitted, scans standard project locations)
- `templatePath` (optional; default: `01_Preparation/Templates/Code Analysis/code_analysis_template.md`)
- `schemaVersion` (optional; default: "1.0")
- `sampleJsonPath` (optional; file path to write the generated JSON sample)
- `applyEdits` (boolean; default: false) — when true, writes files into the workspace (requires explicit approval)

---

## Outputs
- Structured JSON file (`schemaVersion`, `source`, `project`, `sections`, `applicableCodes`, `researchNotes`, `exportedAt`)
- Optional updated HTML analysis page (import/export handlers) when `applyEdits=true`
- Short summary of findings and recommended next steps

---

## Steps Performed
1. Load the RFQ/RFP and the `code_analysis_template.md`.
2. Read the provided `sourceFiles` (or scan common locations such as `02_Projects/*/01_Intake`).
3. Produce a structured JSON following `schemaVersion` with fields: `schemaVersion`, `source`, `project`, `sections` (zoning, programInfo, buildingInfo, detailedCode, ahj, consultants, deliverables, fees), `applicableCodes`, `researchNotes`, `exportedAt`.
4. Validate the generated JSON against JSON schema if present.
5. If `applyEdits=true`, write the JSON to `sampleJsonPath` (or default under target project).
6. Return a concise summary and paths to created/updated files.

