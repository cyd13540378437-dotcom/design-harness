# acknowledged 不等于 confirmed

## Given / 已知

系统给出 provisional 建议。

## When / 当

用户回复“好的，我知道了”或复述系统建议，但没有明确选择和接受代价。

## Then / 则

用户决定状态只能更新为 `acknowledged` 或保持 `pending`，不得写成 `confirmed`，不得封存决定。
