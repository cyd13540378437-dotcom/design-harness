---
schema_version: 1
state_id: BM-001
title: Seat-based Pricing Business Model Impact
slug: seat-pricing-impact
capability_id: product-business-modeling
entry_mode: passive_trigger
status: active
phase: awaiting_decision
knowledge_status: provisional
awaiting_human: true
sealed: false
related_triggers:
  - MT-001
predecessors: []
created_at: 2026-07-17T00:00:00Z
updated_at: 2026-07-17T00:00:00Z
completed_at: ""
---

# Business Modeling Work Item State

## 任务摘要

响应 `MT-001`：计费方式从 Workspace-based 调整为 Seat-based 后，分析业务模型影响。

## 入口模式

`passive_trigger`

## 当前阶段

等待人类确认 `BMD-001`：Seat 是否为独立业务对象。

## 已确认决定

- BA-002 已 confirmed：按 Seat 计费。

## Provisional 判断

- Seat 很可能需要成为独立业务对象，而不仅是 Member 的数量属性。

## 待确认问题

- BMD-001：Seat 是否为独立业务对象？

## 关联 Trigger

- `MT-001-seat-pricing-model.md`

## 产物与链接

- `artifacts/MODEL_IMPACT_REPORT.md`
- `DECISION_NOTES.md`

## 下一步行动

等待用户确认 BMD-001 后，更新 business-dictionary、domain-objects、relationships、rules 和 downstream-views。
