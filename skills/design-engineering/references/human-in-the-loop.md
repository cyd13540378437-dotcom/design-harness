# Human-in-the-loop Gate

Design Harness 只在决定高影响、互斥、难以撤销或会定义产品语义时询问用户。

提问前，Codex 应先压缩决策：

- 当前理解
- 为什么这个决定重要
- 两到三个可行选项，或说明为什么当前只需要一个主方案
- 影响和取舍
- 推荐方案

## Gate

`work-item-binding` 仅在无法确定正确 Work Item 时使用。

`visual-direction-approval` 在 Full Mode 中必需，且必须发生在生产实现前。本 Gate 承载三个视觉子检查点：

- `palette-selection`
- `typography-selection`
- `design-exclusions`

这些子检查点必须先由 Steward 写入等待状态，再等待用户确认。它们不是新的 Gate enum。

`prototype-approval` 在 Full Mode 中必需，发生在视觉原型或等效预览可检查之后。

`interaction-decision` 仅用于会实质改变行为的 UX 决策。

`completion-approval` 在封存任何状态化 Work Item 前都必需。进入本 Gate 前，应检查 `VISUAL_DESIGN.md` 是否已创建或更新，或说明无需更新的理由。

## Delegated Mode

当用户要求 Codex 自行决定普通细节时，Codex 可以不停止地处理轻微视觉和原型决定。但涉及权限、删除、隐私、付费、不可逆行为、核心语义、明显改变已批准视觉基线的方向或最终封存时，仍必须询问用户。
