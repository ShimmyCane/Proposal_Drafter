# Skill: `ai_lesson_learned`

## Purpose
Capture, summarize, and codify project lessons learned into the repository so future proposal drafting remains grounded in real project outcomes.

---

## Inputs
- `projectFolder` (optional; default: current repo root)
- `lessonCategory` (optional: `"proposal"` | `"template"` | `"workflow"` | `"scope"` | `"fee"` | `"process"`)
- `lessonSummary` (optional; brief description of the issue, correction, or improvement)
- `sourceFiles` (optional; list of files or project notes used to confirm the lesson)
- `applyEdits` (boolean; default: false) — when true, updates `03_Feedback/lessons_learned_summary.md` and `04_AI_workspace/lessons_learned/`

---

## Outputs
- Updated lesson log entry in `03_Feedback/lessons_learned_summary.md` and `04_AI_workspace/lessons_learned/`
- Concise summary of what was learned and what should change in future workflow or template use
- Recommended follow-up actions for future projects

---

## Steps Performed
1. Review project outcome, proposal language, or workflow result.
2. Identify what was misunderstood, overgeneralized, or missing from the original draft.
3. Distill the lesson into a reusable project-level principle.
4. Save the lesson in `03_Feedback/lessons_learned_summary.md`.
5. Update related repository templates or guidance.

