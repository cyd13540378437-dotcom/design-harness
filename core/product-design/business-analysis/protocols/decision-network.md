# 决策网协议（Decision Network）v0.1.4

Decision Network 记录本模块内部 Decision Case 之间的关系，不是跨模块触发器。

## 关系类型

```text
depends_on      当前决定依赖另一决定
affects         当前决定会影响另一决定
conflicts_with  两个决定存在冲突
supersedes      新决定替代旧决定
reopens         当前变化触发旧决定复审
```

## Choice-first 写入规则

- `DECISION_NETWORK.yml` 是机器权威源；`DECISION_NETWORK.md` 是完整中文人读视图。
- 新关系必须说明它如何改变 Choice Set、推荐或复审条件。
- `affects` 或 `reopens` 不会自动启动其他能力或任务。
- confirmed / sealed 历史不得静默改写。
- 用户拒绝、修改或暂缓某个推荐时，可更新同一 Case 的 Choice Delta；只有形成新的独立选择问题时才创建新 Case。
