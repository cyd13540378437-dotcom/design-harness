# Codex 开工单：实现 Product Business Modeling Core v0.2.1 Complete

请在当前 Git 仓库中实现本包定义的 **DesignHarnessAgent Product Business Modeling Core v0.2.1 Complete**。

这是完整业务模型开发包，不是 UX Context Bridge 增量包。v0.2.1 已经把 `UX Business Model Context Pack` 合并为业务模型的下游派生视图。

---

## 0. 先读这个顺序

1. `CODEX_START_HERE.md`
2. `docs/PRD.product-business-modeling-v0.2.1.md`
3. `core/product-design/business-modeling/CAPABILITY.md`
4. `core/product-design/business-modeling/capability.manifest.yml`
5. `core/product-design/business-modeling/references/subcapability-work-logic-v0.2.md`
6. `core/product-design/business-modeling/protocols/source-of-truth.md`
7. `core/product-design/business-modeling/protocols/passive-trigger-interface.md`
8. `core/product-design/business-modeling/protocols/human-decision-control-plane.md`
9. `core/product-design/business-modeling/protocols/downstream-view-compilation.md`
10. `core/product-design/business-modeling/protocols/ux-business-model-context-pack.md`
11. `core/product-design/business-modeling/protocols/ux-design-engineering-compatibility.md`
12. `docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.1.md`

`docs/PRD.product-business-modeling-v0.2.md` 与 `docs/PRD.ux-business-model-context-pack-v0.2.1.md` 是拆分参考；正式实现以本开工单和 `docs/PRD.product-business-modeling-v0.2.1.md` 为准。

---

## 1. 工作方式

1. 先输出简短实施计划，不要复述 PRD；
2. 检查当前仓库是否已经有 Design Engineering Harness、`docs/design/`、Reference Library 或 Color Card Registry；
3. 如已存在，只读盘点，不得删除、迁移、覆盖或静默修改；
4. 按 Milestone 顺序实现；
5. 每完成一个 Milestone，交叉检查路径、术语、枚举、Source of Truth、UX 兼容性和示例一致性；
6. 最终对照 Definition of Done 自检。

---

## 2. 严格范围

必须创建完整文档型 Business Modeling Core：

```text
core/product-design/business-modeling/
adapters/codex/
adapters/claude-code/
adapters/cursor/
templates/project/docs/product/
examples/product-business-modeling/
evals/product-business-modeling/
docs/
```

不得实现：

```text
CLI
Hook
Plugin
Marketplace
自动安装器
外部运行时依赖
自动数据库迁移
自动 API 生成
图形化控制台
云端同步
多用户并发锁
自动修改 UX / Design Engineering STATE.md
复杂语义差异多级分层
```

---

## 3. 关键约束

- Business Modeling 是 Agent-neutral Core，不是 Codex 专属 Skill；
- 项目业务模型资产放在 `docs/product/business-modeling/`；
- 运行时特定内容只能放在 `adapters/`；
- 业务模型阶段只有业务属性，没有数据字段；
- `schema-view.json` 只表达对象、业务领域、对象分类、业务属性、属性示例内容；
- `model-requests/` 不得出现，应使用 `model-triggers/`；
- 被动触发必须生成或关联 `MODEL_IMPACT_REPORT.md`；
- AI 可以生成 draft / provisional，但不能自动确认 D2 / D3 业务语义，不能自行 sealed；
- 下游视图是派生视图，不能反向成为核心模型 source of truth；
- 项目解析结果默认是候选，不得自动 confirmed；
- `ux-business-model-context.md/yml` 是 Business Modeling 的下游派生视图，不是 UX 侧 patch；
- 如果仓库已有 `docs/design/`、`REFERENCE_SELECTION.md`、Reference Library 或 Color Card Registry，不得删除、迁移、重命名或静默修改；
- 业务模型影响 UX 时，只能写 `MODEL_IMPACT_REPORT.md`、`downstream-views/ux-design-engineering-view.md`、`downstream-views/ux-business-model-context.md/yml` 和 Follow-up Trigger / Successor 建议；
- 不得由 Business Modeling Core 直接修改 sealed 的 DE Work Item 或 UX `STATE.md`。

---

## 4. 必须交付

### Core

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/capability.manifest.yml
core/product-design/business-modeling/assets/*
core/product-design/business-modeling/protocols/*
core/product-design/business-modeling/references/*
```

### Project Templates

```text
templates/project/AGENTS.fragment.md
templates/project/docs/product/PRODUCT_WORK_ITEMS.md
templates/project/docs/product/model-triggers/MT-000.template.md
templates/project/docs/product/business-modeling/**
templates/project/docs/product/work-items/*.template.md
```

必须包含下游视图：

```text
product-expression-view.md
requirements-view.md
database-view.md
backend-view.md
frontend-view.md
qa-view.md
ux-design-engineering-view.md
ux-business-model-context.md
ux-business-model-context.yml
```

### Adapters

```text
adapters/codex/AGENTS.fragment.md
adapters/codex/business-modeling.prompt.md
adapters/claude-code/CLAUDE.fragment.md
adapters/cursor/rules.fragment.md
```

### Examples and Evals

```text
examples/product-business-modeling/**
evals/product-business-modeling/scenarios/01-*.md ... 20-*.md
```

### Docs

```text
docs/PRD.product-business-modeling-v0.2.1.md
docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md
docs/PACKAGE_MANIFEST.product-business-modeling-v0.2.1.md
docs/CODEX_READINESS_AUDIT.product-business-modeling-core-v0.2.1-complete.md
docs/product-summary.business-modeling-core-v0.2.1.md
```

---

## 5. 实施 Milestones

### Milestone 1：Core 骨架与顶层说明

建立 README、AGENTS、CHANGELOG、CAPABILITY、manifest、Start Here 和 docs。

### Milestone 2：协议与模板

完成 assets、protocols、references，尤其是：

```text
source-of-truth.md
entry-modes.md
human-decision-control-plane.md
passive-trigger-interface.md
downstream-view-compilation.md
ux-business-model-context-pack.md
ux-design-engineering-compatibility.md
```

### Milestone 3：目标项目模板

创建 `templates/project/docs/product/` 完整结构，确保业务模型长期资产、Model Trigger、BM Work Item、downstream views 均存在。

### Milestone 4：Adapters

创建 Codex / Claude Code / Cursor 片段。Adapter 不得改写 Core 语义。

### Milestone 5：示例和评测

创建 Seat-based pricing passive trigger 示例和 20 个评测场景。

### Milestone 6：自检

检查：

```text
YAML / JSON 可解析
没有 model-requests/
没有 CLI / Hook / Plugin / Installer
没有外部依赖
没有数据字段进入核心业务模型
schema-view.json 边界正确
UX 兼容边界正确
20 个评测存在且命名连续
```

---

## 6. 最终回复请说明

1. 创建或修改了哪些核心文件；
2. Core / Adapter / Project Assets 如何分层；
3. 六种入口模式是否已覆盖；
4. 14 个子能力是否已覆盖；
5. Human Decision Control Plane 如何防止高影响语义自动 confirmed；
6. Passive Trigger 如何处理上游变化、下游缺口和横向冲突；
7. `schema-view.json` 边界如何被模板和评测保护；
8. UX Business Model Context Pack 如何作为 Business Modeling 下游视图输出；
9. 是否影响既有 UX / Design Engineering Harness；
10. 20 个评测是否全部满足；
11. 当前明确未实现的 v0.3+ 或非目标能力。
