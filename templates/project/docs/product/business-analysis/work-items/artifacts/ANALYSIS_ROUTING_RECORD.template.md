---
schema_version: 3
language: zh-CN
---

# 分析路由记录（Deep / Audit 按需）

## 1. 输入理解与混合轮次

- Decision signal：`none | acknowledged | confirmed | rejected | revised | deferred`
- Follow-up request：`none | decision_clarification | evidence_clarification | implementation_detail | new_decision_candidate | summary_request`

## 2. 候选 Decision Cases

| Case ID | 标题 | 关系 | 置信度 |
|---|---|---|---|

## 3. 路由决定

```text
create_new_case
continue_existing_case
add_evidence_to_case
record_human_decision
summarize_existing_case
post_decision_clarification
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
new_decision_candidate
no_case_needed
```

## 4. Decision Scope

- Scope ID：
- Scope statement：
- Scope status：`provisional | locked | reopened`
- Explicit non-scope：
- Boundary status：`within_scope | clarification_only | out_of_scope_candidate`

## 5. Analysis Depth

```text
quick | standard | deep
```

## 6. Choice Loop

- Before：`open | closed | reopened`
- After：`open | closed | reopened`
- Closure / reopen reason：

## 7. 选择理由与下一步
