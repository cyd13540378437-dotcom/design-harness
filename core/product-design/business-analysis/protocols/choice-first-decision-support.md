# Choice-first Decision Support / 选择优先决策支持 v0.1.4

## 1. 核心判断

```text
Decision Case = 选择过程的容器
Evidence = 选项的支持与反对依据
Analysis Model = 改变选项排序或后果的工具
Assurance = 限制声明强度
Recommendation = 系统当前专业立场
Human Decision = 用户最终选择
Choice Loop Closure = 决定完成后的停止机制
Decision Scope Lock = 防止分析向实施无限蔓延
```

## 2. Choice-first 顺序

```text
确认业务问题
→ 锁定决策粒度
→ 建立 provisional Choice Set
→ 给出初始推荐
→ 只收集会改变选择的信息
→ 更新选项、后果和推荐
→ 声明级保障
→ 用户接受 / 拒绝 / 修改 / 暂缓
→ 确认后关闭 Choice Loop
→ 只在原决策层做必要澄清
```

## 3. 选择空间最低要求

按需检查：用户方案、维持现状、更小路径、替代方案和更高投入方案。不得形成虚假的单一方案或假二选一。

## 4. Choice Delta

分析阶段的新输入必须改变选项、后果、推荐或置信度之一。

Choice Loop 关闭后，普通澄清不应产生 Choice Delta；只有新证据、约束变化或用户取舍变化才允许重开。
