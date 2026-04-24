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
