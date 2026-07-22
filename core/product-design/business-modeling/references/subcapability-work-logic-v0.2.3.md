# Business Modeling Skill Cluster 子能力工作逻辑 v0.2.3

- **能力**：`product-business-modeling`
- **状态**：规范性增量，覆盖 v0.2 工作逻辑中与本文件冲突的部分
- **日期**：2026-07-22

## 1. v0.2.3 的闭环

```text
请求 / Trigger
→ modeling-orchestrator
→ canonical Work Item binding
→ model-update-router
→ relevant production modules
→ Human Decision Control Plane
→ source-of-truth write
→ model-consistency-validator
→ downstream-view-compiler: BUSINESS_MODEL_OVERVIEW.md
→ other required downstream views
→ MODELING_OUTPUT.md + STATE.md
→ user receives overview only
```

## 2. 业务模型总协调器

新增强制职责：

- 初始化或检查 canonical Work Item 文件；
- 禁止附加文件替代 canonical 文件；
- 所有 Core 写入后调用 validator；
- validator 完成后调用 overview compiler；
- 进入 completion review 前确认总览为 current；
- 用户交付默认只提供总览。

## 3. 模型更新分发器

新增强制职责：

- 在变更计划中显式列出受影响的 Dictionary / Schema / Index 引用；
- 保证同一 stable ID 跨文件一致；
- 将上下文相关值路由给 relationship modeler、evaluation object 或 downstream derivation，而不是错误写入单一对象属性。

## 4. 业务字典构建器

必须维护完整 YAML 注册表：领域、分类、对象、属性、动作、状态、角色和禁用术语。

不得只生产术语列表。

## 5. Schema View Structurer

只能使用冻结结构；不得接受近似字段名或替代结构。所有 ID 必须可解析到字典。

## 6. Domain Object Profiler

一个 object ID 只能表示一个业务身份。斜杠、and/or 或多个生命周期混在同一对象名中时，必须提出 D2 identity decision 或定义明确的 umbrella concept。

## 7. Relationship Modeler

负责识别上下文相关值。若值依赖两个对象、时间、策略或评估上下文，应放到关系、候选、评估对象或派生视图。

## 8. Action Command Modeler

每个动作必须有：

```text
action_id
action_label
actor_role_ids
target_object_id
preconditions
business_effects
responsibility / audit implications
status
```

## 9. State Lifecycle Modeler

每个生命周期只属于一个 object ID。Transition 必须引用 Action ID。跨对象创建使用 Cross-object Materialization，不能把源对象状态混入目标对象生命周期。

## 10. Rule Policy Modeler

规则和权限必须绑定 stable object/action/state/role IDs；责任、权限、审计和自动决策边界属于 D2 / D3。

## 11. Model Consistency Validator

执行 16 项合同检查，结果写入 `MODEL_CONSISTENCY_REPORT.md`。任何 error 阻止 completion；warning 必须进入用户总览风险摘要。

## 12. Downstream View Compiler

新增固定目标：

```text
audience: product_owner
output: docs/product/BUSINESS_MODEL_OVERVIEW.md
```

总览是唯一默认用户入口，但不是 source of truth。

## 13. Human Decision Control Plane

- 使用 `BMD-xxx`；
- 先压缩再提问；
- 完整审计写入 `DECISION_NOTES.md`；
- 用户可决策版本写入总览；
- 等待时使用 canonical State 字段 `phase: awaiting_decision` 与 `awaiting_human: true`。

## 14. Runtime Adapter

Adapter 不得发明 State 字段、替代 Work Item 文件、跳过校验、跳过总览编译，或向用户默认抛出文件清单。
