# 架构决策：Decision Boundary & Choice Closure v0.1.4

- 日期：2026-07-22
- 状态：Accepted

## 背景

v0.1.3 的 Choice-first 回归能够给出推荐并接受用户反对，但 ARCOS 后续对话显示：当用户确认 B+ 路线并追问“M0 手工跑是什么”时，系统继续生成 300 多行手工模拟指南、具体权重和样例执行提议。

这说明“必须给出选择”还不够，还必须明确“选择完成后在哪里停止”。

## 决策

新增七项横切协议：

```text
Mixed-turn Interpretation
Choice Loop Closure
Decision Scope Lock
Post-decision Clarification
Artifact Boundary Gate
No Execution Offer
State Enum Enforcement
```

## 关键规则

1. 同轮可以包含 confirmed + implementation_detail。
2. confirmed 先写入决定，Choice Loop 随即关闭。
3. 决定后只做原决策层概念澄清。
4. 实验表格、字段、公式、样例、代码与代跑不属于商业分析。
5. 不自动触发任何兄弟模块。
6. 新证据或不可接受的新代价才允许正式重开。

## 结果

商业分析同时具备两种克制：证据不足时不逃避推荐，决定完成后不贪恋继续做下去。
