# Cursor Install Profile — Product Business Modeling

Use this profile when runtime adapter resolution selects `cursor`.

## Detection

Strong signals:

- user explicitly says they are using Cursor;
- repository contains `.cursor/`;
- repository contains `.cursor/rules/`;
- current task mentions Cursor Rules or Cursor Agent.

## Transformations

Install common project assets once:

```text
docs/product/PRODUCT_WORK_ITEMS.md
docs/product/model-triggers/
docs/product/business-modeling/
docs/product/work-items/
```

Then install Cursor runtime files:

```text
adapters/cursor/rules/product-business-modeling.mdc -> .cursor/rules/product-business-modeling.mdc
adapters/cursor/skills/product-business-modeling/ -> .cursor/skills/product-business-modeling/  # if current Cursor supports project Agent Skills
adapters/cursor/AGENTS.fragment.md -> merge into AGENTS.md
```

If the user’s Cursor setup does not support project Agent Skills, the `.cursor/rules/product-business-modeling.mdc` rule is the required fallback. Do not invent unsupported Cursor configuration fields.
