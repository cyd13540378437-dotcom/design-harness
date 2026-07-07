---
schema_version: 2
state_id: "2026-07-06-1710-UX-002"
event_id: "2026-07-06-1710-UX-002"
legacy_ids: []
title: "Upgrade modal and pricing page"
slug: "upgrade-modal-and-pricing-page"
scope_type: "work-item"
domain: "UX"
release: "v0.1.3 example"
status: "completed"
phase: "complete"
gate: "none"
awaiting_user: false
sealed: true
mode: "full"
execution_profile: "standard"
predecessors:
  - "2026-07-06-1605-PD-001"
related_items: []
approved_gates: ["visual-direction-approval", "prototype-approval", "completion-approval"]
surface_target:
  primary: "responsive-web"
  secondary: []
  explicitly_out_of_scope: ["checkout implementation"]
reference_selection: "./REFERENCE_SELECTION.md"
approved_color_card: ""
created_at: "2026-07-06T17:10:00+08:00"
updated_at: "2026-07-06T17:50:00+08:00"
completed_at: "2026-07-06T17:50:00+08:00"
outputs:
  current:
    - "../../outputs/current/latest-upgrade-flow.md"
  archive:
    - "../../outputs/archive/2026-07-06-1710-UX-002/"
project_memory_updates:
  - target: "docs/design/project-memory/UX_DESIGN.md"
    status: "applied"
    summary: "Upgrade prompts should appear at feature boundaries and inherit membership constraints."
    source_event: "2026-07-06-1710-UX-002"
---

# Work Item 状态

## 生命周期事件

- Event ID: `2026-07-06-1710-UX-002`
- Domain: `UX`
- Predecessor: `2026-07-06-1605-PD-001`

## 任务摘要

基于 sealed 会员体系 PD 事件设计升级弹窗和套餐页。

## 继承上下文

- 套餐名称：Free、Pro、Team。
- 功能边界：Pro 不包含 Team 协作。
- 目标转化：在用户触达付费功能边界时提示升级。
- 权益不得夸大：升级文案必须与 PD 事件一致。
- 合规文案约束：描述能力，不承诺结果。
- 核心升级路径：展示当前计划、受限能力和下一步。

## Design Contract

### 必须保持

- 只读继承 `2026-07-06-1605-PD-001` 的套餐边界。
- 保持已有中性色、字体、圆角和组件密度。

### 必须改变

- 增加升级弹窗和套餐页的信息结构。

### 明确不做

- 不实现支付流程。
- 不修改 sealed PD predecessor。

### 约束来源

- `docs/design/work-items/2026-07-06-1605-PD-001-membership-system/STATE.md`
- `docs/design/project-memory/PRODUCT_DESIGN.md`

## Review Lens

### 核心审视问题

- UX 是否正确继承产品权益边界，并让用户理解升级原因和下一步。

### 验收时重点观察

- 套餐文案一致性、当前计划可见性、主行动清晰度、响应式可读性。

### 不应使用的审美标准

- 不为了营销冲击力牺牲权益准确性。

## 参考资源摘要

- Reference Selection: `REFERENCE_SELECTION.md`
- Color Direction: retained from project visual baseline.

## 验收标准

- 升级弹窗展示受限能力、当前计划和一个主行动。
- 套餐页准确区分 Free、Pro、Team。
- 所有权益文案与 PD predecessor 一致。

## 产物与交付物索引

- Artifact: `artifacts/upgrade-flow.md`
- Archive: `../../outputs/archive/2026-07-06-1710-UX-002/`
- Current: `../../outputs/current/latest-upgrade-flow.md`
- Review: `review.md`

## Context-bound Final Review

- Review file: `review.md`
- Review status: ready-for-completion

## 关键状态变更摘要

- 已只读继承 sealed PD predecessor。
- 用户批准后 archived 并更新 UX Project Memory。

