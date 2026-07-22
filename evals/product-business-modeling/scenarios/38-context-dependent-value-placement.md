# 上下文相关值不能伪装成固有属性

**Given**：`ServiceLocation` 被赋予“预计到达成本”，但该值取决于资源出发点、时间窗口、通行条件和候选方案。

**When**：一致性校验器检查属性归属。

**Then**：必须报告误放，并建议建模为 Resource–Location 关系属性、`DispatchCandidate` 的 contextual/derived 业务属性或下游派生值；不得把它当作位置的 intrinsic 属性。
