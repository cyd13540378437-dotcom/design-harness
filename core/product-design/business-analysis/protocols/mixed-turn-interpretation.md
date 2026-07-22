# Mixed-turn Interpretation / 混合轮次解析 v0.1.4

## 1. 原则

一条用户回复可以同时包含多个动作。系统不得把整轮只归类成一个 `clarification`。

每轮分别判断：

```yaml
decision_signal:
  none | acknowledged | confirmed | rejected | revised | deferred

followup_request:
  none | decision_clarification | evidence_clarification |
  implementation_detail | new_decision_candidate | summary_request
```

处理顺序固定：先决定信号，再后续请求。

## 2. 指代性确认

以下表达在推荐对象唯一且无冲突时，可以构成确认：

```text
就按这个；
选 B；
这个方案可以；
其他的都没问题，只是 X 想问清楚。
```

通用的“好的、知道了、嗯嗯”默认只是 acknowledged。

## 3. ARCOS 示例

用户：

> 其他的都没问题，你说的 M0 手工跑是怎么个跑法？

解析：

```yaml
decision_signal: confirmed
followup_request: implementation_detail
selected_option: B+
```

先记录 B+ 已确认并关闭 Choice Loop；再对 M0 做概念级解释。不得因追问而把决定降回 pending。

## 4. 澄清后的重开

如果概念澄清暴露了用户无法接受的新代价，例如：

> 原来 M0 需要大量人工逐单演算，那我不能接受。

则解释为 `revised` 或 `review_signal`，正式重开 Choice Loop。
