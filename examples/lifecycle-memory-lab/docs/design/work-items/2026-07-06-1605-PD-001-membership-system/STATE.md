---
schema_version: 2
state_id: "2026-07-06-1605-PD-001"
event_id: "2026-07-06-1605-PD-001"
legacy_ids: []
title: "Membership system"
slug: "membership-system"
scope_type: "work-item"
domain: "PD"
release: "v0.1.3 example"
status: "completed"
phase: "complete"
gate: "none"
awaiting_user: false
sealed: true
mode: "lightweight"
execution_profile: "standard"
predecessors: []
related_items: ["2026-07-06-1710-UX-002"]
approved_gates: ["completion-approval"]
surface_target:
  primary: "web-app"
  secondary: []
  explicitly_out_of_scope: ["visual redesign", "checkout implementation"]
reference_selection: ""
approved_color_card: ""
created_at: "2026-07-06T16:05:00+08:00"
updated_at: "2026-07-06T16:45:00+08:00"
completed_at: "2026-07-06T16:45:00+08:00"
outputs:
  current:
    - "../../outputs/current/latest-product-prd.md"
  archive:
    - "../../outputs/archive/2026-07-06-1605-PD-001/"
project_memory_updates:
  - target: "docs/design/project-memory/PRODUCT_DESIGN.md"
    status: "applied"
    summary: "Record Free, Pro, and Team plan boundaries."
    source_event: "2026-07-06-1605-PD-001"
  - target: "docs/design/project-memory/BUSINESS_CONTEXT.md"
    status: "applied"
    summary: "Record upgrade conversion goal and entitlement-copy caution."
    source_event: "2026-07-06-1605-PD-001"
---

# Work Item 状态

## 生命周期事件

- Event ID: `2026-07-06-1605-PD-001`
- Domain: `PD`

## 任务摘要

设计会员体系，明确 Free、Pro、Team 的功能边界和后续 UX 约束。

## 产品设计上下文

本 PD 事件不选择具体界面终端；frontmatter 保留 `web-app` 以兼容现有 surface enum，实际页面设计由后续 UX successor 承接。

- 目标用户：个人创作者与小团队。
- 业务目标：在用户触达付费能力边界时自然升级。
- 版本边界：只定义套餐与权限，不设计具体页面。
- 功能分层：Free 基础记录；Pro 高级记忆、导出和自动化；Team 共享空间、管理员和统一账单。
- 定价假设：本示例不定价，只定义相对权益。
- 权限与额度：协作能力只属于 Team。
- 风险：升级文案不得夸大权益。
- 对后续 UX 的约束：升级 UI 必须展示当前计划、受限能力和合规下一步。

## Design Contract

### 必须保持

- 产品权益边界清楚，不能把 Team 协作暗示给 Pro。

### 必须改变

- 从模糊高级版概念改为三层会员结构。

### 明确不做

- 不做支付流程、不做视觉页面。

### 约束来源

- 用户产品设计请求。

## Review Lens

### 核心审视问题

- 套餐边界是否足够清楚，能被后续 UX 和工程继承。

### 验收时重点观察

- 权益不夸大、升级路径明确、工程可实现。

### 不应使用的审美标准

- 不评价页面视觉。

## 产物与交付物索引

- Artifacts: `membership-prd.md`, `pricing-model.md`, `decision-map.md`
- Archive: `../../outputs/archive/2026-07-06-1605-PD-001/`
- Current: `../../outputs/current/latest-product-prd.md`
- Review: `review.md`

## Context-bound Final Review

- Review file: `review.md`
- Review status: ready-for-completion

## 关键状态变更摘要

- PD event 已 sealed；后续 UX 只能只读继承。
