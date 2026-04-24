# storage/dictionary

PostgreSQL-oriented SQL source of truth for the active catalog register.

## Files

- `schema.sql` — defines the active `catalog_items` table
- `seed.sql` — loads approved active rows into the register

## Notes

This directory keeps only the active register. Change history lives in Git rather than a separate SQL history table. SQLite is intentionally not a target for this repository.

The seed bootstraps the register with field entries for the `catalog_items` column names themselves, base repo/path/config entries, and the first ratified shared workflow slot fields for execution-key templates.
