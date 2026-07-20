# Product Business Modeling Rules

- Use `docs/product/business-modeling/` as source of truth for business semantics.
- Use `docs/product/model-triggers/` for upstream changes, downstream gaps and cross-cluster conflicts.
- Keep `schema-view.json` limited to objects, domains, categories, business attributes and example content.
- Treat database/backend/frontend artifacts as downstream views, not core semantics.
- Ask for human confirmation before D2/D3 changes.
