# Agent Start Here — Design Harness Core Entries

## Product Business Modeling v0.2.2 Runtime-aware

This package is the runtime-aware replacement for the v0.2.2 skill-fixed package.

Read in this order:

1. `docs/PRD.product-business-modeling-v0.2.1.md`
2. `core/product-design/business-modeling/CAPABILITY.md`
3. `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`
4. `adapters/README.md`
5. `adapters/adapter-registry.yml`
6. The install profile for the runtime actually used by the user:
   - Codex: `adapters/codex/INSTALL_PROFILE.md`
   - Claude Code: `adapters/claude-code/INSTALL_PROFILE.md`
   - Cursor: `adapters/cursor/INSTALL_PROFILE.md`

Hard rule:

```text
Every Agent-neutral Core must ship with a runtime adapter resolution protocol.
A runtime adapter must make the Core callable in the user’s current agent tool.
Project knowledge assets remain in docs/product/** and never move into runtime adapters.
```

This package does not add a CLI, installer, hook, plugin, external dependency, or automation daemon. Runtime transformation means that the agent copies and merges the correct adapter files for the user’s current tool after identifying it.

## Product Business Analysis v0.1.1

`product-business-analysis` is a standalone business decision-support Core.

Read in this order:

1. `docs/PRD.product-business-analysis-v0.1.1.md`
2. `docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.1.md`
3. `core/product-design/business-analysis/CAPABILITY.md`
4. `core/product-design/business-analysis/SKILL.md`
5. `core/product-design/business-analysis/capability.manifest.yml`
6. `core/product-design/business-analysis/protocols/source-of-truth.md`
7. `core/product-design/business-analysis/protocols/output-contract.md`
8. `core/product-design/business-analysis/model-cards/index.yml`

Hard rule:

```text
Business Analysis is not a cross-capability trigger layer.
It owns docs/product/business-analysis/ and preserves Decision Case / Work Item source-of-truth separation.
```
