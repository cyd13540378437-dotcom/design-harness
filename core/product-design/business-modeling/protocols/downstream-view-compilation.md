# 下游视图编译协议

## 1. 默认用户视图

固定编译：

```text
docs/product/BUSINESS_MODEL_OVERVIEW.md
```

这是面向 product owner 的唯一默认用户入口。它位于 `docs/product/` 根目录以便发现，但仍是派生视图，不是 source of truth。

详细合同见 `business-model-overview.md`。

## 2. 专业下游视图

```text
product-expression-view.md
requirements-view.md
database-view.md
backend-view.md
frontend-view.md
qa-view.md
ux-design-engineering-view.md
ux-business-model-context.md
ux-business-model-context.yml
```

## 3. 编译原则

- 从 confirmed 模型编译稳定建议；
- 从 provisional 模型编译时必须标注假设；
- 技术字段只能在数据库或后端视图中出现；
- 不得把技术字段写回核心模型；
- 发现核心模型缺口时创建 Model Trigger；
- 面向 UX / Design Engineering 的影响只写入 `ux-design-engineering-view.md`，不得直接修改 `docs/design/`；
- 面向 UX / Design Engineering 的启动上下文应编译为 `ux-business-model-context.md/yml`；该包是轻量输入，不是 source of truth；
- 总览中的待确认判断必须与 `DECISION_NOTES.md` 一致；
- 总览中的校验状态必须与最新 `MODEL_CONSISTENCY_REPORT.md` 一致。

## 4. 输出结构

每个专业下游视图应说明：

```text
Consumed Model Version
Confirmed Inputs
Provisional Inputs
Derived Recommendations
Open Gaps
Potential Follow-up Triggers
```

## 5. UX Business Model Context Pack

`ux-business-model-context.md` 与 `ux-business-model-context.yml` 是 UX / Design Engineering 启动和设计过程中读取的轻量业务模型上下文包。

编译规则：

```text
- 只从业务模型核心资产和 model-triggers 编译；
- 每条内容必须标注 status 与 source；
- 不包含数据库字段、接口参数、页面布局或视觉参考；
- 缺失内容写入 Open Gaps；
- open / awaiting_human Trigger 必须暴露给 UX；
- 该包不得反向修改核心模型，也不得直接修改 docs/design/。
```

该包缺失时，UX 启动不应被阻断；该包存在时，UX 应轻量读取并在自身状态中记录摘要或链接。
