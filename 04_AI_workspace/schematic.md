## AI Workspace Schematic

This document shows how the AI workspace components interact to support proposal creation.

### Folder Structure
AI_workspace/
├── agents/
│   ├── feedback_analyzer_agent.md
│   ├── preparation_agent.md
│   └── proposal_drafter_agent.md
├── instructions/
│   ├── feedback_process.md
│   ├── new_project_workflow.md
│   └── preparation_guide.md
├── lessons_learned/
│   ├── project_templates.md
│   ├── staffing_insights.md
│   └── time_estimates.md
├── notes/
│   ├── project_requirements.md
│   └── proposal_components.md
├── skills/
│   └── skills.html
├── versions/
│   ├── template_versions.md
│   └── version_log.md
└── version_control/
    ├── skills_history.md
    └── version_log.md


### Workflow Integration
Project Initialization → instructions/new_project_workflow.md → Creates initial notes/project_requirements.md
Proposal Generation →
agents/proposal_drafter_agent.md uses versions/template_versions.md
lessons_learned/project_templates.md provides template context
Feedback Loop →
agents/feedback_analyzer_agent.md processes instructions/feedback_process.md
Updates lessons_learned/staffing_insights.md and lessons_learned/time_estimates.md
Version Tracking →
All changes logged in version_control/version_log.md
Skill updates tracked in version_control/skills_history.md

### Key Relationships

Component	Purpose	Data Flow
lessons_learned/	Stores project-specific insights	→ agents/ during proposal generation
version_control/	Tracks version history and skill changes	← versions/ and agents/
notes/	Contains project requirements and components	→ agents/ for template population
versions/	Manages template versions and version logs	← agents/ for new proposals


### Version Update
- Updated to V1.0.3 as part of wrap_up process
- Includes: change review, simplification proposals, updates to notes and version tracking, and refresh of schematic files
- Reflects the new wrap_up workflow from Skills.md

