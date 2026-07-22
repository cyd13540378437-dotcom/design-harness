# 混合轮次：确认 + 澄清

## Given / 已知
系统推荐 B+，用户决定状态为 pending。

## When / 当
用户回复：“其他的都没问题，你说的 M0 手工跑是怎么个跑法？”

## Then / 则
必须同时识别：

```text
decision_signal=confirmed
followup_request=implementation_detail
```

不得只归类为 clarification。
