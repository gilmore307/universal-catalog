BEGIN TRANSACTION;

-- Bootstrap fields for the catalog register itself and the first ratified shared workflow slots.
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
  ('fld_7X5H7N6Y', 'field', 'TASK_IDENTITY', 'text', 'task_identity', 'canonical shared field name for task identity slots'),
  ('fld_ZGTS8P3D', 'field', 'WORKFLOW_IDENTITY', 'text', 'workflow_identity', 'canonical shared field name for workflow identity slots'),
  ('fld_4YALJN0B', 'field', 'REPOSITORY_PATH', 'text', 'repository_path', 'canonical shared field name for repository path slots'),
  ('fld_PVUM9JE5', 'field', 'TASK_GOAL', 'text', 'task_goal', 'canonical shared field name for task goal slots'),
  ('fld_RSO93XMM', 'field', 'TASK_SCOPE', 'text', 'task_scope', 'canonical shared field name for task scope slots'),
  ('fld_J6FURQOE', 'field', 'ACCEPTANCE_REFERENCE', 'text', 'acceptance_reference', 'canonical shared field name for acceptance reference slots'),
  ('fld_F4OFEVFJ', 'field', 'DECISION_REFERENCES', 'text', 'decision_references', 'canonical shared field name for decision reference slots'),
  ('fld_YLTWJKTJ', 'field', 'ALLOWED_PATHS', 'text', 'allowed_paths', 'canonical shared field name for allowed path slots'),
  ('fld_H2OBUVA0', 'field', 'BLOCKED_PATHS', 'text', 'blocked_paths', 'canonical shared field name for blocked path slots'),
  ('fld_0YVMMK1A', 'field', 'TEST_EXPECTATION', 'text', 'test_expectation', 'canonical shared field name for test expectation slots'),
  ('fld_U27NM0BU', 'field', 'TEST_COMMANDS', 'text', 'test_commands', 'canonical shared field name for test command slots'),
  ('fld_RSIXOXTB', 'field', 'EXPECTED_OUTPUT', 'text', 'expected_output', 'canonical shared field name for expected output slots'),
  ('fld_5NFMUN7N', 'field', 'CONSTRAINTS', 'text', 'constraints', 'canonical shared field name for execution constraint slots'),
  ('fld_Z7TPA496', 'field', 'OUTPUT_REFERENCE', 'text', 'output_reference', 'canonical shared field name for output reference slots'),
  ('fld_H6WM9AVU', 'field', 'COMPLETION_RECEIPT_REFERENCE', 'text', 'completion_receipt_reference', 'canonical shared field name for completion receipt reference slots'),
  ('rep_H6S3V8LA', 'repo', 'UNIVERSAL_CATALOG_REPO', 'text', 'universal-catalog', 'canonical repository name for this catalog'),
  ('pth_C4X8N2ME', 'path', 'UNIVERSAL_CATALOG_ROOT_PATH', 'text', '/root/projects/universal-catalog', 'repository root path for the universal-catalog checkout'),
  ('cfg_J7D1K5RP', 'config', 'DEFAULT_TIMEZONE', 'text', 'America/New_York', 'default shared timezone for this server');

COMMIT;
