# PRD — Product Business Modeling Runtime Adapter Resolution v0.2.2

## 1. Summary

v0.2.2 must not be Codex-only. Product Business Modeling remains an Agent-neutral Core, but every target runtime requires a callable adapter.

This increment adds a hard runtime adapter resolution rule:

```text
Before applying project structure, identify the user's current agent tool and install the matching adapter profile.
```

## 2. Goals

1. Define a shared Agent Skill Facade.
2. Add runtime-specific install profiles for Codex, Claude Code, Cursor, generic agents, and multi-runtime projects.
3. Add a resolver protocol for detecting runtime signals and deciding transformations.
4. Add target project templates for `.agents/`, `.codex/`, `.claude/`, `.cursor/`, `AGENTS.md`, and `CLAUDE.md` without moving product knowledge out of `docs/product/**`.
5. Add readiness criteria and evals so future capability clusters cannot ship Core without runtime adapters.

## 3. Non-goals

- CLI;
- Hook;
- Plugin;
- Marketplace;
- automatic installer;
- external runtime dependency;
- cloud sync;
- automatic tool telemetry.

## 4. Runtime profiles

| Profile | Required files |
|---|---|
| Codex | `.agents/skills/product-business-modeling/`, `.codex/agents/product-model-state-steward.toml`, `AGENTS.md` |
| Claude Code | `.claude/skills/product-business-modeling/`, `.claude/agents/product-model-state-steward.md`, `CLAUDE.md` |
| Cursor | `.cursor/rules/product-business-modeling.mdc`, optional `.cursor/skills/product-business-modeling/`, `AGENTS.md` |
| Generic Agent | `AGENTS.md` and shared manual facade |
| Multi-runtime | common `docs/product/**` plus selected runtime profiles |

## 5. Source of truth rule

Runtime files only route and invoke. They do not own business modeling knowledge. The source of truth remains:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

## 6. Acceptance criteria

- [ ] `agent-runtime-adapter-resolution.md` exists.
- [ ] `adapters/shared/agent-skill-facade/product-business-modeling/SKILL.md` exists.
- [ ] `adapters/adapter-registry.yml` exists and declares Codex, Claude Code, Cursor, generic, and multi-runtime profiles.
- [ ] Codex profile has real Skill and state steward.
- [ ] Claude Code profile has real Skill and state steward file.
- [ ] Cursor profile has Cursor Rules fallback and optional Skill facade.
- [ ] Project template contains runtime resolution metadata.
- [ ] No runtime adapter redefines Core semantics.
- [ ] No product knowledge asset moves out of `docs/product/**`.
- [ ] No CLI, hook, plugin, installer, or external dependency is added.
