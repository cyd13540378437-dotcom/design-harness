# 状态转换缺少 Action ID

Given: WorkOrder 从 `pending_approval` 变为 `closed`。

When: 状态转换没有引用存在于 Action Catalog 的 Trigger Action ID。

Then: 一致性检查器必须报告 error，并建议补充触发动作或修正状态模型。
