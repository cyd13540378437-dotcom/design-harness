# 六种入口模式协议

## 1. 用户主动建模（`direct_modeling`）

适用于用户明确要求新增或更新业务对象、属性、关系、动作、状态、规则或下游视图。

最小流程：

```text
orchestrator → router → relevant modelers → validator → output summary
```

高影响更新必须进入 Human Decision Control Plane。

## 2. 被动触发（`passive_trigger`）

适用于 `model-triggers/MT-xxx.md` 中的上游变化、下游缺口、横向冲突或内部发现。

必须生成或关联：

```text
MODEL_IMPACT_REPORT.md
MODELING_OUTPUT.md
DECISION_NOTES.md（如需要）
```

## 3. 当前项目解析（`project_extraction`）

从 README、PRD、API、数据库、页面、类型定义、测试、路由和错误文案中提取候选业务模型。

解析结果默认 `draft` 或 `provisional`，不得自动 `confirmed`。

## 4. 从零建模（`greenfield_modeling`）

从模糊想法建立 provisional 业务模型，优先输出核心对象、业务属性、关键关系、风险和待确认问题。

## 5. 一致性校验（`consistency_validation`）

检查业务字典、schema-view、对象画像、关系、动作、状态、规则、权限和下游视图的一致性。

## 6. 下游视图编译（`downstream_compilation`）

将核心模型编译给产品表达、需求表达、数据库、后端、前端和 QA。

发现核心缺口时创建 Model Trigger，不得直接修改核心模型。
