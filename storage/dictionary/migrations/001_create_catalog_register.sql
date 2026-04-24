-- Create the long-lived universal-catalog active register and migration ledger.
-- Target engine: PostgreSQL.

CREATE TABLE IF NOT EXISTS schema_migrations (
  version TEXT PRIMARY KEY,
  filename TEXT NOT NULL,
  checksum_sha256 TEXT NOT NULL,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS catalog_items (
  id TEXT PRIMARY KEY,
  kind TEXT NOT NULL CHECK (kind IN ('field', 'output', 'repo', 'path', 'config', 'term', 'script', 'task_lifecycle_state', 'review_readiness', 'acceptance_outcome', 'test_status', 'maintenance_status', 'docs_status')),
  key TEXT NOT NULL UNIQUE,
  payload_format TEXT NOT NULL CHECK (payload_format IN ('text', 'file')),
  payload TEXT NOT NULL,
  note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_catalog_items_kind
ON catalog_items(kind);

CREATE INDEX IF NOT EXISTS idx_catalog_items_updated_at
ON catalog_items(updated_at);

CREATE TABLE IF NOT EXISTS catalog_item_revisions (
  revision_id BIGSERIAL PRIMARY KEY,
  item_id TEXT NOT NULL,
  operation TEXT NOT NULL CHECK (operation IN ('insert', 'update')),
  kind TEXT NOT NULL,
  key TEXT NOT NULL,
  payload_format TEXT NOT NULL,
  payload TEXT NOT NULL,
  note TEXT,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_catalog_item_revisions_item_id
ON catalog_item_revisions(item_id);

CREATE INDEX IF NOT EXISTS idx_catalog_item_revisions_recorded_at
ON catalog_item_revisions(recorded_at);

CREATE OR REPLACE FUNCTION set_catalog_item_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  IF ROW(NEW.kind, NEW.key, NEW.payload_format, NEW.payload, NEW.note)
     IS DISTINCT FROM
     ROW(OLD.kind, OLD.key, OLD.payload_format, OLD.payload, OLD.note) THEN
    NEW.updated_at = NOW();
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION record_catalog_item_revision()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    INSERT INTO catalog_item_revisions (item_id, operation, kind, key, payload_format, payload, note)
    VALUES (NEW.id, 'insert', NEW.kind, NEW.key, NEW.payload_format, NEW.payload, NEW.note);
    RETURN NEW;
  END IF;

  IF TG_OP = 'UPDATE' THEN
    IF ROW(NEW.kind, NEW.key, NEW.payload_format, NEW.payload, NEW.note)
       IS DISTINCT FROM
       ROW(OLD.kind, OLD.key, OLD.payload_format, OLD.payload, OLD.note) THEN
      INSERT INTO catalog_item_revisions (item_id, operation, kind, key, payload_format, payload, note)
      VALUES (NEW.id, 'update', NEW.kind, NEW.key, NEW.payload_format, NEW.payload, NEW.note);
    END IF;
    RETURN NEW;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_catalog_items_updated_at ON catalog_items;
CREATE TRIGGER trg_catalog_items_updated_at
BEFORE UPDATE ON catalog_items
FOR EACH ROW
EXECUTE FUNCTION set_catalog_item_updated_at();

DROP TRIGGER IF EXISTS trg_catalog_items_revision ON catalog_items;
CREATE TRIGGER trg_catalog_items_revision
AFTER INSERT OR UPDATE ON catalog_items
FOR EACH ROW
EXECUTE FUNCTION record_catalog_item_revision();

INSERT INTO catalog_item_revisions (item_id, operation, kind, key, payload_format, payload, note)
SELECT id, 'insert', kind, key, payload_format, payload, note
FROM catalog_items item
WHERE NOT EXISTS (
  SELECT 1
  FROM catalog_item_revisions revision
  WHERE revision.item_id = item.id
);
