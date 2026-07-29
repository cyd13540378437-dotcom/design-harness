# Design Overview Compilation

## 1. Purpose

`docs/design/DESIGN_OVERVIEW.md` is the default module delivery view for Design Engineering.

It solves the reading experience for current UX, product design, and visual design state without replacing Work Item state, Project Memory, `VISUAL_DESIGN.md`, or `docs/design/outputs/`:

```text
STATE.md / Project Memory / outputs / VISUAL_DESIGN.md = design source records
DESIGN_OVERVIEW.md = current user-facing compiled design view
```

Project delivery may consume this file as the design module export, but it must not infer or overwrite sealed design state from it.

## 2. Path and Ownership

Fixed path:

```text
docs/design/DESIGN_OVERVIEW.md
```

Fixed writer:

```text
design-engineering-orchestrator
```

The file must declare:

```yaml
view_type: design_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
```

Do not place it inside a Work Item `artifacts/` directory. Do not use `VISUAL_DESIGN.md`, `review.md`, or `outputs/current/index.yml` as substitutes.

## 3. Compilation Inputs

At minimum, consume the relevant available files:

```text
docs/design/WORK_ITEMS.md
docs/design/VISUAL_DESIGN.md
docs/design/project-memory/*.md
docs/design/outputs/index.yml
docs/design/outputs/current/index.yml
docs/design/outputs/current/*
relevant docs/design/work-items/<event-id-slug>/STATE.md
relevant docs/design/work-items/<event-id-slug>/REFERENCE_SELECTION.md
relevant docs/design/work-items/<event-id-slug>/review.md
```

Only compile from confirmed, adopted, or explicitly current design records. Do not promote unapproved prototypes, temporary screenshots, or unfinished visual directions into this overview.

## 4. Required Content

The overview must let a non-specialist user answer:

1. what the current design baseline is;
2. which surfaces, flows, or product-design events are covered;
3. where the current confirmed design outputs are;
4. what visual system is confirmed;
5. what UX or product constraints future work must inherit;
6. what is draft, provisional, stale, or out of scope;
7. what the user still needs to approve or answer;
8. which source states and outputs support the summary.

If open design decisions exist, the overview must include enough context for the user to reply without opening Work Item state files.

## 5. Compilation Timing

Update the overview:

- after a Work Item is sealed and adopted into `outputs/current/`;
- after `VISUAL_DESIGN.md` changes;
- after approved Project Memory updates affect product, UX, visual, or engineering context;
- before completion approval when the current task changes the user-facing design baseline;
- when `outputs/index.yml` changes current or archive mappings;
- when a successor supersedes a previous design baseline.

Recommended closeout order:

```text
complete QA and context-bound final review
→ update VISUAL_DESIGN.md or record no-change reason
→ update outputs/archive and outputs/current after user approval
→ apply approved Project Memory updates
→ compile DESIGN_OVERVIEW.md
→ update STATE.md output status
```

## 6. Freshness and Failure Handling

Frontmatter must record:

```text
design_overview_status
baseline_status
current_outputs_status
generated_at
source_events
source_outputs
source_assets
open_questions_source
```

If current outputs are missing or stale:

- still generate the overview when useful;
- mark `current_outputs_status: missing | stale`;
- do not describe the design as adopted or sealed;
- include the missing approval, QA, or source event in the open questions or limitations section.

If this overview conflicts with sealed `STATE.md` or `VISUAL_DESIGN.md`, those source records win and the overview must be regenerated.

## 7. Relationship to Other Files

- `STATE.md`: authoritative status for one design Work Item;
- `REFERENCE_SELECTION.md`: task-level reference consumption record;
- `review.md`: context-bound final review for one event;
- `VISUAL_DESIGN.md`: confirmed visual baseline;
- `project-memory/*.md`: compressed cross-task memory;
- `outputs/current/`: current confirmed entry points or adopted baselines;
- `outputs/archive/<event_id>/`: sealed event snapshots;
- `DESIGN_OVERVIEW.md`: user-facing compiled design module export.
