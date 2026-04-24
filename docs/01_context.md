# Context

## Why This Project Exists

Multiple OpenClaw-managed projects and automation flows need a small shared authority for reusable field definitions, output templates, approved terms, repository names, shared paths, concrete source-file locators, default status vocabularies, low-volatility non-sensitive configuration values, and secret-alias config references. Centralizing those entries keeps change reviewable and avoids uncontrolled duplication.

## Related Systems

- OpenClaw-managed projects and automation that consume registered fields, outputs, term definitions, repositories, paths, script locators, shared status vocabularies, shared config values, and shared secret-alias config references
- repository-local docs and skills that govern naming, workflow, and acceptance
- PostgreSQL tooling used to read and validate the active register

## Environment

- PostgreSQL-oriented catalog register under `storage/dictionary/`
- optional catalog-owned output templates under `storage/templates/`
- a small read-only Node helper surface under `src/`
- Git history as the durable change log for catalog evolution

## Dependencies

- a disposable PostgreSQL database for schema and seed verification
- `psql` for the acceptance path that applies `schema.sql` and `seed.sql`
- Node.js for the read-only helper tests under `src/`

## OpenClaw / Codex Setup

- OpenClaw owns project route, docs, review, acceptance, naming, and maintenance.
- Codex may implement bounded repository tasks when explicitly dispatched.
- The fixed docs spine under `docs/00_scope.md` through `docs/05_decision.md` remains authoritative for this repository.

## Important Constraints

- each catalog item gets a stable id with the correct prefix such as `fld_`, `out_`, `rep_`, `pth_`, `cfg_`, `trm_`, or `scr_`
- the active register keeps `id` and `key` unique
- the register schema stays PostgreSQL-oriented rather than SQLite-oriented
- skill-local markdown templates remain in their relevant skill bundles instead of being duplicated here
- `src/` must stay read-only and executor-injected instead of owning database connections or write paths
- catalog `config` entries may point to local secrets-registry aliases, but they must never store secret values or raw secret file contents
