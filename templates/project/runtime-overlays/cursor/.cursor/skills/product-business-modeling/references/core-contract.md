# Product Business Modeling Core Contract

This reference summarizes the non-negotiable Core contract used by runtime facades.

## Identity

`product-business-modeling` is an Agent-neutral DesignHarnessAgent Core capability. Codex, Claude Code, Cursor, and generic agents are runtime adapters.

Runtime Skills, rules, prompts, and agent files only make the Core callable in a tool. They are not the business-model source of truth.

## Project source of truth

Long-lived business-model assets live under:

```text
docs/product/business-modeling/
```

Task-level outputs live under:

```text
docs/product/work-items/BM-xxx-<slug>/
```

Model triggers live under:

```text
docs/product/model-triggers/MT-xxx.md
```

Do not move business model knowledge into `.agents/`, `.codex/`, `.claude/`, `.cursor/`, `AGENTS.md`, `CLAUDE.md`, or adapter directories.

## Business attributes, not fields

The core model uses business attributes, not database fields. Do not write database columns, API parameters, ORM fields, TypeScript properties, storage types, or persistence strategies into core model assets.

Technical field mappings are downstream suggestions only and must stay in derived views such as `database-view.md`, `backend-view.md`, or `frontend-view.md`.

## `schema-view.json`

The schema view is a compact business attribute structure view. It only contains:

- business objects;
- business domain;
- object category;
- business attributes;
- example content.

It must not contain relationships, actions, states, rules, permissions, database fields, APIs, persistence, risk, roadmap, or downstream implementation details.

## Human Decision Control Plane

AI may generate `draft` and `provisional` content automatically. It must not silently upgrade D2/D3 semantics to `confirmed`, overwrite confirmed semantics, or seal a Work Item without explicit human decision.

When a high-impact decision is required, record pending and resolved decisions in `DECISION_NOTES.md` and ask the user before confirmation.
