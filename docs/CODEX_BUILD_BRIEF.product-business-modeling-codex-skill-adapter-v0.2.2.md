# Codex Build Brief: Add Product Business Modeling Skill Adapter v0.2.2

## Goal

Patch the existing DesignHarnessAgent Product Business Modeling implementation so Codex has a real `product-business-modeling` Skill entry point.

## Required changes

Add these source adapter files:

```text
adapters/codex/skills/product-business-modeling/SKILL.md
adapters/codex/skills/product-business-modeling/agents/openai.yaml
adapters/codex/skills/product-business-modeling/references/core-contract.md
adapters/codex/skills/product-business-modeling/references/entry-modes.md
adapters/codex/skills/product-business-modeling/references/state-steward.md
adapters/codex/agents/product-model-state-steward.toml
```

Add these target project template files:

```text
templates/project/.agents/skills/product-business-modeling/SKILL.md
templates/project/.agents/skills/product-business-modeling/agents/openai.yaml
templates/project/.agents/skills/product-business-modeling/references/core-contract.md
templates/project/.agents/skills/product-business-modeling/references/entry-modes.md
templates/project/.agents/skills/product-business-modeling/references/state-steward.md
templates/project/.codex/agents/product-model-state-steward.toml
```

Update docs / README / install instructions to say:

1. Core remains Agent-neutral.
2. Codex runtime uses the Skill adapter.
3. Business model source of truth remains under `docs/product/business-modeling/`.
4. `.agents/skills/product-business-modeling/` is invocation logic, not product knowledge.
5. The optional state steward manages only BM Work Item state.

## Strict constraints

Do not add CLI, Hook, Plugin, installer, scripts, external dependencies, database migrations, or API generators.

Do not move core assets into the Skill.

Do not treat the Skill as source of truth.

Do not modify `docs/design/**`, Reference Library, or Color Card Registry except to document compatibility.

## Verification

After implementing, verify:

```text
find . -path '*/product-business-modeling/SKILL.md'
find . -path '*/product-business-modeling/agents/openai.yaml'
find . -name 'product-model-state-steward.toml'
```

Expected:

- at least one source adapter Skill under `adapters/codex/skills/`;
- one installable project Skill under `templates/project/.agents/skills/`;
- one Codex custom agent template under `templates/project/.codex/agents/`.

Also verify no forbidden paths were created:

```text
find . -path '*model-requests*'
find . -path '*reference-library/reference-packs*'
find . -path '*color-cards/cards*'
```

Expected: no output.

## Final response

Explain:

1. why the missing Skill was a runtime adapter gap;
2. what files were added;
3. how Codex now invokes Business Modeling;
4. how the Skill preserves Agent-neutral Core semantics;
5. what remains non-goal.
