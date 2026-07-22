# ARCOS 调度模拟器 Choice-first 回归

## Given / 已知

用户无历史数据，暂时无法提供正式排班结构和完整策略规则，想做模拟器验证人员利用率。

## When / 当

系统完成商业分析。

## Then / 则

系统比较：

```text
A 先采真实数据
B 纯合成场景实验台
C 规则测试台
D 双轨冷启动：轻量合成实验台 + 最小真实可观测性
```

系统推荐 D（除非新证据改变排序）。

Assurance 必须拆成：

```text
通用实验台设计 = supported
合成相对比较 = provisional
当前策略比较 = conditional
真实业务效果已证明 = blocked
```

不得把整个 Case 标成 block，不得只回复“先采集数据”。
