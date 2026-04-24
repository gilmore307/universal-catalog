# Scope

## Purpose

Define the shared catalog layer for server-wide values, output artifacts, approved terms, source locators, and other stable references that OpenClaw-managed projects and automation should reuse consistently.

## In Scope

- server-wide field registrations
- server-wide output template registrations
- server-wide approved term definitions and glossary entries
- repository identifiers that should be shared consistently across projects
- path values that should be addressed through stable catalog ids
- script-facing full-address locators for concrete source files used by automation
- shared non-sensitive configuration defaults such as timezone
- shared secret-alias config references that point to the local secrets registry without exposing secret values
- PostgreSQL migrations and a migration ledger for long-lived active catalog data
- repository docs and a small read-only helper surface for catalog lookup

## Out of Scope

- secrets, auth material, or security policy
- runtime application data, user content, or operational history
- project-specific business logic
- write-side service orchestration or remote control behavior
- source-code import indirection or module resolution tricks beyond explicit script addresses
- skill-local markdown templates such as project-doc templates or Codex prompt templates
- non-catalog documentation debates unrelated to repository purpose

## Owner Intent

Keep globally shared references explicit, stable, and cheap to change. The repository should reduce downstream edit churn by letting consumers resolve approved values through stable ids instead of hard-coding volatile values everywhere.

## Boundary Rules

- Only server-wide reusable values and artifacts belong in this repository.
- The active `universal_catalog` table lives in the local PostgreSQL database named `openclaw`; `storage/dictionary/schema_migrations/` owns append-only schema/data migrations used to initialize and evolve it.
- Output template files belong under `storage/templates/` only when this repository truly owns them.
- Script entries point to concrete source files that automation may address directly.
- `src/` stays read-only and executor-injected rather than growing into connection management or write-side administration.
- Git history plus the database `schema_migrations` ledger are the change-history layers for catalog evolution.

## Out-of-Scope Signals

A request is outside this repository boundary if it requires:

- a value used by only one project with no shared reuse case
- a secret or security-sensitive configuration value itself
- write-side behavior, command dispatch, or runtime orchestration
- long-lived application state instead of stable reference data
- skill-local prompt or markdown guidance that belongs in a skill bundle
