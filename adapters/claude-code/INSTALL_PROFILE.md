# Claude Code Install Profile — Product Business Modeling

Use this profile when runtime adapter resolution selects `claude-code`.

## Detection

Strong signals:

- user explicitly says they are using Claude Code;
- current task invokes `/product-business-modeling`;
- repository contains `CLAUDE.md`;
- repository contains `.claude/skills/` or `.claude/agents/`.

## Transformations

Install common project assets once:

```text
docs/product/PRODUCT_WORK_ITEMS.md
docs/product/model-triggers/
docs/product/business-modeling/
docs/product/work-items/
```

Then install Claude Code runtime files:

```text
adapters/claude-code/skills/product-business-modeling/ -> .claude/skills/product-business-modeling/
adapters/claude-code/agents/product-model-state-steward.md -> .claude/agents/product-model-state-steward.md
adapters/claude-code/CLAUDE.fragment.md -> merge into CLAUDE.md
```

Do not copy Codex `.toml` agents into `.claude/agents/`.
