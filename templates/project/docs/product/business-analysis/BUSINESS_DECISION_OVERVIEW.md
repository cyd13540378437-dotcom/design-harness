---
schema_version: 1
view_type: business_decision_overview
audience: product_owner
is_default_module_delivery_view: true
is_project_delivery_entry: false
is_source_of_truth: false
decision_overview_status: draft
choice_loop_status: open
recommendation_status: provisional
assurance_status: not_run
generated_at: "YYYY-MM-DDTHH:mm:ssZ"
generated_by: business-analysis-orchestrator
source_cases: []
source_work_items: []
source_assets:
  - docs/product/business-analysis/BUSINESS_ANALYSIS_INDEX.yml
  - docs/product/business-analysis/BUSINESS_ANALYSIS_WORK_ITEMS.md
---

# 商业决策总览

> 这是商业分析模块的默认交付出口，用来阅读当前重要商业选择、推荐、证据边界和待确认问题。Decision Case、Decision Network 与 Evidence Ledger 仍是权威来源。

## 1. 当前商业决策状态

- 总览状态：`draft | provisional | current | partial | stale`
- 当前活跃选择数：
- 已关闭选择数：
- 需要用户确认：
- 最近更新时间：

## 2. 一句话结论

用一句话说明当前最重要的商业选择和系统推荐。

## 3. 当前关键选择

| Case ID | 决策问题 | 当前推荐 | 选择状态 | 用户决定 | 证据强度 |
|---|---|---|---|---|---|

## 4. 推荐与代价

### 当前推荐

-

### 推荐成立的条件

-

### 需要接受的代价

-

### 会改变推荐的条件

-

## 5. 需要你确认的选择

当存在待确认选择时，在这里压缩为用户可直接回复的内容。

#### BA-DC-000 — <决策标题>

- **当前问题**：
- **现实选项 A**：
  - 价值：
  - 代价：
- **现实选项 B**：
  - 价值：
  - 代价：
- **推荐**：
- **证据边界**：
- **请回复**：`选 A / 选 B / 暂缓 / 我修改为...`

若无待确认选择，写明“当前无需要用户确认的商业选择”。

## 6. 已确认或暂缓的决定

| Case ID | 用户决定 | 接受的代价 | 复审条件 | 来源 |
|---|---|---|---|---|

## 7. 证据边界与复审条件

### 当前证据支持

-

### 暂定或有条件成立

-

### 受阻声明

-

### 复审触发条件

-

## 8. 明确非范围

商业分析可以描述概念级验证路径、证据边界和升级条件，但本总览不输出实施 Runbook、正式 Schema、样例数据、脚本、UI 或技术方案。

## 9. 来源与维护说明（非必读）

- 本文件由 `business-analysis-orchestrator` 从商业分析模块资产编译生成。
- 本文件不是 source of truth；若与 Decision Case 冲突，以 `docs/product/business-analysis/decision-cases/` 下的权威 Case 为准，并应重新编译本总览。
- 单轮过程、模型运行和审计材料仍保留在对应 Work Item 中，不要求普通用户逐一阅读。
