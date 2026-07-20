---
name: product-business-modeling
description: Product business modeling workflow for Cursor Agent Skills, covering business objects, attributes, relationships, actions, states, rules, permissions, model triggers, impact reports, extraction, validation, and downstream business-model views.
---

# Product Business Modeling for Cursor

This is the Cursor runtime adapter for the Agent-neutral Product Business Modeling Core.

If the current Cursor environment does not support project Agent Skills, use `.cursor/rules/product-business-modeling.mdc` as the fallback runtime adapter.

## Required behavior

1. Keep business model source of truth under `docs/product/**`.
2. Treat this Skill as a runtime facade, not the Core.
3. Follow the shared Core references in `references/`.
4. Do not directly modify `docs/design/**`.
5. Escalate D2/D3 decisions to the user.
6. Keep business attributes separate from database fields, API parameters, ORM fields, and implementation types.
7. Keep `schema-view.json` limited to business objects, domains, categories, business attributes, and example content.
