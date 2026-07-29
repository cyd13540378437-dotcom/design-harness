---
schema_version: 1
state_id: BM-001
title: "设备设施工单智能调度业务模型"
slug: "work-order-intelligent-dispatch"
capability_id: product-business-modeling
entry_mode: greenfield_modeling
binding_decision: CREATE
status: active
phase: awaiting_decision
knowledge_status: provisional
awaiting_human: true
sealed: false
related_triggers: []
predecessors: []
created_at: 2026-07-22T00:00:00Z
updated_at: 2026-07-22T00:00:00Z
completed_at: ""
extensions:
  state_steward_mode: main-thread-fallback
---

# Business Modeling Work Item State

## 任务摘要

从零建立设备设施工单智能调度业务模型，并修复对象身份、文件协议、机器结构和生命周期边界。

## Work Item 绑定

- Decision: `CREATE`
- State steward: main-thread fallback, recorded under `extensions`

## 入口模式

- Primary: `greenfield_modeling`
- Supporting: `consistency_validation`, `downstream_compilation`

## 范围

### 包含

核心对象、属性、关系、动作、三个生命周期、规则、权限、风险、开发视图和用户总览。

### 不包含

数据库字段、接口、算法实现、UI 视觉设计和自动派单最终授权。

## 验收标准

- 标准 Work Item 根文件存在；
- Index / Dictionary / Schema 使用规范结构和稳定 ID；
- Action 与 State Transition 对齐；
- Dispatch Decision / Assignment 生命周期分离；
- 复合对象和上下文属性问题已修正或进入 BMD；
- 一致性报告完成；
- `BUSINESS_MODEL_OVERVIEW.md` 已编译。

## 当前模型基线

`v0.1-provisional`

## 当前阶段

等待用户确认 BMD-001 至 BMD-005。

## 已确认决定

当前唯一 confirmed 边界是：模型必须保持 provisional，不得声称冷启动策略已验证。

## Provisional 判断

协议性修正已完成：`MaintainableAsset` / `ServiceLocation` 分离、到达成本归入候选上下文、Decision / Assignment 生命周期分离；产品边界、资源抽象、自动派单权限、目标优先级和最小可观测性仍待确认。

## 待确认问题

`BMD-001`–`BMD-005`

## 关联 Trigger

无。

## 产物与链接

- User view: `../../BUSINESS_MODEL_OVERVIEW.md`
- Modeling output: `./MODELING_OUTPUT.md`
- Decision notes: `./DECISION_NOTES.md`
- Consistency report: `./artifacts/MODEL_CONSISTENCY_REPORT.md`

## 校验结果

`passed`，critical = 0。

## 业务模型总览状态

已编译，`validation_status: passed`。

## 下游视图状态

软件开发视图和 UX Context 已编译。

## 下一步行动

用户确认 BMD-001 至 BMD-005 后，更新模型状态并重新校验与编译总览。

## 关键状态变更摘要

- 2026-07-22：CREATE；完成 provisional 模型、合同修复、校验和总览编译。
