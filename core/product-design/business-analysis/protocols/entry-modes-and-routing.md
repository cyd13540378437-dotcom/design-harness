# Entry Modes and Routing / 入口模式与路由

## 1. 入口模式

```text
direct_decision_support       新业务问题或选择
case_continuation             继续已有 Case
evidence_intake               补充材料、数据或附件
decision_review               复盘、挑战或重开旧决定
project_decision_extraction   从项目材料恢复候选决策
assurance_validation          对既有分析做质量检查
case_summary                  基于当前 Case 生成中文阶段摘要
```

## 2. Follow-up Turn Type

```text
new_input
clarification
user_confirmation
evidence_update
human_decision
summary_request
review_signal
scope_change
new_case_candidate
```

## 3. 路由结果

```text
create_new_case
continue_existing_case
add_evidence_to_case
record_human_decision
summarize_existing_case
reopen_existing_decision
conflict_with_existing_decision
impact_existing_decision
no_case_needed
```

## 4. 顺序

首次或范围变化：

```text
保留原始输入
→ Input Understanding
→ 用户确认或明确 provisional 假设
→ 路由
```

已有活动 Work Item：

```text
恢复 STATE / Case / Process Package
→ Turn Type
→ 路由
```

## 5. no_case_needed

只用于纯解释、一次性低风险脑暴、只读查看或没有决策价值的信息。已有活动 BA Work Item 时不得随意使用。
