# 决策网协议（Decision Network）v0.1.2

Decision Network 记录本模块内部 Decision Case 之间的关系，不是跨模块触发器。

## 关系类型

```text
depends_on      当前决定依赖另一决定
 affects         当前决定会影响另一决定
conflicts_with  两个决定存在冲突
supersedes      新决定替代旧决定
reopens         当前变化触发旧决定复审
```

## 写入规则

- `DECISION_NETWORK.yml` 是机器权威源。
- `DECISION_NETWORK.md` 是完整中文人读视图。
- 新关系必须说明原因、证据和状态。
- `affects` 或 `reopens` 不会自动启动其他能力或任务。
- confirmed / sealed 历史不得静默改写。
