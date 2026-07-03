# Cursor Design Harness Adapter

This directory is only the Cursor-facing adapter and vendored skill.

Expected split after install:

```text
.cursor/
  rules/design-engineering.mdc
  design-harness/
    README.md
    agents/design-state-steward.md
    skills/design-engineering/

docs/design/
  WORK_ITEMS.md
  VISUAL_DESIGN.md
  reference-library/
  work-items/
```

Do not expect the project Reference Library, Color Card Registry, Work Items, or `VISUAL_DESIGN.md` to live under `.cursor/design-harness/`. They belong at the project root under `docs/design/` so every agent and every thread can read the same durable design state.

To check an install from the full `design-harness` repository, run:

```bash
./scripts/install-agent-compat.sh doctor /path/to/project
```
