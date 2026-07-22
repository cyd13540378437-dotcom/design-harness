# 六种入口模式协议

## 0. 所有写入型模式的共同收口

凡是修改核心 source of truth 的运行，必须按以下顺序收口：

```text
写入核心资产
→ consistency_validation
→ 修复可安全修复的问题
→ 编译 docs/product/BUSINESS_MODEL_OVERVIEW.md
→ 编译其他必要下游视图
→ 更新 MODELING_OUTPUT.md 与 STATE.md
```

不得在只完成“文件写入”后宣称建模完成。

## 1. 用户主动建模（`direct_modeling`）

适用于用户明确要求新增或更新业务对象、属性、关系、动作、状态、规则或下游视图。

最小流程：

```text
orchestrator → router → relevant modelers → validator → overview compiler → output summary
```

高影响更新必须进入 Human Decision Control Plane。

## 2. 被动触发（`passive_trigger`）

适用于 `model-triggers/MT-xxx.md` 中的上游变化、下游缺口、横向冲突或内部发现。

必须生成或关联：

```text
MODEL_IMPACT_REPORT.md
MODELING_OUTPUT.md
MODEL_CONSISTENCY_REPORT.md
BUSINESS_MODEL_OVERVIEW.md
DECISION_NOTES.md（如需要）
```

## 3. 当前项目解析（`project_extraction`）

从 README、PRD、API、数据库、页面、类型定义、测试、路由和错误文案中提取候选业务模型。

解析结果默认 `draft` 或 `provisional`，不得自动 `confirmed`。任何写入后必须校验并更新总览。

## 4. 从零建模（`greenfield_modeling`）

从模糊想法建立 provisional 业务模型。必须使用标准 Work Item 文件，至少产出业务字典、schema view、必要的对象 / 关系 / 动作 / 状态 / 规则视图、完整一致性报告和用户总览。

关键对象身份、核心动作、自动决策权限、目标优先级和审计边界等 D2 判断可以保持 provisional，但必须在总览中清楚压缩给用户。

## 5. 一致性校验（`consistency_validation`）

检查文件协议、State Schema、业务字典、schema-view、对象画像、关系、动作、状态、规则、权限、对象身份、上下文属性、用户总览和其他下游视图的一致性。

必须生成 `MODEL_CONSISTENCY_REPORT.md`。若校验改变了问题清单或模型可信状态，也必须重新编译总览。

## 6. 下游视图编译（`downstream_compilation`）

将核心模型编译给：

```text
product owner（BUSINESS_MODEL_OVERVIEW.md）
产品表达
需求表达
数据库
后端
前端
QA
UX / Design Engineering
```

发现核心缺口时创建 Model Trigger，不得直接修改核心模型。
