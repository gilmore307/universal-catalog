# Decision

## DEC-001 Create a dedicated shared catalog repository

- **Date:** 2026-04-23
- **Decision:** Keep server-wide catalog content in its own repository instead of burying it inside a single application repository.
- **Reason:** Shared fields, templates, and stable references should be reviewed in one place and reused cleanly across future trading-oriented services.

## DEC-002 Position the repository as `universal-catalog`

- **Date:** 2026-04-23
- **Decision:** Treat the repository as `universal-catalog` rather than `universal-dictionary` because the boundary includes output templates in addition to dictionary-style entries.
- **Reason:** `catalog` matches the actual scope better and leaves room for shared template and path registrations without forcing awkward naming.

## DEC-003 Use stable random ids for catalog identity

- **Date:** 2026-04-23
- **Decision:** Use stable random ids with type prefixes such as `pth_`, `tpl_`, and `fld_` as the immutable identity layer.
- **Reason:** Human-readable keys can change. Stable opaque ids keep downstream code insulated from naming and payload edits.

## DEC-004 Keep only the active register in SQL

- **Date:** 2026-04-23
- **Decision:** Keep a single active catalog table in SQL and rely on Git history for change history.
- **Reason:** A separate SQL history table adds complexity without enough value for the current repository stage.

## DEC-005 Stay off SQLite

- **Date:** 2026-04-23
- **Decision:** Keep the catalog schema PostgreSQL-oriented rather than SQLite-oriented.
- **Reason:** Future trading-oriented services are expected to lean heavily on SQL, so the repository should align with a server-grade SQL path instead of a lightweight SQLite target.

## DEC-006 Start with five catalog kinds

- **Date:** 2026-04-23
- **Decision:** Start the active register with five allowed `kind` values: `field`, `template`, `repo`, `path`, and `config`.
- **Reason:** This covers the current shared boundary cleanly without prematurely exploding the catalog taxonomy.

## DEC-007 Keep the initial helper surface read-only and executor-injected

- **Date:** 2026-04-24
- **Decision:** Keep the first `src/` helper surface limited to read-only lookup helpers that accept a supplied PostgreSQL query executor instead of owning connection management.
- **Reason:** This gives downstream services a concrete lookup layer now without prematurely freezing a runtime stack, connection model, or broader application boundary inside `universal-catalog`.

## DEC-008 Register ratified shared workflow slot fields one template at a time

- **Date:** 2026-04-24
- **Decision:** When a reusable cross-project workflow template is ratified, register its canonical shared field names in `universal-catalog` under `kind = field`.
- **Reason:** This keeps skill-template slot names and catalog governance aligned without pretending undecided wrappers, enums, or full schemas are already standardized.

## DEC-009 Register fixed-location repository documentation templates as template items

- **Date:** 2026-04-24
- **Decision:** Register the canonical root `README.md` template and the fixed-location docs spine templates (`docs/00_scope.md` through `docs/06_memory.md`) as `kind = template` items with file payloads under `storage/templates/`.
- **Reason:** These are stable reusable file-level artifacts. Registering the files themselves is cleaner than treating every internal heading as a catalog field.
