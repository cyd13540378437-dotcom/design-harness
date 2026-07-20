# 23 — Runtime Adapter Resolution: Codex

## Given

A target project contains `.codex/agents/` or the user explicitly says they are using Codex.

## When

The agent prepares Product Business Modeling.

## Then

It selects the `codex` profile, installs `.agents/skills/product-business-modeling/`, installs `.codex/agents/product-model-state-steward.toml`, merges `AGENTS.md`, and keeps product assets under `docs/product/**`.
