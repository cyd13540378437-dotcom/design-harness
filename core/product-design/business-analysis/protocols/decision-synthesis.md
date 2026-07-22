# Decision Synthesis / 中央决策综合 v0.1.4

只有中央综合器可以生成用户可见结论。

## 1. Choice Loop 打开时

综合 Decision Core、Choice Delta、反方分析、Claim-level Assurance 与用户限制，输出当前推荐和业务选择请求。

## 2. Choice Loop 关闭时

综合器不得重新生成选项或推荐。它只能：

```text
忠实呈现已确认决定；
说明接受的代价与证据边界；
处理决定后概念澄清；
检查 Decision Scope；
生成 completion-review 摘要。
```

## 3. 模型结论出口

模型卡的 `conclusion_prompt` 只提供候选含义。`choice_loop_status=closed` 时，除正式 review 外，不得调用模型卡。
