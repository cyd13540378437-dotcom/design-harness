# Product Summary — Lifecycle Memory Version

v0.1.3-alpha upgrades Codex Design Harness from a Work Item state protocol into a file-system backed project lifecycle memory system.

## What Changed

- New Work Items prefer Lifecycle Event IDs such as `2026-07-06-1530-UX-001` and `2026-07-06-1605-PD-001`.
- Legacy `DE-xxx` Work Items remain valid and must not be renamed automatically.
- `docs/design/project-memory/` stores durable business, product, UX, visual, engineering, and decision context.
- `docs/design/outputs/` separates current confirmed deliverables from archived event snapshots.
- `STATE.md` schema version 2 records `event_id`, `domain`, `execution_profile`, Design Contract, Review Lens, outputs, and Project Memory update plans.
- Fast Profile is recorded as `mode: lightweight` plus `execution_profile: fast`.
- Context-bound Final Review runs before `completion-review` and produces `review.md`.
- `domain: PD` supports product design events such as membership systems, pricing models, and feature boundaries.

## Field Validation

The v0.1.3 lifecycle model was validated with a local `testNewPD` project:

- Install the full harness into a fresh project.
- Create and seal an initial UX event for a personal work memo core-page demo.
- Create a successor event for a homepage visual upgrade.
- Run the successor as Fast Profile: `mode: lightweight` plus `execution_profile: fast`.
- Promote the confirmed successor artifact into `outputs/current/`.
- Archive sealed event snapshots under `outputs/archive/<event_id>/`.
- Apply compact Product, UX, Visual, and Decision memory updates after user confirmation.

This validates the intended boundary between Work Item artifacts, sealed output archives, current confirmed entry points, Project Memory, and `VISUAL_DESIGN.md`.

## Compatibility

v0.1.3 preserves:

- State decisions: `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`.
- Status, phase, and Gate enums.
- `completed + sealed` immutability.
- `completion-approval` as the required seal Gate.
- Reference Library as a long-lived reference layer.
- Work Item-level `REFERENCE_SELECTION.md`.
- Color Card Registry integrity, ready-only preview, and large visual color-card confirmation.

## Boundaries

- Work Item `artifacts/`: task-local working material.
- `STATE.md`: authoritative event state and compact context.
- Project Memory: durable cross-task baseline, not chat history.
- `outputs/archive/<event_id>/`: sealed event snapshot.
- `outputs/current/`: current user-confirmed entry points.
- Reference Library: long-lived reference material, not task-specific selections.

## Still Not Implemented

No CLI, Hook, Codex Plugin, Marketplace package, installer product, `statectl`, schema validator, cloud service, external runtime dependency, automatic screenshot download, OCR, or web scraping is introduced in v0.1.3.

Project Adoption / Adoption Baseline is also not implemented yet. Existing long-lived projects still need a dedicated adoption flow that inventories current surfaces, components, docs, historical decisions, and confirmed outputs before the first new Work Item is created. Future versions should distinguish `confirmed`, `observed`, and `inferred` baseline memory so the harness can safely take over old projects without treating them as blank projects.
