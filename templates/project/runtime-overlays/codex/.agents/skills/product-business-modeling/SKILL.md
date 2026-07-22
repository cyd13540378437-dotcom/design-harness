---
name: product-business-modeling
description: Build, update, validate, or compile DesignHarnessAgent business models. Use for business objects, business attributes, dictionary/schema views, relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, the default business-model overview, downstream views, or UX/business-model alignment. Do not use for pure UI styling, database implementation, API coding, or generic PRD writing.
---

# Product Business Modeling Skill

This is the **Codex runtime adapter** for the Agent-neutral DesignHarnessAgent `product-business-modeling` Core.

## Core authority

Read and follow:

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/protocols/business-model-overview.md
core/product-design/business-modeling/protocols/work-item-file-contract.md
core/product-design/business-modeling/protocols/canonical-model-asset-contracts.md
core/product-design/business-modeling/protocols/human-decision-control-plane.md
core/product-design/business-modeling/protocols/validation-and-evals.md
```

Codex is a runtime facade. Project business-model knowledge remains under `docs/product/**`.

## Default user-facing file

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

Read it first when present. It is the only default file shown to ordinary users, but it is a derived view, not source of truth.

## Required startup sequence

For stateful business-modeling work:

1. Read project `AGENTS.md` and runtime-resolution metadata.
2. Read `docs/product/BUSINESS_MODEL_OVERVIEW.md` if present.
3. Read `docs/product/PRODUCT_WORK_ITEMS.md` and semantically relevant unsealed `STATE.md` files.
4. Explicitly delegate Work Item binding and state writes to `product_model_state_steward` when installed.
5. If the steward is unavailable, apply the same frozen state contract in the main thread and record that fact only under `extensions` or in the State body.
6. Select one primary entry mode.
7. Load only the detailed model assets required by the task.

## Entry modes

```text
direct_modeling
passive_trigger
project_extraction
greenfield_modeling
consistency_validation
downstream_compilation
```

## Work Item identity

State binding returns exactly one of:

```text
CREATE
RESUME
SUCCESSOR
NO_STATE
AMBIGUOUS
```

Do not create state for a read-only explanation. Do not resume sealed history. In `AMBIGUOUS`, do not write candidate states.

## Canonical Work Item files

Every durable Work Item at `docs/product/work-items/BM-xxx-<slug>/` has:

```text
STATE.md
MODELING_CONSUMPTION.md
MODELING_OUTPUT.md
DECISION_NOTES.md
```

Standard reports live under `artifacts/`:

```text
SOURCE_EVIDENCE.md
MODEL_EXTRACTION_REPORT.md
MODEL_CONSISTENCY_REPORT.md
MODEL_IMPACT_REPORT.md
```

The four root files always exist. Artifact applicability follows the Core protocol. Never move `MODELING_CONSUMPTION.md` into `artifacts/`; never use `PROPOSED_MODEL.md` or `EVIDENCE_AND_ASSUMPTIONS.md` as substitutes.

## Frozen State Schema

Use the exact Core fields:

```text
schema_version
state_id
title
slug
capability_id
entry_mode
binding_decision
status
phase
knowledge_status
awaiting_human
sealed
related_triggers
predecessors
created_at
updated_at
completed_at
extensions
```

Runtime details belong only in `extensions` or the body. Do not replace Core fields with `primary_entry_mode`, `awaiting_user`, `gate`, `model_status`, `semantic_confirmation_status`, `state_steward`, or other authority flags.

## Human Decision Control Plane

AI may write `draft` and `provisional`; it must not silently confirm D2 / D3 semantics.

Use stable `BMD-xxx` IDs. Before asking the user, provide:

```text
当前理解
为什么重要
2–3 个方案
每个方案的优点与代价
推荐
用户可直接回复的选项
```

Write the full record to `DECISION_NOTES.md` and compile the decision compression into `BUSINESS_MODEL_OVERVIEW.md`.

## Canonical model contracts

- Core uses business attributes, not database fields.
- `business-dictionary.yml` registers domains, categories, objects, attributes, actions, states, roles and prohibited technical terms.
- `BUSINESS_MODEL_INDEX.yml` registers existing assets and the default user view.
- `schema-view.json` uses only the frozen object/domain/category/attribute/example structure.
- All cross-file references use stable IDs.
- Actions include actor, target, preconditions and effects.
- State transitions reference existing Action IDs.
- One lifecycle belongs to one business object; cross-object creation is explicit.
- Slash or compound object identities remain provisional or require D2 confirmation.
- Context-dependent values are not intrinsic object attributes.

## Passive trigger handling

For `docs/product/model-triggers/MT-xxx.md`:

1. Triage and deduplicate.
2. Bind or create a BM Work Item.
3. Write `artifacts/MODEL_IMPACT_REPORT.md`.
4. Identify safe provisional updates and D2 / D3 decisions.
5. Update the correct source-of-truth owners.
6. Run consistency validation.
7. Refresh the business-model overview and affected downstream views.
8. Update trigger resolution and emit follow-up triggers only when another cluster must respond.

## Mandatory post-write sequence

After any persistent Core write, including Greenfield Modeling:

```text
write detailed source-of-truth assets
→ write artifacts/MODEL_CONSISTENCY_REPORT.md
→ fix or expose errors
→ compile docs/product/BUSINESS_MODEL_OVERVIEW.md
→ compile requested downstream views
→ update MODELING_OUTPUT.md
→ update STATE.md
```

Do not claim the model is complete while the consistency report contains blocking errors. The overview must expose `issues_found` when unresolved issues remain.

## UX / Design Engineering compatibility

Business Modeling may compile:

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
docs/product/business-modeling/downstream-views/ux-design-engineering-view.md
```

It must not directly rewrite `docs/design/**`, `REFERENCE_SELECTION.md`, Reference Library, Color Card Registry, or sealed Design Engineering states.

## User delivery

At normal completion, provide a concise status and link only `docs/product/BUSINESS_MODEL_OVERVIEW.md`.

List detailed files only when the user explicitly requests a model-maintainer view, audit trail, evidence, or implementation handoff.
