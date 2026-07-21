# Decision Network Protocol

Decision Network 记录用户个人或组织的决策之间的关系。

目标不是做复杂知识图谱，而是防止：

```text
A 决策当时成立
后来 B 决策改变了 A 的前提
但没人意识到 A 已经需要复审
```

## 1. 第一版关系类型

```text
depends_on      当前决策依赖另一个决策
 affects         当前决策影响另一个决策或领域
conflicts_with  当前决策与另一个决策冲突
supersedes      当前决策替代另一个决策
reopens         当前决策触发另一个决策复审
```

## 2. 规则

```text
新决策不得静默改写旧决策。
旧决策受影响时，生成 Decision Review / Reopen Notice。
冲突不得自动合并，必须请求用户选择处理方式。
影响关系可以 provisional 记录。
高影响 supersedes 必须用户确认。
```

## 3. 最小记录

```yaml
source_decision: BA-DC-002
target_decision: BA-DC-001
relation: reopens
reason: 新的 Seat 计费决策可能改变旧的试用宽限期成本前提。
status: provisional
recommended_action: 复审旧决策，而不是静默改写。
```

## 4. 复审选择题

当旧决策被重开时，输出：

```text
A. 保持旧决策不变
B. 调整旧决策适用范围
C. 创建 successor decision 替代旧决策
D. 先补充证据再判断
```


## 5. 边界

Decision Network 只连接 Decision Cases 或决策主题。它不是模块依赖图，也不产生跨能力 Trigger。
