# schema-view 边界

Given: 模型中存在 WorkOrder 对象、动作和状态。

When: 生成 `schema-view.json`。

Then: 只能包含对象、领域、分类、业务属性、示例内容；不得包含动作、状态转换、规则、权限或数据库字段。
