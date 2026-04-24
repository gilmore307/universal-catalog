# Task

## Queued

- Continue extending the seed set as additional shared templates and cross-project fields are ratified.
- Add the first approved template files and related template catalog items.
- Add a repeatable PostgreSQL-backed verification path in local tooling or CI.
- Add the first real consumer integration example for the `src/` helper surface.

## Completed

- Implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor.
- Registered the first ratified shared workflow slot fields for execution-key templates in `storage/dictionary/seed.sql`.

## Notes

This repository is still intentionally small. The current milestone is no longer just storage shape; it now includes a minimal lookup layer that keeps raw catalog ids concentrated without inventing connection management or write-side behavior.
