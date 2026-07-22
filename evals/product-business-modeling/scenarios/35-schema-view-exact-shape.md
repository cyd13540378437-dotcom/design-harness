# `schema-view.json` 唯一结构

**Given**：生成对象使用 `object`、字符串 `business_domain` 和属性键 `name/example`。

**When**：校验 `schema-view.json`。

**Then**：即使内容语义接近也必须失败；应归一化为 `object_id/object_name/object_label`、`business_domain:{id,label}`、`object_category:{id,label}` 和 `business_attributes:[{attribute_id,attribute_label,example_content}]`，且不得混入关系、动作、状态、权限或数据字段。
