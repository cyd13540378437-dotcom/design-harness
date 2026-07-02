---
schema_version: 1
state_id: "DE-001"
title: "示例设计 Work Item"
slug: "example-design-work-item"
scope_type: "work-item"
release: ""

status: "active"
phase: "discovery"
gate: "none"
awaiting_user: false
sealed: false

mode: "full"
predecessors: []
related_items: []
approved_gates: []

created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""
---

# Work Item 状态

## 任务摘要

简要说明当前 Work Item 的目标、目标用户和完成后的用户价值。

## 范围

### 包含

- 本任务明确负责的页面、流程、组件或设计问题。

### 不包含

- 相关但不在本任务内处理的内容。

## 设计对象与终端

- Primary surface: `web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface`
- Secondary surfaces:
- Explicitly out of scope:
- Evidence:
- Open questions:

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
- 若处于视觉子检查点，写明：`palette-selection` 或 `design-exclusions`。

## 视觉设计上下文

### Visual Seed

- 用户原始视觉输入；如果为空，写“未提供”。

### 参考图片与解析

- 已使用的用户参考图、项目 `reference-images/`、已有 `VISUAL_DESIGN.md` 或内置参考包。
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

### 已确认设计禁区

- 已由用户确认的 4-8 条设计禁区；未确认时写“待确认”。

### 视觉原型摘要

- 原型入口、方案数量、响应式表现和关键状态覆盖情况。

### 视觉基线文档

- `docs/design/VISUAL_DESIGN.md` 是否已读取、创建或更新；若无需更新，说明理由。

## 已批准决定

- 已经由用户明确批准、会影响后续实现的视觉、结构或交互决定。

## 待确认问题

- 需要用户决定的高影响问题；没有时写“无”。

## 工作假设

- Codex 在继续工作时可以依赖的约束、推断和非关键假设。

## 产物与链接

- 原型、截图、实现文件、预览地址、`VISUAL_DESIGN.md` 或相关 Work Item 链接。

## 验证证据

- 浏览器检查、截图、命令输出摘要、人工验收记录或无法验证的原因。

## 下一步行动

- 继续、等待、暂停、关闭确认或创建 Successor 的明确下一步。

## 关键状态变更摘要

- 简短记录重要状态变化，保持为可恢复摘要，不写完整聊天记录。
