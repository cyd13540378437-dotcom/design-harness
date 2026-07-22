# Decision Case Contract v0.1.4

Decision Case 是一个业务选择的长期权威容器，不是聊天记录，也不是下游实施任务。

## 1. 顶部必须包含

```text
Decision Scope Lock
当前决策问题
Choice Set
当前推荐
用户决定
Choice Loop 状态
Claim-level Assurance
```

## 2. Decision Scope Lock

记录当前 Case 解决的决策粒度、明确非范围和是否已经锁定。后续不得静默下沉。

## 3. Choice Loop

```text
open      仍待选择
closed    本次选择已确认
reopened  新证据或取舍变化后正式复审
```

## 4. 三层结构

Decision Core、Decision Basis、Decision Memory 继续保留。Decision Memory 新增“决定后澄清记录”和 Choice Loop 关闭 / 重开原因。

## 5. 历史保护

confirmed 或 sealed 内容不能静默改写。新证据通过 Review、reopened、superseded 或新 Work Item 表达。
