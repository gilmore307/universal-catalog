# Task

## Queued

- Register the first real shared output templates when a project output or record artifact is ratified.
- Extend the approved term set as additional specialized or project-defined terms are stabilized.
- Add a repeatable PostgreSQL-backed verification path in local tooling or CI.
- Add the first real consumer integration example for the `src/` helper surface.

## Completed

- Implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor.
- Registered the first ratified shared workflow slot fields for execution-key templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for completion-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for acceptance-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for maintenance-output templates in `storage/dictionary/seed.sql`.
- Clarified that markdown documentation templates and the Codex task prompt stay in their relevant skills rather than in `universal-catalog`.
- Reserved `storage/templates/` for future project-related output templates instead of skill-local markdown files.
- Added a dedicated `output` kind for catalog-owned output templates.
- Added a dedicated `script` kind and registered the current helper source-file addresses under `src/` as full absolute locators for automation.
- Added a dedicated `term` kind and registered the first approved term definitions in `storage/dictionary/seed.sql`.

## Notes

This repository is still intentionally small. The current milestone is no longer just storage shape; it now includes a minimal lookup layer that keeps raw catalog ids concentrated without inventing connection management or write-side behavior.
