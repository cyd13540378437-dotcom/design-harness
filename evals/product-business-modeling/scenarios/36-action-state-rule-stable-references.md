# Action / State / Rule 稳定引用

**Given**：状态转换只写“已推荐 → 已提交”，Action Catalog 没有 Actor、Target、Preconditions 或 Effects，或者规则只引用展示名称。

**When**：执行一致性校验。

**Then**：必须报告错误；Action、State、Rule 都必须有 stable ID，Transition 必须引用 Action ID，Actor 与 Target 必须引用已定义角色和对象，规则必须按 ID 绑定适用对象、动作或状态。
