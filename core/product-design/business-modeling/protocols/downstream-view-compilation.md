# 下游视图编译协议

## 1. 目标视图

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

## 2. 编译原则

- 从 confirmed 模型编译稳定建议；
- 从 provisional 模型编译时必须标注假设；
- 技术字段只能在数据库或后端视图中出现；
- 不得把技术字段写回核心模型；
- 发现核心模型缺口时创建 Model Trigger。
- 面向 UX / Design Engineering 的影响只写入 `ux-design-engineering-view.md`，不得直接修改 `docs/design/`。
- 面向 UX / Design Engineering 的启动上下文应编译为 `ux-business-model-context.md/yml`；该包是轻量输入，不是 source of truth。

## 3. 输出结构

每个下游视图应说明：

```text
Consumed Model Version
Confirmed Inputs
Provisional Inputs
Derived Recommendations
Open Gaps
Potential Follow-up Triggers
```


## 4. UX Business Model Context Pack

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

## 4. UX Context Pack 编译规则

`ux-business-model-context.md/yml` 应只收集 UX 启动和关键设计判断需要的业务语义：

```text
confirmed / provisional 业务对象
UX 相关业务动作
UX 相关状态
UX 相关规则与权限
影响 UX 的 open model triggers
UX 何时创建 downstream_gap / cross_cluster_conflict 的规则
```

不得包含数据库字段、后端接口、字段类型、ORM、技术表结构或 UI 视觉参考。

该包缺失时，UX 启动不应被阻断；该包存在时，UX 应轻量读取并在 `STATE.md` 中记录摘要或链接。
