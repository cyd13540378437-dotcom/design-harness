# Migration Notes — Business Analysis v0.1.3 → v0.1.4

## 1. State Schema

`schema_version` 从 2 升级为 3，新增：

```text
decision_scope_id
decision_scope_type
decision_scope_status
choice_loop_status
decision_signal
followup_request
boundary_status
summary_mode
```

旧自定义 phase / gate 必须迁移到合法枚举。

## 2. Decision Case

新增 A0 Decision Scope Lock、Choice Loop 关闭 / 重开状态和决定后澄清记录。

## 3. Decision Summary

新增：

```text
choice_request
decision_confirmed
post_decision_clarification
review
```

决定已确认时不得重复请求同一选择。

## 4. Artifact Migration

以下类型不得继续作为商业分析权威产物：

```text
SIMULATOR_IMPLEMENTATION_PATH.md
M0_MANUAL_SIMULATION_GUIDE.md
RUNBOOK / DATA_SCHEMA / SAMPLE_DATA / SCRIPT / UI_SPEC / TECHNICAL_DESIGN
```

其中仍有商业价值的内容，应压缩为概念级目的、证据边界和升级条件，合并回 Decision Case 或 Summary；具体实施内容移出商业分析资产范围。

## 5. ARCOS

- B+ 路线与 M0 → M1 → M2 原则可保留并记录为 confirmed。
- M0 只解释为最小方法检查；不保留具体 Excel 表、公式权重或样例生成提议。
- State 迁移到 `phase=completion-review`、`gate=none`、`choice_loop_status=closed`。
