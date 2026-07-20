# Package Manifest — Product Business Modeling Core v0.2.1 Complete

本文件说明当前压缩包包含的完整业务模型开发内容。它用于避免将本包误认为 UX Context Bridge 增量包。

## 1. 包定位

```text
Package: DesignHarnessAgent Product Business Modeling Codex Dev Pack
Version: v0.2.1
Capability ID: product-business-modeling
Nature: complete Business Modeling Core development pack
```

本包包含完整业务模型 Core，并合入 UX Business Model Context Pack。

## 2. 顶层结构

```text
README.md
README.zh-CN.md
CODEX_START_HERE.md
AGENTS.md
CHANGELOG.md
core/product-design/business-modeling/
adapters/
templates/project/docs/product/
examples/product-business-modeling/
evals/product-business-modeling/
docs/
```

## 3. Core 本体

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/capability.manifest.yml
core/product-design/business-modeling/assets/
core/product-design/business-modeling/protocols/
core/product-design/business-modeling/references/
```

Core 覆盖：

```text
业务属性规则
schema-view 边界
六种入口模式
14 个子能力
Human Decision Control Plane
Passive Trigger Interface
Source of Truth 写入所有权
Downstream View Compilation
UX Design Engineering 兼容性
UX Business Model Context Pack
```

## 4. 项目模板

```text
templates/project/docs/product/PRODUCT_WORK_ITEMS.md
templates/project/docs/product/model-triggers/
templates/project/docs/product/business-modeling/
templates/project/docs/product/work-items/
```

其中业务模型长期资产包含：

```text
BUSINESS_MODEL_INDEX.md/yml
business-dictionary.md/yml
schema-view.json/md
domain-objects/
relationships/
actions/
states/
rules/
roadmap/
risks/
downstream-views/
```

Downstream views 包含：

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

## 5. Adapter 片段

```text
adapters/codex/AGENTS.fragment.md
adapters/codex/business-modeling.prompt.md
adapters/claude-code/CLAUDE.fragment.md
adapters/cursor/rules.fragment.md
```

Adapter 只是运行时包装，不是业务模型 source of truth。

## 6. 示例

```text
examples/product-business-modeling/
```

示例使用 Seat-based pricing passive trigger，覆盖：

```text
MT-001
BM-001 STATE.md
MODEL_IMPACT_REPORT.md
DECISION_NOTES.md
```

## 7. 评测

```text
evals/product-business-modeling/scenarios/01-*.md ... 20-*.md
```

20 个场景覆盖核心业务模型、Human Decision、Passive Trigger、schema-view、下游字段边界、UX Context Pack 和 sealed UX 保护。

## 8. Codex 开发主入口

```text
CODEX_START_HERE.md
docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md
docs/PRD.product-business-modeling-v0.2.1.md
```

不要把 `designharnessagent-ux-business-model-context-bridge-v0.1.3.zip` 当成完整业务模型开发包。那个是双侧桥接增量包；本包才是完整业务模型 Core 开发包。
