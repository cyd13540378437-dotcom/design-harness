---
schema_version: 1
state_id: BM-000
title: ""
slug: ""
capability_id: product-business-modeling
entry_mode: direct_modeling
binding_decision: CREATE
status: active
phase: intake
knowledge_status: draft
awaiting_human: false
sealed: false
related_triggers: []
predecessors: []
created_at: YYYY-MM-DDTHH:mm:ssZ
updated_at: YYYY-MM-DDTHH:mm:ssZ
completed_at: ""
extensions: {}
---

# Business Modeling Work Item State

> Frontmatter is a frozen Core contract. Runtime adapters must not rename fields or add parallel authority fields. Runtime-only metadata may appear only under `extensions` or in the body.

## 任务摘要

## 入口模式

- Primary: `direct_modeling | passive_trigger | project_extraction | greenfield_modeling | consistency_validation | downstream_compilation`
- Composed modes:
- Binding decision: `CREATE | RESUME | SUCCESSOR`

## 范围

### 包含

### 不包含

## 验收标准

## 当前模型基线

## 当前阶段

Allowed phase values:

```text
intake
evidence
modeling
awaiting_decision
validation
compilation
completion_review
complete
```

## 已确认决定

## Provisional 判断

## 待确认问题

## 关联 Trigger

## 产物与链接

Canonical Work Item files:

```text
STATE.md
MODELING_CONSUMPTION.md
MODELING_OUTPUT.md
DECISION_NOTES.md
artifacts/MODEL_EXTRACTION_REPORT.md
artifacts/MODEL_CONSISTENCY_REPORT.md
artifacts/MODEL_IMPACT_REPORT.md
artifacts/SOURCE_EVIDENCE.md
```

## 校验结果

## 用户总览状态

- Path: `../../BUSINESS_MODEL_OVERVIEW.md`
- Status: `missing | stale | current`
- Last compiled at:

## 下游视图状态

## 运行时说明

> Steward availability, runtime adapter notes and execution details belong here or under `extensions`; they are not business-model authority fields.

## 下一步行动

## 关键状态变更摘要
