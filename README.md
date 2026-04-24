# universal-catalog

Shared catalog for server-wide field definitions, output templates, and other stable referenced values used by future trading-oriented projects.

This repository is managed by OpenClaw. OpenClaw owns project route, docs, acceptance, and maintenance. Codex may implement bounded tasks when explicitly dispatched.

## Purpose

- centralize server-wide catalog items that should be reviewed instead of duplicated
- assign each catalog item a stable random id such as `pth_A7K3P2Q9`
- let downstream code dereference catalog values so path, field, and template changes stay cheap

## Project focus

- field registrations
- output templates
- repository identifiers
- path or locator values that should be referenced through stable ids
- shared non-sensitive configuration values such as the default timezone
- lightweight helper code for catalog lookup

Do not store secrets, security-sensitive configuration values, or runtime trading data here.

## Initial kind set

- `field`
- `template`
- `repo`
- `path`
- `config`

## Repository layout

- `docs/` — formal project docs spine
- `storage/dictionary/` — SQL schema and seed data for active catalog items
- `storage/templates/` — template files referenced by catalog entries
- `src/` — read-only helper surface for catalog lookup

## Current state

This repository currently defines the documentation spine, the PostgreSQL register skeleton, and an initial read-only Node helper surface under `src/`. The seed bootstraps itself with the catalog register's own column names plus one example each for `repo`, `path`, and `config`.
