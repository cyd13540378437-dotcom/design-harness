---
schema_version: 1
state_id: BM-001
title: Seat-based Pricing Business Model Impact
slug: seat-pricing-impact
capability_id: product-business-modeling
entry_mode: passive_trigger
binding_decision: CREATE
status: active
phase: awaiting_decision
knowledge_status: provisional
awaiting_human: true
sealed: false
related_triggers:
  - MT-001
predecessors: []
created_at: "2026-07-17T00:00:00Z"
updated_at: "2026-07-22T00:00:00Z"
completed_at: ""
extensions:
  example_runtime: agent-neutral
---

# Business Modeling Work Item State

## 任务摘要

响应 `MT-001`：计费方式从按工作区调整为按席位后，分析业务模型影响，并让用户确认 Seat 的业务对象身份。

## 入口模式

- Primary: `passive_trigger`
- Binding decision: `CREATE`

## 范围

### 包含

- Seat 候选对象、关系、动作、状态、规则、权限和用户总览；
- `BMD-001` 决策压缩。

### 不包含

- 技术字段、数据库结构、API 或计费供应商实现。

## 验收标准

- Canonical Work Item 文件存在；
- 结构化模型 ID 一致；
- 一致性报告完成；
- 用户只读总览即可处理 `BMD-001`。

## 当前模型基线

`BA-002` 已确认按席位计费；Seat 身份仍为 provisional。

## 当前阶段

等待人类确认 `BMD-001`。

## 已确认决定

- `BA-002`：按 Seat 计费。

## Provisional 判断

- Seat 应成为独立业务对象；
- Seat 拥有独立生命周期。

## 待确认问题

- `BMD-001`：Seat 是否为独立业务对象？

## 关联 Trigger

- [`MT-001`](../../model-triggers/MT-001-seat-pricing-model.md)

## 产物与链接

- [MODELING_CONSUMPTION.md](MODELING_CONSUMPTION.md)
- [MODELING_OUTPUT.md](MODELING_OUTPUT.md)
- [DECISION_NOTES.md](DECISION_NOTES.md)
- [MODEL_IMPACT_REPORT.md](artifacts/MODEL_IMPACT_REPORT.md)
- [MODEL_CONSISTENCY_REPORT.md](artifacts/MODEL_CONSISTENCY_REPORT.md)
- [SOURCE_EVIDENCE.md](artifacts/SOURCE_EVIDENCE.md)

## 校验结果

- `passed`：0 个阻断错误；
- 仍有 1 个 D2 人类决策，不影响 provisional 模型的一致性。

## 用户总览状态

- Path: [`../../BUSINESS_MODEL_OVERVIEW.md`](../../BUSINESS_MODEL_OVERVIEW.md)
- Status: `current`
- Last compiled at: `2026-07-22T00:00:00Z`

## 下游视图状态

专业工程视图等待 `BMD-001` 后再编译。

## 下一步行动

用户在总览中回复 `选 A / 选 B / 我补充一个规则`。

## 关键状态变更摘要

- 2026-07-17：由 MT-001 创建；
- 2026-07-22：完成 provisional 建模、校验和总览编译，进入人类决策。
