# Product Business Modeling Core v0.2.3

Use the installed `product-business-modeling` adapter for durable product business semantics.

- Default user entry: `docs/product/BUSINESS_MODEL_OVERVIEW.md`.
- Detailed source of truth remains under `docs/product/business-modeling/`.
- Use canonical Work Item root files and the frozen State Schema.
- Do not substitute custom summaries for `MODELING_OUTPUT.md` or the overview.
- After every persistent Core write: consistency validation → overview compilation → applicable downstream views.
- D2 / D3 decisions use `BMD-xxx`; AI does not auto-confirm or seal.
- Business Modeling must not directly modify `docs/design/**`.
