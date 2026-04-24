# migrations

Append-only PostgreSQL migrations for the active `openclaw` database.

## Files

- `001_create_catalog_register.sql` — creates the migration ledger, active catalog table, revision snapshot table, indexes, and triggers.
- `002_bootstrap_universal_catalog.sql` — loads the currently approved bootstrap catalog rows.

## Boundary

After a migration has been applied and committed, do not rewrite it. Add a new numbered migration for later schema or data changes. The `schema_migrations` table records applied migration versions and SHA-256 checksums so drift is detected instead of silently accepted.
