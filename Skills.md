Skills
ai_wrap_up - review the current project workspace and consolidate AI artifacts. This action may modify files under 04_AI_workspace and update repository metadata. Use only when authorized.
    Inputs:
      - project folder path (optional; default: current repo root)
      - scope (optional: "project" | "all")
    Outputs:
      - updated or created summary file: 04_AI_workspace/ai_wrap_up.md
      - version entry in 04_AI_workspace/versions (e.g., V1.0.1.md)
      - optional edits to schematic.md (version bump) and AI skill documentation
      - a short list of recommended next steps
    Steps performed:
      1. Identify changes since the previous wrap-up (file creations/edits).
      2. Propose and apply minor simplifications to AI files in 04_AI_workspace (when applicable).
      3. Update AI workspace files (notes, lessons_learned, versions) with concise summaries.
      4. Bump the schematic version (md) and record a version entry in 04_AI_workspace/versions.
      5. Produce an ai_wrap_up.md summary with timestamp and files changed.
    Behavior notes:
      - When invoked without explicit approval, ai_wrap_up will only prepare proposed edits and a summary. When invoked with approval to apply changes, it will write the files and record the version entry.
      - Designed for repeatable, small-scope updates. For large changes, run interactively and review proposed edits first.
    .7 validate and review changes
    
new_project - ask the AI to start a new project

refine - ask the AI to just look at the selected document, within the context of the project.

ai_code_analysis - perform a code analysis as a project architect. Reference the RFQ/RFP and 01_Preparation\Templates\code_analysis_template.md.

    Inputs:
      - projectFolder (optional; default: repository root)
      - sourceFiles (optional; list of file paths to include in analysis — if omitted, scans standard project locations)
      - templatePath (optional; default: 01_Preparation\Templates\code_analysis_template.md)
      - schemaVersion (optional; default: "1.0")
      - sampleJsonPath (optional; file path to write the generated JSON sample)
      - applyEdits (boolean; default: false) — when true, the skill may write files into the workspace (requires explicit approval)

    Outputs:
      - generated structured JSON file (schemaVersion, source, project, sections, applicableCodes, researchNotes, exportedAt)
      - optional updated HTML analysis page (import/export handlers) when applyEdits=true
      - a short summary of findings and recommended next steps

    Steps performed:
      1. Load the RFQ/RFP and the code_analysis_template.md (or the provided templatePath).
      2. Read the provided sourceFiles (or scan common locations such as 02_Projects/*/RFP and 01_Preparation/Templates).
      3. Produce a structured JSON following schemaVersion with fields: schemaVersion, source, project, sections (zoning, programInfo, buildingInfo, detailedCode, ahj, consultants, deliverables, fees), applicableCodes, researchNotes, exportedAt.
      4. Validate the generated JSON (if a JSON Schema file exists in the repo) and map legacy flat JSON fields into the structured schema when necessary.
      5. If applyEdits=true, write the JSON to sampleJsonPath (or a default path under the target project) and optionally patch the HTML importer/exporter to support the schema.
      6. Return or save a short summary and the paths to any created/updated files.

    Behavior notes:
      - By default the skill runs in preview mode (applyEdits=false) and will not modify repository files.
      - The skill supports legacy flat JSON inputs and will convert/migrate them to the structured schema when imported.
      - Recommended to store a JSON Schema (e.g., 01_Preparation\Templates\code_analysis_schema.json) to validate outputs and support automated checks in the "ai_code_analysis" skill.
      - Large or destructive changes must be reviewed before applyEdits=true is used.

ai_feedback_proposal - compare an AI-generated proposal draft against the client’s actual proposal or project narrative, note the differences in scope, assumptions, pricing, exclusions, and tone, ask clarifying questions, and then update the 01_Preparation workflow files and the proposal template so future drafts better match the real project. Use when reviewing earlier AI work against a handwritten or final proposal.

    Inputs:
      - projectFolder (optional; default: current repo root)
      - draftProposalPath (optional; path to the AI-generated proposal or draft)
      - clientProposalPath (optional; path to the client-authored proposal text or project notes)
      - reviewMode (optional: "compare" | "edit" | "both")
      - applyEdits (boolean; default: false) — when true, the skill may update the 01_Preparation workflow and template files
      - projectPath (optional: "full design" | "permit-led" | "planning support" | "hybrid") — used to prompt the user if the project type is ambiguous

    Outputs:
      - difference summary between the AI draft and the actual proposal
      - list of clarifying questions to close gaps in scope, fee logic, or assumptions
      - revised workflow guidance in 01_Preparation and updated proposal template language
      - short recommendations for the next proposal iteration
      - a starter block or checklist for project type validation before finalizing the draft

    Steps performed:
      1. Compare the draft proposal against the real project narrative or client-authored text.
      2. Identify mismatches in project description, scope, phase structure, exclusions, billing, and legal terms.
      3. Ask for missing facts that change the actual scope, consultant responsibilities, or permit path.
      4. Prompt the user to identify the applicable project path before drafting or revising scope, especially for permit-led, limited-service, or subdivision packages.
      5. Update the 01_Preparation proposal framework, workflow notes, and template to reflect the real project type and delivery logic.
      6. Produce a concise feedback summary and recommended next actions.

    Behavior notes:
      - Prefer the client’s project facts and written language over generic AI template wording.
      - Keep the proposal realistic, specifically scoped, and grounded in the actual project path (for example, permit-led or limited-service work).
      - If the project is a limited builder’s permit set or subdivision package, make sure the workflow keeps those assumptions visible instead of defaulting to a broad design-phase proposal.
      - Use prompt-first project path selection before assuming a scope, fee, or phase structure.
      - Validate the AI draft against the real narrative using a checklist covering scope, fee, exclusions, consultant responsibility, permit assumptions, and deferred submittals.
      - Use questions to resolve uncertainty before finalizing fees, milestones, legal terms, or consultant scope.

ai_lesson_learned - capture, summarize, and codify project lessons learned into the repository so future AI work and proposal drafting remain grounded in real project outcomes. Use after a project review, proposal comparison, or feedback cycle to write durable process improvements.

    Inputs:
      - projectFolder (optional; default: current repo root)
      - lessonCategory (optional: "proposal" | "template" | "workflow" | "scope" | "fee" | "process")
      - lessonSummary (optional; brief description of the issue, correction, or improvement)
      - sourceFiles (optional; list of files or project notes used to confirm the lesson)
      - applyEdits (boolean; default: false) — when true, the skill may update the lessons learned log under 04_AI_workspace/lessons_learned

    Outputs:
      - updated lesson log entry in 04_AI_workspace/lessons_learned
      - concise summary of what was learned and what should change in future workflow or template use
      - recommended follow-up actions for future projects

    Steps performed:
      1. Review the project outcome, proposal language, or workflow result.
      2. Identify what was misunderstood, overgeneralized, or missing from the original draft.
      3. Distill the lesson into a reusable project-level principle.
      4. Save the lesson in the relevant lessons learned document under 04_AI_workspace/lessons_learned.
      5. Recommend the workflow or template change needed to avoid repeating the issue.

    Behavior notes:
      - Prefer grounded lessons from actual client work over generic process advice.
      - Record project-specific corrections such as permit-led scope, small-lot subdivision logic, milestone-based fees, and consultant responsibility clarity.
      - If the lesson affects proposals, templates, or workflows, update the related repository guidance as well as the lesson log.
      - Keep the record concise, practical, and reusable for future AI project drafting.
