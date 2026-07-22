# 单一中央决策综合

## Given / 已知

多个模型均有分析结果。

## When / 当

准备用户阶段性或最终结论。

## Then / 则

- 模型各自的 `conclusion_prompt` 只能向中央综合器提供候选含义；
- 低相关、重复或没有 Choice Delta 的结果不得进入综合；
- 只生成一个中文 `artifacts/DECISION_SYNTHESIS.md`；
- 再由它生成或更新唯一的中文 `DECISION_SUMMARY.md`；
- 不允许多个模型分别向用户收尾。
