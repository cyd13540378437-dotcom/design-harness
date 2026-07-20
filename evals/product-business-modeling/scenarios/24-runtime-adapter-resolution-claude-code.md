# 24 — Runtime Adapter Resolution: Claude Code

## Given

A target project contains `CLAUDE.md` or `.claude/skills/`, or the user explicitly says they are using Claude Code.

## When

The agent prepares Product Business Modeling.

## Then

It selects the `claude-code` profile, installs `.claude/skills/product-business-modeling/`, installs `.claude/agents/product-model-state-steward.md`, merges `CLAUDE.md`, and does not copy Codex TOML into `.claude/agents/`.
