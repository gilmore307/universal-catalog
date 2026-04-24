# Acceptance

## Acceptance Summary

Current accepted repository slice:

- fixed docs spine for project boundary and decisions
- PostgreSQL migrations and migration runner for the long-lived active catalog register
- catalog-owned output-template storage boundary under `storage/templates/`
- a small read-only helper surface under `src/`

## Acceptance Rules

### For storage changes

A storage change is acceptable only if:

- the item is truly server-wide rather than project-local
- `id` and `key` remain unique in the active register
- `kind`, `payload_format`, and `payload` match the actual artifact
- any referenced output file or script address actually exists

### For `src/` helper changes

A `src/` change is acceptable only if:

- the helper surface remains read-only
- the code still accepts an injected PostgreSQL query executor instead of owning connection management
- any secret-related helper reads only alias references plus the local secrets registry and never stores secret values in the catalog
- raw ids stay concentrated instead of spreading casually across unrelated logic
- local tests pass for the changed helper surface

### For docs-only changes

A docs-only change is acceptable only if:

- the docs spine remains complete and coherent for the current repository shape
- each durable fact still has one canonical home
- docs stay aligned with the real storage and helper boundaries
- no skill-local markdown template boundary is accidentally moved into this repository

## Verification Commands

Run these commands against the local active PostgreSQL catalog database named `universal-catalog` from the repository root.
The local host resolves `UNIVERSAL_CATALOG_DATABASE_URL` from the secret alias registered by `UNIVERSAL_CATALOG_DATABASE_URL_SECRET_ALIAS` (`universal-catalog/database-url`).

```bash
python3 scripts/apply-migrations.py
psql "$UNIVERSAL_CATALOG_DATABASE_URL" -Atc "SELECT COUNT(*), COUNT(DISTINCT key), COUNT(DISTINCT id) FROM catalog_items;"
psql "$UNIVERSAL_CATALOG_DATABASE_URL" -Atc "SELECT version, checksum_sha256 FROM schema_migrations ORDER BY version;"
```

When `src/` changes, also run:

```bash
node --test src/catalog-reader.test.js
```

Do not maintain a second long-lived acceptance database. The local active database evolves through append-only migrations recorded in `schema_migrations`; do not hand-edit long-lived catalog rows outside reviewed migrations. SQLite is not an acceptance target for this repository.

## Required Review Evidence

- diff review for storage, docs, and helper-boundary changes
- successful migration application output
- migration ledger output from `schema_migrations`
- note that `UNIVERSAL_CATALOG_DATABASE_URL` came from the local active catalog database alias
- `src/catalog-reader.test.js` output when `src/` changed
- explicit note that a new or updated item is truly shared rather than project-local
- explicit note when docs or decisions changed because repository boundary moved

## Rejection Reasons

Reject a change when:

- a supposedly shared item is actually project-local
- an update silently changes the meaning of an existing stable id
- the active register breaks migration application or ledger checksum validation
- a maintained directory loses its boundary README
- docs and storage drift out of sync about what this repository owns
- helper code quietly expands into write-side behavior or hides catalog access behind opaque runtime state
