BEGIN TRANSACTION;

-- Self-describing bootstrap fields for the catalog register itself.
INSERT INTO catalog_items (id, kind, key, payload_format, payload, note)
VALUES
  ('fld_A7K3P2Q9', 'field', 'CATALOG_ITEM_ID', 'text', 'id', 'canonical column name for catalog_items.id'),
  ('fld_M4N8X2KD', 'field', 'CATALOG_ITEM_KIND', 'text', 'kind', 'canonical column name for catalog_items.kind'),
  ('fld_R7P1C6LW', 'field', 'CATALOG_ITEM_KEY', 'text', 'key', 'canonical column name for catalog_items.key'),
  ('fld_T9V2H5QS', 'field', 'CATALOG_ITEM_PAYLOAD_FORMAT', 'text', 'payload_format', 'canonical column name for catalog_items.payload_format'),
  ('fld_B6J4N8XP', 'field', 'CATALOG_ITEM_PAYLOAD', 'text', 'payload', 'canonical column name for catalog_items.payload'),
  ('fld_D3W7K1RM', 'field', 'CATALOG_ITEM_NOTE', 'text', 'note', 'canonical column name for catalog_items.note'),
  ('fld_P8L2C4TY', 'field', 'CATALOG_ITEM_CREATED_AT', 'text', 'created_at', 'canonical column name for catalog_items.created_at'),
  ('fld_Q5F9M2NZ', 'field', 'CATALOG_ITEM_UPDATED_AT', 'text', 'updated_at', 'canonical column name for catalog_items.updated_at'),
  ('rep_H6S3V8LA', 'repo', 'UNIVERSAL_CATALOG_REPO', 'text', 'universal-catalog', 'canonical repository name for this catalog'),
  ('pth_C4X8N2ME', 'path', 'UNIVERSAL_CATALOG_ROOT_PATH', 'text', '/root/projects/universal-catalog', 'repository root path for the universal-catalog checkout'),
  ('cfg_J7D1K5RP', 'config', 'DEFAULT_TIMEZONE', 'text', 'America/New_York', 'default shared timezone for this server');

COMMIT;
