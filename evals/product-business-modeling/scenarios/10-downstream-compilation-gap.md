# 下游编译发现模型缺口

Given: QA 视图需要审批失败场景。

When: 核心状态模型没有“审批失败”状态或动作。

Then: 下游视图编译器不得直接补核心状态；必须创建 `downstream_gap` Trigger。
