# 一个生命周期只属于一个业务对象

**Given**：`DispatchDecision` 表达推荐、确认和覆盖后的选择，`Assignment` 表达提交决策后形成的执行责任，但 Assignment 生命周期包含 `recommended → committed`。

**When**：状态生命周期建模器和一致性校验器检查模型。

**Then**：必须拆分 Decision 与 Assignment 生命周期，并用 Commit Action 表达“Decision 创建 Assignment”；不得把一个对象的状态放入另一个对象的生命周期。
