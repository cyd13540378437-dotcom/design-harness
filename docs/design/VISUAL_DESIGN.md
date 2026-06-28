# Visual Design Baseline

> This file records the approved visual baseline for the current design trial. Work Item STATE.md files remain authoritative for individual task status.

## Status

- Last updated: 2026-06-28T21:37:00+08:00
- Source Work Item: DE-002
- Stability: draft

## Visual Seed

个人备忘录。

## Reference Images

- Built-in reference direction: `playful-consumer-app`
- User custom color input: "主色是白色的，干干净净的极简风格"

## Reference Analysis Summary

- Borrowable traits: mobile-first navigation, touch-friendly spacing, visible empty state, light status feedback.
- Final adjustment: reduce playfulness and color saturation; keep white as the main visual color with warm neutral support.
- Do not copy: candy-colored cards, oversized rounded shapes, decorative images that distract from quick note entry.

## Approved Palette

### User-facing hierarchy

- Primary: white main surfaces with dark ink actions.
- Secondary: warm gray chips and filters.
- Tertiary accent: muted warm gold for pinned notes, reminders, and small status marks.

### UI tokens

- Background: `#FAF8F3`
- Surface: `#FFFFFF`
- Elevated surface: `#FFFFFF`
- Text primary: `#24211D`
- Text secondary: `#716B62`
- Text muted: `#9A9288`
- Border: `#E8E1D6`
- Divider: `#EFE8DE`
- Success: `#5F8F73`
- Warning: `#D8B56D`
- Error: `#B75E55`
- Info: `#7B8FA8`

## Design Exclusions

- Do not create a cold pure-white medical feel.
- Do not use large colorful or candy-like surfaces.
- Do not use blue-purple AI gradients.
- Do not stack complex decorative cards.
- Do not over-round every element.
- Do not let decoration compete with the quick note entry.
- Do not make it feel like an enterprise productivity dashboard.

## Typography

Use system sans-serif. Keep text compact and readable. Titles should feel personal and calm, not promotional.

## Spacing and Density

Use mobile-first spacing with generous tap targets. Keep memo cards compact enough for scanning while preserving readable line length.

## Component Language

- Surfaces are white with fine warm borders.
- Cards use subtle shadow and modest radius.
- Primary action uses dark ink on white/warm background for strong contrast.
- Tags are quiet warm-gray chips.
- Pinned and reminder states use small warm-gold marks, not large color blocks.

## Layout Principles

- The quick entry field owns the first viewport.
- Recent notes stay close to the input.
- Search and settings are secondary navigation items.
- Desktop may use list + detail, but should not become a dashboard.

## Interaction and Motion Notes

- Autosave status should be visible but quiet.
- Deletion moves to trash first; permanent deletion is delayed.
- Motion should be functional and minimal.

## Accessibility Notes

- Keep dark text on warm white for readability.
- Do not use pale gold as the only indicator for important states.
- Maintain visible focus outlines for input, cards, and navigation.

## Example Screens or Prototypes

- DE-002 prototype: `docs/design/prototypes/DE-002-personal-memo/index.html`

## Change Summary

- 2026-06-28: Created from DE-002 after custom white primary visual direction, warm minimal palette, design exclusions, prototype, and interaction decisions were approved.
