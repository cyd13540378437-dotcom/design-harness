# Product Design Events

Use `domain: PD` for product design work that is upstream of UI implementation.

Examples:

- Membership systems.
- Pricing models.
- Feature boundaries.
- Permissions and plan limits.
- Product strategy.
- User segmentation.
- Object models.
- PRDs and decision maps.

## Workflow

PD events still use Work Item resolution, `STATE.md`, artifacts, outputs archive, Project Memory updates, and `completion-approval`.

Skip UI-specific visual Gates when they do not apply. Do not skip product decision confirmation or final completion approval.

## PD State Content

Record:

- Target users.
- Business goals.
- Version boundaries.
- Feature tiers.
- Pricing assumptions.
- Permissions and quotas.
- Risks.
- Open questions.
- Approved decisions.
- Constraints for later UX.
- Constraints for engineering.
- Project Memory update plan.

## PD to UX Inheritance

When a later UX event depends on a sealed PD event:

```yaml
predecessors:
  - "2026-07-06-1605-PD-001"
inherited_context:
  - "Plan names"
  - "Feature boundaries"
  - "Target conversion"
  - "Entitlements must not be overstated"
  - "Compliance copy constraints"
  - "Core upgrade path"
```

The UX event may read the sealed PD state and archived outputs, but must not modify them.

