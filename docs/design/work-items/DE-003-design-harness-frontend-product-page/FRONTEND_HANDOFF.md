# Frontend Handoff: Design Harness Product Page

> Trial artifact for DE-003. This file translates approved product direction into implementation-ready frontend structure. It is not yet part of the official v0.1 protocol.

## Product Surface

- Surface name: Design Harness Workspace
- Primary route: `/`
- Prototype file: `docs/design/prototypes/DE-003-design-harness-frontend-product-page/index.html`
- Target user: builders using Codex for important UI/UX work who need recoverable design state, human gates, and frontend-ready handoff.

## Page Map

| Route | Purpose | Status |
|---|---|---|
| `/` | Work Item workspace with state, gates, and handoff readiness | prototyped |
| `/work-items/:id` | Focused Work Item detail | represented inside single-page prototype |
| `/visual-baseline` | Project-level visual baseline | represented as panel |
| `/handoff` | Frontend handoff checklist and tokens | represented as panel |

## Layout Framework

### Desktop

- Breakpoint: `min-width: 1040px`.
- Structure: left navigation, central work area, right handoff rail.
- Left navigation width: `264px`.
- Right rail width: `340px`.
- Central area uses two stacked sections: Work Item header and tabbed body.

### Tablet

- Breakpoint: `720px` to `1039px`.
- Structure: top brand row, Work Items as horizontal chips, content stacked.
- Right rail moves below the main work area.

### Mobile

- Breakpoint: below `720px`.
- Structure: single column.
- Navigation becomes horizontal scroll.
- Panels keep one level of containment; do not nest cards inside cards.

## Design Tokens

```css
:root {
  --color-bg: #f7f8f6;
  --color-surface: #ffffff;
  --color-surface-muted: #eef3ef;
  --color-text: #202622;
  --color-text-secondary: #68726c;
  --color-border: #dce3dd;
  --color-primary: #206b5f;
  --color-primary-strong: #174b44;
  --color-info: #315c84;
  --color-warning: #b77a20;
  --color-success: #4d7c5b;
  --color-danger: #a95d55;
  --radius-sm: 6px;
  --radius-md: 8px;
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 24px;
  --space-6: 32px;
}
```

## Typography

- Font stack: system sans-serif.
- Page title: 30px desktop, 24px mobile, weight 680.
- Section title: 16px, weight 680.
- Body: 14px to 15px.
- Metadata: 12px to 13px.
- Letter spacing: `0`.

## Component Contracts

### WorkItemNav

- Props: `items`, `activeId`, `onSelect`.
- States: active, paused, completed, awaiting user.
- Required fields: id, title, phase, gate, status.

### GateTimeline

- Props: `gates`, `currentGate`.
- States: done, current, pending.
- Must expose current human decision clearly.

### StateSnapshot

- Props: `stateId`, `phase`, `gate`, `awaitingUser`, `sealed`, `updatedAt`.
- Must distinguish Work Item state from project visual baseline.

### HandoffPanel

- Props: `routes`, `tokens`, `components`, `checklist`.
- Checklist items must be independently actionable.
- Do not hide remaining frontend risks behind generic "ready" labels.

### PrototypePreview

- Props: `title`, `description`, `viewport`.
- Shows the shape of the product experience, not a marketing image.

## Interaction Rules

- Selecting a Work Item updates the central state snapshot and gate timeline.
- Handoff checklist toggles are local-only in this prototype.
- Adding a gate note appends a local note and changes the quiet status copy.
- No action in the prototype writes to `STATE.md`.
- Destructive actions are not included in DE-003.

## Required States

| Area | Loading | Empty | Error | Success |
|---|---|---|---|---|
| Work Items | skeleton row | no work items | state file unavailable | item selected |
| Gate Timeline | muted placeholders | no gates required | invalid gate enum | current gate visible |
| Handoff | checklist placeholders | no handoff yet | missing token/component | checklist item done |

## Accessibility

- All interactive controls must be keyboard reachable.
- Buttons and tabs use visible focus outlines.
- Status is represented with both text and color.
- Primary text contrast must stay readable on white and muted green surfaces.

## Acceptance Viewports

- Mobile: 390 x 844.
- Tablet: 768 x 1024.
- Desktop: 1440 x 900.

## Known Gaps

- No real framework integration yet.
- No route-level implementation.
- No persistent state mutation.
- Browser verification depends on serving the static file over localhost rather than `file://`.
