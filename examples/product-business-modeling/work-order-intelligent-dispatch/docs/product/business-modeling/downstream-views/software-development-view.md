# Software Development View

> 派生视图，非 source of truth。输入包含 provisional 语义，工程范围不得被误解为 confirmed 业务合同。

## First Delivery Slices

1. 可调度工单池与要求确认；
2. 资源能力、区域与可用性；
3. 候选生成、硬约束排除原因和预计到达成本；
4. 推荐、人工确认、覆盖与审计；
5. 独立的 Dispatch Decision 与 Assignment 生命周期；
6. 执行反馈、重派与关闭；
7. 调度评估快照和基础策略复盘。

## Backend Boundaries

- Demand Context
- Resource Capacity
- Dispatch Decisioning
- Assignment Execution
- Evaluation Evidence

## QA Focus

- 不合格资源不得进入候选；
- 决策状态不得混入 Assignment 生命周期；
- committed 决策的变更必须形成新决策 / 新 Assignment；
- 人工覆盖有原因；
- 快照能回放候选、排序、最终选择和执行结果。
