# src

Read-only helper surface for `universal-catalog`.

## Intended use

- concentrated catalog lookup helpers
- thin reader utilities that resolve active catalog items by stable id or key
- readable local reference layers above raw random ids

## Current files

- `catalog-types.js` — current allowed catalog kinds and kind validation helpers, including `term` and `script`
- `catalog-reader.js` — row mapping plus read-only lookup helpers built around an injected query executor
- `index.js` — stable entrypoint exports for downstream consumers
- `catalog-reader.test.js` — Node tests for the helper surface

## Current boundary

- read-only queries against `catalog_items`
- no connection management
- no registration or write paths
- no future-kind or workflow invention beyond the current schema

Downstream services should provide the PostgreSQL client or query executor and keep raw catalog ids concentrated behind a local lookup layer.
