# Human-in-the-loop Gate

Design Harness 只在决定高影响、互斥、难以撤销或会定义产品语义时询问用户。

提问前，Codex 应先压缩决策：

- 当前理解
- 为什么这个决定重要
- 两到三个可行选项
- 影响和取舍
- 推荐方案

## Gate

`work-item-binding` 仅在无法确定正确 Work Item 时使用。

`visual-direction-approval` 在 Full Mode 中必需，且必须发生在生产实现前。

`prototype-approval` 在 Full Mode 中必需，发生在静态原型或等效预览可检查之后。

`interaction-decision` 仅用于会实质改变行为的 UX 决策。

`completion-approval` 在封存任何状态化 Work Item 前都必需。

## Delegated Mode

当用户要求 Codex 自行决定普通细节时，Codex 可以不停止地处理轻微视觉和原型决定。但涉及权限、删除、隐私、付费、不可逆行为、核心语义或最终封存时，仍必须询问用户。

