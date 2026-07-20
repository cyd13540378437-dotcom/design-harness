# 28 — Neutral Template Does Not Include Runtime Directories

## Given

The user has not selected Codex, Claude Code, Cursor, or multi-runtime support.

## When

The agent prepares the default `templates/project/` assets.

## Then

The default template contains portable `docs/product/**` and runtime-selection metadata only. It must not contain `.agents/`, `.codex/`, `.claude/`, or `.cursor/` runtime directories at the root of `templates/project/`.
