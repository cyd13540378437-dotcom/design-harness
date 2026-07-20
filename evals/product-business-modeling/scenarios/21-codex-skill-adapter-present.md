# 21 — Codex Skill Adapter Present

## Given

A DesignHarnessAgent repository includes Product Business Modeling Core.

## When

Codex is asked to perform a business modeling task.

## Then

The repository or target project provides an installable Skill at:

```text
.agents/skills/product-business-modeling/SKILL.md
```

or a source adapter at:

```text
adapters/codex/skills/product-business-modeling/SKILL.md
```

And the Skill states that it is a thin runtime adapter, not source of truth.
