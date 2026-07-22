# 25 — Runtime Adapter Resolution: Cursor

## Given

A target project contains `.cursor/rules/` or the user explicitly says they are using Cursor.

## When

The agent prepares Product Business Modeling.

## Then

It selects the `cursor` profile, installs `.cursor/rules/product-business-modeling.mdc`, optionally installs `.cursor/skills/product-business-modeling/` only if supported by the current Cursor runtime, merges `AGENTS.md`, and does not invent unsupported Cursor config fields.
