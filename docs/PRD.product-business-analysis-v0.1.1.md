# DesignHarnessAgent — Product Business Analysis Core PRD

- Version: v0.1.1-alpha
- Status: Codex implementation specification
- Capability ID: `product-business-analysis`
- Product name: 商业分析能力集群
- Architecture: Agent-neutral standalone Core

## 1. Product Summary

Business Analysis is a decision-support capability for business situations of any size. It preserves the user's original input, confirms understanding, routes to a new or existing Decision Case, dynamically selects professional Analysis Model Cards, produces structured Analysis Runs, performs counterfactual and assurance checks, and records user decisions, validation plans, review conditions, and Decision Network relationships.

It is not a business report generator and not a pipeline into another capability.

## 2. Core Value

```text
模糊业务输入
→ 被正确理解
→ 被路由到正确 Decision Case
→ 事实、假设和证据被分开
→ 适用专业模型被动态装配
→ 真实选择和后果被看见
→ 用户选择、验证或暂缓
→ 决策过程可追踪、可复审
```

## 3. Standalone Requirement

Business Analysis MUST:

- start and finish without any sibling capability;
- own its project assets and Work Items;
- avoid reading sibling assets as implicit authority;
- avoid modifying sibling Core, Adapters, templates, examples, evals, or project assets;
- emit no cross-capability Trigger;
- compile no downstream view;
- create no shared Product Work Item directory.

## 4. Architecture

Three layers:

```text
Core → Runtime Adapters → Project Knowledge Assets
```

Five operational domains:

```text
1. Orchestration and Routing
2. Core Decision Analysis
3. Review, Risk and Decision Memory
4. Intake, Extraction and Assurance
5. Human Decision Control Plane
```

Passive Trigger is a non-goal.

## 5. Required Workflow

1. Preserve first input verbatim.
2. Produce Input Understanding Snapshot.
3. Confirm understanding or record a provisional assumption.
4. Determine entry mode and Case routing.
5. Bind one authoritative Decision Case and a BA Work Item when state has value.
6. Ask the Next Best Question.
7. Classify and admit evidence.
8. Select Model Cards based on fit and input sufficiency.
9. Produce Analysis Runs and cross-model synthesis.
10. Run counterfactual analysis.
11. Run Decision Assurance.
12. Produce choice-style conclusion.
13. Record D2/D3 human decision where applicable.
14. Update Case, Network, Evidence, Review, Analysis Output, and Process Package.

## 6. Required Outputs

### Long-lived

```text
BUSINESS_ANALYSIS_INDEX.md/yml
BUSINESS_ANALYSIS_WORK_ITEMS.md
decision-cases/
decision-network/DECISION_NETWORK.md/yml
evidence/EVIDENCE_LEDGER.md/yml
reviews/
```

### Work Item

```text
STATE.md
ANALYSIS_CONSUMPTION.md
ANALYSIS_OUTPUT.md
DECISION_NOTES.md
DECISION_PROCESS_PACKAGE.md
artifacts/*
```

### Decision Case

Fixed 16-field contract; original input and Analysis Workspace are mandatory structural fields.

## 7. Analysis Model Cards

A ready card MUST include fit conditions, input/output contracts, misuse guards, quality checks, combinations, and six non-empty usage prompts.

The first registry contains 8 core and 16 professional cards.

## 8. Human Decision

Use D0–D3 impact classification. AI may create draft/provisional analysis. D2/D3 confirmed decisions, supersession, deprecation, and sealing require explicit user authority.

## 9. Project Structure

```text
docs/product/business-analysis/
├── BUSINESS_ANALYSIS_INDEX.md
├── BUSINESS_ANALYSIS_INDEX.yml
├── BUSINESS_ANALYSIS_WORK_ITEMS.md
├── decision-cases/
├── decision-network/
├── evidence/
├── reviews/
└── work-items/
```

No Decision Case copy is allowed under a Work Item.

## 10. Definition of Done

- Core / Adapter / Project Assets exist and are consistent.
- Standalone five-domain architecture is documented.
- Passive Trigger is absent.
- 16-field Case contract is implemented.
- First input is preserved verbatim.
- Work Item and Case sources of truth are separated.
- 24 ready model cards validate and have six prompts.
- Counterfactual and Assurance are mandatory.
- Example is internally consistent.
- 20 eval scenarios exist.
- No shared Work Item path, trigger folder, downstream view, CLI, Hook, Plugin, installer, or external dependency.
- Existing sibling capability paths are not modified by the implementation.
