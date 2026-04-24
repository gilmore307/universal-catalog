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
- path or locator values that should be referenced through stable ids
- lightweight helper code for catalog lookup when implementation begins

Do not store secrets, security configuration, or runtime trading data here.

## Repository layout

- `docs/` — formal project docs spine
- `storage/dictionary/` — SQL schema and seed data for active catalog items
- `storage/templates/` — template files referenced by catalog entries
- `src/` — future helper surface for reading catalog items by id

## Current state

This repository currently defines the initial documentation spine and storage skeleton. The first seed examples can be the catalog register's own column names so the repository bootstraps itself with a tiny real dataset.
