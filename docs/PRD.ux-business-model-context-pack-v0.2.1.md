# PRD 增量：UX Business Model Context Pack v0.2.1

- **基线版本**：Business Modeling Core v0.2 reviewed
- **增量状态**：implementation-ready addendum
- **新增核心能力**：`ux-business-model-context` 下游派生视图
- **主要语言**：简体中文；稳定 ID、文件名和枚举使用英文

## 1. 一句话

在业务模型 Core 中正式定义 `UX Business Model Context Pack`，让 UX / Design Engineering 可以轻量读取业务模型语义，发现业务模型缺口候选和 confirmed 冲突候选，而不需要全量读取或阻断设计启动。

## 2. 背景

Business Modeling Core v0.2 reviewed 已经定义了 `ux-design-engineering-view.md`，用于表达业务模型变化对 UX 的影响。但 UX 在启动设计任务时仍缺少一个稳定、轻量、可低成本读取的业务语义输入。

如果 UX 每次启动都全量读取业务模型核心资产，流程会变重；如果完全不读取业务模型，又容易在页面、CTA、状态和权限表达中静默创造或违反业务语义。

## 3. 目标

本增量必须实现：

```text
1. 定义 `ux-business-model-context.md` 与 `.yml`；
2. 明确它是 downstream view，不是 source of truth；
3. 明确由 `downstream-view-compiler` 生成；
4. 支持 UX 启动时轻量读取；
5. UX 缺失上下文时不阻断启动；
6. UX 只提示两类问题：business_model_gap_candidate 与 business_model_conflict_candidate；
7. 不引入复杂语义差异分层；
8. 未解决高影响缺口或冲突不得被 sealed 为 confirmed UX 行为。
```

## 4. 非目标

本增量不实现：

```text
复杂文案别名系统
语义差异五级分层
UX 自动确认业务模型
业务模型直接修改 docs/design/
自动同步 Design Engineering STATE.md
CLI / Hook / Plugin / 外部依赖
```

## 5. 文件增量

新增：

```text
core/product-design/business-modeling/protocols/ux-business-model-context-pack.md
core/product-design/business-modeling/assets/ux-business-model-context.template.md
core/product-design/business-modeling/assets/ux-business-model-context.template.yml
templates/project/docs/product/business-modeling/downstream-views/ux-business-model-context.md
templates/project/docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

更新：

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/capability.manifest.yml
core/product-design/business-modeling/protocols/downstream-view-compilation.md
core/product-design/business-modeling/protocols/ux-design-engineering-compatibility.md
docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.md
README.zh-CN.md
CHANGELOG.md
```

## 6. 上下文包内容

上下文包应包含：

```text
Consumption Policy
Generated From
Business Objects for UX
UX-Relevant Actions
UX-Relevant States
UX-Relevant Rules and Permissions
Open Model Triggers Affecting UX
When UX Should Create a Model Trigger
When UX Should Not Create a Model Trigger
Open Gaps
```

## 7. UX 触发规则

UX 只产生两类候选信号：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

映射到业务模型 Trigger：

```text
business_model_gap_candidate      → trigger_type: downstream_gap
business_model_conflict_candidate → trigger_type: cross_cluster_conflict
```

## 8. 完成边界

UX 可以在业务模型缺失时继续低成本探索，但不得把未确认业务能力作为 confirmed 产品行为实现或封存。

如果缺口或冲突影响对象、动作、状态、权限、责任、审计或核心流程，必须创建 Model Trigger 并在 `completion-approval` 前解决或明确降级范围。

## 9. Definition of Done

- [ ] Context Pack 协议存在；
- [ ] Markdown 与 YAML 模板存在；
- [ ] 项目模板包含 Context Pack 占位文件；
- [ ] manifest 声明 Context Pack；
- [ ] 下游编译协议列出 Context Pack；
- [ ] UX 兼容性协议说明 Context Pack 与 `ux-design-engineering-view.md` 的区别；
- [ ] 没有新增复杂语义分层机制；
- [ ] 没有允许业务模型直接修改 `docs/design/`；
- [ ] 没有新增 CLI / Hook / Plugin / 外部依赖。
