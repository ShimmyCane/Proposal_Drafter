# AI Workspace Schematic

Schematic version: V1.03 (2026-10-23)

This document shows how the AI workspace components interact to support proposal creation.

## Folder Structure

```
04_AI_workspace/
├── agents/
│   ├── feedback_analyzer_agent.md      (not yet implemented)
│   ├── preparation_agent.md            (not yet implemented)
│   └── proposal_drafter_agent.md
├── instructions/
│   ├── feedback_process.md
│   ├── new_project_workflow.md
│   └── preparation_guide.md
├── lessons_learned/
│   ├── project_templates.md
│   ├── staffing_insights.md            (awaiting data)
│   └── time_estimates.md               (awaiting data)
├── notes/
│   ├── project_requirements.md
│   └── proposal_components.md
├── skills/
│   ├── ai_code_analysis.md
│   ├── ai_feedback_proposal.md
│   ├── ai_lesson_learned.md
│   ├── ai_new_draft_proposal.md
│   ├── ai_wrap_up.md
│   ├── new_project.md
│   ├── refine.md
│   └── skills.html                     (view; title needs fixing)
├── versions/
│   ├── template_versions.md
│   ├── version_log.md
│   ├── V1.0.1.md
│   ├── V1.02.md
│   └── V1.03.md
├── version_control/
│   └── skills_history.md
├── ai_wrap_up.md
├── file_tree_manifest.md
├── schematic.md
└── schematic_view.html
```

## Workflow Integration

- Project initialization: `instructions/new_project_workflow.md` creates the project folders and feeds `notes/project_requirements.md`.
- Proposal generation: `agents/proposal_drafter_agent.md` uses `versions/template_versions.md` and `lessons_learned/project_templates.md`.
- Feedback loop: `agents/feedback_analyzer_agent.md` follows `instructions/feedback_process.md` and updates `lessons_learned/staffing_insights.md` and `lessons_learned/time_estimates.md`.
- Version tracking: changes are logged in `versions/version_log.md` and per-release entries in `versions/V*.md`.
- Skill history: skill changes are logged in `version_control/skills_history.md`.

## Key Relationships

| Component | Purpose | Data Flow |
| :--- | :--- | :--- |
| `lessons_learned/` | Project-specific insights | → `agents/` during proposal generation |
| `version_control/` | Skill change history | ← `skills/` and `agents/` |
| `notes/` | Project requirements and components | → `agents/` for template population |
| `versions/` | Template versions and release logs | ← `agents/` for new proposals |

## Version Update

- V1.02: repository review and schematic refresh.
- V1.03 (2026-10-23): corrected folder tree (the log lives at `versions/version_log.md`, not `version_control/`), added the skill definitions and the observation folder, and refreshed status fields.
