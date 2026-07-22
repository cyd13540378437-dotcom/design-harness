---
schema_version: 1
view_type: ux_business_model_context
source_model_status: draft
model_version: ""
generated_at: ""
generated_by: downstream-view-compiler
is_source_of_truth: false
---

# UX Business Model Context

> This file is a lightweight downstream view for UX / Design Engineering. It is not the business model source of truth.

## Consumption Policy

- UX should read this file at Work Item start if it exists.
- Missing or partial context does not block UX startup.
- UX should create a Model Trigger only for business model gap candidates or confirmed model conflict candidates.
- UX must not confirm new business objects, actions, states, rules, permissions, responsibilities, or audit semantics by itself.
- Unresolved high-impact gaps or conflicts must block completion seal, not low-cost exploration.

## Generated From

| Source | Status | Notes |
|---|---|---|
| `business-dictionary.*` |  |  |
| `schema-view.*` |  |  |
| `actions/*` |  |  |
| `states/*` |  |  |
| `rules/*` |  |  |
| `model-triggers/` |  |  |

## Business Objects for UX

| Object ID | Label | Short Definition | Status | Source |
|---|---|---|---|---|
|  |  |  | draft/provisional/confirmed |  |

## UX-Relevant Actions

| Action ID | Label | Actor | Target | Business Effect | Status | Source |
|---|---|---|---|---|---|---|
|  |  |  |  |  | draft/provisional/confirmed |  |

## UX-Relevant States

| Object ID | State ID | Label | Meaning | Status | Source |
|---|---|---|---|---|---|
|  |  |  |  | draft/provisional/confirmed |  |

## UX-Relevant Rules and Permissions

| Rule ID | Summary | Affects | Status | Source |
|---|---|---|---|---|
|  |  | visibility / action_availability / error_state / responsibility / audit | draft/provisional/confirmed |  |

## Open Model Triggers Affecting UX

| Trigger ID | Type | Status | Summary | Blocking Before Completion |
|---|---|---|---|---|
|  | downstream_gap / cross_cluster_conflict | open / triaged / in_progress / awaiting_human |  | yes/no |

## When UX Should Create a Model Trigger

Create `downstream_gap` when UX needs a business object, action, state, rule, permission, responsibility, or audit semantic not present in this context.

Create `cross_cluster_conflict` when UX behavior contradicts confirmed model semantics in this context.

## When UX Should Not Create a Model Trigger

Do not create a Model Trigger for visual layout, color, spacing, responsive behavior, Reference Library selection, Color Card selection, local UI mechanics, or copy changes that do not change the user's understanding of the business result.

## Open Gaps

- None recorded.
