# Context

## Why this exists

Future trading-oriented services on this server will need a small shared authority for reusable field definitions, output templates, repository names, shared paths, and low-volatility non-sensitive configuration values. Centralizing those entries keeps change reviewable and avoids uncontrolled duplication.

## System role

This repository is a shared catalog dependency, not an application. It stores the authoritative active register and the template files referenced by that register.

## Core assumptions

- each catalog item gets a stable random id such as `fld_R7P1C6LW`, `tpl_M4N8X2KD`, `rep_H6S3V8LA`, `pth_A7K3P2Q9`, or `cfg_J7D1K5RP`
- the current active register keeps `id` and `key` unique
- Git history is sufficient for historical change tracking; no separate SQL history table is required
- templates live as files under `storage/templates/`
- the register schema should stay PostgreSQL-oriented rather than SQLite-oriented
- helper code may be added later under `src/` when the first real consumer appears

## Related systems

- future trading-oriented services that consume registered fields, templates, repositories, paths, and shared config values
- repository-local docs that govern naming, workflow, and acceptance
- SQL tooling used to read and validate the active register
