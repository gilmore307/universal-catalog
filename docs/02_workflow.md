# Workflow

## Purpose

Define how shared catalog items are registered, updated, and consumed without blurring the repository into a write-side service or a dumping ground for project-local values.

## Workflow Set

`universal-catalog` currently operates through three repository workflows:

1. register a new catalog item
2. update an existing catalog item
3. consume catalog values in code

## Operating Principles

- confirm shared server-wide scope before adding a new catalog item
- keep stable ids stable once introduced
- keep the active row, referenced artifact, and docs aligned in the same change
- update only the canonical doc home when boundary or decision changes
- keep `src/` read-only and executor-injected

---

## WF-001 Register a new catalog item

### Trigger Conditions

Current triggers:

- a shared reusable value or artifact is ratified and needs one authoritative catalog identity

Target runtime triggers:

- any OpenClaw-managed project or automation flow needs a stable shared catalog entry instead of duplicating a volatile value

### Main Owner

- `storage/dictionary/seed.sql`
- `storage/templates/` when `kind = output`
- the relevant docs file when repository boundary or decisions change

### Main Outputs

- one new active register row with a stable id and key
- one matching output artifact or script address when the kind requires it
- aligned docs when the repository boundary changed

### Workflow

1. confirm the item belongs to the shared server-wide catalog boundary
2. check that no existing active item already covers the same concept
3. assign a stable id with the correct prefix
4. add or update the supporting artifact:
   - SQL row in `storage/dictionary/seed.sql`
   - output template file in `storage/templates/` when `kind = output`
   - full source-file address in the active row when `kind = script`
   - text definition in the active row when `kind = term`
5. update docs when the new item changes scope, workflow, acceptance, task state, or project decisions

---

## WF-002 Update an existing catalog item

### Trigger Conditions

Current triggers:

- an existing shared catalog item keeps the same identity but needs a payload or artifact update

Target runtime triggers:

- a stable shared concept changes content while retaining the same catalog identity

### Main Owner

- `storage/dictionary/seed.sql`
- `storage/templates/` when an existing `output` file changes
- neighboring docs only when repository boundary or decisions changed

### Main Outputs

- one updated active register row for the same stable item
- updated output artifact content when the item points to a catalog-owned output file
- clear downstream impact notes when the update is non-trivial

### Workflow

1. confirm the item identity is unchanged; if the concept changed, create a new id instead
2. update the active row in `storage/dictionary/seed.sql`
3. update any referenced output template file when the payload points to an output file under `storage/templates/`
4. update docs only when repository boundary, workflow, task state, or decisions changed

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

1. registration and updates change the active register first
2. output files or script addresses stay aligned with the active row in the same change
3. docs move only when repository boundary, task state, workflow, acceptance, or decisions truly changed
4. consumer code treats this repository as a read-only shared authority rather than a runtime service
