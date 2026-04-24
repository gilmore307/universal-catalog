# storage/dictionary

PostgreSQL-oriented rebuild input for the active catalog register.

## Files

- `schema.sql` — defines the active `catalog_items` table
- `seed.sql` — loads approved active rows into the register

## Notes

This directory keeps the versioned rebuild inputs for the active register. Change history lives in Git rather than a separate SQL history table. SQLite is intentionally not a target for this repository.

The seed bootstraps the register with field entries for the `catalog_items` column names themselves, base repo/path/config entries, the first ratified shared workflow slot fields for execution-key, completion-receipt, acceptance-receipt, and maintenance-output templates, default status vocabulary values for shared task, review, and maintenance artifacts, `script` entries that provide full addresses for the current helper source files under `src/`, the first approved term definitions, and the first secret-alias config reference.

No `output` rows are registered yet. Markdown documentation templates and prompt templates are intentionally kept out of this register. Secret values and raw secret file contents are also intentionally kept out; only secret-alias references belong in `kind = config` rows.
