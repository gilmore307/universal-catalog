# storage/templates

Catalog-owned output template files live here when this repository truly owns them.

## Current files

No output template files are registered yet.

## Rule

When a catalog item uses `kind = output` and `payload_format = file`, its `payload` should point to a file stored under this directory unless a later decision expands the boundary.

Do not place skill-local markdown templates here. Markdown docs templates and Codex prompt templates stay in their relevant skills.
