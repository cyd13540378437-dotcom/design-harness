# Design Engineering Harness

Use `/design-engineering` for new product interfaces, important feature pages, cross-page flows, and significant UI/UX redesigns.

Project rules:

- A Claude Code session is not a Work Item.
- Each independent Work Item has one authoritative `docs/design/work-items/<ID-slug>/STATE.md`.
- `docs/design/WORK_ITEMS.md` is an index; `STATE.md` wins on conflict.
- `docs/design/VISUAL_DESIGN.md` is the project visual baseline; later Work Items must read it first.
- Do not reopen or edit `completed + sealed` Work Items. Related follow-up work creates a Successor.
- Before stateful design work, use the `design-state-steward` subagent to return exactly one binding decision: `CREATE`, `RESUME`, `SUCCESSOR`, `NO_STATE`, or `AMBIGUOUS`.
- Before every Gate, have `design-state-steward` write the checkpoint; after every Gate reply, have it record the user decision before continuing.
- Palette confirmation, typography confirmation, and design-exclusion confirmation are substeps of `visual-direction-approval`; do not invent new Gates such as `palette-approval` or `typography-approval`.
- Completion requires explicit user approval at `completion-approval` before sealing.
- The steward manages state only. Product reasoning, visual direction, implementation, and QA stay in the main agent.

Claude Code compatibility:

- The personal skill should be installed at `~/.claude/skills/design-engineering/`.
- The project steward should be installed at `.claude/agents/design-state-steward.md`.
- When the skill says to call `design_state_steward`, use the Claude subagent named `design-state-steward`.
- If `/design-engineering` is unavailable, the skill was not installed for Claude Code; ask the user to run the compatibility installer.
