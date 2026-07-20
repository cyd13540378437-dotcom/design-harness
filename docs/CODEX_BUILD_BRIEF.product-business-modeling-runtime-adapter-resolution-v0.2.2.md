# Build Brief — Runtime Adapter Resolution v0.2.2

Apply this brief to upgrade the Product Business Modeling v0.2.2 package from Codex-skill-fixed to runtime-aware.

## Read first

1. `core/product-design/business-modeling/CAPABILITY.md`
2. `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`
3. `adapters/README.md`
4. `adapters/adapter-registry.yml`
5. Runtime install profiles under `adapters/*/INSTALL_PROFILE.md`

## Required work

- Add shared Agent Skill Facade under `adapters/shared/agent-skill-facade/product-business-modeling/`.
- Keep Codex Skill Adapter.
- Add Claude Code Skill Adapter and state steward.
- Add Cursor Rules fallback and optional Skill Adapter.
- Add adapter registry and project runtime resolution metadata.
- Update README, CAPABILITY, manifest, readiness audit, and evals.

## Strict constraints

Do not add:

- CLI;
- Hook;
- Plugin;
- Marketplace package;
- automatic installer;
- external dependency.

Do not move or duplicate project knowledge source of truth outside:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

## Final response must include

1. Runtime selected or supported profiles.
2. Files installed per profile.
3. How ambiguous runtime detection is handled.
4. How Core remains Agent-neutral.
5. Confirmation that product assets remain under `docs/product/**`.
6. Confirmation that no CLI / hook / plugin / installer / external dependency was added.
