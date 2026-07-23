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

## Source Resolution

Resolve and ensure the color-card source before palette selection:

1. Use the project registry when `docs/design/reference-library/assets/color-cards/palette-index.yml` exists.
2. If the project registry is missing and the Skill-bundled registry exists at `<skill-root>/assets/color-cards/palette-index.yml`, install the bundled registry into `docs/design/reference-library/assets/color-cards/` before palette selection.
3. If installation is not safe or not possible, use the Skill-bundled registry as a temporary fallback.
4. If both project and bundled registries are missing, or both have no valid ready cards, continue with non-registry color direction proposals.

Safe installation means the target `docs/design/reference-library/assets/color-cards/` directory is missing, empty, or contains only `.gitkeep` placeholders. Create the needed directories and copy the full bundled `color-cards/` contents, preserving centralized `images/`, `palettes/`, and `annotations/`.

Do not silently overwrite a partial or custom project registry. If the target directory contains non-`.gitkeep` files but lacks a valid `palette-index.yml`, report that the project registry is incomplete, use the bundled registry for the current Work Item, and ask for explicit repair/overwrite approval before modifying those assets.

When installing from the bundled registry, tell the user that the project had no installed Color Card Registry and that the Skill installed one from bundled assets. Record `registry_source: project-installed-from-skill-bundled` in `REFERENCE_SELECTION.md`. When installation is impossible and the bundled registry is used only temporarily, record `registry_source: skill-bundled`. Do not pretend the project already had a project-level registry.

## Retrieval Rules

Before proposing color direction candidates:

1. Resolve and ensure the registry source: project-first, auto-install from Skill-bundled assets when absent, temporary Skill-bundled fallback only when installation is unsafe or impossible.
2. Read the selected `palette-index.yml`.
3. Exclude entries whose `status` is not `ready`; only `status: ready` cards may be consumed.
4. Exclude entries whose `gate_preview` is not `true` when preparing user-facing approval choices; only `status: ready` and `gate_preview: true` cards may appear in `visual-direction-approval`.
5. Verify the referenced `image`, `palette`, and `annotation` exist relative to the selected registry directory.
6. Verify palette and annotation IDs match the index ID.
7. Prefer cards whose `surfaces` match the Work Item surface target.
8. Prefer cards whose mood and business semantics fit the task diagnosis.

If no valid cards exist in either the project registry or the Skill-bundled registry, say that no ready color cards are available and continue with non-library color direction proposals. Do not pretend that a missing or draft card came from the registry.

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
- registry source: `project`, `project-installed-from-skill-bundled`, or `skill-bundled`;
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
