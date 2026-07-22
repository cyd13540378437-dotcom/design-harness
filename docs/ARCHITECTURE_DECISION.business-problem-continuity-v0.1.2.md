# 架构决定：Business Problem Continuity v0.1.2

## 决定

商业分析继续作为完全独立的兄弟能力，采用 Core / Runtime Adapters / Project Knowledge Assets 三层架构和五个运行域。

v0.1.2 不增加跨模块功能，而是在模块内部增加：

```text
Follow-up Turn Continuity
Decision Anchor
Business Problem Continuity
Analysis Depth Control
Solution Premise Challenge
Decision Delta
Unified Decision Synthesis
Chinese Output Contract
```

## 原因

ARCOS 智能调度模拟器实测表明：首轮能够建立 Decision Case，但后续回复可能不再读取状态，逐渐退化成普通咨询；同时分析可能从“是否应采用某条验证路径”滑向“模拟器具体怎么设计”。

这说明当前首要问题不是更多模型或跨模块联动，而是：

```text
多轮状态是否连续；
商业问题是否始终是对话主语；
模型是否真正改变业务选择；
结论是否绑定 Case、证据和用户决定状态。
```

## 不采用

- 不新增 Passive Trigger；
- 不实现与业务模型或其他能力的自动影响传播；
- 不共享 Work Item 目录；
- 不让模型卡拥有独立用户结论出口；
- 不创建临时 `intake/` 知识层；
- 不把实施规格纳入商业分析权威结论。

## 产物决定

- 所有过程文件位于 Work Item `artifacts/`；
- 用户请求最终结论时，生成 `DECISION_SUMMARY.md`；
- `DECISION_PROCESS_PACKAGE.md` 按需生成，不再强制每轮生成；
- 所有人读项目输出必须包含完整简体中文内容。
