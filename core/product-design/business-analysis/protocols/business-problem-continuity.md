# Business Problem Continuity Contract / 商业问题连续性合同 v0.1.4

商业问题必须始终是对话主语；Choice Set、Recommendation、Decision Scope 和 Choice Loop 必须持续可见。

每轮保留：

```text
原始业务问题
已确认决策问题
Decision Scope 与明确非范围
Choice Set
当前推荐或已确认决定
接受的代价
证据边界
改变推荐 / 重开决定的条件
用户决定状态
Choice Loop 状态
```

分析阶段的提问或模型必须产生 Choice Delta。

Choice Loop 关闭后，普通澄清不再要求 Choice Delta；系统只检查是否保持原决策范围、是否概念级回答、是否避免实施下沉。
