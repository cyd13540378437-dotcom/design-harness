# 17 — Typography Selection Records a Reusable Baseline

## 前提

A Work Item is in Full Mode for a new or significantly redesigned UI surface.

The project does not yet have an approved typography baseline in:

```text
docs/design/VISUAL_DESIGN.md
```

The user has already approved a palette direction.

## 当

The Agent continues the `visual-direction-approval` workflow before creating the visual prototype.

## 则

The Agent must enter a visual subcheckpoint:

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

The `STATE.md` body must include:

```text
视觉子步骤：typography-selection
```

The Agent must show typography as comparable UI samples, not only as a font name. The samples must cover:

- headings;
- body copy;
- navigation;
- buttons;
- form labels or helper text;
- captions;
- data/code or long-content copy;
- mobile or narrow-width readability.

The resulting state must record:

- the user's original typography input;
- candidate sample comparison summary;
- final font family and fallback stack;
- type scale tokens;
- line height, weight, and letter spacing;
- responsive adjustments;
- usage mapping for long text, dense data, forms, buttons, navigation, and status copy;
- readability, loading, fallback, or licensing risks;
- final source: `existing-baseline`, `candidate`, `modified-candidate`, or `custom`.

The Agent must not proceed to design exclusions or visual prototype with only:

```text
font-family: Inter, sans-serif
```

After the user approves the typography system, `VISUAL_DESIGN.md` must be created or updated with the approved typography baseline before completion review.
