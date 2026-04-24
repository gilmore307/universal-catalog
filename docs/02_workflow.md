# Workflow

## Purpose

Define how shared catalog items are registered, updated, and consumed without blurring the repository into a write-side service or a dumping ground for project-local values.

## Workflow Set

`universal-catalog` currently operates through four repository workflows:

1. apply pending database migrations
2. register a new catalog item
3. update an existing catalog item
4. consume catalog values in code

## Operating Principles

- confirm shared server-wide scope before adding a new catalog item
- keep stable ids stable once introduced
- keep migrations append-only after they are applied
- use migrations for schema changes and small static/bootstrap reference data, not bulk data storage
- do not hand-edit long-lived database rows outside a reviewed migration
- avoid full-row audit tables for high-volume data unless explicitly justified; preserve data integrity and disk headroom first
- do not mirror large active datasets into Git as SQL literals; use database storage plus explicit backup/restore policy instead
- keep the active row, referenced artifact, and docs aligned in the same change
- update only the canonical doc home when boundary or decision changes
- keep `src/` read-only and executor-injected

---

## WF-000 Apply pending database migrations

### Trigger Conditions

Current triggers:

- repository storage migration files changed
- active PostgreSQL database needs to catch up with committed catalog changes

Target runtime triggers:

- catalog maintenance or deployment needs to apply pending schema/data changes without rebuilding a second database

### Main Owner

- active PostgreSQL database `openclaw`
- `storage/dictionary/schema_migrations/`
- `scripts/apply-migrations.py`

### Main Outputs

- active `universal_catalog` rows
- `schema_migrations` ledger rows with migration version, filename, checksum, and applied time
- no full-row revision snapshots by default; preserve active data and the lightweight migration ledger first

### Workflow

1. resolve `OPENCLAW_DATABASE_URL` from the local secret alias when the environment variable is not already set
2. inspect `schema_migrations` for already-applied migration versions and checksums
3. stop if an applied migration file has a checksum mismatch
4. apply each pending migration in filename order
5. record the migration in `schema_migrations` after successful application
6. verify active row count and uniqueness checks

---

## WF-001 Register a new catalog item

### Trigger Conditions

Current triggers:

- a shared reusable value or artifact is ratified and needs one authoritative catalog identity

Target runtime triggers:

- any OpenClaw-managed project or automation flow needs a stable shared catalog entry instead of duplicating a volatile value

### Main Owner

- active PostgreSQL database `openclaw`
- new append-only migration under `storage/dictionary/schema_migrations/`
- `storage/templates/` when `kind = output`
- the relevant docs file when repository boundary or decisions change

### Main Outputs

- one new active `universal_catalog` table row with a stable id and key
- one matching output artifact or script address when the kind requires it
- aligned docs when the repository boundary changed

### Workflow

1. confirm the item belongs to the shared server-wide catalog boundary
2. check that no existing active item already covers the same concept
3. assign a stable id with the correct prefix
4. for small static catalog rows, add an append-only migration under `storage/dictionary/schema_migrations/`; for high-volume data, use a reviewed import path that writes to the active database without committing the full dataset into Git
5. update output template files or script addresses when the kind requires it
6. apply pending migrations to the active PostgreSQL database named `openclaw`
7. update docs when the new item changes scope, workflow, acceptance, task state, or project decisions

---

## WF-002 Update an existing catalog item

### Trigger Conditions

Current triggers:

- an existing shared catalog item keeps the same identity but needs a payload or artifact update

Target runtime triggers:

- a stable shared concept changes content while retaining the same catalog identity

### Main Owner

- active PostgreSQL database `openclaw`
- new append-only migration under `storage/dictionary/schema_migrations/`
- `storage/templates/` when an existing `output` file changes
- neighboring docs only when repository boundary or decisions changed

### Main Outputs

- one updated active `universal_catalog` table row for the same stable item
- updated output artifact content when the item points to a catalog-owned output file
- clear downstream impact notes when the update is non-trivial

### Workflow

1. confirm the item identity is unchanged; if the concept changed, create a new id instead
2. for small static catalog rows, add a new append-only migration that updates the active row; do not rewrite an already-applied migration
3. update any referenced output template file when the payload points to an output file under `storage/templates/`
4. apply pending migrations to the active PostgreSQL database named `openclaw`
5. update docs only when repository boundary, workflow, task state, or decisions changed

---

## WF-003 Consume catalog values in code

### Trigger Conditions

Current triggers:

- helper code or downstream automation needs one shared way to resolve stable catalog ids into payloads

Target runtime triggers:

- downstream code needs to dereference catalog values without scattering volatile payloads across business logic

### Main Owner

- `src/`
- downstream consumer code outside this repository
- docs and decisions when the helper boundary changes materially

### Main Outputs

- thin read-only lookup helpers that keep raw ids concentrated
- readable consumer code that depends on stable ids instead of copied payloads
- a helper boundary that does not silently grow into connection management or writes

### Workflow

1. keep raw ids concentrated behind helper code when implementation begins
2. resolve values through the catalog helper surface instead of scattering volatile payloads
3. keep consumer code readable by exposing meaningful local names above the raw id layer
4. prefer thin read-only lookup helpers that accept a supplied PostgreSQL query executor instead of embedding connection management here

---

## Cross-Workflow Operating Pattern

Across the repository:

1. registration and updates add append-only migrations and apply them to the active PostgreSQL register in the same maintenance pass
2. output files or script addresses stay aligned with the active row in the same change
3. docs move only when repository boundary, task state, workflow, acceptance, or decisions truly changed
4. consumer code treats this repository as a read-only shared authority rather than a runtime service
