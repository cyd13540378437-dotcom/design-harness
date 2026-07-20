# Product Model State Steward Reference

The Codex Skill should delegate state operations to `product_model_state_steward` when that custom agent is installed.

The steward manages state only. It does not make business modeling decisions.

## Steward responsibilities

- bind current request to `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`;
- create or update `docs/product/work-items/BM-xxx-<slug>/STATE.md`;
- update `docs/product/PRODUCT_WORK_ITEMS.md` as an index;
- record gate checkpoints and pending human decisions;
- check closure readiness;
- seal only after explicit user approval;
- never modify sealed states.

## Main agent responsibilities

- perform business modeling analysis;
- write `MODELING_CONSUMPTION.md`, `MODELING_OUTPUT.md`, reports, and model assets;
- request human decisions;
- ensure semantic updates follow Core rules.
