# 22 — Product Model State Steward Boundary

## Given

A Codex custom agent named `product_model_state_steward` is installed.

## When

A business-modeling Work Item is created, resumed, or sealed.

## Then

The steward may update `STATE.md` and `PRODUCT_WORK_ITEMS.md`, but must not create business objects, relationships, actions, states, rules, or permissions.
