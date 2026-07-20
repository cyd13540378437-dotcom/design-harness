<!-- BEGIN DesignHarnessAgent: product-business-modeling -->
# DesignHarnessAgent — Product Business Modeling

Use `/product-business-modeling` for Product Business Modeling tasks: business objects, business attributes, relationships, actions, states, rules, permissions, model triggers, impact reports, project extraction, consistency validation, and downstream views.

Business Modeling is an Agent-neutral Core. Claude Code files are only runtime adapters.

Project source of truth:

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

Do not move business model knowledge into `.claude/skills/`, `.claude/agents/`, or `CLAUDE.md`. Do not directly modify `docs/design/**` from Business Modeling. Escalate D2/D3 business semantics to the user before marking them confirmed.
<!-- END DesignHarnessAgent: product-business-modeling -->
