# storage/templates

Template files referenced by active catalog entries live here.

## Current files

- `root-readme.md` — canonical root `README.md` template for formal repositories
- `docs_00_scope.md` — canonical template for `docs/00_scope.md`
- `docs_01_context.md` — canonical template for `docs/01_context.md`
- `docs_02_workflow.md` — canonical template for `docs/02_workflow.md`
- `docs_03_acceptance.md` — canonical template for `docs/03_acceptance.md`
- `docs_04_task.md` — canonical template for `docs/04_task.md`
- `docs_05_decision.md` — canonical template for `docs/05_decision.md`
- `docs_06_memory.md` — canonical template for `docs/06_memory.md` when that optional file is used
- `codex_task_prompt.md` — canonical reusable Codex task prompt template for OpenClaw-managed implementation dispatch

## Rule

When a catalog item uses `kind = template` and `payload_format = file`, its `payload` should point to a file stored under this directory unless a later decision expands the boundary.
