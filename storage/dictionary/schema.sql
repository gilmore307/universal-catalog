-- Active catalog register schema.
-- Target engine: PostgreSQL.

CREATE TABLE IF NOT EXISTS catalog_items (
  id TEXT PRIMARY KEY,
  kind TEXT NOT NULL CHECK (kind IN ('field', 'output', 'repo', 'path', 'config', 'term', 'script')),
  key TEXT NOT NULL UNIQUE,
  payload_format TEXT NOT NULL CHECK (payload_format IN ('text', 'file')),
  payload TEXT NOT NULL,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_catalog_items_kind
ON catalog_items(kind);
