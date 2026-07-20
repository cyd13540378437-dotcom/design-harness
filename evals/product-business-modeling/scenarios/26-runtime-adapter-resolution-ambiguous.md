# 26 — Runtime Adapter Resolution: Ambiguous or Multi-runtime

## Given

A target project contains both `.codex/agents/` and `CLAUDE.md`, but the user did not say whether to install one runtime or multiple runtimes.

## When

The agent prepares Product Business Modeling.

## Then

It does not silently choose one runtime. It presents a resolution summary with evidence and asks the user whether to install Codex, Claude Code, Cursor, or a multi-runtime profile.
