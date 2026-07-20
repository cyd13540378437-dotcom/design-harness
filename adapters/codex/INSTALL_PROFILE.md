# Codex Install Profile — Product Business Modeling

Use this profile when runtime adapter resolution selects `codex`.

## Detection

Strong signals:

- user explicitly says they are using Codex;
- current task uses `$product-business-modeling`;
- repository uses `.agents/skills/`;
- repository uses `.codex/agents/`;
- repository has Codex-oriented `AGENTS.md` instructions.

## Transformations

Install common project assets once:

```text
docs/product/PRODUCT_WORK_ITEMS.md
docs/product/model-triggers/
docs/product/business-modeling/
docs/product/work-items/
```

Then install Codex runtime files:

```text
adapters/codex/skills/product-business-modeling/ -> .agents/skills/product-business-modeling/
adapters/codex/agents/product-model-state-steward.toml -> .codex/agents/product-model-state-steward.toml
adapters/codex/AGENTS.fragment.md -> merge into AGENTS.md
```

Do not copy Claude or Cursor adapter files unless the user explicitly requests multi-runtime installation.
