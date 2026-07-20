# UX / Design Engineering 兼容性协议

## 1. 目的

本协议说明 `product-business-modeling` 与已经完成的 Design Engineering Harness / UX 设计工程体系之间的边界。

业务模型是上游或横向的产品语义能力；Design Engineering Harness 是 UI/UX 设计工程执行体系。业务模型变化可能影响 UX，但业务模型能力不得直接接管、覆盖或迁移既有 UX Work Item。

## 2. 既有 UX 体系保持不变

如果目标项目中已经存在以下资产，它们仍由 Design Engineering Harness 维护：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/DE-xxx/STATE.md
docs/design/work-items/DE-xxx/REFERENCE_SELECTION.md
docs/design/reference-library/
docs/design/reference-library/assets/color-cards/
```

这些资产继续遵守既有规则：

- Thread 不等于 Work Item；
- 每个 UI/UX Work Item 最多一个权威 `STATE.md`；
- `WORK_ITEMS.md` 只是索引；
- `completed + sealed` 的 DE Work Item 只读，不得恢复执行；
- 视觉方向、原型、关键交互和完成封存仍通过既有 Gate；
- Reference Library 仍是长期视觉参考资料层；
- `REFERENCE_SELECTION.md` 仍是单个 UX Work Item 的参考消费记录；
- Color Card Registry 仍以 `palette-index.yml` 为 source of truth。

## 3. 业务模型能力不得直接写入的 UX 资产

Business Modeling Core 默认只写：

```text
docs/product/business-modeling/
docs/product/model-triggers/
docs/product/work-items/
```

它不得直接修改：

```text
docs/design/WORK_ITEMS.md
docs/design/work-items/*/STATE.md
docs/design/work-items/*/REFERENCE_SELECTION.md
docs/design/reference-library/**
docs/design/reference-library/assets/color-cards/**
```

如果业务模型变化影响 UX，正确做法是输出 `ux-design-engineering-view.md`、在 `MODEL_IMPACT_REPORT.md` 中列出 UX 影响，并创建后续 Trigger 或建议由 Design Engineering Harness 创建 Successor Work Item。

## 4. 会影响 UX 的业务模型变化

以下变化必须在影响分析中显式标注 UX 影响：

| 业务模型变化 | 可能影响的 UX 位置 | 正确处理 |
|---|---|---|
| 业务对象身份变化 | 信息架构、对象详情页、列表列、对象命名 | 写入 UX 影响视图；必要时触发产品表达 / UX 后续任务 |
| 对象关系变化 | 页面层级、对象关联展示、创建 / 绑定流程 | 标注受影响流程，不直接改 UX `STATE.md` |
| 业务动作变化 | CTA、菜单、操作权限、确认弹窗 | 在下游视图中列出动作与前置条件 |
| 状态生命周期变化 | 状态标签、空 / 错误 / 禁用态、流程进度 | 编译状态展示建议，保留 confirmed / provisional 标识 |
| 规则权限变化 | 可见性、可操作性、错误提示、审计提示 | 触发 UX / QA 检查，不自行定稿交互 |
| 横向语义冲突 | 文案、按钮命名、流程理解 | 创建 `cross_cluster_conflict`，必要时请求人类决策 |

示例：如果业务模型确认“提交”不等于“完成”，而产品表达或 UX 文案曾把两者混用，业务模型应保持动作模型权威，输出影响报告，必要时向产品表达或 Design Engineering Harness 发起后续 Trigger；不得直接改写已封存的 DE Work Item。

## 5. 不应影响 UX 的内容

以下业务模型工作通常不应触碰既有 UX 资产：

- 仅新增低影响业务属性，且不会改变对象展示、流程、权限或状态；
- 仅重编译数据库 / 后端视图；
- 仅整理业务字典中的同义词，且没有改变用户可见语言；
- 内部一致性校验没有发现对页面、流程、文案或视觉方向的影响。

即使无 UX 影响，也建议在 `MODEL_IMPACT_REPORT.md` 中写明 “UX Impact: none observed”。

## 6. `ux-design-engineering-view.md`

当业务模型变化可能影响 UX / Design Engineering 时，下游视图编译器应生成或更新：

```text
docs/product/business-modeling/downstream-views/ux-design-engineering-view.md
```

建议结构：

```markdown
# ux-design-engineering-view.md

## Consumed Model Version

## Confirmed Inputs

## Provisional Inputs

## UX-Relevant Model Changes

## Affected UX Work Items or Areas

## Flow / Page / Component Implications

## State, Permission, and Error-State Implications

## Recommended Design Engineering Response

## Open Gaps

## Potential Follow-up Triggers
```

该视图是派生视图，不是 UX `STATE.md`，也不是 `REFERENCE_SELECTION.md`。



## 6A. `ux-business-model-context.*`

为了避免 UX 每次启动时全量读取业务模型，又避免 UX 在界面中静默发明业务语义，Business Modeling Core 还应生成：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

该上下文包用于 UX 启动、关键交互设计和完成封存前轻量读取。它只回答：

```text
当前有哪些 UX 需要知道的业务对象、动作、状态、规则、权限和 open model triggers。
```

它不是 UX `STATE.md`，不是 `REFERENCE_SELECTION.md`，也不是业务模型 source of truth。

UX 消费该包时只产生两类候选信号：

```text
business_model_gap_candidate
business_model_conflict_candidate
```

其中：

```text
business_model_gap_candidate      → downstream_gap
business_model_conflict_candidate → cross_cluster_conflict
```

Context Pack 缺失不阻断 UX 启动；但未解决的高影响缺口或 confirmed 冲突不得被 UX sealed 为 confirmed 行为。

## 6A. `ux-business-model-context.md/yml`

业务模型应额外提供轻量上下文包：

```text
docs/product/business-modeling/downstream-views/ux-business-model-context.md
docs/product/business-modeling/downstream-views/ux-business-model-context.yml
```

这个包供 UX Work Item 启动时读取。它不用于说明某次变化的影响，而是用于提供当前可消费的业务语义基线。

消费规则：

- 存在则读取；缺失不阻断 UX 启动；
- UX 只记录摘要或链接，不复制完整业务模型；
- UX 只提示 `business_model_gap_candidate` 和 `business_model_conflict_candidate`；
- 只有影响对象、动作、状态、规则、权限、责任、审计或核心流程时，才创建 `MT-xxx.md`；
- 未解决高影响缺口或 confirmed 冲突，不得被 sealed 为 confirmed UX 行为。

---

## 7. 与 Reference Library / Color Card Registry 的关系

业务模型变化通常不会直接改变视觉参考库或色卡注册表。

只有当业务语义变化导致产品定位、目标终端、用户成熟度、业务情绪或品牌语义发生变化时，才可能建议 Design Engineering Harness 重新执行 Surface Resolution、Reference Selection 或 Color Direction。即便如此，也必须通过 UX Work Item 或 Successor 表达，不得由 Business Modeling Core 直接修改 `reference-library/` 或 `palette-index.yml`。

## 8. Codex 执行要求

当 Codex 在已有 Design Engineering Harness 仓库中落地 Business Modeling Core 时，必须：

1. 先检查是否存在 `docs/design/`；
2. 若存在，不删除、不迁移、不改名、不重排既有 UX 资产；
3. 将业务模型资产新增到 `docs/product/`；
4. 如果业务模型影响 UX，只写 `MODEL_IMPACT_REPORT.md` 和 `ux-design-engineering-view.md`；
5. 对 sealed 的 DE Work Item 只读引用；
6. 需要 UX 后续工作时，通过 Design Engineering Harness 的状态解析创建 Successor，而不是直接修改旧状态；
7. 最终回复必须说明是否影响 UX，以及是否创建了 UX follow-up 建议。

## 9. 最小兼容性评测

### 9.1 不破坏既有 UX 资产

Given: 项目已有 `docs/design/work-items/DE-001/STATE.md` 且 `sealed: true`。  
When: Codex 添加 Business Modeling Core。  
Then: 不修改 DE-001；业务模型资产只写入 `docs/product/`。

### 9.2 业务模型变化触发 UX 影响但不直接改 UX

Given: 业务模型确认“提交”和“完成”是不同动作。  
When: 发现 UX 文案把“提交”写成“完成”。  
Then: 创建 `cross_cluster_conflict` 或 Follow-up Trigger，生成 `ux-design-engineering-view.md`，不得直接改 `docs/design/work-items/*/STATE.md`。

### 9.3 视觉参考库不被业务模型静默修改

Given: 项目已有 `reference-library/` 和 Color Card Registry。  
When: 业务模型新增对象或状态。  
Then: 不修改 reference-library 或 palette-index；如需重新选择视觉方向，建议创建 Design Engineering Successor。
