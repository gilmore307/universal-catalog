-- Active catalog register schema.
-- Apply with: sqlite3 /tmp/universal-catalog.db < storage/dictionary/schema.sql

CREATE TABLE IF NOT EXISTS catalog_items (
  id TEXT PRIMARY KEY,
  kind TEXT NOT NULL CHECK (kind IN ('path', 'template', 'field')),
  key TEXT NOT NULL UNIQUE,
  payload_format TEXT NOT NULL CHECK (payload_format IN ('text', 'file')),
  payload TEXT NOT NULL,
  note TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_catalog_items_kind
ON catalog_items(kind);
