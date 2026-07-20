# 下游字段不能反推为核心属性

Given: database-view 或数据库 schema 中出现 `current_executor_id`。

When: 编译器或解析器发现该字段。

Then: 核心模型只能表达“当前执行人”业务属性；不得把 `current_executor_id` 写入 `business-dictionary` 或 `schema-view.json`。
