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

> Lightweight downstream view for UX / Design Engineering. Do not treat this file as source of truth.

## Consumption Policy

- Read at UX Work Item start if present.
- Missing context does not block UX startup.
- UX only reports `business_model_gap_candidate` and `business_model_conflict_candidate`.
- High-impact unresolved candidates block completion seal, not exploration.

## Business Objects for UX

| Object ID | Label | Short Definition | Status | Source |
|---|---|---|---|---|

## UX-Relevant Actions

| Action ID | Label | Actor | Target | Business Effect | Status | Source |
|---|---|---|---|---|---|---|

## UX-Relevant States

| Object ID | State ID | Label | Meaning | Status | Source |
|---|---|---|---|---|---|

## UX-Relevant Rules and Permissions

| Rule ID | Summary | Affects | Status | Source |
|---|---|---|---|---|

## Open Model Triggers Affecting UX

| Trigger ID | Type | Status | Summary | Blocking Before Completion |
|---|---|---|---|---|

## When UX Should Create a Model Trigger

- Create `downstream_gap` when UX needs a missing business object, action, state, rule, permission, responsibility, or audit semantic.
- Create `cross_cluster_conflict` when UX behavior contradicts confirmed model semantics.

## When UX Should Not Create a Model Trigger

Do not create a Model Trigger for visual layout, spacing, color, responsive behavior, Reference Library selection, Color Card selection, local UI mechanics, or copy changes that do not change business meaning.
