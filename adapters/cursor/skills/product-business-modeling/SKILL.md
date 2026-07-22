---
name: product-business-modeling
description: Apply the Agent-neutral Product Business Modeling Core in Cursor for durable model assets, canonical Work Items, consistency validation, the default business-model overview, triggers, and downstream views.
---

# Product Business Modeling — Cursor Adapter

- Read `docs/product/BUSINESS_MODEL_OVERVIEW.md` first when present.
- Follow `core/product-design/business-modeling/CAPABILITY.md` and the v0.2.3 overview, Work Item, canonical asset, Human Decision and validation contracts.
- Use exact canonical Work Item files and the frozen State Schema.
- Keep all model references stable by ID.
- Run consistency validation after every persistent Core write, refresh the overview, then compile requested professional views.
- Show only the overview as the default user result.

Do not substitute custom task files, write technical fields into Core assets, mix object lifecycles, misplace derived values, edit `docs/design/**`, or seal without human approval.
