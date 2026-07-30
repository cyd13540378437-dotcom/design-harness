# Color Card Registry — Bundled Reusable Library

This folder is the reusable Color Card Registry bundled with
`design-engineering`. It contains the original selected generic batch plus
project-produced directions that have been promoted for cross-project use.

## Scope

- Original selected generic cards: 28
- Reusable additions: 18
  - External color-relationship studies: 5
  - User-supplied night-lab directions: 3
  - Custom ambient-gradient directions: 6
  - Archive/editorial directions: 4
- Total ready cards: 46
- All 46 cards use `status: ready` and `gate_preview: true`

Project-only generators, comparison labs, macOS metadata, and rejected
experiments are not part of the bundled registry.

## Registry contract

A valid Color Card is a reference object, not a standalone image:

```text
palette-index.yml entry + image + palette + annotation
```

`palette-index.yml` is the machine-readable source of truth.
`palette-index.md` is a synchronized human-readable browsing index.

The following integrity rules apply:

- Every `id` is stable and unique.
- Each entry references exactly one image, palette, and annotation.
- Referenced files exist and their file stems match the entry `id`.
- Palette and annotation IDs match the index entry.
- Every non-placeholder file under `images/`, `palettes/`, and
  `annotations/` belongs to exactly one index entry.
- Orphan assets are not allowed.

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

The centralized `images/` directory intentionally supports visual browsing.
Do not convert the registry into `cards/<id>/` directories.

## Lifecycle

- `draft`: incomplete or under review; never use at a user approval Gate.
- `ready`: complete and eligible for retrieval.
- `deprecated`: retained for read-only history; exclude from recommendations
  by default.

Only a complete card with `status: ready` and `gate_preview: true` may appear
in `visual-direction-approval`.

## Adding a reusable card

1. Assign a stable, generic `id`.
2. Add `images/<id>.png`.
3. Add `palettes/<id>.yml`.
4. Add `annotations/<id>.md`.
5. Add the entry to `palette-index.yml`.
6. Update `palette-index.md`.
7. Run the full integrity checks from `color-card.schema.yml`.
8. Set `status: ready` only after every check passes.

If the image, palette, annotation, provenance, or business interpretation is
incomplete, keep the card out of user-facing approval. Do not infer visual
knowledge from a filename.

## Cross-project consumption

Use the project registry first. If a project has no registry and its target
directory is missing, empty, or contains only `.gitkeep`, install this entire
folder into:

```text
docs/design/reference-library/assets/color-cards/
```

If that project already contains a partial or custom registry, do not
overwrite it silently. Use this bundled registry only as a temporary fallback
until the project registry is explicitly repaired or merged.

At color approval:

- show large Color Card images with business semantics, trade-offs, and role
  intent;
- do not ask users to decide primarily from HEX/RGB values or tiny swatches;
- show at least three comparable directions with the same UI sample.

Record candidate and selected cards in the Work Item's
`REFERENCE_SELECTION.md`. Keep `STATE.md` limited to the approved card ID,
title, short usage/risk summary, and the `REFERENCE_SELECTION.md` link.

## Provenance boundary

The bundled images are abstract, project-produced Color Card previews. Some
entries document color-relationship studies derived from observable design
principles. They do not include third-party logos, screenshots, page layouts,
or other protected brand assets. Reuse the abstract color relationship and
business semantics; do not claim brand affiliation or copy third-party assets.
