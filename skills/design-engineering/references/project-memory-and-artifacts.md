# Project Memory and Artifacts

Project Memory and Outputs extend the existing Work Item model without changing the state lifecycle.

## Boundaries

```text
docs/design/work-items/<event-id-slug>/STATE.md
```

Authoritative state snapshot for one Work Item.

```text
docs/design/work-items/<event-id-slug>/artifacts/
```

Task-local working material, prototypes, screenshots, drafts, and QA evidence.

```text
docs/design/project-memory/
```

Compressed cross-task project context. This is not a transcript and does not replace `STATE.md`.

```text
docs/design/outputs/archive/<event_id>/
```

Sealed event deliverable snapshot and traceable summary.

```text
docs/design/outputs/current/
```

Current user-confirmed entry points or baseline candidates.

```text
docs/design/reference-library/
```

Long-lived reference material. Do not store Work Item-specific selections here.

## Project Memory Files

- `BUSINESS_CONTEXT.md`: users, business goals, commercial constraints, compliance boundaries.
- `PRODUCT_DESIGN.md`: feature boundaries, plan or permission logic, pricing assumptions, product decisions.
- `UX_DESIGN.md`: flows, information architecture, interaction principles, empty/loading/error state strategy.
- `VISUAL_DESIGN.md`: durable visual baseline notes, palette, typography, density, layout principles, exclusions.
- `ENGINEERING_CONTEXT.md`: stack, components, implementation boundaries, testing and deployment notes.
- `DECISIONS.md`: compact decision index with source events and supersedes relationships.

## Update Rules

- Only persist information that should guide future Work Items.
- Record proposed updates in `STATE.md` before applying them.
- Do not write unapproved Work Item results as project baseline.
- Do not copy complete conversations, full reference analysis, full color-card annotations, or complete artifacts.
- If a sealed decision must be superseded, append a new decision with a source event; do not edit sealed history.

## Outputs Rules

- Keep `outputs/index.yml` as the project output map.
- Keep archive entries traceable to source `STATE.md`.
- Promote to `outputs/current/` only after user confirmation or explicit baseline adoption.
- Keep `outputs/current/` small; prefer pointers or latest entry files over copied history.

