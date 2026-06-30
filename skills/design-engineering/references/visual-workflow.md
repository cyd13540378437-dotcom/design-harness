# Visual Workflow

This reference defines the visual workflow used by `design-engineering` in v0.1.1-alpha / reference-library increment on top of the v0.1.0-alpha visual-workflow revision.

## Intent

The workflow replaces abstract user-facing style taxonomies with concrete visual artifacts. Users should not be required to fill in product personality, brand temperament, emotion coordinates, or user-feeling matrices.

The agent should ask for or provide concrete material:

```text
Visual Seed
→ Surface Resolution
→ Reference Library / Reference Images / Reference Packs
→ Reference Analysis
→ Palette Proposal
→ Palette Confirmation
→ Design Exclusions
→ Exclusions Confirmation
→ Visual Prototype
```

## Visual Seed

Visual Seed is the user's original visual input. It can be a word, a sentence, a product name, a rough description, or empty.

Rules:

- Record the original wording.
- Do not force it into product-personality labels.
- Treat it as a starting hint, not a complete strategy.

## Surface Resolution

Before searching references, resolve the target surface:

```yaml
primary_surface: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
secondary_surfaces: []
explicitly_out_of_scope: []
evidence: []
open_questions: []
```

If the surface is clear from the request, repository structure, technology stack, or existing state, record the assumption and continue. Ask the user only when the ambiguity would materially change reference selection, prototype scope, or implementation.

## Reference Library

If `docs/design/reference-library/` exists, use it before presenting visual directions. Filter by:

1. Same surface.
2. Same page type.
3. Same task type.
4. Similar content density and interaction complexity.
5. Similar user maturity.
6. Adjacent industry.
7. Visual tags.

Save task-level reference consumption in:

```text
docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md
```

References are evidence for the agent, not vocabulary the user is expected to know. Present directions as product-language trade-offs such as "efficiency workspace", "guided assistant", "content discovery", or "quick logging"; product names may appear as supporting rationale, not as required user choices.

`STATE.md` records only the surface target, Reference Selection link, adopted principles, approved direction, and important exclusions. Cross-surface references may inform abstract patterns, but must not be directly copied into layout, navigation, gesture, density, or visual ratio decisions.

## Reference Images

Use sources in this order:

1. Images uploaded in the conversation.
2. Images placed in `docs/design/reference-images/`.
3. References already recorded in `docs/design/VISUAL_DESIGN.md`.
4. Product or pattern references from `docs/design/reference-library/`, when present.
5. Built-in packs under `assets/visual-reference-packs/`.
6. Text-only candidates inferred from Visual Seed.

Analyze only observable visual features: layout, density, color behavior, hierarchy, component shape, borders, typography, motion cues, and responsive implications.

Do not copy third-party brand assets, screenshots, logos, or proprietary content. Clearly separate "borrowable traits" from "do not copy".

## Palette Confirmation

Palette confirmation must happen before complete visual design. Every `palette-selection` checkpoint must present at least three candidate palettes. The agent may mark one as recommended, but must not ask the user to confirm a single palette in isolation.

Candidate palettes must be shown as one palette comparison board. Each palette uses the same mini UI sample so the user can compare actual contrast and feel across buttons, cards, tags, navigation, text, and states. Do not provide color values alone.

User-facing hierarchy:

- Primary: primary buttons, selected state, critical highlights.
- Secondary: auxiliary emphasis, tags, secondary actions.
- Tertiary accent: small decorations, local hints, low-priority variation.

Implementation tokens:

- Background
- Surface
- Elevated surface
- Text primary
- Text secondary
- Text muted
- Border
- Divider
- Success
- Warning
- Error
- Info

Each candidate also includes a concise comparison note:

- Primary text on background readability.
- Button text on primary color contrast.
- Secondary text, border, and tag clarity.
- Best-fit usage mood or scenario.
- Risk notes such as too bright, too cold, too sweet, too corporate, or weak contrast.

State checkpoint:

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

State body:

```text
视觉子步骤：palette-selection
```

Stop until the user confirms, rejects, combines, asks for revision, or provides a custom color direction.

If the user provides a custom color direction instead of choosing a candidate, treat it as a valid `palette-selection` decision. Record the user's original color input, the comparison summary, the final adjusted palette, whether it was derived from a candidate, and the reason for the choice.

## Design Exclusions

Design exclusions are short, actionable "do not go there" constraints generated after palette confirmation.

Inputs:

- Product context
- Visual Seed
- Reference analysis
- Approved palette
- Existing `VISUAL_DESIGN.md`
- Common template-like risks

Recommended length: 4-8 items.

State checkpoint:

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

State body:

```text
视觉子步骤：design-exclusions
```

Stop until the user confirms, rejects, or revises.

## Visual Prototype

A visual prototype must show:

- Page structure
- Information hierarchy
- Content density
- Core components
- Approved palette
- Approved design exclusions
- Key responsive behavior
- At least one empty, loading, or error state

Variant rules:

- Clear visual input: one main proposal.
- Conflicting references or uncertain user input: two proposals.
- No references and no selected reference pack: two or three directions.
- Never present fake variants that differ only by color, radius, or icon swaps.

## Visual Baseline

Create or update `docs/design/VISUAL_DESIGN.md` before completion review for visual Work Items, unless the state explains why no update is needed.

The baseline records only approved results. It does not replace `STATE.md` and must not include unapproved experiments.

Future Work Items must read the baseline first. If a later task changes it, record the reason in that task's `STATE.md` and update `VISUAL_DESIGN.md`.
