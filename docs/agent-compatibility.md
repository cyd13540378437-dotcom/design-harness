# Agent Compatibility

Design Harness was first shaped around Codex Skills, Codex project rules, and a Codex custom agent. Claude Code and Cursor can use the same workflow, but they need different entry points.

## Why Files Went Missing

There are two common causes:

1. The lightweight `designharness` rules folder contains only routing rules. It is not the full Design Harness repository.
2. Copying only `SKILL.md` is incomplete. The skill depends on `references/`, `assets/`, the project `docs/design/` template, and a state-steward adapter.

Use the full repository root, then run the compatibility installer:

```bash
./scripts/install-agent-compat.sh claude /path/to/project
./scripts/install-agent-compat.sh cursor /path/to/project
./scripts/install-agent-compat.sh codex /path/to/project
./scripts/install-agent-compat.sh doctor /path/to/project
```

The installer never uses `--delete`. It adds missing project template files and updates the agent-specific skill copy.

If a Cursor install looks small, check both places: `.cursor/design-harness/` contains only the Cursor adapter and vendored skill; the durable project files are expected under `docs/design/`.

## Codex Layout

Codex installs:

```text
~/.agents/skills/design-engineering/
target-project/.codex/agents/design-state-steward.toml
target-project/AGENTS.md
target-project/docs/design/
```

Invoke with:

```text
使用 $design-engineering 检查项目上下文，不要修改文件。
```

## Claude Code Layout

Claude Code installs:

```text
~/.claude/skills/design-engineering/
target-project/.claude/agents/design-state-steward.md
target-project/CLAUDE.md
target-project/docs/design/
```

Invoke with:

```text
/design-engineering 检查项目上下文，不要修改文件。
```

Claude Code uses `/design-engineering` for the skill and `design-state-steward` for the subagent. When the original Codex-oriented skill text says `design_state_steward`, Claude should map that to `design-state-steward`.

## Cursor Layout

Cursor installs:

```text
target-project/.cursor/rules/design-engineering.mdc
target-project/.cursor/design-harness/README.md
target-project/.cursor/design-harness/skills/design-engineering/
target-project/.cursor/design-harness/agents/design-state-steward.md
target-project/docs/design/
```

Cursor does not get a Codex-style user skill or Codex custom agent from this repository. The `.cursor/rules/design-engineering.mdc` rule tells Cursor to read the vendored skill files and apply the steward rules directly.

The large Reference Library, Color Card Registry, Work Item templates, and `VISUAL_DESIGN.md` do not live under `.cursor/design-harness/`; they live under `docs/design/` at the project root.

Invoke with a normal prompt, for example:

```text
按 design-engineering 轻量模式检查这个 UI 调整，不要直接改文件。
```

## Completeness Check

After install, these files should exist:

```text
docs/design/WORK_ITEMS.md
docs/design/VISUAL_DESIGN.md
docs/design/reference-library/product-index.yml
docs/design/reference-library/pattern-index.yml
docs/design/reference-library/assets/color-cards/palette-index.yml
docs/design/work-items/REFERENCE_SELECTION.template.md
```

And the installed skill copy should include:

```text
SKILL.md
references/visual-workflow.md
references/reference-library-consumption.md
references/color-card-consumption.md
assets/visual-reference-packs/reference-index.md
```
