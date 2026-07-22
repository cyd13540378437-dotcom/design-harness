# schema-view 边界与唯一结构

Given: 模型中存在 WorkOrder 对象、动作和状态。

When: 生成 `schema-view.json`。

Then: 只能包含固定键结构下的对象、领域、分类、业务属性和示例内容；不得包含动作、状态转换、规则、权限或数据库字段，也不得用近似字段名创建平行 Schema。
