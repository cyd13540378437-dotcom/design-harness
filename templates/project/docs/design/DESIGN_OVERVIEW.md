---
schema_version: 1
view_type: design_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
design_overview_status: draft
baseline_status: draft
current_outputs_status: missing
generated_at: "YYYY-MM-DDTHH:mm:ssZ"
generated_by: design-engineering-orchestrator
source_events: []
source_outputs: []
source_assets:
  - docs/design/WORK_ITEMS.md
  - docs/design/VISUAL_DESIGN.md
  - docs/design/outputs/index.yml
open_questions_source: []
---

# 设计总览

> 这是 Design Engineering 模块的默认交付出口，用来阅读当前 UX、产品设计、视觉基线和已确认设计入口。Work Item `STATE.md`、`VISUAL_DESIGN.md`、Project Memory 与 `outputs/` 仍是权威来源。

## 1. 当前设计状态

- 总览状态：`draft | provisional | current | partial | stale`
- 视觉基线：`missing | draft | provisional | confirmed | stale`
- 当前 outputs：`missing | draft | current | stale`
- 覆盖终端：
- 最近 sealed 事件：
- 最近更新时间：

## 2. 一句话设计结论

用一句话说明当前产品设计方向、主要体验承诺或本阶段采用的设计基线。

## 3. 当前确认入口

| 类型 | 名称 | 路径 | 状态 | 来源事件 |
|---|---|---|---|---|

## 4. 产品与 UX 范围

### 当前覆盖

-

### 明确非范围

-

### 后续 UX 必须继承的约束

-

## 5. 关键流程与界面

| 流程 / 界面 | 目标用户 | 主要任务 | 状态 | 来源 |
|---|---|---|---|---|

## 6. 视觉基线

### 已确认方向

-

### 配色

-

### 字体字号与排版

-

### 组件、密度与布局原则

-

### 设计禁区

-

## 7. 验证与质量状态

- 最近 Context-bound Final Review：
- QA 证据：
- 已知限制：
- 需要补充验证：

## 8. 需要你确认的设计问题

当存在待确认设计问题时，在这里压缩为用户可直接回复的内容。

#### UX-000 — <问题标题>

- **当前情境**：
- **选项 A**：
  - 价值：
  - 代价：
- **选项 B**：
  - 价值：
  - 代价：
- **推荐**：
- **请回复**：`选 A / 选 B / 暂缓 / 我修改为...`

若无待确认设计问题，写明“当前无需要用户确认的设计问题”。

## 9. 来源与维护说明（非必读）

- 本文件由 `design-engineering-orchestrator` 从设计模块资产编译生成。
- 本文件不是 source of truth；若与 sealed `STATE.md`、`VISUAL_DESIGN.md` 或 `outputs/index.yml` 冲突，以权威来源为准，并应重新编译本总览。
- Work Item artifacts、临时截图、未确认原型和未批准视觉方向不会进入当前总览。
