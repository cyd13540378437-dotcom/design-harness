# CODEX START HERE — Product Business Modeling v0.2.2

This package is the runtime-aware Codex entry for `product-business-modeling`.

Important correction in v0.2.2:

- v0.2.1 defined the Agent-neutral Core and Codex prompt fragments, but did not include a real Codex Skill runtime adapter.
- v0.2.2 adds shared and runtime-specific Skill facades. Codex project files live under `templates/project/runtime-overlays/codex/` until the Codex profile is selected and materialized.
- The Skill is a thin Codex adapter. It is not the business-model source of truth.

Read in this order:

1. `docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md`
2. `docs/PRD.product-business-modeling-v0.2.1.md`
3. `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`
4. `adapters/adapter-registry.yml`
5. `docs/PRD.product-business-modeling-codex-skill-adapter-v0.2.2.md`
6. `docs/CODEX_BUILD_BRIEF.product-business-modeling-codex-skill-adapter-v0.2.2.md`
7. `core/product-design/business-modeling/CAPABILITY.md`
8. `skills/product-business-modeling/SKILL.md`
9. `adapters/codex/skills/product-business-modeling/SKILL.md`
10. `templates/project/runtime-overlays/codex/.agents/skills/product-business-modeling/SKILL.md`

Do not remove the Core / Adapter / Project Assets separation.

`docs/product/business-modeling/` is the product knowledge source of truth.

`.agents/skills/product-business-modeling/` is only the Codex invocation facade after the Codex runtime overlay is selected and materialized.

---

## Runtime-aware note

This package now includes runtime adapter resolution. If you are applying it from Codex, use the Codex profile. If the target project is meant for Claude Code or Cursor, do not install only Codex files; apply `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` and the matching install profile.
