---
schema_version: 2
state_id: "2026-07-06-1530-UX-001"
event_id: "2026-07-06-1530-UX-001"
legacy_ids: []
title: "示例生命周期事件"
slug: "example-lifecycle-event"
scope_type: "work-item"
domain: "UX"
release: ""

status: "active"
phase: "discovery"
gate: "none"
awaiting_user: false
sealed: false

mode: "full"
execution_profile: "standard"
predecessors: []
related_items: []
approved_gates: []

surface_target:
  primary: "web-app"
  secondary: []
  explicitly_out_of_scope: []

reference_selection: "./REFERENCE_SELECTION.md"
approved_color_card: ""

design_contract:
  must_keep: []
  must_change: []
  must_not_do: []
  constraint_sources: []

review_lens:
  primary_questions: []
  acceptance_focus: []
  excluded_aesthetic_standards: []

created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""

outputs:
  current: []
  archive: []

project_memory_updates: []
---

# Work Item 状态

## 生命周期事件

- Event ID: `2026-07-06-1530-UX-001`
- Domain: `UX | PD`
- Legacy IDs: none
- Mode: `full | lightweight | delegated`
- Execution profile: `standard | fast`
- Predecessors:

Legacy `DE-xxx` Work Item 可以继续使用 `schema_version: 1` 或保留空 `event_id`。不要为了补字段修改 `completed + sealed` 状态。

## 任务摘要

简要说明当前 Work Item 的目标、目标用户、业务价值和可独立验收边界。

## 业务上下文摘要

- 目标用户：
- 业务目标：
- 产品约束：
- 工程约束：
- Project Memory 已读取：

## 范围

### 包含

- 本任务明确负责的页面、流程、组件、产品决策或设计问题。

### 不包含

- 相关但不在本任务内处理的内容。

## 设计对象与终端

- Primary surface: `web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface`
- Secondary surfaces:
- Explicitly out of scope:
- Evidence:
- Open questions:

PD 事件如果不涉及界面终端，应说明“不适用”，并记录产品对象、版本边界和后续 UX 约束。

## Design Contract

### 必须保持

- 

### 必须改变

- 

### 明确不做

- 

### 约束来源

- `docs/design/project-memory/...`
- predecessor `STATE.md`
- 用户明确批准决定
- 工程或合规约束

## Review Lens

### 核心审视问题

- 

### 验收时重点观察

- 

### 不应使用的审美标准

- 不脱离本次业务目标评价“高级感”或通用审美偏好。

## 参考资源摘要

- Reference Selection: `REFERENCE_SELECTION.md` 链接；若未使用参考库，说明原因。
- Color Card：若采用色卡，只记录已批准色卡 ID、标题、采用摘要和风险摘要；完整候选、palette、annotation 保存在 `REFERENCE_SELECTION.md` 与 reference-library 中。
- 采用的参考原则：只写本任务真正采用的 2-4 条设计原则摘要。
- 明确不采用：记录被排除的参考、跨终端风险或不适合本任务的模式。
- 版权边界：仅用于内部设计分析和模式抽象，不复制第三方品牌资产、图标、插画、文案或完整页面布局。

## 验收标准

- 可验证的完成标准。

## 当前检查点

- 当前阶段、当前 Gate、是否等待用户，以及下一步负责人。
- 若处于视觉子检查点，写明：`palette-selection`、`typography-selection` 或 `design-exclusions`。
- Fast Profile 可以跳过不适用的视觉或原型 Gate，但不得跳过 `completion-approval`。

## 视觉设计上下文

### Visual Seed

- 用户原始视觉输入；如果为空，写“未提供”。

### 参考图片与解析

- 已使用的用户参考图、项目 `reference-images/`、已有 `VISUAL_DESIGN.md`、Project Memory 或内置参考包。
- 只记录可观察视觉特征，并区分可借鉴与不应复制。

### 已确认配色

- 候选调色盘对比：至少 3 套候选，使用同一组 UI 样张；记录可读性/对比摘要。若使用 Color Card Registry，记录大图色卡候选摘要，完整内容保存在 `REFERENCE_SELECTION.md`。
- 用户原始颜色输入：用户选择候选、混合候选、色卡方向或直接给出的颜色偏好。
- 最终配色来源：candidate | modified-candidate | custom。
- 用户选择：
- 选择理由：
- 主色：
- 次色：
- 末级强调色：
- 背景、文字、边框和语义色摘要：
- 选中色卡：`<color-card-id>`；若未使用色卡，说明原因。

### 已确认字体字号与排版系统

- 候选字体字号样张对比：使用同一组 UI 样张；记录标题、正文、导航、按钮、表单、辅助文案、数据/代码或长内容的可读性摘要。
- 用户原始字体/字号输入：用户选择候选、混合候选、指定品牌字体、要求系统字体或直接给出的字号偏好。
- 最终排版来源：existing-baseline | candidate | modified-candidate | custom。
- 用户选择：
- 选择理由：
- 字体族与 fallback stack：
- 字号阶梯/token：display / title / heading / body / label / caption / code-data。
- 行高、字重、字距：
- 响应式调整：
- 用途映射：长文本、密集数据、表单、按钮、导航、状态文案。
- 可读性与授权风险：

### 已确认设计禁区

- 已由用户确认的 4-8 条设计禁区；未确认时写“待确认”。

### 视觉原型摘要

- 原型入口、方案数量、响应式表现和关键状态覆盖情况。

### 视觉基线文档

- `docs/design/VISUAL_DESIGN.md` 是否已读取、创建或更新；若无需更新，说明理由。

## 产品设计上下文

PD 事件至少记录：

- 目标用户：
- 业务目标：
- 版本边界：
- 功能分层：
- 定价假设：
- 权限与额度：
- 风险：
- 未决问题：
- 已确认决策：
- 对后续 UX 的约束：
- 对工程实现的约束：

UX 事件继承 PD predecessor 时，记录继承内容和只读引用边界。

## 已批准决定

- 已经由用户明确批准、会影响后续实现的视觉、结构、产品或交互决定。

## 待确认问题

- 需要用户决定的高影响问题；没有时写“无”。

## 工作假设

- Codex 在继续工作时可以依赖的约束、推断和非关键假设。

## 产物与交付物索引

- Work Item artifacts: `docs/design/work-items/<event-id-slug>/artifacts/`
- Outputs archive: `docs/design/outputs/archive/<event_id>/`
- Outputs current:
- 生产实现或原型入口：
- 截图或 QA 证据：

## Project Memory 更新计划

| Target | Status | Summary | Source Event |
|---|---|---|---|

状态建议值：`none / proposed / applied / skipped`。这些不是 Work Item 生命周期状态。

## 验证证据

- 浏览器检查、截图、命令输出摘要、人工验收记录或无法验证的原因。

## Context-bound Final Review

- Review file: `review.md`
- Review status: not-started | ready-for-completion | fixes-required
- Required fixes before completion:
- Completion recommendation:

最终审查必须基于本 `STATE.md`、Design Contract、Review Lens、已批准 Gate、Reference Selection、Approved Color Direction、Project Memory 和实际 QA 证据。不得输出脱离上下文的通用审美审计。

## 下一步行动

- 继续、等待、暂停、关闭确认或创建 Successor 的明确下一步。

## 关键状态变更摘要

- 简短记录重要状态变化，保持为可恢复摘要，不写完整聊天记录。

