---
schema_version: 3
state_id: BA-000
title: ""
status: active
phase: input-understanding
gate: none
awaiting_user: false
sealed: false
entry_mode: direct_decision_support
analysis_depth: standard
output_language: zh-CN
primary_case_id: ""
primary_case_path: ""
decision_scope_id: ""
decision_scope_type: ""
decision_scope_status: provisional
choice_loop_status: open
last_turn_type: new_input
decision_signal: none
followup_request: none
boundary_status: within_scope
turn_continuity_status: initialized
overall_assurance: ""
recommended_option_id: ""
recommendation_status: provisional
user_decision_status: not_requested
summary_mode: choice_request
latest_decision_summary: ""
created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""
---

# 商业分析 Work Item 状态

## 1. Decision Scope Lock

- 决策范围 ID：
- 决策类型：
- 当前决策范围：
- 范围状态：`provisional | locked | reopened`
- 明确不包含：
- 当前边界状态：`within_scope | clarification_only | out_of_scope_candidate`

## 2. Choice Core

- 当前决策问题：
- 当前 Choice Set：
- 当前推荐：
- 推荐状态：
- 接受的主要代价：
- 证据边界：
- 改变推荐的条件：
- 用户决定状态：
- Choice Loop：`open | closed | reopened`

## 3. 本轮混合输入

- Decision signal：`none | acknowledged | confirmed | rejected | revised | deferred`
- Follow-up request：`none | decision_clarification | evidence_clarification | implementation_detail | new_decision_candidate | summary_request`
- 处理结果：

## 4. Claim-level Assurance 摘要

| 声明 | 状态 | 说明 |
|---|---|---|

## 5. Primary Decision Case

- Case ID：
- Case path：
- Routing result：

## 6. 当前阶段

合法 phase：

```text
input-understanding
case-routing
choice-set
analysis
recommendation
human-decision
post-decision-clarification
review
completion-review
complete
```

合法 gate：

```text
none
decision-confirmation
completion-approval
```

## 7. 已确认决定

## 8. 待确认选择

## 9. 当前假设与限制

## 10. 核心输出

| 输出物 | 路径 | 状态 | 中文版本 | 边界检查 |
|---|---|---|---|---|

## 11. 下一步

## 12. 关键状态变更摘要
