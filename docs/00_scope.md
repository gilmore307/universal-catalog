# Scope

## Purpose

Define the shared catalog layer for server-wide values that future trading-oriented services should reference consistently.

## In Scope

- server-wide field registrations
- server-wide output template registrations
- path or locator values that should be addressed through stable catalog ids
- SQL storage for the active catalog register
- repository docs and a future helper surface for catalog lookup

## Out of Scope

- secrets, auth material, or security policy
- runtime trading, order, position, or market data
- project-specific business logic
- source-code import indirection or module resolution tricks
- non-catalog documentation debates unrelated to repository purpose

## Owner Intent

Keep globally shared references explicit, stable, and cheap to change. The repository should reduce downstream edit churn by letting consumers resolve approved values through stable random ids instead of hard-coding volatile values everywhere.
