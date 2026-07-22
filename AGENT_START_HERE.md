# Agent Start Here — Design Harness Core Entries

## Product Business Modeling v0.2.3

This package keeps the v0.2.2 runtime-aware architecture and adds a single default user-facing overview plus stricter Core contracts.

Read in this order:

1. `docs/PRD.product-business-modeling-v0.2.3.md`
2. `core/product-design/business-modeling/CAPABILITY.md`
3. `core/product-design/business-modeling/protocols/business-model-overview.md`
4. `core/product-design/business-modeling/protocols/validation-and-evals.md`
5. `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md`
6. `adapters/README.md`
7. `adapters/adapter-registry.yml`
8. The install profile for the runtime actually used by the user:
   - Codex: `adapters/codex/INSTALL_PROFILE.md`
   - Claude Code: `adapters/claude-code/INSTALL_PROFILE.md`
   - Cursor: `adapters/cursor/INSTALL_PROFILE.md`

Hard rule:

```text
Every Agent-neutral Core must ship with a runtime adapter resolution protocol.
A runtime adapter must make the Core callable in the user’s current agent tool.
Project knowledge assets remain in docs/product/** and never move into runtime adapters.
docs/product/BUSINESS_MODEL_OVERVIEW.md is the single default user-facing file.
Canonical Work Item files and the frozen State Schema are runtime-independent.
Every Core write is followed by consistency validation and overview compilation.
```

This package does not add a CLI, installer, hook, plugin, external dependency, or automation daemon. Runtime transformation means that the agent copies and merges the correct adapter files for the user’s current tool after identifying it.

## Product Business Analysis v0.1.4

`product-business-analysis` is a standalone, choice-first business decision-support Core with explicit decision-boundary and choice-closure controls.

Read in this order:

1. `docs/PRD.product-business-analysis-v0.1.4.md`
2. `docs/ARCHITECTURE_DECISION.decision-boundary-and-choice-closure-v0.1.4.md`
3. `docs/ARCHITECTURE_DECISION.choice-first-business-analysis-v0.1.3.md`
4. `docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.2.md`
5. `docs/ARCHITECTURE_DECISION.business-problem-continuity-v0.1.2.md`
6. `core/product-design/business-analysis/CAPABILITY.md`
7. `core/product-design/business-analysis/SKILL.md`
8. `core/product-design/business-analysis/capability.manifest.yml`
9. `core/product-design/business-analysis/protocols/mixed-turn-interpretation.md`
10. `core/product-design/business-analysis/protocols/choice-loop-closure.md`
11. `core/product-design/business-analysis/protocols/decision-scope-lock.md`
12. `core/product-design/business-analysis/protocols/post-decision-clarification.md`
13. `core/product-design/business-analysis/protocols/artifact-boundary-gate.md`
14. `core/product-design/business-analysis/protocols/no-execution-offer.md`
15. `core/product-design/business-analysis/protocols/state-enum-enforcement.md`
16. `core/product-design/business-analysis/protocols/choice-first-decision-support.md`
17. `core/product-design/business-analysis/protocols/recommendation-obligation.md`
18. `core/product-design/business-analysis/protocols/claim-level-assurance.md`
19. `core/product-design/business-analysis/protocols/no-dead-end-rule.md`
20. `core/product-design/business-analysis/protocols/decision-closure-contract.md`
21. `core/product-design/business-analysis/protocols/follow-up-turn-continuity.md`
22. `core/product-design/business-analysis/protocols/output-contract.md`
23. `core/product-design/business-analysis/model-cards/index.yml`

Hard rule:

```text
Business Analysis is not a cross-capability trigger layer.
It owns docs/product/business-analysis/ and preserves Decision Case / Work Item source-of-truth separation.
Follow-up turns must recover the linked Case before answering.
Choices are the core object; form a provisional Choice Set soon after problem confirmation.
Every stage conclusion must include a current recommendation.
Assurance is claim-level; blocked claims do not terminate the whole Case.
No Dead-End: missing information still requires realistic paths and a recommendation.
Mixed turns split decision_signal from followup_request and handle decisions first.
Confirmed decisions close the Choice Loop and must not request the same choice again.
Post-decision clarification stays conceptual and within the original decision scope.
Do not create implementation runbooks, schemas, sample data, formulas, scripts, UI / technical design, execution outputs, or execution offers.
Use only the fixed State status / phase / gate enums.
Deep / Audit process files live under work-items/BA-xxx/artifacts/ only; do not create intake/.
User-visible and human-readable project Markdown defaults to Simplified Chinese.
Acknowledgement is not a confirmed D2 / D3 decision.
```
