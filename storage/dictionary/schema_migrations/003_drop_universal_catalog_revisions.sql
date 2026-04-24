-- Remove full-row revision snapshots to keep the active database storage-efficient.
-- Target engine: PostgreSQL.

DROP TRIGGER IF EXISTS trg_universal_catalog_revision ON universal_catalog;
DROP FUNCTION IF EXISTS record_universal_catalog_revision();
DROP TABLE IF EXISTS universal_catalog_revisions;
