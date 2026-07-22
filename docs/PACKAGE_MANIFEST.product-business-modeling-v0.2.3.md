# Package Manifest — Product Business Modeling v0.2.3

## Identity

- Capability: `product-business-modeling`
- Version: `v0.2.3`
- Status: `implementation-ready`
- Architecture: Agent-neutral Core + runtime adapters + project assets
- Release profile: documentation-only; no runtime dependency

## Release purpose

v0.2.3 turns a real Greenfield modeling experiment into a hardened product contract:

```text
modular source-of-truth assets
+ canonical Work Item protocol
+ mandatory consistency closure
+ one product-owner overview
```

The detailed files remain in place. Only the default reading experience is simplified.

## Single default user artifact

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

This file is a derived product-owner view. It is not source of truth and must be recompiled after validated model changes.

## New primary Core files

```text
core/product-design/business-modeling/assets/BUSINESS_MODEL_OVERVIEW.template.md
core/product-design/business-modeling/protocols/business-model-overview.md
core/product-design/business-modeling/protocols/work-item-file-contract.md
core/product-design/business-modeling/protocols/canonical-model-asset-contracts.md
core/product-design/business-modeling/references/semantic-ownership-and-derived-attributes.md
core/product-design/business-modeling/references/subcapability-work-logic-v0.2.3.md
```

## New project template file

```text
templates/project/docs/product/BUSINESS_MODEL_OVERVIEW.md
```

## v0.2.3 release documents

```text
docs/PRD.product-business-modeling-v0.2.3.md
docs/CODEX_BUILD_BRIEF.product-business-modeling-v0.2.3.md
docs/V0.2.2-to-v0.2.3-delta.md
docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.3.md
docs/READINESS_AUDIT.product-business-modeling-v0.2.3.md
docs/product-summary.business-modeling-v0.2.3.md
```

## Updated contracts

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/capability.manifest.yml
Core and project State / Decision / Output / Consistency templates
Business Dictionary / Business Model Index / Schema View templates
Action / Relationship / State / Rule / Permission templates
Shared Agent Skill facade
Codex / Claude Code / Cursor adapters and State Stewards
Runtime overlays
Project initialization templates
Examples and evaluation scenarios
Root start-here, README, AGENTS and CHANGELOG files
```

## Canonical Work Item contract

Every persistent BM Work Item uses:

```text
docs/product/work-items/BM-xxx/
├── STATE.md
├── MODELING_CONSUMPTION.md
├── MODELING_OUTPUT.md
├── DECISION_NOTES.md
└── artifacts/
    ├── SOURCE_EVIDENCE.md
    ├── MODEL_EXTRACTION_REPORT.md
    ├── MODEL_CONSISTENCY_REPORT.md
    └── MODEL_IMPACT_REPORT.md
```

Artifact applicability depends on entry mode, but the four root files are canonical. Legacy aliases are migration inputs only.

## Regression examples

### Primary Greenfield example

```text
examples/product-business-modeling/work-order-intelligent-dispatch/
```

Demonstrates the full v0.2.3 contract using the equipment and facilities intelligent dispatch model.

### Compact passive-trigger example

```text
examples/product-business-modeling/docs/product/
```

Demonstrates an upstream pricing change, provisional Seat semantics and a pending Human Decision.

## Evaluation inventory

```text
evals/product-business-modeling/scenarios/01-*.md ... 41-*.md
```

- 28 retained regression scenarios;
- 13 v0.2.3 hardening scenarios;
- 41 total contiguous Given / When / Then scenarios.

## Package inventory

At release audit time:

| Type | Count |
|---|---:|
| Total files | 281 |
| Markdown | 247 |
| YAML | 16 |
| JSON | 4 |
| TOML | 2 |
| Evaluation scenarios | 41 |

## Scope exclusions

The package contains no CLI, Hook, Plugin, Installer, executable state manager, external runtime dependency, database migration generator, API generator, cloud service or multi-user locking mechanism.
