---
name: product-business-modeling
description: Build, update, validate, or compile DesignHarnessAgent business models. Use for business objects, business attributes, business dictionary, schema-view, relationships, actions, states, rules, permissions, model triggers, model impact reports, project extraction, consistency validation, downstream views, or UX/business-model alignment. Do not use for pure UI styling, database implementation, API coding, or generic PRD writing.
---

# Product Business Modeling Skill

This is the **Codex runtime adapter** for the DesignHarnessAgent `product-business-modeling` Core capability.

It is a thin facade. It must not redefine the Core semantics. It makes the Core callable inside Codex by providing:

- a selectable / implicitly invokable Codex Skill;
- a deterministic loading order for business-modeling protocols;
- Work Item state handling rules;
- a safe path from user request to project knowledge assets.

## Core boundary

Business Modeling is Agent-neutral Core. Codex is only a runtime adapter.

The authoritative business-modeling knowledge in a target project lives in:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
docs/product/PRODUCT_WORK_ITEMS.md
```

Do not treat `.codex/`, `.agents/`, this Skill directory, or any prompt file as business-model source of truth.

## When to use this Skill

Use this Skill when the user asks to:

- create, update, or validate a business model;
- define business objects, business attributes, domains, or object categories;
- build or update `business-dictionary.*` or `schema-view.*`;
- model object relationships, business actions, state lifecycles, rules, or permissions;
- respond to a `docs/product/model-triggers/MT-xxx.md` trigger;
- produce `MODEL_IMPACT_REPORT.md`;
- extract provisional business model knowledge from an existing project;
- compile downstream views for product expression, requirements, database, backend, frontend, QA, or UX;
- check whether UX / Design Engineering has a business-model gap or conflict.

Do not use this Skill for:

- pure visual styling or UI implementation;
- generic product brainstorming that does not need durable business-model assets;
- database migration, API generation, or backend implementation;
- changing sealed UX / Design Engineering Work Items;
- changing `docs/design/reference-library/**` or Color Card Registry assets.

## Required startup sequence

For any stateful business-modeling task:

1. Read applicable project `AGENTS.md` instructions.
2. Check whether the target project has:

   ```text
   docs/product/PRODUCT_WORK_ITEMS.md
   docs/product/business-modeling/
   docs/product/model-triggers/
   docs/product/work-items/
   ```

3. Read the relevant lightweight project assets first:

   ```text
   docs/product/PRODUCT_WORK_ITEMS.md
   docs/product/business-modeling/BUSINESS_MODEL_INDEX.md
   docs/product/business-modeling/BUSINESS_MODEL_INDEX.yml
   docs/product/business-modeling/business-dictionary.md
   docs/product/business-modeling/business-dictionary.yml
   docs/product/business-modeling/schema-view.json
   docs/product/business-modeling/schema-view.md
   ```

4. If available, explicitly delegate Work Item binding and state updates to `product_model_state_steward`.
5. If the steward is unavailable, perform the same state rules in the main thread and say so in the final summary.
6. Classify the request into one primary entry mode.
7. Read only the additional source-of-truth files required by that entry mode.
8. Write proposed updates to the correct Work Item artifacts before changing long-lived source-of-truth assets.

## Entry modes

Every run must choose one primary entry mode:

```text
direct_modeling
passive_trigger
project_extraction
greenfield_modeling
consistency_validation
downstream_compilation
```

Multiple modes may be chained, but the primary mode must stay clear in `STATE.md` and `MODELING_CONSUMPTION.md`.

## Work Item state rules

A business-modeling Work Item lives at:

```text
docs/product/work-items/BM-xxx-<slug>/STATE.md
```

Use the same five state binding decisions as the wider Harness pattern:

```text
CREATE
RESUME
SUCCESSOR
NO_STATE
AMBIGUOUS
```

Do not create a Work Item for a read-only explanation with no durable modeling value.

Do not resume a sealed Work Item. Create a successor instead.

## Human Decision Control Plane

You may generate `draft` and `provisional` content automatically.

You must not silently upgrade high-impact semantics to `confirmed`.

You must request human confirmation before confirming or overwriting semantics that affect:

- business object identity;
- core object relationships;
- business actions;
- state lifecycles;
- business rules or permissions;
- responsibility, audit, compliance, or billing;
- substantial model refactoring;
- source-of-truth replacement;
- sealing, deprecating, or superseding important model assets.

When a human decision is needed, use the format in `references/core-contract.md` and write the decision or pending decision to:

```text
docs/product/work-items/BM-xxx-<slug>/DECISION_NOTES.md
```

## Source-of-truth writing rules

Only write durable source-of-truth files after:

1. the Work Item is bound;
2. evidence and assumptions are captured;
3. high-impact decisions have been resolved or marked provisional;
4. the target file ownership is clear.

Core source-of-truth files:

```text
business-dictionary.*
schema-view.*
domain-objects/*
relationships/*
actions/*
states/*
rules/*
roadmap/*
risks/*
downstream-views/*
```

`downstream-views/*` are derived views. They are not source of truth.

## Business attribute rule

Business Modeling Core has **business attributes**, not data fields.

Never put database columns, API parameters, ORM fields, TypeScript properties, storage types, or persistence strategies into core model assets.

Technical mappings may appear only in downstream views such as `database-view.md`, `backend-view.md`, or `frontend-view.md`, and must be labeled as derived mapping suggestions.

## `schema-view.json` boundary

`schema-view.json` may only answer:

1. what business objects exist;
2. each object's business domain;
3. each object's object category;
4. each object's business attributes;
5. example content for each business attribute.

It must not include relationships, actions, states, rules, permissions, database fields, field types, APIs, persistence, future risk, or downstream implementation details.

## Passive trigger handling

For `docs/product/model-triggers/MT-xxx.md`:

1. Triage and deduplicate the trigger.
2. Bind or create a BM Work Item.
3. Write `MODEL_IMPACT_REPORT.md` under the Work Item artifacts.
4. Identify safe automatic updates and high-impact human decisions.
5. Update source-of-truth assets only after decision boundaries are clear.
6. Recompile relevant downstream views.
7. Update the trigger resolution.
8. Create follow-up triggers only when another cluster must respond.

## UX / Design Engineering compatibility

Business Modeling may produce UX-facing downstream views:

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
docs/product/business-modeling/downstream-views/ux-design-engineering-view.md
```

Business Modeling must not directly rewrite:

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

If UX is affected, express it through model impact reports, downstream views, and follow-up trigger or successor recommendations.

## Completion summary

At the end of a run, report:

1. primary entry mode;
2. Work Item decision and path;
3. source files read;
4. files created or modified;
5. human decisions requested or resolved;
6. whether source-of-truth assets were changed;
7. downstream views recompiled;
8. unresolved risks or follow-up triggers.
