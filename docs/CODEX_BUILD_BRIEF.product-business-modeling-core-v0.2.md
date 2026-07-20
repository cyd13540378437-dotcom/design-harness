# Historical Brief Notice

This is the original v0.2 build brief. For Codex implementation of the complete v0.2.1 package, use:

```text
docs/CODEX_BUILD_BRIEF.product-business-modeling-core-v0.2.1-complete.md
```

The content below is retained as historical baseline.

---

# Codex 开工单：实现 DesignHarnessAgent Business Modeling Core v0.2

请在当前 Git 仓库中实现 `docs/PRD.product-business-modeling-v0.2.md` 定义的 **DesignHarnessAgent Business Modeling Core v0.2**。

## 工作方式

1. 先阅读 `docs/PRD.product-business-modeling-v0.2.md`；
2. 再阅读 `core/product-design/business-modeling/CAPABILITY.md`；
3. 再阅读 `core/product-design/business-modeling/references/subcapability-work-logic-v0.2.md`；
4. 再阅读 `core/product-design/business-modeling/protocols/ux-design-engineering-compatibility.md`；
5. 如果当前仓库已存在 Design Engineering Harness / `docs/design/`，先盘点但不要修改既有 UX 资产；
6. 先输出简短实施计划，但不要复述 PRD；
7. 按 Milestone 顺序创建文件；
8. 每完成一个 Milestone，交叉检查路径、术语、枚举、Source of Truth、UX 兼容性和示例一致性；
9. 最终对照 Definition of Done 自检。

## 严格范围

必须创建完整文档型 Core 包，但不要实现：

- CLI；
- Hook；
- Plugin；
- Marketplace；
- 自动安装器；
- 外部运行时依赖；
- 自动数据库迁移；
- 自动 API 生成；
- 图形化控制台；
- 云端同步；
- 多用户并发锁。

## 关键约束

- Business Modeling 是 Agent-neutral Core，不是 Codex 专属 Skill；
- 项目业务模型资产放在 `docs/product/business-modeling/`；
- 业务模型阶段只有业务属性，没有数据字段；
- `schema-view.json` 只表达对象、领域、分类、业务属性和示例内容；
- `model-requests/` 不得出现，应使用 `model-triggers/`；
- 被动触发必须生成或关联 `MODEL_IMPACT_REPORT.md`；
- AI 可以生成 draft / provisional，但不能自动确认高影响语义，不能自行 sealed；
- 下游视图是派生视图，不能反向成为核心模型 source of truth；
- 项目解析结果默认是候选，不得自动 confirmed。
- 如果仓库已有 `docs/design/`、`REFERENCE_SELECTION.md`、Reference Library 或 Color Card Registry，不得删除、迁移、重命名或静默修改；
- 业务模型影响 UX 时，只能写 `MODEL_IMPACT_REPORT.md`、`downstream-views/ux-design-engineering-view.md` 和 Follow-up Trigger / Successor 建议；
- 不得由 Business Modeling Core 直接修改 sealed 的 DE Work Item 或 UX `STATE.md`；

## 必须交付

- `core/product-design/business-modeling/CAPABILITY.md`；
- `core/product-design/business-modeling/capability.manifest.yml`；
- `core/product-design/business-modeling/assets/` 模板；
- `core/product-design/business-modeling/protocols/` 协议说明；
- `core/product-design/business-modeling/references/` 参考说明；
- `templates/project/docs/product/` 项目模板；
- `adapters/codex/`、`adapters/claude-code/`、`adapters/cursor/` 规则片段；
- `examples/product-business-modeling/` 示例；
- `evals/product-business-modeling/scenarios/` 14 个评测；
- `docs/PRD.product-business-modeling-v0.2.md`；
- `docs/product-summary.business-modeling-core-v0.2.md`。

## 最终回复请说明

1. 创建或修改了哪些核心文件；
2. Core / Adapter / Project Assets 如何分层；
3. 六种入口模式是否已覆盖；
4. Human Decision Control Plane 如何防止高影响语义自动 confirmed；
5. Passive Trigger 如何处理上游变化、下游缺口和横向冲突；
6. `schema-view.json` 边界如何被模板和评测保护；
7. 14 个评测是否全部满足；
8. 是否影响既有 UX / Design Engineering Harness，以及哪些影响点通过派生视图或 Follow-up Trigger 表达；
9. 当前明确未实现的 v0.3+ 或非目标能力。


## v0.2.1 UX Context Addendum

If this pack is used, also implement `docs/PRD.ux-business-model-context-pack-v0.2.1.md`.

Important:

- Generate `ux-business-model-context.md` and `ux-business-model-context.yml` as downstream views.
- Treat them as lightweight UX inputs, not source of truth.
- UX startup must not be blocked if they are missing.
- UX may only report `business_model_gap_candidate` and `business_model_conflict_candidate`.
- Do not implement a complex semantic discrepancy taxonomy in this increment.

---

## v0.2.1 UX Context Pack 增量

在实现 reviewed v0.2 后，继续实现 `docs/PRD.ux-business-model-context-pack-v0.2.1.md`。

新增 `ux-business-model-context.md/yml` 作为 Business Modeling 的下游派生视图。它供 UX 启动时轻量读取，缺失不阻断 UX。不得因此修改 `docs/design/`、Reference Library 或 Color Card Registry。

新增评测 15–20，覆盖 UX Context Pack 派生视图、无数据字段、缺口候选、冲突候选、缺失不阻断和 sealed UX 只读边界。
