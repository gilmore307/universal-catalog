# Acceptance

## Consolidated acceptance rules

A repository change is accepted only if:

- the docs spine remains complete and coherent for the current project shape
- each meaningful maintained directory has a boundary `README.md`
- `storage/dictionary/schema.sql` applies cleanly
- `storage/dictionary/seed.sql` applies cleanly after the schema
- catalog item ids use the expected type prefixes and remain stable once introduced
- templates referenced by file path actually exist when present in the seed data

## Required verification

Run these commands from the repository root:

```bash
sqlite3 /tmp/universal-catalog.acceptance.db < storage/dictionary/schema.sql
sqlite3 /tmp/universal-catalog.acceptance.db < storage/dictionary/seed.sql
```

Delete or overwrite the temporary database freely after verification.

## Rejection conditions

Reject a change when:

- a supposedly shared item is actually project-local
- an update silently changes the meaning of an existing stable id
- the active register breaks schema application
- a maintained directory loses its boundary README
- docs and storage drift out of sync about what this repository owns
