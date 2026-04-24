# Decision

## Decision Summary

- DEC-001: keep shared catalog content in its own repository
- DEC-002: position the repository as `universal-catalog`
- DEC-003: use stable random ids for catalog identity
- DEC-004: keep only the active `universal_catalog` table in SQL
- DEC-005: stay off SQLite
- DEC-006: start from a bounded catalog kind set and expand only when justified
- DEC-007: keep the initial helper surface read-only and executor-injected
- DEC-008: register ratified shared workflow slot fields one template at a time
- DEC-009: keep fixed-location repository markdown templates in skills
- DEC-010: add a dedicated `term` kind for approved term definitions
- DEC-011: keep the Codex task prompt markdown template in skills
- DEC-012: use `script` for full source-file addresses consumed by automation
- DEC-013: reserve `storage/templates/` for output templates
- DEC-014: register default status vocabularies as dedicated kinds
- DEC-015: register maintenance and docs status vocabularies
- DEC-016: use `config` entries for secret-alias references, not secret values
- DEC-017: use a long-lived PostgreSQL active database with append-only migrations and a migration ledger
- DEC-018: prioritize disk headroom and active data integrity over exhaustive row-level audit history
- DEC-019: do not mirror high-volume active data into migration files

## Decisions

### DEC-001 Create a dedicated shared catalog repository

- **Date:** 2026-04-23
- **Decision:** Keep server-wide catalog content in its own repository instead of burying it inside a single application repository.
- **Reason:** Shared fields, outputs, terms, script locators, and stable references should be reviewed in one place and reused cleanly across projects.
- **Revisit condition:** Revisit only if all current consumers intentionally collapse into one repository boundary.

### DEC-002 Position the repository as `universal-catalog`

- **Date:** 2026-04-23
- **Decision:** Treat the repository as `universal-catalog` rather than `universal-dictionary` because the boundary includes output-style artifacts in addition to dictionary-style entries.
- **Reason:** `catalog` matches the actual scope better and leaves room for shared output, script, path, and term registrations without forcing awkward naming.
- **Revisit condition:** None.

### DEC-003 Use stable random ids for catalog identity

- **Date:** 2026-04-23
- **Decision:** Use stable random ids with type prefixes such as `pth_`, `out_`, `scr_`, and `fld_` as the immutable identity layer.
- **Reason:** Human-readable keys can change. Stable opaque ids keep downstream code insulated from naming and payload edits.
- **Revisit condition:** Revisit only if a stronger immutable identity layer is intentionally adopted across all consumers.

### DEC-004 Keep only the active `universal_catalog` table in SQL

- **Date:** 2026-04-23
- **Decision:** Keep a single active catalog table in SQL and rely on Git history for change history.
- **Reason:** A separate SQL history table adds complexity without enough value for the current repository stage.
- **Revisit condition:** Revisit only if audit or rollback requirements outgrow Git-backed history.
- **Later change:** DEC-017 supersedes the Git-only history model by adding append-only migrations and `schema_migrations`; DEC-018 later removes default full-row revision snapshots to preserve disk headroom.

### DEC-005 Stay off SQLite

- **Date:** 2026-04-23
- **Decision:** Keep the catalog schema PostgreSQL-oriented rather than SQLite-oriented.
- **Reason:** The repository should align with a server-grade SQL path instead of a lightweight SQLite target.
- **Revisit condition:** Revisit only if SQLite becomes an intentional acceptance target.

### DEC-006 Start from a bounded catalog kind set and expand only when justified

- **Date:** 2026-04-23
- **Decision:** Start with a bounded set of allowed `kind` values and expand only when the shared boundary actually requires it.
- **Reason:** This keeps the catalog taxonomy controlled instead of exploding early.
- **Revisit condition:** None.
- **Later change:** the current set later replaced `template` with `output` and added both `term` and `script`, along with dedicated default status-vocabulary kinds.

### DEC-007 Keep the initial helper surface read-only and executor-injected

- **Date:** 2026-04-24
- **Decision:** Keep the first `src/` helper surface limited to read-only lookup helpers that accept a supplied PostgreSQL query executor instead of owning connection management.
- **Reason:** This gives downstream services a concrete lookup layer now without prematurely freezing a runtime stack, connection model, or broader application boundary inside `universal-catalog`.
- **Revisit condition:** Revisit only if a later accepted boundary intentionally turns this repository into a runtime service.

### DEC-008 Register ratified shared workflow slot fields one template at a time

- **Date:** 2026-04-24
- **Decision:** When a reusable cross-project workflow template is ratified, register its canonical shared field names in `universal-catalog` under `kind = field`.
- **Reason:** This keeps skill-template slot names and catalog governance aligned without pretending undecided wrappers, enums, or full schemas are already standardized.
- **Revisit condition:** Revisit only if a broader shared schema layer is explicitly ratified.

### DEC-009 Keep fixed-location repository markdown templates in skills

- **Date:** 2026-04-24
- **Decision:** Keep markdown templates for files such as `README.md` and `docs/00_scope.md` through `docs/06_memory.md` in their relevant skills instead of registering them in `universal-catalog`.
- **Reason:** Those markdown files are skill-local guidance artifacts, not shared catalog-owned output templates.
- **Revisit condition:** Revisit only if the repository intentionally takes ownership of a true shared output version of one of those files.

