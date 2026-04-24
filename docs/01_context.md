# Context

## Why this exists

Future trading-oriented services on this server will need a small shared authority for reusable field definitions, output templates, approved term definitions, repository names, shared paths, concrete source-file locators for automation, and low-volatility non-sensitive configuration values. Centralizing those entries keeps change reviewable and avoids uncontrolled duplication.

## System role

This repository is a shared catalog dependency, not an application. It stores the authoritative active register plus any output-template files that are explicitly approved for catalog use.

## Core assumptions

- each catalog item gets a stable random id such as `fld_R7P1C6LW`, `out_T7M2KQ4P`, `rep_H6S3V8LA`, `pth_A7K3P2Q9`, `cfg_J7D1K5RP`, `trm_NBPU5J5P`, or `scr_YO00DVVP`
- the current active register keeps `id` and `key` unique
- Git history is sufficient for historical change tracking; no separate SQL history table is required
- output templates live as files under `storage/templates/` when this repository truly owns them
- skill-local markdown templates remain in the relevant skill bundles instead of being duplicated here
- the register schema should stay PostgreSQL-oriented rather than SQLite-oriented
- `src/` now provides a small read-only helper surface built around an injected query executor rather than owning database connections itself

## Related systems

- future trading-oriented services and automation that consume registered fields, outputs, term definitions, repositories, paths, script locators, and shared config values
- repository-local docs and skills that govern naming, workflow, and acceptance
- SQL tooling used to read and validate the active register
