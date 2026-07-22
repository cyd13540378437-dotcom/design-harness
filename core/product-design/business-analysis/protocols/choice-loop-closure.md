# Choice Loop Closure / 选择循环关闭协议 v0.1.4

## 1. 状态

```text
open      仍在比较或等待用户决定
closed    用户已经确认本次选择快照
reopened  新证据、约束或用户取舍变化后正式重开
```

## 2. 关闭条件

用户明确选择、接受或确认某个方案时：

```text
更新 user_decision_status=confirmed
更新 recommendation_status=user_confirmed
将选项标为 selected
记录接受的代价和证据边界
写入 DECISION_NOTES.md
设置 choice_loop_status=closed
```

## 3. 关闭后的行为

Choice Loop 关闭后：

```text
不得重复要求用户选择同一问题；
不得继续生成同层或更低层的新选项；
不得继续运行专业模型；
不得静默下沉到实施设计；
只能做概念澄清、总结、封存或等待正式复审。
```

## 4. 正式重开

只有以下信号可以重开：

```text
新证据改变后果；
约束或目标发生变化；
用户明确拒绝已确认方案；
澄清暴露不可接受的新代价；
复审条件被触发。
```

重开必须记录原因，不得静默覆盖历史确认。
