# Entry Modes and Routing / 入口模式与路由 v0.1.4

## 入口模式

```text
direct_decision_support
case_continuation
evidence_intake
decision_review
project_decision_extraction
assurance_validation
case_summary
```

## Turn 路由

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

路由前必须解析 `decision_signal` 和 `followup_request`。用户确认后再问实施细节，应路由为 `record_human_decision + post_decision_clarification`，而不是继续当前分析或进入实施。
