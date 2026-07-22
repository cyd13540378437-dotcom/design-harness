# Product Model State Steward Reference v0.2.3

The runtime adapter should delegate BM state operations to the installed state steward when available.

## Steward responsibilities

- return `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`;
- create/update canonical `STATE.md`;
- update `PRODUCT_WORK_ITEMS.md` as an index;
- record decision wait and closure readiness;
- protect sealed Work Items.

## Frozen fields

Use exactly the Core state fields. Do not substitute runtime-specific fields such as `awaiting_user`, `primary_entry_mode` or `gate`.

## Closure readiness

Requires:

- canonical Work Item files in correct locations;
- acceptance criteria satisfied or explicitly deferred;
- no unresolved D2/D3 content represented as confirmed;
- latest consistency report has no blocking errors;
- `BUSINESS_MODEL_OVERVIEW.md` is current;
- required downstream views and triggers are updated;
- explicit user closure approval before seal.

The steward does not model semantics or compile the overview.
