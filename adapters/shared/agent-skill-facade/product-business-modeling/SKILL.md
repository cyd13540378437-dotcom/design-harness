---
name: product-business-modeling
description: Use for product business modeling: business objects, business attributes, object relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, and downstream business-model views. Runtime-neutral facade; adapter-specific wrappers must map this workflow into Codex, Claude Code, Cursor, or another agent runtime.
---

# Product Business Modeling

You are invoking the runtime-neutral Product Business Modeling workflow.

## Load order

1. Read the runtime adapter resolution protocol when installing or preparing a project:
   `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`.
2. Read the Core contract:
   `core/product-design/business-modeling/CAPABILITY.md`.
3. Read the relevant protocols under:
   `core/product-design/business-modeling/protocols/`.
4. In a target project, use:
   `docs/product/business-modeling/`, `docs/product/model-triggers/`, and `docs/product/work-items/` as the only business modeling project asset roots.

## Hard boundaries

- This Skill facade is not the source of truth.
- Do not move business model knowledge into `.agents/`, `.claude/`, `.cursor/`, `.codex/`, `AGENTS.md`, or `CLAUDE.md`.
- Business Modeling uses business attributes, not database fields.
- `schema-view.json` only contains business objects, business domains, object categories, business attributes, and example content.
- Do not directly edit `docs/design/**`, Reference Library, or Color Card Registry assets.
- High-impact semantics require Human Decision Control Plane approval before becoming `confirmed`.
- AI must not seal a task without explicit human closure approval.

## Entry modes

Select one primary mode:

1. Direct Modeling
2. Passive Trigger
3. Project Extraction
4. Greenfield Modeling
5. Consistency Validation
6. Downstream Compilation

Modes may compose, but Work Item boundaries must stay clear.

## Required task flow

1. Bind or create a BM Work Item when the task has persistent modeling value.
2. Record consumed inputs in `MODELING_CONSUMPTION.md`.
3. Produce modeling output in `MODELING_OUTPUT.md` and task artifacts.
4. Escalate D2/D3 decisions to `DECISION_NOTES.md` and ask the user.
5. Update Core source-of-truth assets only within the owned file boundaries.
6. Compile downstream views after model changes.
7. If processing a `MT-xxx.md`, write `MODEL_IMPACT_REPORT.md` and update trigger resolution.

## Runtime adapter behavior

When this facade is installed into a runtime-specific location, follow that runtime's install profile. If no tool-specific profile is installed, use this facade as a manual workflow and do not claim automatic invocation support.
