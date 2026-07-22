# Decision Synthesis / 中央决策综合协议

## 1. 单一出口

专业模型卡只能产出分析材料。只有中央决策综合器可以生成 `artifacts/DECISION_SYNTHESIS.md`，并由它向中文 `DECISION_SUMMARY.md` 提供唯一结论来源。

## 2. 输入

```text
Decision Anchor
Decision Case
Analysis Runs 的 Decision Relevance 与 Decision Delta
反方分析
Decision Assurance
用户已确认决定
```

## 3. 运行规则

1. 剔除 `low_relevance / discarded` 或没有 Decision Delta 的内容。
2. 合并重复分析，保留冲突观点和证据边界。
3. 恢复用户确认过的商业问题，不让模型名称或过程文件成为主语。
4. 明确区分：商业选择、验证路径、实施细节。
5. 未经用户确认的系统建议保持 `provisional`。

## 4. 输出

中央综合必须说明：

```text
当前真正的商业选择
真实选项及适用条件
系统推荐及主要代价
各模型究竟改变了什么
证据状态
能证明什么
不能证明什么
用户决定是否已确认
下一次决策点
复审条件
```

## 5. 选择题规则

优先生成来自当前 Case 的真实业务选项。不得机械套用“继续 / 试点 / 补证据 / 暂缓”。只有当“如何降低不确定性”本身是当前决策时，才把这些元选项作为主选项。

## 6. 中文规则

`DECISION_SYNTHESIS.md` 必须使用简体中文；内部 Prompt 可以英文。
