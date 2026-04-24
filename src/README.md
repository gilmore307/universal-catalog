# src

Read-only helper surface for `universal-catalog`.

## Intended use

- concentrated catalog lookup helpers
- thin reader utilities that resolve active catalog items by stable id or key
- helper utilities that resolve registered secret aliases through the local secrets registry without storing secret values in the catalog
- readable local reference layers above raw random ids

## Current files

- `catalog-types.js` — current allowed catalog kinds and kind validation helpers, including `output`, `term`, `script`, and the default status-vocabulary kinds
- `catalog-reader.js` — row mapping plus read-only lookup helpers built around an injected query executor
- `secret-resolver.js` — read-only helper that resolves catalog `config` entries holding secret aliases through `/root/secrets/registry.json`
- `index.js` — stable entrypoint exports for downstream consumers
- `catalog-reader.test.js` — Node tests for the helper surface

## Current boundary

- read-only queries against `universal_catalog`
- read-only lookup of local secret aliases through the secrets registry
- no connection management
- no registration or write paths
- no secret values stored in the catalog
- no future-kind or workflow invention beyond the current schema

Downstream services should provide the PostgreSQL client or query executor and keep raw catalog ids concentrated behind a local lookup layer.
