# Project Memory

Project Memory stores durable project context that should survive beyond a single Work Item. It is not a transcript and does not replace any Work Item `STATE.md`.

Use this folder for compressed, long-lived facts:

- Business context and constraints.
- Product design decisions and object models.
- UX principles, flows, and state strategy.
- Visual baseline notes that remain true across Work Items.
- Engineering constraints that affect design execution.
- Decision index entries with source Lifecycle Event IDs.

Do not copy full conversations, complete `REFERENCE_SELECTION.md` files, full color-card annotations, or transient implementation notes into Project Memory.

## Files

- `BUSINESS_CONTEXT.md`: users, business goals, market assumptions, compliance or commercial constraints.
- `PRODUCT_DESIGN.md`: feature boundaries, plans, permissions, pricing assumptions, product decisions.
- `UX_DESIGN.md`: user journeys, information architecture, interaction principles, empty/loading/error state strategy.
- `VISUAL_DESIGN.md`: visual baseline, palette direction, typography, density, layout principles, visual exclusions.
- `ENGINEERING_CONTEXT.md`: stack constraints, reusable components, implementation limits, testing or deployment notes.
- `DECISIONS.md`: index of durable decisions, each tied to a source event.

