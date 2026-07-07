# Lifecycle Event ID

Use Lifecycle Event IDs for new v0.1.3 Work Items:

```text
yyyy-mm-dd-hhmm-<DOMAIN>-<SEQ>
```

Examples:

```text
2026-07-06-1530-UX-001
2026-07-06-1605-PD-001
```

## Rules

- Use the project local time available to the Codex session.
- Do not use colons in filesystem paths.
- Supported v0.1.3 domains are `UX` and `PD`.
- Directory names should use `<event_id>-<slug>`.
- New lifecycle states should set `state_id` and `event_id` to the same event ID.
- Legacy `DE-xxx` IDs remain valid and must not be automatically renamed.
- Do not modify `completed + sealed` states just to add `event_id`.

## Legacy Compatibility

Legacy states may keep:

```yaml
state_id: "DE-001"
event_id: ""
domain: "UX"
legacy_ids: []
```

For successor work related to a sealed legacy state, create a new Lifecycle Event ID and list the legacy predecessor in `predecessors`.

## Steward Notes

The Steward may record optional fields:

```yaml
event_id: ""
domain: "UX | PD"
legacy_state: true
execution_profile: "standard | fast"
```

These fields do not replace the required state-resolution decision:

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

