# 多轮对话必须续接状态

## Given / 已知

已有活动 BA-001 和 Primary Decision Case。

## When / 当

用户继续确认、复述、补充、请求总结或发出复审信号。

## Then / 则

回复前读取 `STATE.md`、Primary Case、最新 `ANALYSIS_OUTPUT.md`、Assurance、Decision Notes 和最近 Summary / Process Package；更新 `STATE.md` 的本轮续接检查点。

对于 `standard / deep`、总结、决定、复审、范围变化或连续性风险，还应更新同一个滚动的 `artifacts/TURN_CONTINUITY_CHECK.md`；不得每轮创建新文件，也不得退化成无状态普通建议。
