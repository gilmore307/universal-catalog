# Task

## Queued

- Continue extending the seed set as additional shared templates and cross-project fields are ratified.
- Decide whether to register additional fixed-location shared templates beyond the current root README and docs spine files.
- Add a repeatable PostgreSQL-backed verification path in local tooling or CI.
- Add the first real consumer integration example for the `src/` helper surface.

## Completed

- Implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor.
- Registered the first ratified shared workflow slot fields for execution-key templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for completion-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for acceptance-receipt templates in `storage/dictionary/seed.sql`.
- Registered the first ratified shared workflow slot fields for maintenance-output templates in `storage/dictionary/seed.sql`.
- Added the first approved template files under `storage/templates/` and registered the fixed-location root README and docs spine templates in `storage/dictionary/seed.sql`.

## Notes

This repository is still intentionally small. The current milestone is no longer just storage shape; it now includes a minimal lookup layer that keeps raw catalog ids concentrated without inventing connection management or write-side behavior.
