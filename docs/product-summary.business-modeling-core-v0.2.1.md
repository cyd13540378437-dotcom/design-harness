# Product Summary — Business Modeling Core v0.2.1 Complete

Business Modeling Core v0.2.1 是 DesignHarnessAgent 产品设计知识系统中的完整业务模型能力包。

它的职责是把业务世界抽象成统一、稳定、可演进的产品语义模型，让商业分析、产品表达、需求表达、UX、前端、后端、数据库和 QA 在同一套业务语言下协作。

## 本版包含

```text
Agent-neutral Core
Core / Adapter / Project Assets 三层架构
完整业务模型 source of truth
BM Work Item 任务级文件
六种入口模式
14 个子能力模块
Human Decision Control Plane
Passive Trigger Interface
MODEL_IMPACT_REPORT.md
Model Trigger 协议
Downstream View Compilation
UX Design Engineering 兼容性
UX Business Model Context Pack
Codex / Claude Code / Cursor Adapter 片段
示例
20 个评测场景
```

## v0.2.1 关键新增

v0.2.1 把 `UX Business Model Context Pack` 合并进业务模型 Core，作为下游派生视图：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

它让 UX / Design Engineering 启动时可以轻量读取业务语义，而不必全量读取核心业务模型。Context Pack 缺失不阻断 UX 启动。UX 只提示业务模型缺口候选和 confirmed 冲突候选，不自行确认核心业务语义。

## 不做什么

本包不做 CLI、Hook、Plugin、自动安装器、外部运行时依赖、自动数据库迁移、自动 API 生成，也不直接修改既有 UX / Design Engineering 资产。
