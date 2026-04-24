# Task

## Queued

- Continue extending the seed set as additional shared templates and cross-project fields are ratified.
- Extend the approved term set as additional specialized or project-defined terms are stabilized.
- Decide whether to register additional reusable shared templates beyond the current docs and Codex task prompt templates.
- Add a repeatable PostgreSQL-backed verification path in local tooling or CI.
- Add the first real consumer integration example for the `src/` helper surface.

## Completed

- Implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor.
- Registered the first ratified shared workflow slot fields for execution-key templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for completion-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for acceptance-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for maintenance-output templates in `storage/dictionary/seed.sql`.
- Added the first approved template files under `storage/templates/` and registered the fixed-location root README and docs spine templates in `storage/dictionary/seed.sql`.
- Added the canonical reusable `codex_task_prompt.md` template under `storage/templates/` and registered it in `storage/dictionary/seed.sql`.
- Registered stable path entries for the canonical template files under `storage/templates/` so scripts can resolve them without hardcoding raw paths.
- Added a dedicated `term` kind and registered the first approved term definitions in `storage/dictionary/seed.sql`.

## Notes

This repository is still intentionally small. The current milestone is no longer just storage shape; it now includes a minimal lookup layer that keeps raw catalog ids concentrated without inventing connection management or write-side behavior.
