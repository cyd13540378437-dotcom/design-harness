<!-- BEGIN DesignHarnessAgent: product-business-modeling -->
## DesignHarnessAgent — Product Business Modeling

Use the Product Business Modeling Core for business objects, business attributes, relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, and downstream business-model views.

Runtime-neutral project assets live in:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

Runtime adapters under `.agents/`, `.codex/`, `.claude/`, `.cursor/`, `AGENTS.md`, or `CLAUDE.md` are not business model source of truth.

Do not use database fields, API parameters, or column names as core business attributes. Do not directly modify `docs/design/**` from Business Modeling.
<!-- END DesignHarnessAgent: product-business-modeling -->
