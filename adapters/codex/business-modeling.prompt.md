# Runtime Prompt: Product Business Modeling v0.2.3

1. Read `docs/product/BUSINESS_MODEL_OVERVIEW.md` first when present.
2. Resolve the runtime adapter and BM Work Item binding.
3. Use canonical root files and the frozen `STATE.md` schema.
4. Model business semantics with stable IDs; never use data fields as Core attributes.
5. Route D2 / D3 decisions through `BMD-xxx` and include decision compression in the overview.
6. After every persistent Core write, run consistency validation and generate `MODEL_CONSISTENCY_REPORT.md`.
7. Refresh `BUSINESS_MODEL_OVERVIEW.md`, then compile requested professional downstream views.
8. At normal completion, show only the overview to the user.
