# Product Business Modeling Core

Use the `product-business-modeling` Core for business model tasks.

## Required behavior

- Treat `docs/product/business-modeling/` as the business model source of truth.
- Use `docs/product/model-triggers/` for passive triggers; do not create `model-requests/`.
- For each substantial modeling task, create or resume a BM Work Item under `docs/product/work-items/`.
- Preserve the distinction between business attributes and data fields.
- Do not write database fields into core business model assets.
- Do not confirm D2/D3 product semantics without explicit human decision.
- Do not seal a task or decision without explicit user approval.
- When compiling downstream views, write only to `downstream-views/*`.
