# Codex 开工单：实现 UX Business Model Context Pack v0.2.1 增量

请在现有 DesignHarnessAgent Business Modeling Core v0.2 reviewed 基础上，实现 `docs/PRD.ux-business-model-context-pack-v0.2.1.md` 定义的增量。

## 工作方式

1. 先阅读 Business Modeling v0.2 reviewed 的 `CAPABILITY.md`、`passive-trigger-interface.md`、`downstream-view-compilation.md` 和 `ux-design-engineering-compatibility.md`。
2. 再阅读本增量 PRD。
3. 保持 Core / Adapter / Project Assets 分层不变。
4. 不要改变业务模型 source of truth 的写入权。
5. 不要修改或迁移既有 `docs/design/` 资产。

## 必须新增

```text
core/product-design/business-modeling/protocols/ux-business-model-context-pack.md
core/product-design/business-modeling/assets/ux-business-model-context.template.md
core/product-design/business-modeling/assets/ux-business-model-context.template.yml
templates/project/docs/product/business-modeling/downstream-views/ux-business-model-context.md
templates/project/docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

## 必须更新

```text
core/product-design/business-modeling/CAPABILITY.md
core/product-design/business-modeling/capability.manifest.yml
core/product-design/business-modeling/protocols/downstream-view-compilation.md
core/product-design/business-modeling/protocols/ux-design-engineering-compatibility.md
README.zh-CN.md
CHANGELOG.md
```

## 核心规则

- `ux-business-model-context.*` 是下游派生视图，不是 source of truth。
- 它由 `downstream-view-compiler` 从业务模型核心资产生成。
- UX 启动时可轻量读取；缺失时不阻断 UX。
- UX 只提示两类 candidate：`business_model_gap_candidate` 和 `business_model_conflict_candidate`。
- 不引入复杂语义差异分层、文案别名系统或产品表达治理。
- 未解决高影响业务模型缺口或 confirmed 冲突不得被 UX sealed 为 confirmed 行为。
- 业务模型 Core 仍不得直接写 `docs/design/**`。

## 最终回复请说明

1. 创建或修改了哪些文件；
2. Context Pack 与 `ux-design-engineering-view.md` 的区别；
3. UX 如何消费该包；
4. 缺口和冲突如何映射到 Model Trigger；
5. 为什么这不会阻断 UX 启动；
6. 为什么没有实现复杂语义差异分层；
7. 自检结果。
