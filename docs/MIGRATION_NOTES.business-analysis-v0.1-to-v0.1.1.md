# Migration Notes — v0.1 to v0.1.1

## Breaking structure fixes

1. Move BA Work Items from `docs/product/work-items/BA-xxx/` to `docs/product/business-analysis/work-items/BA-xxx/`.
2. Remove Work Item-level `DECISION_CASE.md`; keep the authoritative Case only under `decision-cases/`.
3. Add `BUSINESS_ANALYSIS_WORK_ITEMS.md` under the module root.
4. Add `ANALYSIS_CONSUMPTION.md`, `ANALYSIS_OUTPUT.md`, and `DECISION_NOTES.md`.
5. Replace implied six-domain inheritance with an explicit five-domain standalone architecture.
6. Remove any language implying downstream implications are executable cross-capability work.

Existing v0.1 content can be migrated by keeping Decision Cases, model cards, and Analysis Runs, while relocating Work Items and updating links.
