# scripts

Operational helpers for maintaining the active `openclaw` PostgreSQL database.

## Files

- `apply-migrations.py` — applies pending SQL migrations from `storage/dictionary/schema_migrations/` to the active database and records them in `schema_migrations`.

## Boundary

Scripts may perform repository maintenance against the local active catalog database, but they should not become a general write-side service or hide catalog mutation behind opaque runtime behavior. Durable catalog changes still need reviewed migration files and OpenClaw acceptance.
