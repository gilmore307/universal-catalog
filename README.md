# universal-catalog

Shared catalog for server-wide field definitions, output templates, approved terms, script-facing source locators, default status vocabularies, secret-alias config references, and other stable referenced values used by OpenClaw-managed projects.

This repository is managed by OpenClaw. OpenClaw owns project route, docs, acceptance, and maintenance. Codex may implement bounded tasks when explicitly dispatched.

## Purpose

- centralize server-wide catalog items that should be reviewed instead of duplicated
- assign each catalog item a stable random id such as `pth_A7K3P2Q9`, `out_T7M2KQ4P`, or `scr_YO00DVVP`
- let downstream code dereference catalog values so path, script locator, field, output, and approved-term changes stay cheap

## Project focus

- field registrations
- output templates
- approved term definitions
- repository identifiers
- path values that should be referenced through stable ids
- script-facing full-address locators for concrete source files used by automation
- default status vocabularies used by shared task, review, and maintenance artifacts
- shared non-sensitive configuration values such as the default timezone
- shared secret-alias config references that point to local secrets-registry entries without storing secret values in the catalog
- lightweight helper code for catalog lookup

Do not store secrets, security-sensitive configuration values, runtime application data, or skill-local markdown templates here.

## Current kind set

- `field`
- `output`
- `repo`
- `path`
- `config`
- `term`
- `script`
- `task_lifecycle_state`
- `review_readiness`
- `acceptance_outcome`
- `test_status`
- `maintenance_status`
- `docs_status`

## Repository layout

- `docs/` — formal project docs spine
- `storage/dictionary/` — SQL schema and seed data for active catalog items
- `storage/templates/` — output template files referenced by catalog entries
- `src/` — read-only helper surface for catalog lookup

## Current state

This repository currently defines the documentation spine, the PostgreSQL register skeleton, an initial read-only Node helper surface under `src/`, and the storage boundary for future output templates under `storage/templates/`.

The active seed currently includes the catalog register's own column names, base repo/path/config entries, ratified shared workflow slot fields, default status vocabulary values for task, review, and maintenance artifacts, script entries that provide full addresses for the current helper source files under `src/`, the first approved term definitions, and the first config entry that points to a local secrets-registry alias instead of storing a secret value.

Markdown documentation templates and Codex prompt templates now stay in their relevant skills instead of being registered here.
