# Work Order Intelligent Dispatch — v0.2.3 Example

This end-to-end greenfield example demonstrates the v0.2.3 contracts.

Start with:

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

The detailed modular assets remain under `docs/product/business-modeling/` and the canonical Work Item remains under `docs/product/work-items/BM-001-work-order-intelligent-dispatch/`.

The example specifically demonstrates:

- the sole user-facing overview;
- canonical Work Item file placement and State Schema;
- structured Index / Dictionary / Schema contracts;
- `BMD-xxx` decision compression;
- stable Action IDs and lifecycle ownership;
- separate Dispatch Decision and Assignment lifecycles;
- `MaintainableAsset` instead of the ambiguous `Asset / Facility`;
- arrival cost as Dispatch Candidate context rather than a Location intrinsic attribute;
- mandatory consistency validation before overview compilation.
