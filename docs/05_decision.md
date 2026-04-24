# Decision

## DEC-001 Create a dedicated shared catalog repository

- **Date:** 2026-04-23
- **Decision:** Keep server-wide catalog content in its own repository instead of burying it inside a single application repository.
- **Reason:** Shared fields, outputs, and stable references should be reviewed in one place and reused cleanly across future trading-oriented services.

## DEC-002 Position the repository as `universal-catalog`

- **Date:** 2026-04-23
- **Decision:** Treat the repository as `universal-catalog` rather than `universal-dictionary` because the boundary includes output-style artifacts in addition to dictionary-style entries.
- **Reason:** `catalog` matches the actual scope better and leaves room for shared output, script, and path registrations without forcing awkward naming.

## DEC-003 Use stable random ids for catalog identity

- **Date:** 2026-04-23
- **Decision:** Use stable random ids with type prefixes such as `pth_`, `out_`, `scr_`, and `fld_` as the immutable identity layer.
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
- **Reason:** This covered the initial shared boundary cleanly without prematurely exploding the catalog taxonomy.
- **Later change:** the current set later replaced `template` with `output` and added both `term` and `script`.

## DEC-007 Keep the initial helper surface read-only and executor-injected

- **Date:** 2026-04-24
- **Decision:** Keep the first `src/` helper surface limited to read-only lookup helpers that accept a supplied PostgreSQL query executor instead of owning connection management.
- **Reason:** This gives downstream services a concrete lookup layer now without prematurely freezing a runtime stack, connection model, or broader application boundary inside `universal-catalog`.

## DEC-008 Register ratified shared workflow slot fields one template at a time

- **Date:** 2026-04-24
- **Decision:** When a reusable cross-project workflow template is ratified, register its canonical shared field names in `universal-catalog` under `kind = field`.
- **Reason:** This keeps skill-template slot names and catalog governance aligned without pretending undecided wrappers, enums, or full schemas are already standardized.

## DEC-009 Keep fixed-location repository markdown templates in skills

- **Date:** 2026-04-24
- **Decision:** Keep markdown templates for files such as `README.md` and `docs/00_scope.md` through `docs/06_memory.md` in their relevant skills instead of registering them in `universal-catalog`.
- **Reason:** Those markdown files are skill-local guidance artifacts, not shared catalog-owned output templates.

## DEC-010 Add a dedicated `term` kind for approved term definitions

- **Date:** 2026-04-24
- **Decision:** Add `term` as an allowed `kind` so `universal-catalog` can register approved specialized terms and self-defined project terms with text definitions.
- **Reason:** Terms and meanings are stable shared reference material, and they should not be forced awkwardly into `field` or `config` entries.

## DEC-011 Keep the Codex task prompt markdown template in skills

- **Date:** 2026-04-24
- **Decision:** Keep `codex_task_prompt.md` in the relevant OpenClaw/Codex skills instead of registering it as a catalog item.
- **Reason:** It is skill-local markdown instruction material, not a catalog-owned project output template.

## DEC-012 Use `script` for full source-file addresses consumed by automation

- **Date:** 2026-04-24
- **Decision:** Use `kind = script` for concrete full addresses to source files that automation may need directly, such as helper files under `src/`.
- **Reason:** Script locators are not generic paths; they are automation-facing references to specific source files and should be explicit.

## DEC-013 Reserve `storage/templates/` for output templates

- **Date:** 2026-04-24
- **Decision:** Use `storage/templates/` only for catalog-owned output templates and register those files under `kind = output` when they are real.
- **Reason:** This keeps output artifacts separate from skill-local markdown templates and preserves a cleaner catalog boundary.
