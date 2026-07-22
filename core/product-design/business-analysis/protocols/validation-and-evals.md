# 验证与评测（Validation and Evals）v0.1.4

本版本在 v0.1.3 的 Choice-first 回归基础上，新增：

```text
混合轮次确认 + 追问；
指代性确认；
Choice Loop 关闭；
决定后概念澄清；
Decision Scope Lock；
实施细节不扩张 Case；
禁止执行提议；
Artifact Boundary Gate；
State 枚举强校验；
澄清暴露新代价时正式重开；
明确实施请求只形成新任务候选；
决定已确认的 Summary 不重复请求选择。
```

评测必须检查真实回复与文件内容，不能只检查 Agent 是否写了“未越界”。
