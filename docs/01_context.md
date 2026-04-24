# Context

## Why This Project Exists

Multiple OpenClaw-managed projects and automation flows need a small shared authority for reusable field definitions, output templates, approved terms, repository names, shared paths, concrete source-file locators, default status vocabularies, low-volatility non-sensitive configuration values, and secret-alias config references. Centralizing those entries keeps change reviewable and avoids uncontrolled duplication.

## Related Systems

- OpenClaw-managed projects and automation that consume registered fields, outputs, term definitions, repositories, paths, script locators, shared status vocabularies, shared config values, and shared secret-alias config references
- repository-local docs and skills that govern naming, workflow, and acceptance
- PostgreSQL tooling used to read and validate the active `universal_catalog` table

## Environment

- long-lived PostgreSQL database named `openclaw` with an active `universal_catalog` table
- append-only schema and small bootstrap migrations under `storage/dictionary/schema_migrations/`
- optional catalog-owned output templates under `storage/templates/`
- a small read-only Node helper surface under `src/`
- Git history plus the lightweight `schema_migrations` database ledger as the durable change log for catalog evolution

## Dependencies

- a local PostgreSQL database named `openclaw` for OpenClaw-managed durable tables, currently including `universal_catalog`
- `psql` for the acceptance path that applies pending migrations
- a local secret alias for the active OpenClaw database URL, registered as `OPENCLAW_DATABASE_URL_SECRET_ALIAS` with payload `openclaw/database-url`
- Node.js for the read-only helper tests under `src/`

## OpenClaw / Codex Setup

- OpenClaw owns project route, docs, review, acceptance, naming, and maintenance.
- Codex may implement bounded repository tasks when explicitly dispatched.
- The fixed docs spine under `docs/00_scope.md` through `docs/05_decision.md` remains authoritative for this repository.

## Important Constraints

- each catalog item gets a stable id with the correct prefix such as `fld_`, `out_`, `rep_`, `pth_`, `cfg_`, `trm_`, or `scr_`
- the active `universal_catalog` table keeps `id` and `key` unique
- applied migrations are recorded in `schema_migrations` with filename and SHA-256 checksum
- full row-history snapshots are intentionally not retained by default; disk space and active data integrity take priority over exhaustive audit history
- high-volume operational data must not be duplicated into migration files as literal row text; the database is the active store for that data
- the register schema stays PostgreSQL-oriented rather than SQLite-oriented
- skill-local markdown templates remain in their relevant skill bundles instead of being duplicated here
- `src/` must stay read-only and executor-injected instead of owning database connections or write paths
- catalog `config` entries may point to local secrets-registry aliases, but they must never store secret values or raw secret file contents
- the active PostgreSQL database URL may be resolved from the local secret alias `openclaw/database-url`; do not commit a concrete connection string into repository docs or config
