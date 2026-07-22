# Codex 开工单：实现 Product Business Analysis Core v0.1.2 Complete

请在当前 **DesignHarnessAgent Git 仓库**中，把本包定义的 `product-business-analysis` 实现或升级为 v0.1.2。

## 0. 阅读顺序

1. `CODEX_START_HERE.md`
2. `docs/PRD.product-business-analysis-v0.1.2.md`
3. `docs/ARCHITECTURE_DECISION.business-problem-continuity-v0.1.2.md`
4. `core/product-design/business-analysis/CAPABILITY.md`
5. `core/product-design/business-analysis/SKILL.md`
6. `core/product-design/business-analysis/capability.manifest.yml`
7. `core/product-design/business-analysis/protocols/follow-up-turn-continuity.md`
8. `core/product-design/business-analysis/protocols/business-problem-continuity.md`
9. `core/product-design/business-analysis/protocols/analysis-depth-control.md`
10. `core/product-design/business-analysis/protocols/final-conclusion-contract.md`
11. `core/product-design/business-analysis/protocols/output-language-contract.md`
12. `core/product-design/business-analysis/protocols/business-analysis-vs-solution-design-boundary.md`
13. `core/product-design/business-analysis/model-cards/analysis-model-card.schema.yml`
14. `docs/MIGRATION_NOTES.business-analysis-v0.1.1-to-v0.1.2.md`

## 1. 首要边界

商业分析与业务模型及所有其他能力完全独立。

本次不得：

```text
修改兄弟能力 Core / Adapter / Project Assets
创建跨模块 Trigger
创建 Downstream View
使用共享 Work Item 目录
把兄弟能力协议作为依赖
```

## 2. 工作方式

1. 先盘点目标仓库和现有 `product-business-analysis` 版本；
2. 输出简短实施计划，不重复 PRD；
3. 若已有 v0.1.1，按迁移说明原位升级；若没有，新增完整模块；
4. 同名 root README / AGENTS / CHANGELOG 只做最小追加；
5. 所有兄弟能力目录只读保护；
6. 按 Milestone 实现；
7. 每个 Milestone 后检查独立性、路径、中文输出和回归场景；
8. 最终执行静态自检。

## 3. 必须实现的修正

### 3.1 Follow-up Turn Continuity

有相关 BA Work Item 时，每轮回复前必须读取最小恢复集，不得退化为无状态普通回答。

### 3.2 Decision Anchor

`STATE.md` 和 Decision Case 顶部维护商业问题、业务选项、关键未知、证据边界、Assurance 和用户决定状态。

### 3.3 Solution Premise Challenge

新增 `solution-premise-challenge` 模型卡。用户带着具体解法进入时，先比较不做、更小验证、用户方案和更重方案。

### 3.4 Decision-relevant Question

把 Next Best Question 修正为 Decision Delta Test。不能改变业务选择的问题不得优先询问。

### 3.5 Model-to-Decision Traceability

- 25 张 ready 卡；
- 7 个非空 usage prompts；
- 每个 Analysis Run 有 Decision Delta；
- `low_relevance / discarded` 不进入用户结论；
- `conclusion_prompt` 只供统一综合器。

### 3.6 Unified Synthesis

只能生成一次用户可见结论；不得让多个模型各自收尾。

### 3.7 Depth and Paths

支持 quick / standard / deep。所有过程文件只放在 Work Item `artifacts/`，不得创建 `intake/`。

### 3.8 Final Conclusion

按需生成 `DECISION_SUMMARY.md`，绑定 Case、Work Item、Assurance、结论状态、证据边界和用户决定状态。

### 3.9 Chinese Output

所有用户可见回复和人读 Markdown 输出必须有完整简体中文版本。内部 Prompt 可以英文。

## 4. 项目模板

```text
templates/project/docs/product/business-analysis/
├── BUSINESS_ANALYSIS_INDEX.md
├── BUSINESS_ANALYSIS_INDEX.yml
├── BUSINESS_ANALYSIS_WORK_ITEMS.md
├── DECISION_CASE.template.md
├── DECISION_REVIEW.template.md
├── decision-cases/
├── decision-network/
├── evidence/
├── reviews/
└── work-items/
    ├── STATE.template.md
    ├── ANALYSIS_CONSUMPTION.template.md
    ├── ANALYSIS_OUTPUT.template.md
    ├── DECISION_NOTES.template.md
    ├── DECISION_SUMMARY.template.md
    ├── DECISION_PROCESS_PACKAGE.template.md
    └── artifacts/
        ├── INPUT_UNDERSTANDING_SNAPSHOT.template.md
        ├── TURN_CONTINUITY_CHECK.template.md
        ├── ANALYSIS_ROUTING_RECORD.template.md
        ├── EVIDENCE_INTAKE_RECORD.template.md
        ├── MODEL_SELECTION_RECORD.template.md
        ├── ANALYSIS_RUN.template.md
        ├── DECISION_ASSURANCE_CHECK.template.md
        ├── DECISION_SYNTHESIS.template.md
        └── DECISION_NETWORK_UPDATE.template.md
```

## 5. Milestones

### Milestone 1：Core 协议与 Skill

更新 CAPABILITY、SKILL、manifest 和连续性、深度、结论、语言协议。

### Milestone 2：输出模板与路径

更新全部中文模板；过程文件归入 `artifacts/`；增加 `DECISION_SUMMARY`、滚动 `TURN_CONTINUITY_CHECK` 和中央 `DECISION_SYNTHESIS` 模板。

### Milestone 3：Model Cards

升级全部卡片为 7 prompts，增加 Solution Premise Challenge，校验 Decision Delta。

### Milestone 4：Adapters 与 Project Rules

更新 namespaced adapters 和项目 AGENTS fragment，不覆盖兄弟模块。

### Milestone 5：Examples and Evals

保留 Seat 示例，新增 ARCOS 多轮连续性示例；保留原有场景并扩展到 34 个 v0.1.2 回归场景。

### Milestone 6：Root Docs

最小更新 README、AGENTS、CHANGELOG；加入当前版本文档链接。

### Milestone 7：Self-check

检查 YAML、模型卡、中文输出、相对链接、路径、Case 单一权威、无 `intake/`、无 sibling changes。

## 6. Definition of Done

- Business Analysis 独立运行；
- 兄弟能力保持原样；
- Follow-up Turn Continuity 生效；
- Decision Anchor 完整；
- 25 张 ready 卡和 7 prompts 通过；
- Analysis Run 有 Decision Delta；
- 单一统一结论；
- `DECISION_SUMMARY` 绑定 Case / Work Item / Assurance / 证据边界 / 用户状态；
- 所有人读输出有中文版本；
- ARCOS 回归通过；
- 无 `intake/`、Trigger、Downstream View、共享 Work Item、CLI、Hook、Plugin、Installer、外部依赖。

## 7. 最终回复

请说明：

1. 新增或升级了哪些核心文件；
2. 如何保证商业分析完全独立；
3. 多轮续接如何工作；
4. Decision Anchor 和 Decision Delta 如何保护商业问题连续性；
5. 25 张模型卡及 7 prompts 是否通过；
6. 中文输出合同如何落实；
7. ARCOS 回归是否通过；
8. 是否修改任何兄弟能力；
9. 当前明确未实现的未来集成功能。
