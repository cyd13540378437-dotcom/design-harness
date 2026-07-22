# 专业分析运行

## AR-001 问题界定

- Decision Relevance：决定现在验证什么，而不是如何实现模拟器。
- Decision Delta：新增 A/B/C/D 四条真实路径，D 不再是默认。

## AR-002 解法前提挑战

- Decision Relevance：验证模拟器是否是最低成本路径。
- Decision Delta：C 被保留，B 成为基础层，D 当前被排除。

## AR-003 假设映射

- Decision Relevance：限定合成场景的证据价值。
- Decision Delta：结论从“证明策略有效”降级为“验证相对稳健性”。

## AR-004 情景与敏感性

- Decision Relevance：比较 C 相对 B/D 的学习价值和成本。
- Decision Delta：C 成为 provisional 首选。

## AR-005 反方分析

- Decision Delta：C 必须带真实数据升级路径和保护指标。
