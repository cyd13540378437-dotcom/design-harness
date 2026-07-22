---
schema_version: 3
language: zh-CN
work_item_id: BA-000
primary_case_id: BA-DC-000
decision_signal: none
followup_request: none
choice_loop_status: open
boundary_status: within_scope
continuity_result: passed
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
---

# 多轮对话续接检查（Deep / Audit 或连续性风险时）

## 1. 本轮混合输入

- Decision signal：`none | acknowledged | confirmed | rejected | revised | deferred`
- Follow-up request：`none | decision_clarification | evidence_clarification | implementation_detail | new_decision_candidate | summary_request`
- 用户原话：

## 2. 回复前已读取

- `STATE.md`：
- Primary Decision Case：
- 最近 `DECISION_SUMMARY.md`：
- `DECISION_NOTES.md`：
- 最新 Claim-level Assurance：

## 3. Decision Scope 与 Choice Loop

- Scope ID：
- 当前决策范围：
- 明确不包含：
- Choice Loop：`open | closed | reopened`

## 4. 处理顺序

- 决定信号处理：
- 后续请求处理：
- 是否需要 Choice Delta：
- 是否需要正式重开：

## 5. 边界与连续性

- Boundary status：`within_scope | clarification_only | out_of_scope_candidate`
- 是否发生抽象层级下沉：
- 是否创建越界产物：
- 是否出现执行提议：
- phase / gate 是否合法：

## 6. 需要更新的资产
