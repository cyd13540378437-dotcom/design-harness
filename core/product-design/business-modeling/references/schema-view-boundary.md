# `schema-view.json` 冻结边界与结构合同

`schema-view.json` 只回答：

1. 有哪些业务对象；
2. 每个对象属于哪个业务领域；
3. 每个对象属于哪种对象分类；
4. 每个对象有哪些业务属性；
5. 每个业务属性有哪些示例内容。

## 唯一允许的顶层结构

```json
{
  "schema_version": 1,
  "view_type": "business_attribute_structure",
  "objects": []
}
```

每个 object 只能使用：

```text
object_id
object_name
object_label
business_domain: {id, label}
object_category: {id, label}
business_attributes
```

每个 business attribute 只能使用：

```text
attribute_id
attribute_label
example_content
```

禁止使用 `object`、`domain`、`category`、`name/example` 等替代键来创建平行结构。

## 引用完整性

- `object_id` 必须存在于 `business-dictionary.yml.business_objects`；
- domain ID 必须存在于 `business_domains`；
- category ID 必须存在于 `object_categories`；
- attribute ID 必须存在于 `business_attributes`，且其 `object_id` 匹配；
- 同一数组中 ID 必须唯一。

## 禁止内容

```text
对象关系
业务动作
状态流转
业务规则
权限策略
数据库字段
字段类型
持久化策略
后端接口
路线图
风险
下游影响
```

任何结构替代、缺少引用或越界内容都是 consistency error，而不是“合理差异”。
