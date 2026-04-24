'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');

const {
  CATALOG_KINDS,
  assertCatalogKind,
  createCatalogReader,
  isCatalogKind,
  mapCatalogItemRow,
} = require('./index');

function createRow(overrides) {
  return {
    id: 'fld_A7K3P2Q9',
    kind: 'field',
    key: 'CATALOG_ITEM_ID',
    payload_format: 'text',
    payload: 'id',
    note: 'canonical column name for catalog_items.id',
    created_at: '2026-04-23T00:00:00.000Z',
    updated_at: '2026-04-23T00:00:00.000Z',
    ...overrides,
  };
}

test('catalog kinds stay fixed to the documented set', () => {
  assert.deepEqual(CATALOG_KINDS, ['field', 'output', 'repo', 'path', 'config', 'term', 'script', 'task_lifecycle_state', 'review_readiness', 'acceptance_outcome', 'test_status', 'maintenance_status', 'docs_status']);
  assert.equal(isCatalogKind('repo'), true);
  assert.equal(isCatalogKind('term'), true);
  assert.equal(isCatalogKind('script'), true);
  assert.equal(isCatalogKind('task_lifecycle_state'), true);
  assert.equal(isCatalogKind('review_readiness'), true);
  assert.equal(isCatalogKind('acceptance_outcome'), true);
  assert.equal(isCatalogKind('test_status'), true);
  assert.equal(isCatalogKind('maintenance_status'), true);
  assert.equal(isCatalogKind('docs_status'), true);
  assert.equal(isCatalogKind('unknown'), false);
  assert.equal(assertCatalogKind('config'), 'config');
  assert.throws(() => assertCatalogKind('unknown'), /Invalid catalog kind: unknown/);
});

test('mapCatalogItemRow converts snake_case columns into readable JS keys', () => {
  assert.deepEqual(mapCatalogItemRow(createRow()), {
    id: 'fld_A7K3P2Q9',
    kind: 'field',
    key: 'CATALOG_ITEM_ID',
    payloadFormat: 'text',
    payload: 'id',
    note: 'canonical column name for catalog_items.id',
    createdAt: '2026-04-23T00:00:00.000Z',
    updatedAt: '2026-04-23T00:00:00.000Z',
  });
});

test('getItemById uses a read-only catalog_items query', async () => {
  const calls = [];
  const reader = createCatalogReader(async (sql, params) => {
    calls.push({ sql, params });
    return { rows: [createRow()] };
  });

  const item = await reader.getItemById('fld_A7K3P2Q9');

  assert.equal(item.id, 'fld_A7K3P2Q9');
  assert.match(calls[0].sql, /FROM catalog_items/);
  assert.match(calls[0].sql, /WHERE id = \$1/);
  assert.deepEqual(calls[0].params, ['fld_A7K3P2Q9']);
});

test('getItemByKey returns null when no row matches', async () => {
  const reader = createCatalogReader(async () => []);

  const item = await reader.getItemByKey('MISSING_KEY');

  assert.equal(item, null);
});

test('require item helpers throw clear errors when the item is missing', async () => {
  const reader = createCatalogReader(async () => ({ rows: [] }));

  await assert.rejects(() => reader.requireItemById('fld_missing'), /Catalog item not found for id: fld_missing/);
  await assert.rejects(() => reader.requireItemByKey('MISSING_KEY'), /Catalog item not found for key: MISSING_KEY/);
});

test('lookup helpers reject blank id and key inputs', async () => {
  const reader = createCatalogReader(async () => ({ rows: [] }));

  await assert.rejects(() => reader.getItemById(''), /id must be a non-empty string/);
  await assert.rejects(() => reader.getItemByKey('   '), /key must be a non-empty string/);
});

test('require helpers still work when destructured from the reader object', async () => {
  const requireItemById = createCatalogReader(async () => ({ rows: [createRow()] })).requireItemById;

  const item = await requireItemById('fld_A7K3P2Q9');

  assert.equal(item.id, 'fld_A7K3P2Q9');
});

test('listItemsByKind validates kind and returns mapped items', async () => {
  const reader = createCatalogReader(async (sql, params) => {
    assert.match(sql, /WHERE kind = \$1/);
    assert.match(sql, /ORDER BY key ASC/);
    assert.deepEqual(params, ['path']);

    return {
      rows: [
        createRow({
          id: 'pth_C4X8N2ME',
          kind: 'path',
          key: 'UNIVERSAL_CATALOG_ROOT_PATH',
          payload: '/root/projects/universal-catalog',
        }),
      ],
    };
  });

  const items = await reader.listItemsByKind('path');

  assert.equal(items.length, 1);
  assert.equal(items[0].kind, 'path');
  assert.equal(items[0].payloadFormat, 'text');
  await assert.rejects(
    async () => reader.listItemsByKind('workflow'),
    /Invalid catalog kind: workflow/
  );
});

test('createCatalogReader rejects unsupported query result shapes', async () => {
  const reader = createCatalogReader(async () => ({ value: [] }));

  await assert.rejects(
    () => reader.getItemById('fld_A7K3P2Q9'),
    /Invalid catalog query result: expected an array of rows or an object with a rows array/
  );
});
