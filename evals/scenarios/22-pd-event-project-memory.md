# 22. PD Event Project Memory

## Given

The user asks Codex to design a membership system with Free, Pro, and Team boundaries.

## When

Codex creates the Work Item.

## Then

- The state decision is `CREATE`.
- The Work Item uses `domain: "PD"`.
- The Work Item records target users, business goals, feature tiers, pricing assumptions, permissions, risks, open questions, approved decisions, and downstream UX constraints.
- Artifacts include a PRD, pricing model, decision map, or equivalent product outputs.
- `project_memory_updates` proposes updates to `PRODUCT_DESIGN.md` and/or `BUSINESS_CONTEXT.md`.
- Visual Gates are skipped when not applicable, but `completion-approval` remains required.

