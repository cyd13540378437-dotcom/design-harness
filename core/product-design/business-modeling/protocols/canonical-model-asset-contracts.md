# 业务模型资产规范合同

## 1. 成对资产的权威关系

| 资产对 | 结构权威 | 人读视图 |
|---|---|---|
| Business Model Index | `BUSINESS_MODEL_INDEX.yml` | `BUSINESS_MODEL_INDEX.md` |
| Business Dictionary | `business-dictionary.yml` | `business-dictionary.md` |
| Schema View | `schema-view.json` | `schema-view.md` |

人读视图不得拥有结构化文件中不存在的 ID、状态或路径。两者冲突时，先报告一致性问题，再由对应单一写入者修复。

## 2. `BUSINESS_MODEL_INDEX.yml`

必须包含：

```text
schema_version
business_model_version
status
default_user_view
consistency
business_domains
business_objects
relationships
actions
states
rules
permissions
downstream_views
open_triggers
```

对象、动作、状态、规则等条目必须使用唯一稳定 ID，并指向真实资产路径。

## 3. `business-dictionary.yml`

必须包含：

```text
schema_version
business_model_version
status
business_domains
object_categories
business_objects
business_attributes（包含 attribute_kind）
actions
states
roles
terms_not_to_use
```

禁止仅使用一个通用 `terms:` 数组代替结构化业务字典。

## 4. `schema-view.json`

必须包含：

```json
{
  "schema_version": 1,
  "view_type": "business_attribute_structure",
  "objects": []
}
```

每个对象必须拥有：

```text
object_id
object_name
object_label
business_domain.id / label
object_category.id / label
business_attributes[].attribute_id / attribute_label / example_content[]
```

它仍然只能回答对象、领域、分类、业务属性和示例内容五类问题。

## 5. 关系、动作与状态

### Relationship

每条关系必须有唯一 ID、source object、relationship label、target object、meaning 和 status。

### Action

每个动作必须有唯一 Action ID、Actor、Target Object、Preconditions、Effects 和 Status。Actor 必须是已定义角色或明确的系统参与者；Target 必须是已定义业务对象。

### State Lifecycle

每个生命周期必须明确 owner object。每条转换必须引用：

```text
From State ID
Triggering Action ID
To State ID
Conditions
Status
```

生命周期不得混入其他对象的状态。例如，决策对象的 `recommended / confirmed / overridden` 不得放入 Assignment 生命周期；应建立独立 Decision 生命周期。

## 6. 业务对象身份检查

以下命名默认视为 D2 身份歧义信号：

```text
Asset / Facility
Person / Team
Order and Request
```

斜杠、并列词或一个对象同时承担明显不同生命周期时，必须：

1. 拆分对象；或
2. 在 `DECISION_NOTES.md` 记录明确的统一抽象决定。

不得把未决复合对象标为 confirmed。

## 7. 上下文依赖属性检查

一个值如果依赖两个以上对象、时间或场景，就不应默认成为单一对象的固有业务属性。

例如“到达成本”通常依赖资源当前位置、服务位置、时间窗口和通行条件，更适合作为：

- Relationship attribute；或
- `Dispatch Candidate` 等上下文对象的评估内容。

校验器应将此类问题标为 warning；若会影响对象身份、排序或工程结构，则升级为 D2。

## 8. 状态与 ID

- 所有 ID 在各自命名空间内唯一；
- 引用必须使用 ID，不只使用展示名称；
- Markdown、YAML、JSON 之间共享的 ID 必须一致；
- `draft / provisional / confirmed / superseded / deprecated / sealed` 之外的知识状态不得自由扩展；
- 技术字段、API 参数和持久化类型不得进入核心资产。
