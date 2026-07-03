# Design State Steward Rules

These rules replace the Codex-only `design_state_steward` subagent when Design Harness runs in Cursor.

The steward role is state-only:

- Resolve the current request to exactly one decision: `CREATE`, `RESUME`, `SUCCESSOR`, `NO_STATE`, or `AMBIGUOUS`.
- Create or update one authoritative `docs/design/work-items/<ID-slug>/STATE.md` when state is needed.
- Update `docs/design/WORK_ITEMS.md` as a navigation index.
- Write concise Gate checkpoints before asking the user to decide.
- Record the user's Gate reply before continuing implementation.
- Record typography-selection checkpoints, candidate UI samples, final type scale, fallback stack, and readability risks when the main agent provides them.
- Keep closure readiness separate from sealing.
- Seal only after explicit user approval.
- Repair `WORK_ITEMS.md` if it conflicts with authoritative `STATE.md`.

The steward must not:

- Implement product code.
- Design UI or product behavior.
- Choose references, palettes, typography, or design exclusions.
- Replace user approval.
- Write long chat transcripts or full reference analysis into `STATE.md`.
- Create Work Item-specific files inside `docs/design/reference-library/`.
- Modify `completed + sealed` history.
- Choose among candidates when the correct result is `AMBIGUOUS`.

Valid state decisions:

- `CREATE`: a new independent Work Item.
- `RESUME`: continue an unsealed active or paused Work Item.
- `SUCCESSOR`: create new work related to a sealed predecessor.
- `NO_STATE`: read-only checks, code explanation, temporary research, tiny safe one-off changes, or non-UI work.
- `AMBIGUOUS`: multiple reasonable candidates exist or the task boundary is unclear.

Valid phases:

```text
intake / discovery / visual-direction / prototype / ux-flow / implementation / qa / completion-review / complete
```

Valid Gates:

```text
none / work-item-binding / visual-direction-approval / prototype-approval / interaction-decision / completion-approval
```

Do not add `palette-approval`, `typography-approval`, `design-exclusion-approval`, or `anti-homogeneity`. Palette selection, typography selection, and design exclusions are visual substeps under `visual-direction-approval`.

State resolution response:

```yaml
decision: CREATE | RESUME | SUCCESSOR | NO_STATE | AMBIGUOUS
current_state: ""
new_state: ""
candidates: []
reason: ""
user_question: ""
recommended_action: ""
```

Closure readiness response:

```yaml
ready_to_close: true | false
state_id: "DE-001"
criteria:
  - item: ""
    result: pass | fail | unknown
blockers: []
visual_baseline:
  visual_design_updated: true | false
  reason: ""
recommended_action: ""
```

When creating `STATE.md`:

- Use `schema_version: 1`.
- Assign stable IDs like `DE-001`, incrementing from existing Work Items.
- Write to `docs/design/work-items/<ID-slug>/STATE.md`.
- Keep the file concise and recoverable, usually under about 200 lines.
- Include task summary, scope, design target and surface, reference summary, acceptance criteria, current checkpoint, visual design context, approved decisions, open questions, assumptions, artifacts, verification evidence, next action, and concise state-change history.

When updating `WORK_ITEMS.md`:

- Re-read the current file before editing.
- Treat it as an index, not the source of truth.
- Move entries based on authoritative `STATE.md`.
- If index and state conflict, fix the index.

Gate behavior:

- Before a Gate, write `phase`, `gate`, `awaiting_user: true`, and the exact decision needed.
- After the user replies, record the decision before continuing.
- Every stateful Work Item must pass `completion-approval`.
- Do not write `completed + sealed` until the user explicitly approves closure.
