# Color Card Registry — Selected Batch 01

This folder contains the first selected batch for the generic product visual library.

## Scope

- Source board: `color-card-sourcing-board-v1`
- User rejected: 04, 06, 17, 19, 20, 21, 23, 33
- Produced ready cards: 28
- Status: all produced cards are `ready`
- Gate preview: all produced cards use `gate_preview: true`

## Registry contract

A valid color card equals:

```text
palette-index.yml entry + image + palette + annotation
```

`palette-index.yml` is the machine-readable source of truth. `palette-index.md` is a human-readable browsing index.

## Asset layout

```text
color-cards/
├── README.md
├── palette-index.yml
├── palette-index.md
├── color-card.schema.yml
├── images/
├── palettes/
└── annotations/
```

The centralized `images/` browsing experience is intentionally preserved. Do not convert this batch into `cards/<id>/` directories.
