---
schema_version: 3
language: zh-CN
case_id: BA-DC-002
title: 冷启动条件下如何启动调度策略有效性验证
status: confirmed
decision_scope_id: cold-start-validation-path
decision_scope_type: validation_path_choice
decision_scope_status: locked
choice_loop_status: closed
overall_assurance: partial
recommended_option_id: B+
recommendation_status: user_confirmed
user_decision_status: confirmed
created_at: "2026-07-21"
updated_at: "2026-07-22"
owner: product-owner
---

# 决策案例：冷启动条件下如何启动调度策略有效性验证

# A. Decision Core / 决策核心

## A0. Decision Scope Lock

- 本 Case 解决：没有历史数据时，选择哪条路径启动调度策略验证。
- 明确不包含：M0 具体表格、字段、逐单步骤、评分公式、样例数据、脚本、UI 和模拟器执行。
- Scope status：`locked`

## A1. 当前决策问题

> 在冷启动条件下，应该采用哪条验证路径，既能现在开始学习，又不把合成结果误当成真实业务证明？

## A2. Choice Set

| ID | 选项 | 状态 | 主要价值 | 主要代价 / 风险 |
|---|---|---|---|---|
| A | 先采数据，暂不做模拟 | rejected | 未来证据更真实 | 现在无法开始 |
| B | 直接做纯合成实验台 | superseded | 快速开始 | 容易过度建设 |
| B+ | 冷启动假设模拟器，按 M0 → M1 → M2 分阶段投入 | selected | 能立即开始并逐步提高保真度 | 当前只能形成 provisional 证据 |
| C | 暂缓 | rejected | 不增加投入 | 无法解决当前问题 |

## A3. 当前推荐

- 推荐：B+（user_confirmed）
- 核心理由：以最低成本先检查比较方法，再决定是否脚本化和可视化。
- 接受的代价：早期结论高度依赖假设，不能宣称真实业务提升。
- 改变条件：M0 成本不可接受、比较方法无效或团队无法调用候选策略。

## A4. 用户决定与 Choice Loop

- 用户原话：“其他的都没问题，你说的 M0 手工跑是怎么个跑法？”
- 解释：明确接受 B+ 路线，同时提出 implementation-detail 澄清。
- 用户决定：confirmed
- Choice Loop：closed

## A5. Claim-level Assurance

| 声明 | 状态 | 说明 |
|---|---|---|
| 可以采用 B+ 分阶段验证路线 | supported | 作为当前投入路径成立 |
| M0 可检查比较方法是否值得进入 M1 | provisional | 依赖简化假设 |
| 合成结果证明真实业务提升 | blocked | 需要现实证据 |

# B. Decision Basis / 决策依据

## B0. 原始输入

> 我想做一个模拟器用来分析策略是否有效，但没有历史数据，不知道从何开始。

## B1–B9 摘要

用户需要的是模拟器起步路径，而不是先做日志。B+ 将投入分成 M0 方法检查、M1 脚本化和 M2 可视化，避免一开始建设高保真平台。

# C. Decision Memory / 决策记忆

## C1. M0 概念澄清

M0 是“不先开发系统的最小方法检查”：在一个很小、固定、明确假设的场景中比较基线和候选策略，确认比较逻辑是否可执行、指标是否能反映人力利用效率、差异是否值得进入 M1。

它能验证比较方法是否成立，不能证明真实业务效果。

## C2. 明确边界

具体表格、字段、逐单跑法、评分公式、权重、样例数据和代跑不属于本 Case。

## C3. 复审条件

若用户发现 M0 的人工成本不可接受，或 M0 无法提供决策价值，则正式重开 Choice Loop。

## C4. Choice Delta 日志

| 日期 | 新输入 | Choice Delta | 推荐是否改变 |
|---|---|---|---|
| 2026-07-22 | 用户拒绝“先采日志” | B+ 成为推荐 | 改变 |
| 2026-07-22 | “其他的都没问题” | B+ selected，Choice Loop 关闭 | 推荐确认 |
