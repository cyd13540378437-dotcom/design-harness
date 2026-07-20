# PRD Hotfix: Product Business Modeling Codex Skill Adapter v0.2.2

## Problem

The v0.2.1 Business Modeling package correctly defined `product-business-modeling` as an Agent-neutral Core capability, but it did not include an actual Codex Skill runtime facade.

This creates a usability gap:

- Codex can read `AGENTS.md` fragments and prompt files when explicitly instructed.
- But without `.agents/skills/product-business-modeling/SKILL.md`, Codex does not have a selectable or implicitly invokable Skill for Business Modeling.
- Therefore the Core exists as protocol and templates, but the Codex runtime lacks a first-class entry point.

## Decision

Add a thin Codex Skill adapter:

```text
adapters/codex/skills/product-business-modeling/
templates/project/.agents/skills/product-business-modeling/
```

The adapter must not redefine the Core. It only loads and operationalizes the Core inside Codex.

## Also add a narrow state steward

Because Business Modeling has Work Items and `STATE.md`, add an optional Codex custom agent:

```text
adapters/codex/agents/product-model-state-steward.toml
templates/project/.codex/agents/product-model-state-steward.toml
```

The steward manages state only. It does not model business semantics.

## Non-goals

This hotfix does not add:

- CLI;
- Hook;
- Plugin;
- installer;
- external runtime dependency;
- database migration;
- API generation;
- UX asset rewriting.

## Definition of Done

- `product-business-modeling/SKILL.md` exists.
- `agents/openai.yaml` exists for the Skill.
- The Skill can be installed under `.agents/skills/product-business-modeling/`.
- The Skill points to `docs/product/business-modeling/` as source of truth.
- The Skill requires Work Item binding for stateful modeling tasks.
- The Skill protects Human Decision Control Plane boundaries.
- The Skill prevents data fields from entering core model assets.
- The Skill does not modify sealed UX / Design Engineering assets.
- The optional state steward exists and has narrow responsibilities.
