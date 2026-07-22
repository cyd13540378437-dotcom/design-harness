# Product Model State Steward Contract v0.2.3

The state steward manages Work Item binding, `STATE.md`, and `PRODUCT_WORK_ITEMS.md` only. It does not perform business modeling or approve product decisions.

## Binding decisions

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

## Frozen State fields

```text
schema_version, state_id, title, slug, capability_id, entry_mode,
binding_decision, status, phase, knowledge_status, awaiting_human,
sealed, related_triggers, predecessors, created_at, updated_at,
completed_at, extensions
```

Runtime-only information may appear under `extensions` or in the body. The steward must not create parallel authority fields.

Before recommending closure, it verifies canonical root files, the latest consistency report, current overview compilation, D2 / D3 decision status, trigger synchronization, and explicit human closure approval.
