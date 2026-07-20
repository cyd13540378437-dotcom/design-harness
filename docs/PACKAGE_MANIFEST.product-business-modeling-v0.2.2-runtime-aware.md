# Package Manifest — Product Business Modeling v0.2.2 Runtime-aware

## Package identity

- Capability ID: `product-business-modeling`
- Version: `v0.2.2-runtime-aware`
- Status: implementation-ready
- Runtime support: Codex, Claude Code, Cursor, Generic Agent, Multi-runtime

## Added runtime-aware files

```text
AGENT_START_HERE.md
core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md
adapters/README.md
adapters/adapter-registry.yml
adapters/shared/agent-skill-facade/product-business-modeling/
adapters/codex/INSTALL_PROFILE.md
adapters/claude-code/INSTALL_PROFILE.md
adapters/claude-code/skills/product-business-modeling/
adapters/claude-code/agents/product-model-state-steward.md
adapters/cursor/INSTALL_PROFILE.md
adapters/cursor/rules/product-business-modeling.mdc
adapters/cursor/skills/product-business-modeling/
templates/project/.designharness/
templates/project/.designharnessagent/
templates/project/runtime-overlays/codex/
templates/project/runtime-overlays/claude-code/
templates/project/runtime-overlays/cursor/
docs/PRD.product-business-modeling-runtime-adapter-resolution-v0.2.2.md
docs/CODEX_BUILD_BRIEF.product-business-modeling-runtime-adapter-resolution-v0.2.2.md
docs/RUNTIME_ADAPTER_READINESS_AUDIT.product-business-modeling-v0.2.2.md
evals/product-business-modeling/scenarios/23-28
```

## Hard rule

Every future Agent-neutral capability must include:

```text
Core
+ Shared Agent Skill Facade
+ Runtime-specific Adapters
+ Runtime Adapter Resolution Protocol
+ Project Knowledge Assets
+ Runtime readiness evals
```
