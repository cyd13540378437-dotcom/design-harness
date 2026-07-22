---
name: product-business-modeling
description: "Use for product business modeling: business objects, business attributes, relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, business-model overview compilation, and downstream views. Runtime-neutral facade for Codex, Claude Code, Cursor, or another agent runtime."
---

# Product Business Modeling

You are invoking the runtime-neutral Product Business Modeling workflow.

## Load order

1. Resolve the current runtime through `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` when installing or preparing a project.
2. Read `core/product-design/business-modeling/CAPABILITY.md`.
3. Read these v0.2.3 hard contracts:

   ```text
   core/product-design/business-modeling/protocols/business-model-overview.md
   core/product-design/business-modeling/protocols/work-item-file-contract.md
   core/product-design/business-modeling/protocols/canonical-model-asset-contracts.md
   core/product-design/business-modeling/protocols/validation-and-evals.md
   ```

4. In a target project, read `docs/product/BUSINESS_MODEL_OVERVIEW.md` first when it exists, then load only the detailed source assets needed for the task.

## Project asset roots

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
docs/product/PRODUCT_WORK_ITEMS.md
```

Runtime files are invocation adapters, not business-model source of truth.

## Entry modes

Select one primary mode:

```text
direct_modeling
passive_trigger
project_extraction
greenfield_modeling
consistency_validation
downstream_compilation
```

Modes may compose, but Work Item identity and primary mode must remain clear.

## Canonical Work Item flow

For every stateful BM Work Item:

1. Resolve `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`.
2. Create or maintain the exact root files:

   ```text
   STATE.md
   MODELING_CONSUMPTION.md
   MODELING_OUTPUT.md
   DECISION_NOTES.md
   ```

3. Use standard artifact names under `artifacts/`.
4. Never replace standard files with `PROPOSED_MODEL.md`, `EVIDENCE_AND_ASSUMPTIONS.md`, or another alias.
5. Use the frozen `STATE.md` frontmatter. Runtime metadata belongs under `extensions` or in the body.

## Modeling boundaries

- Business Modeling uses business attributes, not database fields.
- `schema-view.json` must use the exact frozen shape and five-question boundary.
- Dictionary, Index and Schema IDs must remain referentially aligned.
- Actions require stable IDs, actors, targets, preconditions and effects.
- State transitions reference existing Action IDs and belong to exactly one object lifecycle.
- Context-dependent values belong to relationships, evaluation objects or derived views—not intrinsic object attributes.
- Compound object identities such as `Asset / Facility` remain provisional or enter a D2 decision.
- Do not directly edit `docs/design/**`, Reference Library, or Color Card Registry assets.

## Human Decision Control Plane

AI may create `draft` / `provisional`. D2 / D3 semantics require a `BMD-xxx` decision package before confirmation or replacement of confirmed truth.

The user-facing decision compression must also appear in `docs/product/BUSINESS_MODEL_OVERVIEW.md`, so the user can decide without opening task files.

## Mandatory post-write sequence

After any persistent Core model write:

```text
model-consistency-validator
→ artifacts/MODEL_CONSISTENCY_REPORT.md
→ fix or expose blocking issues
→ compile docs/product/BUSINESS_MODEL_OVERVIEW.md
→ compile requested professional downstream views
→ update MODELING_OUTPUT.md and STATE.md
```

Greenfield Modeling follows the same sequence.

## Default user delivery

At normal completion, present only:

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

Do not expose a long file list unless the user asks for audit, implementation handoff, evidence, or model-maintainer detail.
