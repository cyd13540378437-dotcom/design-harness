# CODEX START HERE — Design Harness Core Entries

## Product Business Modeling v0.2.3

This package is the runtime-aware Codex entry for `product-business-modeling`. v0.2.3 keeps the Core / Adapter / Project Assets separation from v0.2.2 and adds a single default user-facing overview plus stricter canonical file contracts.

Read in this order:

1. `docs/PRD.product-business-modeling-v0.2.3.md`
2. `docs/CODEX_BUILD_BRIEF.product-business-modeling-v0.2.3.md`
3. `core/product-design/business-modeling/CAPABILITY.md`
4. `core/product-design/business-modeling/protocols/business-model-overview.md`
5. `core/product-design/business-modeling/protocols/validation-and-evals.md`
6. `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`
7. `adapters/adapter-registry.yml`
8. `skills/product-business-modeling/SKILL.md`
9. `adapters/codex/skills/product-business-modeling/SKILL.md`
10. `adapters/codex/agents/product-model-state-steward.toml`
11. `templates/project/docs/product/BUSINESS_MODEL_OVERVIEW.md`
12. `templates/project/runtime-overlays/codex/.agents/skills/product-business-modeling/SKILL.md`

Do not remove the Core / Adapter / Project Assets separation.

`docs/product/business-modeling/` is the product knowledge source of truth.

`.agents/skills/product-business-modeling/` is only the Codex invocation facade after the Codex runtime overlay is selected and materialized.

v0.2.3 Codex rules:

- bind a BM Work Item using the five Harness binding decisions;
- use canonical Work Item files: `STATE.md`, `MODELING_CONSUMPTION.md`, `MODELING_OUTPUT.md`, and `DECISION_NOTES.md`;
- use the exact Core State fields; runtime metadata belongs in `extensions`;
- write Core assets only within owned boundaries;
- run consistency validation after Core writes;
- compile `docs/product/BUSINESS_MODEL_OVERVIEW.md`;
- present the overview as the only default user reading link.

If you are applying runtime files from Codex, use the Codex profile. If the target project is meant for Claude Code or Cursor, do not install only Codex files; apply `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` and the matching install profile.

## Product Business Analysis v0.1.4

`product-business-analysis` is a fully standalone, choice-first sibling capability for business decision support, with explicit decision-boundary and choice-closure controls.

Read in this order:

1. `README.zh-CN.md`
2. `docs/PRD.product-business-analysis-v0.1.4.md`
3. `docs/ARCHITECTURE_DECISION.decision-boundary-and-choice-closure-v0.1.4.md`
4. `docs/ARCHITECTURE_DECISION.choice-first-business-analysis-v0.1.3.md`
5. `docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.2.md`
6. `docs/ARCHITECTURE_DECISION.business-problem-continuity-v0.1.2.md`
7. `core/product-design/business-analysis/CAPABILITY.md`
8. `core/product-design/business-analysis/SKILL.md`
9. `core/product-design/business-analysis/capability.manifest.yml`
10. `core/product-design/business-analysis/protocols/mixed-turn-interpretation.md`
11. `core/product-design/business-analysis/protocols/choice-loop-closure.md`
12. `core/product-design/business-analysis/protocols/decision-scope-lock.md`
13. `core/product-design/business-analysis/protocols/post-decision-clarification.md`
14. `core/product-design/business-analysis/protocols/artifact-boundary-gate.md`
15. `core/product-design/business-analysis/protocols/no-execution-offer.md`
16. `core/product-design/business-analysis/protocols/state-enum-enforcement.md`
17. `core/product-design/business-analysis/protocols/choice-first-decision-support.md`
18. `core/product-design/business-analysis/protocols/recommendation-obligation.md`
19. `core/product-design/business-analysis/protocols/claim-level-assurance.md`
20. `core/product-design/business-analysis/protocols/no-dead-end-rule.md`
21. `core/product-design/business-analysis/protocols/decision-closure-contract.md`
22. `core/product-design/business-analysis/protocols/follow-up-turn-continuity.md`
23. `core/product-design/business-analysis/protocols/output-contract.md`
24. `core/product-design/business-analysis/model-cards/analysis-model-card.schema.yml`
25. `docs/MIGRATION_NOTES.business-analysis-v0.1.3-to-v0.1.4.md`
26. `docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.4-complete.md`
27. `docs/PACKAGE_MANIFEST.product-business-analysis-v0.1.4.md`

Hard rules:

```text
Business Analysis owns docs/product/business-analysis/ only.
It does not depend on, trigger, or modify Business Modeling, Design Engineering, Motivation Analysis, or any sibling capability.
Decision Cases live only in decision-cases/; BA Work Items never copy DECISION_CASE.md.
Follow-up turns must recover the active BA Work Item and linked Decision Case before answering.
Choices are the core object: form a provisional Choice Set soon after problem confirmation.
Every stage conclusion must include a current provisional, conditional, or user-confirmed recommendation.
Assurance is claim-level; blocked claims must not terminate the whole Case.
No Dead-End: missing information still requires realistic paths and a recommendation.
Mixed turns must split decision_signal from followup_request; handle decisions first.
Confirmed decisions close the Choice Loop, write DECISION_NOTES, and stop asking for the same choice.
Post-decision clarification stays at the original business decision layer.
Do not create implementation runbooks, schemas, sample data, formulas, scripts, UI / technical design, or execution outputs.
Do not offer to generate, run, script, simulate, build, or implement.
Use only the fixed State status / phase / gate enums.
Standard output centers on STATE, Decision Case, ANALYSIS_WORKSPACE, DECISION_SUMMARY, and DECISION_NOTES.
Deep / Audit process files live under work-items/BA-xxx/artifacts/ only; do not create intake/.
User-visible and human-readable project Markdown defaults to Simplified Chinese.
Acknowledgement is not a D2 / D3 confirmed decision.
```

Do not implement future integration features in this module: no motivation-analysis integration, passive triggers, downstream views, cross-capability propagation, shared work-items, CLI, hook, plugin package, installer, external runtime dependency, or automatic D2 / D3 decision.
