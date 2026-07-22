# Codex 开工单：实现 Product Business Analysis Core v0.1.3 Complete

请在当前 DesignHarnessAgent Git 仓库中，把 `product-business-analysis` 实现或升级为 v0.1.3。

## 0. 阅读顺序

1. `CODEX_START_HERE.md`
2. `docs/PRD.product-business-analysis-v0.1.3.md`
3. `docs/ARCHITECTURE_DECISION.choice-first-business-analysis-v0.1.3.md`
4. `core/product-design/business-analysis/CAPABILITY.md`
5. `core/product-design/business-analysis/SKILL.md`
6. `core/product-design/business-analysis/capability.manifest.yml`
7. `core/product-design/business-analysis/protocols/choice-first-decision-support.md`
8. `core/product-design/business-analysis/protocols/recommendation-obligation.md`
9. `core/product-design/business-analysis/protocols/claim-level-assurance.md`
10. `core/product-design/business-analysis/protocols/no-dead-end-rule.md`
11. `core/product-design/business-analysis/protocols/decision-closure-contract.md`
12. `docs/MIGRATION_NOTES.business-analysis-v0.1.2-to-v0.1.3.md`

## 1. 首要边界

商业分析与业务模型、动机分析及所有其他能力完全独立。本次不得修改、调用、触发或集成任何兄弟能力。

## 2. 工作方式

1. 先盘点现有仓库和 Business Analysis 版本；
2. 输出简短实施计划；
3. 已有 v0.1.2 时按迁移说明原位升级；
4. 兄弟能力目录只读；
5. Root README / AGENTS / CHANGELOG 只做最小追加；
6. 按 Milestone 实现并自检。

## 3. 必须实现

### 3.1 Choice Core

Decision Case 和 STATE 顶部维护 Choice Set、推荐、代价、证据边界、改变条件和用户决定状态。

### 3.2 Recommendation Obligation

每次阶段性结论给出 `provisional | conditional | user_confirmed` 推荐。

### 3.3 Claim-level Assurance

整体 `pass | warn | partial`；声明 `supported | provisional | conditional | blocked`。迁移旧 `block`。

### 3.4 No Dead-End

缺少输入时仍比较现实路径并推荐一个，不得只要求补材料。

### 3.5 Decision Closure

中文 Summary 允许用户接受、拒绝、修改或暂缓，并记录下一次决策点。

### 3.6 Model Cards

26 张 ready 卡；10 Core + 16 Professional；全部包含 `runtime_role`、7 prompts 和 Choice Delta；新增 `choice-set-construction`。

### 3.7 Output Economy

Standard 默认核心为 STATE、Case、ANALYSIS_WORKSPACE、Summary、Notes。完整审计文件仅 Deep / Audit。

### 3.8 ARCOS

缺少排班与策略规则时，不得全局 block。比较 A/B/C/D 并推荐双轨冷启动；只阻塞真实业务效果声明。

## 4. Milestones

### Milestone 1：Core 与 Choice-first 协议
更新 CAPABILITY、SKILL、manifest 和选择 / 推荐 / Assurance / Closure 协议。

### Milestone 2：模板与项目结构
更新 Decision Case、STATE、Summary、Assurance、Synthesis；新增 ANALYSIS_WORKSPACE。

### Milestone 3：Model Cards
新增 runtime_role 与 choice-set-construction；升级全部卡片 Prompt。

### Milestone 4：Adapters 与项目规则
更新 Codex / Claude / Cursor Adapter 和 AGENTS fragment。

### Milestone 5：Examples / Evals
重写 ARCOS 回归；评测扩展到 44 个场景。

### Milestone 6：Docs / Audit
更新 README、CHANGELOG、PRD、Migration、Readiness Audit 和 Package Manifest。

## 5. Definition of Done

- Choice-first 流程完整；
- 推荐义务完整；
- Claim-level Assurance 完整；
- No Dead-End 完整；
- Decision Closure 完整；
- 26 张模型卡通过；
- ARCOS 回归通过；
- 中文输出完整；
- Business Analysis 独立；
- 未修改兄弟能力；
- 无 CLI / Hook / Plugin / Installer / 外部依赖。

## 6. 最终回复

请说明：

1. 升级了哪些核心文件；
2. Choice Set 和 Recommendation 如何贯穿 Case；
3. Assurance 如何从全局 block 改为声明级；
4. No Dead-End 如何工作；
5. 26 张模型卡是否通过；
6. ARCOS 回归是否通过；
7. 中文输出如何落实；
8. 是否修改任何兄弟能力；
9. 当前非目标。
