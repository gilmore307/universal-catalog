'use strict';

const CATALOG_KINDS = Object.freeze([
  'field',
  'template',
  'repo',
  'path',
  'config',
  'term',
]);

function isCatalogKind(value) {
  return CATALOG_KINDS.includes(value);
}

function assertCatalogKind(value) {
  if (!isCatalogKind(value)) {
    throw new Error(
      `Invalid catalog kind: ${String(value)}. Expected one of: ${CATALOG_KINDS.join(', ')}`
    );
  }

  return value;
}

module.exports = {
  CATALOG_KINDS,
  assertCatalogKind,
  isCatalogKind,
};
