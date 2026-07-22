# 输出合同完整

## Given / 已知

一次商业分析需要持久化。

## When / 当

系统按分析深度落盘。

## Then / 则

- quick 可只更新 Decision Case 与中文结论；
- standard 默认核心为 `STATE.md`、`ANALYSIS_WORKSPACE.md`（按需）、`DECISION_SUMMARY.md` 和 `DECISION_NOTES.md`（按需）；
- deep / audit 才生成消费、输出、路由、证据、模型选择、Synthesis 和 Process Package；
- Decision Case 只有一份权威文件；
- 不得为了模板完整无条件创建全部文件；
- 所有人读输出有中文版本。
