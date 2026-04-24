# Workflow

## WF-001 Register a new catalog item

1. Confirm the item belongs to the shared server-wide catalog boundary.
2. Check that no existing active item already covers the same concept.
3. Assign a stable random id with the correct prefix (`fld_`, `tpl_`, `rep_`, `pth_`, `cfg_`, or `trm_`).
4. Add or update the supporting artifact:
   - SQL row in `storage/dictionary/seed.sql`
   - template file in `storage/templates/` when `kind = template`
   - text definition in the active row when `kind = term`
5. Update docs when the new item changes scope, workflow, acceptance, or project decisions.

### WF-001 acceptance

A new catalog item is ready for review only if:
- the concept is clearly server-wide rather than project-local
- `id` and `key` are unique in the active register
- `kind`, `payload_format`, and `payload` match the actual artifact
- any new directory or maintained boundary still has a `README.md`

## WF-002 Update an existing catalog item

1. Confirm the item identity is unchanged; if the concept changed, create a new id instead.
2. Update the active row in `storage/dictionary/seed.sql`.
3. Update any referenced template file when the payload points to a template path.
4. Update docs only when repository boundary, workflow, or decisions changed.

### WF-002 acceptance

An update is ready for review only if:
- the existing id remains stable
- the new payload is correct for the same underlying concept
- the active register still parses cleanly against `schema.sql`
- consumer-facing change impact is clear when the update is non-trivial

## WF-003 Consume catalog values in code

1. Keep raw random ids concentrated behind helper code when implementation begins.
2. Resolve values through the catalog helper surface instead of scattering volatile payloads.
3. Keep business code readable by exposing meaningful local names above the raw id layer.
4. Prefer thin read-only lookup helpers that accept a supplied PostgreSQL query executor instead of embedding connection management here.

### WF-003 acceptance

Catalog consumption is ready for review only if:
- the code depends on stable ids rather than duplicated volatile values
- raw ids are not spread casually across unrelated business logic
- the helper surface stays small and clearly scoped to catalog lookup
- helper code does not silently grow into connection management or write-side catalog administration
