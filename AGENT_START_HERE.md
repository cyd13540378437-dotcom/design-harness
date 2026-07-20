# Agent Start Here — Product Business Modeling v0.2.2 Runtime-aware

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
