---
name: product-business-modeling
description: Product business modeling workflow for business objects, business attributes, relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, and downstream business-model views. Use when the user asks to model or validate product business semantics.
---

# Product Business Modeling for Claude Code

This is the Claude Code runtime adapter for the Agent-neutral Product Business Modeling Core.

Use `/product-business-modeling` to invoke it directly, or apply it automatically when the user asks for business modeling, model triggers, business object extraction, or model consistency validation.

## Required behavior

1. Treat this Skill as a runtime facade, not as the source of truth.
2. Use `docs/product/business-modeling/`, `docs/product/model-triggers/`, and `docs/product/work-items/` as project knowledge asset roots.
3. Follow the Core contract in `references/core-contract.md`.
4. Use the entry mode reference in `references/entry-modes.md`.
5. Use the state steward contract in `references/state-steward.md` when managing BM Work Item state.
6. Do not confirm D2/D3 semantics without the user.
7. Do not modify `docs/design/**` directly.
8. Keep business attributes separate from database fields, API parameters, ORM fields, and implementation types.
9. Keep `schema-view.json` limited to business objects, domains, categories, business attributes, and example content.

## When installing

If this Skill is not already in `.claude/skills/product-business-modeling/`, apply `adapters/claude-code/INSTALL_PROFILE.md`.
