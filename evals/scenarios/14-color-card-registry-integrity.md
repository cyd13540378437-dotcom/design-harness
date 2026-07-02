# 14 — Color Card Registry Integrity

## 前提

A project contains:

```text
docs/design/reference-library/assets/color-cards/
├── palette-index.yml
├── images/ocean-wave-clear-cyan.png
├── palettes/ocean-wave-clear-cyan.yml
└── annotations/
```

`palette-index.yml` declares a card `ocean-wave-clear-cyan` with image and palette paths but no annotation path that exists.

## 当

The Agent prepares color direction candidates for a UI/UX Work Item.

## 则

- The Agent must detect that the card is incomplete.
- The Agent must not show this card to the user as a `visual-direction-approval` candidate.
- The Agent may briefly report that the incomplete card was skipped.
- The Agent must not ask the user to decide whether to use an incomplete color card.
- The Agent must not write the incomplete card as selected in `REFERENCE_SELECTION.md`.
