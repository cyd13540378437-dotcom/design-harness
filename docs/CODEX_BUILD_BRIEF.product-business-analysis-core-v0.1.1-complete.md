# Codex 开工单：实现 Product Business Analysis Core v0.1.1 Complete

请在当前 **DesignHarnessAgent Git 仓库**中，把本包定义的 `product-business-analysis` 实现为一个新的、完全独立的兄弟能力。

## 0. 阅读顺序

1. `CODEX_START_HERE.md`
2. `docs/PRD.product-business-analysis-v0.1.1.md`
3. `docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.1.md`
4. `core/product-design/business-analysis/CAPABILITY.md`
5. `core/product-design/business-analysis/SKILL.md`
6. `core/product-design/business-analysis/capability.manifest.yml`
7. `core/product-design/business-analysis/protocols/standalone-architecture.md`
8. `core/product-design/business-analysis/protocols/source-of-truth.md`
9. `core/product-design/business-analysis/protocols/output-contract.md`
10. `core/product-design/business-analysis/protocols/human-decision-control-plane.md`
11. `core/product-design/business-analysis/references/subcapability-work-logic-v0.1.md`
12. `docs/PACKAGE_MANIFEST.product-business-analysis-v0.1.1.md`

## 1. 首要边界

商业分析与业务模型以及所有其他能力是完全独立的模块。

本次实现只新增 Business Analysis。不要把它写成任何能力的上游、下游、前置 Gate、回填器或触发器。

如果当前仓库已经存在任何兄弟能力：

```text
只读盘点路径冲突；
不得删除、迁移、重命名、覆盖或语义修改；
不得导入其协议作为 Business Analysis 的依赖；
不得生成对其的 Trigger、任务、Context Pack 或 Downstream View。
```

## 2. 工作方式

1. 先输出简短实施计划，不复述 PRD；
2. 盘点目标仓库现有目录和同名文件；
3. 将本包文件作为 source bundle 和规范，按路径新增到仓库；
4. 同名 root README / AGENTS / CHANGELOG 只做最小合并，不覆盖原内容；
5. 任何兄弟能力目录保持不变；
6. 按 Milestone 实现；
7. 每个 Milestone 后检查独立性、Source of Truth、路径和示例；
8. 最终执行静态自检和 Definition of Done。

## 2.1 路径碰撞规则

Adapter 和项目规则片段必须使用 namespaced 路径：

```text
adapters/codex/product-business-analysis/
adapters/claude-code/product-business-analysis/
adapters/cursor/product-business-analysis/
templates/project/fragments/product-business-analysis.AGENTS.fragment.md
```

不得覆盖已经存在的通用 `adapters/*/AGENTS.fragment.md`、`CLAUDE.fragment.md`、`rules.fragment.md` 或 `templates/project/AGENTS.fragment.md`。

## 3. 必须创建

```text
core/product-design/business-analysis/**
adapters/codex/product-business-analysis/**
adapters/claude-code/product-business-analysis/**
adapters/cursor/product-business-analysis/**
templates/project/docs/product/business-analysis/**
examples/product-business-analysis/**
evals/product-business-analysis/**
docs/PRD.product-business-analysis-v0.1.1.md
docs/ARCHITECTURE_DECISION.standalone-business-analysis-v0.1.1.md
docs/PACKAGE_MANIFEST.product-business-analysis-v0.1.1.md
docs/CODEX_READINESS_AUDIT.product-business-analysis-core-v0.1.1-complete.md
docs/product-summary.business-analysis-core-v0.1.1.md
```

## 4. 项目模板必须是模块自有结构

```text
templates/project/docs/product/business-analysis/
├── BUSINESS_ANALYSIS_INDEX.md
├── BUSINESS_ANALYSIS_INDEX.yml
├── BUSINESS_ANALYSIS_WORK_ITEMS.md
├── decision-cases/
├── decision-network/
├── evidence/
├── reviews/
└── work-items/
```

禁止创建或依赖：

```text
templates/project/docs/product/work-items/
templates/project/docs/product/model-triggers/
templates/project/docs/product/business-analysis/downstream-views/
```

## 5. Source of Truth 约束

- Decision Case 唯一权威文件：`decision-cases/BA-DC-xxx.md`。
- Work Item 不得包含 `DECISION_CASE.md`。
- Work Item 只包含状态、消费、输出、人类决定、过程包和 artifacts。
- Decision Network 与 Evidence Ledger 的 YML 是机器权威源，MD 是人读视图。

## 6. 架构约束

采用五个运行域：

```text
统筹与路由
核心决策分析
复审、风险与决策记忆
材料接收、项目提取与质量保障
Human Decision Control Plane
```

不要实现 Passive Trigger，不要创建其空文件或占位目录。

## 7. 模型卡约束

- 保留并安装 24 张 ready 卡；
- 每张卡必须有 `schema_version: 1`；
- 每张 ready 卡必须有六个非空 usage prompts；
- index ID、路径、卡内 model_id 一致；
- 不得使用关键词机械路由；
- 数值模型输入不足时必须阻止伪精确。

## 8. Milestones

### Milestone 1：Core 与独立架构

创建 CAPABILITY、SKILL、manifest、协议、references 和 model-card registry。

### Milestone 2：输出物和 Source of Truth

创建全部 assets，确保 Case 与 Work Item 不重复，加入消费、输出和人类决定合同。

### Milestone 3：Project Template

创建模块自有项目根目录，不触碰任何兄弟模板。

### Milestone 4：Adapters

添加 namespaced adapter 文件；不得覆盖现有其他 adapter 文件。

### Milestone 5：Example and Evals

安装完整示例和连续 20 个 Given / When / Then 场景。

### Milestone 6：Root Documentation Merge

在目标仓库 README / README.zh-CN / AGENTS / CHANGELOG 中增加简短链接或条目。只追加，不重写现有产品定义。

### Milestone 7：Self-check

检查 YAML、路径、模型卡 prompts、单一权威、独立目录、无 Trigger、无 downstream views、无 sibling changes。

## 9. Definition of Done

- Business Analysis 可在不存在任何兄弟能力时独立运行；
- 若兄弟能力存在，全部保持原样；
- Core / Adapter / Project Assets 三层完整；
- 五个运行域完整，Passive Trigger 不存在；
- Decision Case 16 字段完整；
- 第一输入完整保存；
- Case 单一权威；
- BA Work Item 位于模块根目录；
- Output Contract 文件完整；
- Human Decision Control Plane 完整；
- 24 张 ready 模型卡通过校验；
- 示例一致；
- 20 个评测存在；
- 没有跨模块 Trigger、共享 Work Item 目录、downstream view、CLI、Hook、Plugin、installer 或外部依赖。

## 10. 最终回复

请说明：

1. 新增和最小修改了哪些文件；
2. 如何保证 Business Analysis 完全独立；
3. 为什么使用五个运行域而不是强制六段式；
4. Decision Case 和 Work Item 的 Source of Truth 如何分工；
5. 输出物目录在哪里；
6. 24 张模型卡及 prompts 是否通过校验；
7. 20 个评测是否存在；
8. 是否修改任何兄弟能力；
9. 当前明确未实现的未来集成功能。
