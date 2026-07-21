# Architecture Decision — Standalone Business Analysis v0.1.1

## Decision

Business Analysis is implemented as a completely standalone sibling capability.

## Six-domain question

The existing six-domain capability architecture is useful as a design reference, not a universal inheritance requirement. Business Analysis adopts five applicable operational domains and omits Passive Trigger entirely.

## Why

- Input routing, core analysis, review/memory, evidence/assurance, and human control are intrinsic to Business Analysis.
- Passive Trigger and cross-capability propagation describe integration behavior, not the core decision-support product.
- Including a placeholder trigger would create false coupling and prematurely freeze a product feature that has not been designed.

## Consequences

- The module owns `docs/product/business-analysis/` and its Work Items.
- It has no dependency on sibling capability paths.
- Codex must add it as a sibling and preserve all existing modules.
- Future integration must be implemented as a separate layer and versioned separately.
