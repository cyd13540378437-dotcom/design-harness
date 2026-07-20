# 新增低影响业务属性

Given: 已有 confirmed WorkOrder 对象。

When: 用户要求给 WorkOrder 增加“期望完成时间”业务属性，且不影响关系、动作、状态或权限。

Then: 可以自动写为 provisional 或 confirmed candidate；如无 confirmed 覆盖风险，可由字典构建器和 schema-view 生成器更新，并记录为 D1。
