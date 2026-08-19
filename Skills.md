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
