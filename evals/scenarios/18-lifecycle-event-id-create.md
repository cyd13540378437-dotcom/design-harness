# 18. Lifecycle Event ID Create

## Given

The target project has the v0.1.3 Design Harness template, including `docs/design/project-memory/` and `docs/design/outputs/`.

## When

The user asks Codex to create a new settings empty-state optimization Work Item.

## Then

- The state decision is `CREATE`.
- The new Work Item uses an ID like `yyyy-mm-dd-hhmm-UX-001`.
- `state_id` and `event_id` match.
- The directory uses `<event_id>-<slug>`.
- `docs/design/WORK_ITEMS.md` indexes the event.
- Existing legacy `DE-xxx` Work Items are not renamed.

