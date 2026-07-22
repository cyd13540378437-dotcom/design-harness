# Product Business Modeling Core Contract v0.2.3

The Core owns business-model semantics. Runtime adapters only expose it to an agent tool.

## Default user entry

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

This is a derived product-owner view, not source of truth. Ordinary users should not need to inspect all detailed assets.

## Source of truth and task roots

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

## Hard contracts

- Canonical Work Item root files are `STATE.md`, `MODELING_CONSUMPTION.md`, `MODELING_OUTPUT.md`, and `DECISION_NOTES.md`.
- Runtime metadata belongs under the State `extensions` field or in the body.
- Core models business attributes, not data fields.
- Dictionary, Index and Schema use stable IDs and exact structures.
- Actions and transitions use stable references; one lifecycle belongs to one object.
- Context-dependent values are relational, evaluative or derived—not intrinsic.
- D2 / D3 decisions use `BMD-xxx` and are compressed into the overview.
- Every persistent Core write is followed by consistency validation and overview compilation.
- AI cannot seal without explicit human approval.
