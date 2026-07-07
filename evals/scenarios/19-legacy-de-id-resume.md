# 19. Legacy DE ID Resume

## Given

The project contains an active legacy state at `docs/design/work-items/DE-001-optimize-frontend-style/STATE.md`.

## When

A new Thread asks to continue `DE-001`.

## Then

- The state decision is `RESUME`.
- No duplicate Work Item is created.
- The legacy directory is not renamed.
- The Steward may report `legacy_state: true`, but the required `decision` enum remains unchanged.

