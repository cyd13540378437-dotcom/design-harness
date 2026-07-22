# Follow-up Turn Continuity / 多轮对话续接协议

## 1. 目的

首次创建 Case 不是完成状态化商业分析。只要 BA Work Item 仍然活动，后续每一轮都必须恢复决策上下文，避免退化成普通咨询。

## 2. 回复前最小恢复集

```text
BUSINESS_ANALYSIS_WORK_ITEMS.md
STATE.md
Primary Decision Case
最新 ANALYSIS_OUTPUT.md
DECISION_NOTES.md（若存在）
最近 DECISION_SUMMARY.md 或 DECISION_PROCESS_PACKAGE.md（若存在）
最新 DECISION_ASSURANCE_CHECK.md
```

`STATE.md` 是当前 Work Item 的恢复入口；Decision Case 是长期决策权威源。

## 3. Turn Type

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

Turn Type 必须写入 `STATE.md`。以下情况还应更新滚动的 `artifacts/TURN_CONTINUITY_CHECK.md`：

```text
standard / deep 分析
summary_request
human_decision
review_signal
scope_change
Case 绑定或用户决定状态存在歧义
```

不得为每轮创建新的 Turn Check 文件。

## 4. Follow-up 行为

- `user_confirmation`：先判断是对“理解”的确认、对“建议”的知悉，还是明确商业决定。
- `evidence_update`：先分类并更新 Case，不直接改写结论。
- `human_decision`：评估 D0–D3；D2 / D3 明确决定写入 `DECISION_NOTES.md`。
- `summary_request`：读取当前 Case、Assurance 和用户决定状态，生成 Case-bound 中文 `DECISION_SUMMARY.md`。
- `review_signal`：保留旧结论，进入正式复审。
- `scope_change`：判断是否仍属于当前 Case；不得静默扩大范围。

## 5. acknowledged 不等于 confirmed

用户说“好的”“我知道了”“理解了”或只是复述系统建议，默认只能解释为：

```text
acknowledged
```

只有用户明确选择某个业务选项、接受主要代价或明确授权记录为决定时，才可写为：

```text
confirmed
```

## 6. 禁止行为

- 不得仅依赖聊天记忆继续。
- 不得在已有活动 Work Item 时直接输出无 Case 绑定的建议。
- 不得为了生成摘要而跳过状态和 Assurance。
- 不得把用户复述系统建议自动视为 confirmed 决定。
- 不得让新的补充信息静默改变原始商业问题。
