# Color Card Consumption

This reference extends the Reference Library consumption workflow with Color Card Registry rules.

## Purpose

Color cards are first-class visual references for color direction. They help users confirm a palette through a large visual card and business semantics, not raw HEX/RGB values or tiny icons.

## Position in Workflow

Use color cards during visual direction work:

```text
Surface Resolution
→ Reference Retrieval
→ Color Card Registry Retrieval
→ REFERENCE_SELECTION.md
→ visual-direction-approval
→ Prototype / Implementation / QA
```

## Registry Location

```text
docs/design/reference-library/assets/color-cards/
├── palette-index.yml
├── palette-index.md
├── color-card.schema.yml
├── images/
├── palettes/
└── annotations/
```

`palette-index.yml` is the source of truth.

## Retrieval Rules

Before proposing color direction candidates:

1. Read `palette-index.yml`.
2. Exclude entries whose `status` is not `ready`; only `status: ready` cards may be consumed.
3. Exclude entries whose `gate_preview` is not `true` when preparing user-facing approval choices; only `status: ready` and `gate_preview: true` cards may appear in `visual-direction-approval`.
4. Verify the referenced `image`, `palette`, and `annotation` exist.
5. Verify palette and annotation IDs match the index ID.
6. Prefer cards whose `surfaces` match the Work Item surface target.
7. Prefer cards whose mood and business semantics fit the task diagnosis.

If no valid cards exist, say that no ready color cards are available and continue with non-library color direction proposals. Do not pretend that a missing or draft card came from the registry.

## User-Facing Gate Rules

At `visual-direction-approval`, show color direction as business language plus large visual cards.

Do not ask the user to choose by HEX/RGB values.

Good pattern:

```text
Direction A: Clear Ocean Cyan
[show large color-card image]

Best for: calm, trustworthy, clean, technology-oriented interface.
Trade-off: cooler emotional tone; less suitable for aggressive sales or high-energy community pages.
Implementation intent: deep blue for primary actions, cyan for highlights, pale blue for calm backgrounds.
```

Bad pattern:

```text
Choose #006C9F + #1CA6D9 + #23B8B5.
```

## REFERENCE_SELECTION.md Rules

When color cards are considered, add a color section to the Work Item's `REFERENCE_SELECTION.md`:

- candidate color-card IDs;
- included / rejected reason;
- selected color-card ID after user approval;
- user-facing color direction summary;
- token mapping notes;
- accessibility notes;
- implementation boundaries.

## STATE.md Rules

Keep `STATE.md` compact. It may record:

- approved color direction title;
- selected color-card ID;
- link to `REFERENCE_SELECTION.md`;
- short summary of color usage and accessibility risk.

Do not copy the full color-card annotation or complete palette analysis into `STATE.md`.

## Steward Boundary

`design_state_steward` may record the selected color-card summary and link in `STATE.md`, but it does not select color cards, design color systems, or modify the Reference Library.

## Integrity Failure Handling

If incomplete color cards are found:

- skip them for user-facing candidates;
- report the skipped IDs briefly;
- do not block the Work Item if other valid cards exist;
- do not ask the user to decide whether to use an incomplete card.

Example:

```text
Reference Library 中有 2 张色卡不完整，已跳过：
- ocean-wave-clear-cyan：缺少 annotations/ocean-wave-clear-cyan.md
- warm-sunset-coral：palette id 与 index id 不一致
```
