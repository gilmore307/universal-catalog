# Task

## Task Status Summary

- `accepted`: 16
- `ready_to_dispatch`: 3

## Active Tasks

None.

## Next Dispatch

- `task_register_first_shared_output_template` — `ready_to_dispatch` — register the first real shared output template when a project output or record artifact is ratified
- `task_extend_term_set` — `ready_to_dispatch` — extend the approved term set as additional specialized or project-defined terms are stabilized
- `task_add_helper_consumer_example` — `ready_to_dispatch` — add the first real consumer integration example for the `src/` helper surface

## Pending Acceptance

None.

## Blocked Tasks

None.

## Recently Accepted

- implemented the initial read-only helper surface under `src/` with kind validation, row mapping, and lookup helpers over an injected PostgreSQL query executor
- registered the first ratified shared workflow slot fields for execution-key templates in the catalog register
- registered the first ratified shared workflow slot fields for completion-receipt templates in the catalog register
- registered the first ratified shared workflow slot fields for acceptance-receipt templates in the catalog register
- registered the first ratified shared workflow slot fields for maintenance-output templates in the catalog register
- clarified that markdown documentation templates and the Codex task prompt stay in their relevant skills rather than in `universal-catalog`
- reserved `storage/templates/` for future project-related output templates instead of skill-local markdown files
- added a dedicated `output` kind for catalog-owned output templates
- added a dedicated `script` kind and registered the current helper source-file addresses under `src/` as full absolute locators for automation
- added a dedicated `term` kind and registered the first approved term definitions in the catalog register
- registered the first secret-alias config reference and added a read-only helper path for resolving secret aliases through the local secrets registry
- configured the local active PostgreSQL database named `openclaw` and resolved its URL through the `openclaw/database-url` secret alias
- replaced schema/seed rebuild maintenance with append-only migrations plus the `schema_migrations` ledger
- removed default full-row revision snapshots so future high-volume data preserves disk headroom and active data integrity over exhaustive row-level audit history
- clarified that migrations are for schema and small static/bootstrap reference data only; future high-volume active datasets should live in the database rather than being duplicated into Git as literal SQL rows
- registered network-framework Internet proxy VPN defaults for the Tailscale exit-node slice: provider, exit-node config key, LAN-access config key, and default exit-node host name

## Notes

- This repository is still intentionally small.
- The current milestone includes the long-lived PostgreSQL register boundary, append-only migrations, and the minimal read-only helper surface under `src/`.
- The next accepted storage expansion should keep output templates, script locators, term definitions, and secret-alias config references inside the same read-only catalog boundary rather than letting them sprawl into unrelated repos.
