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
