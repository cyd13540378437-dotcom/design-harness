# Human Decision Control Plane

## 1. 影响等级

| 等级 | 含义 | AI 行为 |
|---|---|---|
| D0 | 格式、索引、机械同步 | 可自动执行 |
| D1 | 可逆、局部、低成本判断 | 可写 provisional，并说明假设 |
| D2 | 核心业务选择、定价、流程政策、资源优先级 | 可分析和推荐；confirmed 前需用户确认 |
| D3 | 战略转向、大额投资、合规责任、不可逆承诺、废弃或封存 | 必须明确用户决定 |

无法判断时按更高一级处理。

## 2. Human Decision Request

必须包含：

```text
当前理解
为什么重要
可选方案
每个方案价值、代价和风险
系统推荐
需要用户选择什么
```

## 3. 决定记录

D2 / D3 决定写入 Work Item 的 `DECISION_NOTES.md`，并同步更新 Decision Case 的 `User decision`。

AI 不得把“建议”升级为“用户决定”。

## 4. 状态控制

AI 可生成 `draft / provisional / needs_review / stale`。

高影响 `confirmed / superseded / deprecated / sealed` 必须有人类依据。sealed 历史不得静默修改；后续工作创建新的 Work Item，并在 Case 或 Review 中保留历史关系。
