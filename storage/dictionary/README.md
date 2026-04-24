# storage/dictionary

PostgreSQL migration boundary for the active `universal_catalog` table.

## Files

- `schema_migrations/` — append-only schema and data migrations applied to the long-lived active PostgreSQL database

## Current database tables

- `schema_migrations` — applied migration ledger with version, filename, SHA-256 checksum, and applied time
- `universal_catalog` — active catalog rows consumed by read-only helpers and downstream projects
- `universal_catalog_revisions` — database-side snapshots for inserted or materially updated catalog rows

## Notes

The active `universal_catalog` table lives in PostgreSQL database `openclaw`. Migrations are the reviewed change path for schema and data evolution; do not keep a separate long-lived acceptance database and do not hand-edit active rows outside reviewed migrations. SQLite is intentionally not a target for this repository.

The initial bootstrap migration loads field entries for the `universal_catalog` column names themselves, base repo/path/config entries, ratified shared workflow slot fields, default status vocabulary values, `script` entries for helper source files, approved term definitions, network-framework packaged-client config/default entries, and secret-alias config references.

No `output` rows are registered yet. Markdown documentation templates and prompt templates are intentionally kept out of this register. Secret values and raw secret file contents are also intentionally kept out; only secret-alias references belong in `kind = config` rows.
