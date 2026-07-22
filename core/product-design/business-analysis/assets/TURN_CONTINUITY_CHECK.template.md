---
schema_version: 1
language: zh-CN
work_item_id: BA-000
primary_case_id: BA-DC-000
turn_type: clarification
continuity_result: passed
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
---

# 多轮对话续接检查

> 本文件是滚动检查点，不为每一轮创建新文件。`quick` 模式可只在 `STATE.md` 更新检查点；`standard / deep` 或出现范围、决定状态、Case 绑定风险时更新本文件。

## 1. 本轮输入分类

- Turn type：
- 当前输入摘要：
- 是否可能属于新 Case：

## 2. 回复前已读取的最小恢复集

- `BUSINESS_ANALYSIS_WORK_ITEMS.md`：
- `STATE.md`：
- Primary Decision Case：
- 最新 `ANALYSIS_OUTPUT.md`：
- `DECISION_NOTES.md`：
- 最近 `DECISION_SUMMARY.md` / `DECISION_PROCESS_PACKAGE.md`：
- 最新 `DECISION_ASSURANCE_CHECK.md`：

## 3. 当前 Decision Anchor

- 原始商业问题：
- 已确认商业问题：
- 当前真实业务选项：
- 当前阻塞不确定性：
- 证据边界：
- 最新 Assurance：
- 用户决定状态：

## 4. 连续性判断

- Continuity result：`passed | warning | blocked`
- 是否发生范围漂移：
- 是否退化成无状态普通建议：
- 是否需要重新做 Input Understanding：

## 5. 本轮后续动作

```text
continue_current_case
add_evidence
check_understanding
record_user_decision
provide_case_bound_summary
reopen_or_review
candidate_new_case
no_case_needed
```

- 选择：
- 理由：

## 6. 用户表达的决定含义

- 原话：
- 解释为：`pending | acknowledged | confirmed | rejected | revised`
- 为什么：

## 7. 本轮需要更新的资产
