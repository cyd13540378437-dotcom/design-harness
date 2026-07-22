# Standalone Product Business Analysis Rules v0.1.2

- Use only `docs/product/business-analysis/` project assets.
- Preserve original user input verbatim.
- Input Understanding precedes Routing and solution recommendation.
- Resume the relevant BA Work Item before every follow-up response.
- Maintain Decision Anchor continuity.
- Treat the user's solution as a candidate and challenge its premise.
- Decision Case has one authoritative file in `decision-cases/`.
- BA Work Items live inside the module root.
- Process artifacts live under `work-items/BA-xxx/artifacts/`; no `intake/` directory.
- Analysis Model Cards require seven usage prompts, including `decision_relevance_prompt`.
- Every Analysis Run requires Decision Delta.
- Only one unified conclusion may be user-facing.
- Counterfactual and Decision Assurance are mandatory.
- Final conclusions bind Case, Work Item, Assurance, evidence boundary, and user-decision status.
- Human-readable outputs must have a complete Simplified Chinese version.
- No cross-capability read/write/trigger/handoff.
