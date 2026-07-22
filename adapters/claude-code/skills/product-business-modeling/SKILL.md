---
name: product-business-modeling
description: Build, validate, or compile Agent-neutral Product Business Modeling assets, including the default business-model overview, canonical Work Item files, model triggers, consistency reports, and downstream views.
---

# Product Business Modeling — Claude Code Adapter

This Skill exposes the Agent-neutral Core to Claude Code. Read the Core capability and v0.2.3 contracts before modeling.

## Required flow

1. Read `docs/product/BUSINESS_MODEL_OVERVIEW.md` first when present.
2. Resolve `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS` through the installed state steward when available.
3. Use the canonical Work Item root files and frozen `STATE.md` schema.
4. Keep dictionary, index, schema, objects, relationships, actions, states and rules aligned by stable IDs.
5. Route D2 / D3 decisions through `BMD-xxx` packages.
6. After every persistent Core write, generate `MODEL_CONSISTENCY_REPORT.md`, refresh the overview, then compile requested downstream views.
7. At normal completion, show only `docs/product/BUSINESS_MODEL_OVERVIEW.md` to the user.

Do not create substitute files, write data fields into Core assets, mix object lifecycles, treat context-dependent values as intrinsic attributes, modify `docs/design/**`, or seal without explicit human approval.
