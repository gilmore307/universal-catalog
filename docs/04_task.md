# Task

## Task Status Summary

- `accepted`: 11
- `ready_to_dispatch`: 4

## Active Tasks

None.

## Next Dispatch

- `task_register_first_shared_output_template` — `ready_to_dispatch` — register the first real shared output template when a project output or record artifact is ratified
- `task_extend_term_set` — `ready_to_dispatch` — extend the approved term set as additional specialized or project-defined terms are stabilized
- `task_add_postgresql_verification_path` — `ready_to_dispatch` — add a repeatable PostgreSQL-backed verification path in local tooling or CI
- `task_add_helper_consumer_example` — `ready_to_dispatch` — add the first real consumer integration example for the `src/` helper surface

## Pending Acceptance

None.

## Blocked Tasks

None.

## Recently Accepted

- implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor
- registered the first ratified shared workflow slot fields for execution-key templates in `storage/dictionary/seed.sql`
- registered the first ratified shared workflow slot fields for completion-receipt templates in `storage/dictionary/seed.sql`
- registered the first ratified shared workflow slot fields for acceptance-receipt templates in `storage/dictionary/seed.sql`
- registered the first ratified shared workflow slot fields for maintenance-output templates in `storage/dictionary/seed.sql`
- clarified that markdown documentation templates and the Codex task prompt stay in their relevant skills rather than in `universal-catalog`
- reserved `storage/templates/` for future project-related output templates instead of skill-local markdown files
- added a dedicated `output` kind for catalog-owned output templates
- added a dedicated `script` kind and registered the current helper source-file addresses under `src/` as full absolute locators for automation
- added a dedicated `term` kind and registered the first approved term definitions in `storage/dictionary/seed.sql`
- registered the first secret-alias config reference and added a read-only helper path for resolving secret aliases through the local secrets registry

## Notes

- This repository is still intentionally small.
- The current milestone includes both the PostgreSQL register boundary and the minimal read-only helper surface under `src/`.
- The next accepted storage expansion should keep output templates, script locators, term definitions, and secret-alias config references inside the same read-only catalog boundary rather than letting them sprawl into unrelated repos.
