# Agent Runtime Adapter Resolution Protocol

## 1. Purpose

Business Modeling is an Agent-neutral Core. It must not become Codex-only, Claude-only, or Cursor-only.

However, every real agent runtime still needs a callable facade. Therefore the package must include a runtime adapter resolution layer that answers:

```text
Which agent tool is the user currently using?
Which runtime adapter should be installed or invoked?
Which project files should be created or merged for that runtime?
Which files must remain Agent-neutral project knowledge assets?
```

## 2. Non-goals

This protocol is not:

- a CLI;
- an installer;
- a hook;
- a marketplace plugin;
- an external dependency;
- a background daemon;
- a tool-specific replacement for the Core.

The agent may apply file transformations when explicitly asked to install or prepare the capability, but it must do so by copying and merging documented adapter files, not by running an installer.

## 3. Layer contract

```text
Product Business Modeling Core
        ↓
Shared Agent Skill Facade
        ↓
Runtime-specific Adapter
        ↓
Project Knowledge Assets
```

### Core

Defines the business modeling capability:

```text
CAPABILITY.md
capability.manifest.yml
protocols/
assets/
references/
evals/
```

### Shared Agent Skill Facade

Defines the portable workflow entry:

```text
adapters/shared/agent-skill-facade/product-business-modeling/SKILL.md
adapters/shared/agent-skill-facade/product-business-modeling/references/
```

The shared facade must avoid Codex-, Claude-, or Cursor-only syntax unless clearly marked as runtime-specific.

### Runtime-specific Adapter

Maps the shared facade into each tool’s supported project structure:

```text
adapters/codex/
adapters/claude-code/
adapters/cursor/
```

### Project Knowledge Assets

Always remain Agent-neutral:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

Runtime files are never source of truth for business semantics.

## 4. Runtime detection signals

The agent must detect the user’s current runtime before applying project structure changes.

Priority order:

1. Explicit user statement, for example “I am using Codex”, “this is Claude Code”, or “install for Cursor”.
2. Current invocation convention, for example `$product-business-modeling` for Codex-style skill mention or `/product-business-modeling` for Claude Code-style skill command.
3. Repository files already present.
4. Ambiguous or no signal.

Detection signals:

| Runtime | Strong signals | Adapter profile |
|---|---|---|
| Codex | `.agents/skills/`, `.codex/agents/`, Codex `AGENTS.md`, user mentions Codex | `codex` |
| Claude Code | `CLAUDE.md`, `.claude/skills/`, `.claude/agents/`, user mentions Claude Code | `claude-code` |
| Cursor | `.cursor/rules/`, `.cursor/`, Cursor Rules, user mentions Cursor | `cursor` |
| Generic Agent | only `AGENTS.md` or no tool-specific markers | `generic-agent` |
| Multi-runtime | two or more explicit target tools | `multi-runtime` |

## 5. Resolution output

Before applying transformations, the agent should produce a short resolution summary:

```yaml
runtime_resolution:
  selected_profile: codex | claude-code | cursor | generic-agent | multi-runtime | ambiguous
  confidence: high | medium | low
  evidence:
    - "..."
  project_assets_required: true
  adapter_transformations:
    - from: "..."
      to: "..."
      action: copy | merge | skip
  human_confirmation_required: true | false
```

Human confirmation is required when:

- multiple strong runtime signals conflict;
- a target file already exists and must be merged;
- the user asks for a destructive replacement;
- the agent cannot infer whether to install one runtime or multiple runtimes.

## 6. Transformation rules

### Always install or preserve common project assets

```text
docs/product/PRODUCT_WORK_ITEMS.md
docs/product/model-triggers/
docs/product/business-modeling/
docs/product/work-items/
```

### Codex profile

Create or merge:

```text
.agents/skills/product-business-modeling/SKILL.md
.agents/skills/product-business-modeling/agents/openai.yaml
.agents/skills/product-business-modeling/references/
.codex/agents/product-model-state-steward.toml
AGENTS.md
```

### Claude Code profile

Create or merge:

```text
.claude/skills/product-business-modeling/SKILL.md
.claude/skills/product-business-modeling/references/
.claude/agents/product-model-state-steward.md
CLAUDE.md
```

### Cursor profile

Create or merge:

```text
.cursor/rules/product-business-modeling.mdc
.cursor/skills/product-business-modeling/SKILL.md
.cursor/skills/product-business-modeling/references/
AGENTS.md
```

If the installed Cursor version does not support project Agent Skills, the `.cursor/rules/product-business-modeling.mdc` rule is the required fallback. Do not invent unsupported Cursor configuration fields.

### Generic-agent profile

Create or merge:

```text
AGENTS.md
docs/product/**
```

Generic agents may follow the shared skill facade as a manual workflow, but the package must not pretend generic agents support a tool-specific skill mechanism.

### Multi-runtime profile

Install the common project assets once and then install every explicitly selected runtime adapter. Do not duplicate `docs/product/**` per runtime.

## 7. Merge safety

The agent must not overwrite existing user files without reading them first.

For root-level persistent instruction files such as `AGENTS.md` and `CLAUDE.md`, the agent should merge a clearly marked section:

```markdown
<!-- BEGIN DesignHarnessAgent: product-business-modeling -->
...
<!-- END DesignHarnessAgent: product-business-modeling -->
```

If the marked section already exists, update only that section.

## 8. Hard readiness rule

A Business Modeling package is not ready if any of the following is true:

- it has Core but no callable runtime adapter;
- it has a Codex adapter but no shared facade;
- it claims Claude or Cursor compatibility but has no runtime-specific install profile;
- it moves project knowledge assets into runtime adapter directories;
- it relies on an installer, CLI, hook, or plugin despite those being non-goals;
- it does not define how to handle ambiguous or multi-runtime projects.

## 9. Impact on future capability clusters

This protocol is not Business Modeling-specific. Commercial Analysis, Product Expression, Requirements Expression, and future independent capability clusters must use the same pattern:

```text
Agent-neutral Core
+ Shared Agent Skill Facade
+ Runtime-specific Adapters
+ Runtime Adapter Resolution Protocol
+ Agent-neutral Project Knowledge Assets
```

## 9. Neutral project template rule

The default `templates/project/` directory must stay runtime-neutral. It may include `docs/product/**` and runtime-resolution metadata, but it must not include runtime directories at its root.

Runtime files must remain under `templates/project/runtime-overlays/<profile>/` until the resolver selects a profile.

Neutral template must not contain by default:

```text
.agents/**
.codex/**
.claude/**
.cursor/**
```
