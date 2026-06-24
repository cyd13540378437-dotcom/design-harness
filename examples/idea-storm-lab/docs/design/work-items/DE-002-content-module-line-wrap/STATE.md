---
schema_version: 1
state_id: "DE-002"
title: "统一内容模块问题长度换行"
slug: "content-module-line-wrap"
scope_type: "work-item"
release: "v0.1.0-alpha"

status: "active"
phase: "completion-review"
gate: "completion-approval"
awaiting_user: true
sealed: false

mode: "lightweight"
predecessors: ["DE-001"]
related_items: ["DE-001"]
approved_gates:
  - gate: "prototype-approval"
    approved_at: "2026-06-21T09:45:00Z"
    summary: "用户批准在现有 DE-001 视觉体系内做轻量修复，不重新打开整体样式任务。"

created_at: "2026-06-21T09:10:00Z"
updated_at: "2026-06-21T11:20:00Z"
completed_at: ""
---

# Work Item 状态

## 任务摘要

统一 idea-storm-lab 内容模块中“问题”文本的长度换行表现，避免长问题撑破卡片、影响列表扫描和移动端阅读。

## 范围

### 包含

- 内容模块问题标题的换行、截断和最大行数规则。
- 桌面列表、详情面板和移动单列布局中的长文本表现。
- hover/focus 状态下保持布局稳定。
- 与 DE-001 已批准视觉体系保持一致。

### 不包含

- 修改 DE-001 的封存状态。
- 重做整体前端样式方向。
- 改变问题内容的数据结构或编辑语义。

## 验收标准

- 问题文本在卡片和详情区域内自然换行，不横向溢出。
- 超长连续字符串不会撑破容器。
- 列表项高度变化可控，不造成相邻模块遮挡。
- 390px 移动宽度下问题文本仍可读。
- 实现不修改 `DE-001` 的 sealed 状态。

## 当前检查点

实现和 QA 已完成，正在等待用户在 `completion-approval` Gate 明确关闭、继续调整、暂停或拆分后继任务。

## 已批准决定

- 将本任务作为 `DE-001` 的 Successor，而不是恢复已封存的 DE-001。
- 使用 lightweight mode，在现有视觉系统内修正长文本表现。
- 允许问题标题换行到最多三行；连续无空格字符串使用断词保护。

## 待确认问题

- 用户是否批准关闭并封存 DE-002。

## 工作假设

- 内容模块的“问题”字段可能包含中文、英文、混合标点和少量连续无空格字符串。
- 三行以上的问题在列表中会降低扫描效率，应由详情区承载完整阅读。

## 产物与链接

- 前任状态：`../DE-001-optimize-frontend-style/STATE.md`
- 实现入口：`/modules`
- 长文本测试数据：`fixtures/long-question-modules.json`

## 验证证据

- 桌面检查：1440x900，长中文、英文和混合标点问题均在卡片内换行。
- 移动检查：390x844，单列模块没有横向滚动。
- 极端内容检查：连续 80 字符字符串使用断词保护，容器宽度稳定。
- 键盘检查：列表项 focus 后高度不跳动，焦点环完整可见。

## 下一步行动

等待用户回复 completion Gate。若用户回复“关闭”，Steward 将写入 `status: completed`、`phase: complete`、`gate: none`、`awaiting_user: false`、`sealed: true`，并移动索引到 Completed。

## 关键状态变更摘要

- 2026-06-21T09:10:00Z：`SUCCESSOR DE-002`，引用 sealed 的 `DE-001`。
- 2026-06-21T09:45:00Z：用户批准在 lightweight mode 内处理。
- 2026-06-21T11:20:00Z：实现和 QA 完成，进入 `completion-approval`，等待用户关闭确认。