### DEC-010 Add a dedicated `term` kind for approved term definitions

- **Date:** 2026-04-24
- **Decision:** Add `term` as an allowed `kind` so `universal-catalog` can register approved specialized terms and self-defined project terms with text definitions.
- **Reason:** Terms and meanings are stable shared reference material, and they should not be forced awkwardly into `field` or `config` entries.
- **Revisit condition:** None.

### DEC-011 Keep the Codex task prompt markdown template in skills

- **Date:** 2026-04-24
- **Decision:** Keep `codex_task_prompt.md` in the relevant OpenClaw/Codex skills instead of registering it as a catalog item.
- **Reason:** It is skill-local markdown instruction material, not a catalog-owned project output template.
- **Revisit condition:** Revisit only if the file becomes a true catalog-owned output artifact.

### DEC-012 Use `script` for full source-file addresses consumed by automation

- **Date:** 2026-04-24
- **Decision:** Use `kind = script` for concrete full addresses to source files that automation may need directly, such as helper files under `src/`.
- **Reason:** Script locators are not generic paths; they are automation-facing references to specific source files and should be explicit.
- **Revisit condition:** Revisit only if a clearer automation-facing locator kind replaces `script` across the repository.

### DEC-013 Reserve `storage/templates/` for output templates

- **Date:** 2026-04-24
- **Decision:** Use `storage/templates/` only for catalog-owned output templates and register those files under `kind = output` when they are real.
- **Reason:** This keeps output artifacts separate from skill-local markdown templates and preserves a cleaner catalog boundary.
- **Revisit condition:** None.

### DEC-014 Register default status vocabularies as dedicated kinds

- **Date:** 2026-04-24
- **Decision:** Add dedicated kinds for `task_lifecycle_state`, `review_readiness`, `acceptance_outcome`, and `test_status`, and register default shared values for each kind in the active `universal_catalog` table.
- **Reason:** Shared task and review artifacts become more automatable when their default value vocabularies are explicit instead of being left fully project-defined.
- **Revisit condition:** Revisit only if a stronger shared status-governance model replaces these defaults.

### DEC-015 Register maintenance and docs status vocabularies

- **Date:** 2026-04-24
- **Decision:** Add dedicated kinds for `maintenance_status` and `docs_status`, and register default shared values for each kind in the active `universal_catalog` table.
- **Reason:** Maintenance outputs become more stable and automatable when overall maintenance condition and docs-drift condition use explicit default vocabularies instead of staying fully project-defined.
- **Revisit condition:** Revisit only if those vocabularies are intentionally superseded by another shared governance layer.

### DEC-016 Use `config` entries for secret-alias references, not secret values

- **Date:** 2026-04-24
- **Decision:** Use `kind = config` to register stable secret-alias references such as token aliases, SSH-key aliases, or password aliases, while keeping the real secret material outside the catalog in the local secrets registry.
- **Reason:** Consumers need reviewed, shared names for secret references, but the catalog must not expose secret values or become a raw dump of local secret file contents.
- **Revisit condition:** Revisit only if the catalog later introduces a more specific secret-reference kind across all consumers.

### DEC-017 Use a long-lived PostgreSQL active database with migrations

- **Date:** 2026-04-24
- **Decision:** Treat the local PostgreSQL database named `openclaw` as the long-lived OpenClaw database, with `universal_catalog` as the catalog table, and evolve it through append-only migrations under `storage/dictionary/schema_migrations/` applied by `scripts/apply-migrations.py`.
- **Reason:** Future catalog usage may involve much more data, so a seed-file rebuild model would become fragile and drift-prone. A migration ledger lets the database stay active while still keeping changes reviewed and replayable.
- **Revisit condition:** Revisit only if the repository intentionally moves to a managed migration framework or a runtime service boundary with equivalent ledger and audit guarantees.


### DEC-018 Prioritize storage efficiency over exhaustive row audit

- **Date:** 2026-04-24
- **Decision:** Do not retain full-row revision snapshots by default for catalog or future high-volume tables. Keep the lightweight migration ledger and Git-reviewed migrations, but avoid storage-amplifying audit tables unless a later task explicitly justifies their disk cost and retention policy.
- **Reason:** Future OpenClaw-managed data volume may be large while local disk is finite. Active data integrity and recoverability are more important than preserving every historical row version.
- **Revisit condition:** Revisit only for narrowly scoped tables where audit value clearly outweighs storage cost and a retention budget is documented.


### DEC-019 Do not mirror high-volume active data into migration files

- **Date:** 2026-04-24
- **Decision:** Use schema migrations for database structure and small static/bootstrap reference data only. Do not store future high-volume active datasets as literal SQL rows in Git migrations; those datasets should live in PostgreSQL, with a separate backup/restore policy when needed.
- **Reason:** Committing large active datasets into migration files duplicates data on disk and turns Git into a second storage source. With finite disk, active data integrity and recoverability matter more than keeping a full textual copy of every row in the repository.
- **Revisit condition:** Revisit only for small, stable reference datasets where Git review value clearly outweighs the duplication cost.
