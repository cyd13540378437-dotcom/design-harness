# Codex 开工单：实现 Product Business Analysis Core v0.1.4 Complete

请在当前 DesignHarnessAgent Git 仓库中，把 `product-business-analysis` 原位升级为 v0.1.4。

## 1. 阅读顺序

1. `README.zh-CN.md`
2. `docs/PRD.product-business-analysis-v0.1.4.md`
3. `docs/ARCHITECTURE_DECISION.decision-boundary-and-choice-closure-v0.1.4.md`
4. `core/product-design/business-analysis/CAPABILITY.md`
5. `core/product-design/business-analysis/SKILL.md`
6. 新增七份边界与闭环协议
7. `docs/MIGRATION_NOTES.business-analysis-v0.1.3-to-v0.1.4.md`

## 2. 首要边界

商业分析与业务模型、动机分析及所有其他能力完全独立。本次不得修改、调用、触发或集成任何兄弟能力。

## 3. 必须实现

- Mixed-turn Interpretation；
- Choice Loop Closure；
- Decision Scope Lock；
- Post-decision Clarification；
- Artifact Boundary Gate；
- No Execution Offer；
- State Enum Enforcement；
- schema 3 的 State / Case / Summary / Notes / Continuity / Assurance；
- ARCOS 决定确认与 M0 实施追问回归；
- 56 个评测；
- 全部中文人读输出。

## 4. 迁移规则

- 保留 v0.1.3 Choice-first、Recommendation Obligation、Claim-level Assurance 和 No Dead-End。
- 删除或移出商业分析范围的实施指南、Runbook、样例、代码和技术设计。
- 不允许 `simulator-design` 等自定义 phase 或 gate。
- 决定已 confirmed 时，Summary 不再请求同一选择。

## 5. Milestones

1. Core / Protocols；
2. Templates / State Schema；
3. Model-card boundary guards；
4. Adapters / AGENTS；
5. Examples / 56 Evals；
6. Docs / Audit / Package Manifest。

## 6. Definition of Done

- ARCOS 原话回归通过；
- 未创建 `M0_MANUAL_SIMULATION_GUIDE.md` 或实施同类产物；
- 未出现执行提议；
- 所有示例 State 枚举合法；
- Choice Loop 和 Summary mode 一致；
- 26 张模型卡继续通过；
- 未修改任何兄弟模块；
- 无 CLI / Hook / Plugin / Installer / 外部依赖。

## 7. 最终回复

说明核心升级、ARCOS 回归、Choice Closure、Scope Lock、边界产物、State 枚举、模型卡、评测、中文输出与兄弟模块保护结果。
