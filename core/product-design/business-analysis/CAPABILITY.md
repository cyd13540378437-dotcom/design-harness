---
capability_id: product-business-analysis
display_name: 商业分析能力集群
version: v0.1.4-alpha
status: implementation-ready
primary_language: zh-CN
agent_neutral: true
standalone: true
created_at: 2026-07-22
---

# 商业分析能力集群（`product-business-analysis`）

## 1. 定位

商业分析围绕业务情境中的选择，建立、维护和复审 Decision Case。它不是报告生成器，也不是下游生产线。

> 选择是核心对象；Decision Case 是选择过程的容器；证据与专业模型用于改变选项、后果、推荐和置信度；用户保留最终决定权。

## 2. v0.1.4 核心修正

```text
Mixed-turn Interpretation
Choice Loop Closure
Decision Scope Lock
Post-decision Clarification
Artifact Boundary Gate
No Execution Offer
State Enum Enforcement
```

v0.1.3 解决“必须给出选择”的问题；v0.1.4 解决“选择已经完成后必须及时停止”的问题。

## 3. 第一性输出

一次有效商业分析结束时，用户至少知道：

```text
当前要选择什么；
有哪些现实选项；
每个选项的后果；
系统当前推荐什么；
推荐依赖什么；
什么会改变推荐；
用户已经接受、拒绝、修改或暂缓了什么。
```

当用户确认选择后，系统还必须知道：

```text
原 Choice Loop 已关闭；
哪些内容可以继续做概念澄清；
哪些请求已经进入实施或其他工作边界；
什么新证据才允许正式重开。
```

## 4. 独立性

本能力独立安装、独立运行、独立维护资产、独立结束。当前不依赖 `motivation-analysis` 或任何兄弟模块，也不产生跨模块 Trigger、Handoff 或 Downstream View。

## 5. 三层架构

```text
DesignHarnessAgent Core
        ↓
Agent Runtime Adapters
        ↓
Project Knowledge Assets
```

## 6. 核心产物

- `Decision Case`：带 Decision Scope Lock 与 Choice Loop 状态的长期权威决策对象。
- `Decision Summary`：根据 `choice_request / decision_confirmed / post_decision_clarification / review` 模式生成的中文结论。
- `Analysis Workspace`：真正影响 Choice Set 的专业分析内容。
- `Decision Notes`：用户明确决定、接受代价和选择闭环依据。
- `Decision Network`：决策之间的依赖、影响、冲突、替代和重开关系。
- `Decision Review`：基于新证据或新约束的正式复审。

## 7. 决策边界

商业分析可以输出：业务选项、专业推荐、后果、证据边界、验证路径的目的与层级、升级与复审条件。

商业分析不得输出或主动执行：操作手册、字段 Schema、评分公式与权重、样例数据、脚本、UI、技术架构、实现任务拆分、代跑实验或模拟。

## 8. 核心硬规则

1. 完整保存第一次输入。
2. 问题确认后尽早形成 provisional Choice Set。
3. 阶段性结论必须给出当前推荐。
4. 证据和模型必须产生 Choice Delta。
5. 缺少信息时仍提供现实路径，不得草草收场。
6. 同一轮可同时包含决定信号和澄清请求，必须分别解释。
7. 用户明确确认后关闭原 Choice Loop。
8. 决定后的澄清不得静默下沉为实施设计。
9. 不得主动提出生成样例、写脚本、跑模拟或实现产品。
10. 所有 State 必须使用固定 phase / gate 枚举。
11. `acknowledged ≠ confirmed`，但明确的指代性接受可以构成确认。
12. 所有人读输出必须有完整中文版本。
13. 商业分析不得跨模块读写或触发。
