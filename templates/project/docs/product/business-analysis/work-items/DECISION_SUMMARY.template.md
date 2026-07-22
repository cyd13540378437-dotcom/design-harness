---
schema_version: 3
language: zh-CN
summary_id: BA-DS-000
work_item_id: BA-000
primary_case_id: BA-DC-000
summary_mode: choice_request
choice_loop_status: open
decision_scope_id: ""
boundary_status: within_scope
overall_assurance: warn
recommended_option_id: ""
recommendation_status: provisional
user_decision_status: pending
generated_at: "YYYY-MM-DDTHH:mm:ssZ"
---

# 商业分析结论：<标题>

## 1. 当前决策范围

- 本次解决的选择：
- 明确不包含：
- Choice Loop：`open | closed | reopened`

## 2. 当前选择或已确认决定

> `choice_request` 时说明当前要选什么；`decision_confirmed` / `post_decision_clarification` 时说明用户已经确认什么。

## 3. 现实选项与后果（Choice Loop 打开时）

| ID | 选项 | 当前状态 | 主要价值 | 主要代价 / 风险 |
|---|---|---|---|---|

## 4. 当前推荐或用户已确认路线

- 推荐 / 已确认选项：
- 状态：
- 核心理由：
- 接受的主要代价：
- 证据边界：

## 5. 决定后澄清（仅 `post_decision_clarification`）

- 用户询问：
- 概念级解释：
- 该概念在已确认路线中的作用：
- 当前 Case 不继续展开的实施细节：

## 6. Claim-level Assurance

| 关键声明 | 状态 | 当前可以说什么 | 当前不能说什么 |
|---|---|---|---|

## 7. 改变或重开决定的条件

## 8. 用户决定状态

- 当前状态：
- Choice Loop：
- 已确认：
- 尚未确认：

## 9. 收口方式

### 当 `summary_mode=choice_request`

```text
接受当前推荐
拒绝并选择其他选项
修改推荐方案或条件
暂缓决定
```

### 当 `summary_mode=decision_confirmed`

本次选择已经确认，不再重复请求同一选择。当前 Case 进入 `completion-review`。

### 当 `summary_mode=post_decision_clarification`

澄清已经完成，原决定保持有效；具体实施请求不属于当前 Case。当前 Case 进入 `completion-review`。

### 当 `summary_mode=review`

说明重开原因、更新后的 Choice Set 和新的选择请求。

## 10. 来源

- Primary Decision Case：
- Work Item：
- Analysis Workspace：
- 最新 Assurance：
