# Product Business Analysis Rules

This project uses the standalone `product-business-analysis` capability.

## Owned project root

```text
docs/product/business-analysis/
```

All Business Analysis assets, including Work Items, stay under this root.

## Hard rules

- Preserve first user input verbatim.
- Do Input Understanding before Routing.
- Decision Cases are authoritative only in `decision-cases/`.
- Work Items link to Cases and never duplicate them.
- Use Model Cards with all usage prompts.
- Record explicit D2 / D3 human decisions.
- Run counterfactual and assurance checks.
- Do not read, modify, trigger, or create sibling capability assets.
- Do not create shared `docs/product/work-items/`, `model-triggers/`, or downstream views for this module.
