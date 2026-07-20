# Runtime Adapters

This directory contains runtime wrappers for the Agent-neutral Product Business Modeling Core.

The Core lives under:

```text
core/product-design/business-modeling/
```

The real project knowledge assets live under:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

Runtime adapters only make the Core callable in a specific agent tool. They do not redefine business semantics.

## Required adapter architecture

```text
adapters/shared/agent-skill-facade/product-business-modeling/
        ↓
adapters/codex/
adapters/claude-code/
adapters/cursor/
```

Before installing into a user project, apply:

```text
core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md
```

## Profiles

| Profile | Use when | Primary runtime files |
|---|---|---|
| `codex` | User is using Codex | `.agents/skills/`, `.codex/agents/`, `AGENTS.md` |
| `claude-code` | User is using Claude Code | `.claude/skills/`, `.claude/agents/`, `CLAUDE.md` |
| `cursor` | User is using Cursor | `.cursor/rules/`, optional `.cursor/skills/`, `AGENTS.md` |
| `generic-agent` | No tool-specific runtime is known | `AGENTS.md` + manual shared facade |
| `multi-runtime` | User explicitly wants multiple agent tools | common project assets + selected runtime profiles |

Do not copy Codex TOML agents into Claude or Cursor. Do not copy Claude agent markdown into Codex. Do not treat Cursor rules as Codex skills.
