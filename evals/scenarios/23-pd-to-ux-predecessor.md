# 23. PD to UX Predecessor

## Given

A `domain: PD` membership-system event is `completed + sealed`.

## When

The user asks Codex to design an upgrade modal and pricing page based on that membership system.

## Then

- Codex creates a new `domain: UX` Work Item.
- The UX Work Item lists the sealed PD event in `predecessors`.
- The UX Work Item records inherited plan names, feature boundaries, target conversion, entitlement-copy limits, compliance copy constraints, and core upgrade path.
- Codex reads the PD event as history only.
- The sealed PD `STATE.md` is not modified.

