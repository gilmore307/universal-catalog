# universal-catalog

Shared catalog for server-wide field definitions, output templates, and other stable referenced values used by future trading-oriented projects.

> Note: the local path and Git remote may still use the earlier `universal-dictionary` name until repository rename work is completed.

## Purpose

- centralize server-wide catalog items that should be reviewed instead of duplicated
- assign each catalog item a stable random id such as `pth_A7K3P2Q9`
- let downstream code dereference catalog values so path, field, and template changes stay cheap

## Repository layout

- `docs/` — formal project docs spine
- `storage/dictionary/` — SQL schema and seed data for active catalog items
- `storage/templates/` — template files referenced by catalog entries
- `src/` — future helper surface for reading catalog items by id

## Current state

This repository currently defines the initial documentation spine and storage skeleton. Templates and helper code can stay minimal until the first real consuming workflow arrives.
