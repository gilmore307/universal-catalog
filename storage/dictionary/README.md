# storage/dictionary

PostgreSQL migration boundary for the active `universal_catalog` table.

## Files

- `schema_migrations/` — append-only schema migrations plus small static/bootstrap reference-data migrations applied to the long-lived active PostgreSQL database

## Current database tables

- `schema_migrations` — applied migration ledger with version, filename, SHA-256 checksum, and applied time
- `universal_catalog` — active catalog rows consumed by read-only helpers and downstream projects

## Notes

The active `universal_catalog` table lives in PostgreSQL database `openclaw`. Migrations are the reviewed change path for schema and data evolution; do not keep a separate long-lived acceptance database and do not hand-edit active rows outside reviewed migrations. Full-row revision snapshots are not retained by default because disk headroom and active data integrity take priority over exhaustive audit history. SQLite is intentionally not a target for this repository.

The initial bootstrap migration loads a small static reference baseline: field entries for the `universal_catalog` column names themselves, base repo/path/config entries, ratified shared workflow slot fields, default status vocabulary values, `script` entries for helper source files, approved term definitions, network-framework packaged-client config/default entries, and secret-alias config references. Future high-volume active datasets should not be committed here as literal SQL row lists.

No `output` rows are registered yet. Markdown documentation templates and prompt templates are intentionally kept out of this register. Secret values and raw secret file contents are also intentionally kept out; only secret-alias references belong in `kind = config` rows.
