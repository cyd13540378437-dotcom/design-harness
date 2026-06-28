# Codex Design Harness 版本差异说明

- **从**：`v0.1.0-alpha` initial PRD
- **到**：`v0.1.0-alpha / visual-workflow revision`
- **用途**：给已经按第一版 PRD 开发过的 `codex-design-harness` 仓库做增量迁移说明。
- **核心判断**：这不是 v0.2，也不是推翻重做；这是 v0.1.0-alpha 内部的一次视觉流程修订。状态架构继续保留，视觉工作流需要重写和补强。

---

## 1. 为什么需要这份差异说明

如果 Codex 已经按照第一版 PRD 开发过仓库，只给新版 PRD 会有几个风险：

1. Codex 可能把新版 PRD 当作从零创建任务，重复生成已有文件；
2. Codex 可能误以为 Work Item / STATE.md / Gate / Steward 的状态模型也被推翻；
3. Codex 可能继续沿用旧版“视觉方向 = 2–3 个抽象方向”的理解；
4. Codex 可能新增不应该新增的 Gate，例如 `palette-approval`、`anti-homogeneity`；
5. Codex 可能漏掉新引入的 `VISUAL_DESIGN.md`、`visual-reference-packs/` 和 3 个新增评测场景；
6. Codex 可能保留旧文档中的表述，导致新旧流程在 README、Skill、Agent、模板、示例中互相冲突。

这份文档的作用是：

```text
告诉 Codex：哪些必须保留，哪些必须修改，哪些必须新增，哪些必须删除或禁止。
```

---

## 2. 版本定位

| 项目 | 第一版 PRD | visual-workflow revision |
|---|---|---|
| 版本名 | `v0.1.0-alpha` | `v0.1.0-alpha / visual-workflow revision` |
| 版本性质 | 初始可执行草案 | 同一 alpha 版本内的视觉流程修订 |
| 是否改变状态架构 | 是，首次定义 | 否，保留状态架构 |
| 是否改变 Gate 枚举 | 首次定义 | 不新增 Gate 枚举 |
| 是否改变视觉流程 | 基础版 | 大幅重写 |
| 是否改变仓库结构 | 基础结构 | 增加视觉模板、参考包、视觉文档和评测 |
| 是否进入 v0.2 | 否 | 否 |

**不要把 visual-workflow revision 写成 v0.2。**

v0.2 仍然留给确定性 `statectl`、Schema 校验、自动索引、状态迁移和更可靠并发冲突检测等能力。

---

## 3. 必须保持不变的核心架构

以下内容是第一版 PRD 中正确且仍然有效的核心，不要推翻，不要重命名，不要重设语义。

### 3.1 核心概念保持不变

```text
Thread 是临时对话现场
Work Item 是任务身份
STATE.md 是 Work Item 的权威状态快照
WORK_ITEMS.md 是导航索引，不是权威来源
Gate 是人的控制点
Skill 是流程编排器
Steward 是状态管理员
用户拥有最终关闭权
```

### 3.2 状态解析结果保持不变

`design_state_steward` 只能返回以下五种状态解析结果：

```text
CREATE
RESUME
SUCCESSOR
NO_STATE
AMBIGUOUS
```

不得新增：

```text
MIGRATE
REOPEN
FORK
ARCHIVE
UPDATE_ONLY
```

### 3.3 状态字段枚举保持不变

`status` 仍然是：

```text
active
paused
completed
cancelled
```

`phase` 仍然是：

```text
intake
discovery
visual-direction
prototype
ux-flow
implementation
qa
completion-review
complete
```

`gate` 仍然是：

```text
none
work-item-binding
visual-direction-approval
prototype-approval
interaction-decision
completion-approval
```

### 3.4 sealed 规则保持不变

```yaml
status: completed
sealed: true
```

表示 Work Item 已封存。封存状态：

- 不得恢复为 active；
- 不得继续追加新的实现阶段；
- 不得静默改写已批准决定；
- 可以只读引用；
- 相关后续工作必须创建 `SUCCESSOR`。

### 3.5 Steward 职责保持窄边界

`design_state_steward` 仍然只负责：

- 状态解析；
- 创建或更新 `STATE.md`；
- 更新 `WORK_ITEMS.md`；
- 写入 Gate 等待状态；
- 记录用户批准决定；
- closure readiness 检查；
- 用户批准后 seal；
- 修复索引和状态冲突。

它仍然不得：

- 实现业务代码；
- 设计页面；
- 替用户通过 Gate；
- 修改 sealed 状态；
- 把完整聊天写入状态；
- 在 `AMBIGUOUS` 时自行选择。

---

## 4. 本次修订的核心变化

一句话概括：

> 从“让用户批准抽象视觉方向”，改为“让用户确认具体视觉材料：参考图片、配色样张、设计禁区、视觉原型，并沉淀为项目视觉基线”。

旧版视觉阶段偏向：

```text
业务理解
→ 提出 2–3 个明显不同的视觉方向
→ 用户选择
→ 静态原型
→ 实现
```

新版视觉阶段改为：

```text
业务理解与 Visual Seed
→ 参考图片收集与解析
→ 配色方案与 UI 样张
→ 用户确认配色
→ 设计禁区
→ 用户确认设计禁区
→ 视觉原型
→ 用户确认原型
→ 生产实现
→ QA
→ 创建或更新 VISUAL_DESIGN.md
→ completion-approval
→ seal
```

关键变化不是“多加几个步骤”，而是改变用户参与方式：

```text
减少抽象表述输入
增加图片和样张输入
让 Agent 先解析和生成
让用户确认具体产物
```

---

## 5. 视觉流程变化明细

### 5.1 删除或降级的内容

新版不再要求用户填写：

- 产品人格；
- 品牌人格；
- 品牌气质矩阵；
- 理性 / 感性；
- 专业 / 亲和；
- 克制 / 表现力；
- 工具感 / 内容感；
- 用户感受目标必填表。

这些词可以作为 Agent 内部分析语言，但不能成为用户必须回答的问题。

### 5.2 新增 Visual Seed

`Visual Seed` 是用户对视觉方向的原始输入。

它可以是：

- 一个词；
- 一句话；
- 一段描述；
- 参考产品名；
- 空。

要求：

- 只记录用户原文；
- 不强制归纳成产品人格；
- 不作为完整视觉策略；
- 后续以参考图片、配色、设计禁区和原型来具体化。

### 5.3 新增参考图片流程

输入来源优先级：

1. 用户在对话中上传的参考图片；
2. 用户放入项目 `docs/design/reference-images/` 的图片；
3. 项目已有 `VISUAL_DESIGN.md` 中记录的参考；
4. 本仓库内置的 `visual-reference-packs/`；
5. 只有文字时，使用 Visual Seed 生成候选。

解析规则：

- 只描述可观察视觉特征；
- 不把图片归纳成抽象人格；
- 不复制第三方品牌资产；
- 不要求用户解释每张图喜欢什么，Agent 先给理解；
- 明确区分“可借鉴”和“不应复制”。

### 5.4 新增配色确认子检查点

配色必须在完整视觉设计之前确认。

配色方案必须包含用户可理解的三级结构：

```text
主色：主要按钮、关键状态、当前选中项
次色：辅助强调、标签、次级操作
末级强调色：轻量装饰、局部提示、低优先级视觉变化
```

同时要包含实现所需基础 token：

```text
背景、文字、边框、语义色
```

每套配色都必须配一个小型 UI 样张，不得只给色值。

**重要：配色确认不新增 Gate enum。**

它属于：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文检查点写：

```text
视觉子步骤：palette-selection
```

### 5.5 新增设计禁区确认子检查点

设计禁区在配色确认后生成。

来源包括：

- 产品上下文；
- Visual Seed；
- 参考图片解析；
- 已确认配色；
- 项目已有 `VISUAL_DESIGN.md`；
- 常见模板化风险。

设计禁区必须简短、可执行，建议 4–8 条。

**重要：设计禁区确认也不新增 Gate enum。**

它同样属于：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文检查点写：

```text
视觉子步骤：design-exclusions
```

### 5.6 原型阶段改为视觉原型

视觉原型必须体现：

- 页面结构；
- 信息层级；
- 内容密度；
- 核心组件；
- 已确认配色；
- 已确认设计禁区；
- 关键响应式表现；
- 空、加载、错误等状态之一。

原型数量规则更新为：

- 视觉输入清晰：输出 1 个主方案；
- 参考图冲突或用户不确定：输出 2 个方案；
- 用户完全没有参考图且未选择参考包：输出 2–3 个方向；
- 不得输出只有颜色或圆角差异的伪方案。

这替代旧版“Full Mode 固定提出 2–3 个视觉方向”的表达。

---

## 6. 新增项目级视觉基线：`VISUAL_DESIGN.md`

新增文件：

```text
docs/design/VISUAL_DESIGN.md
```

它不是 Work Item 状态文件，也不替代 `STATE.md`。

职责区别：

| 文件 | 职责 |
|---|---|
| `STATE.md` | 单个 Work Item 的权威状态、Gate、验收、批准决定和证据 |
| `VISUAL_DESIGN.md` | 项目级长期复用的视觉基线 |
| `WORK_ITEMS.md` | Work Item 导航索引 |

`VISUAL_DESIGN.md` 必须只记录已确认视觉结果，不记录未批准实验方案。

后续 Work Item 必须先读取它。若后续任务改变视觉基线，必须在对应 `STATE.md` 中说明原因，并更新 `VISUAL_DESIGN.md`。

---

## 7. 仓库结构变化

### 7.1 新增文件和目录

必须新增：

```text
skills/design-engineering/assets/VISUAL_DESIGN.template.md
skills/design-engineering/assets/visual-reference-packs/
skills/design-engineering/references/visual-workflow.md
templates/project/docs/design/VISUAL_DESIGN.md
templates/project/docs/design/reference-images/.gitkeep
examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md
examples/idea-storm-lab/docs/design/reference-images/README.md
evals/scenarios/08-visual-seed-reference-palette.md
evals/scenarios/09-no-product-personality-taxonomy.md
evals/scenarios/10-visual-design-document.md
```

### 7.2 视觉参考包目录

必须创建：

```text
skills/design-engineering/assets/visual-reference-packs/
├── README.md
├── reference-index.md
├── clean-minimal-product/
│   ├── 01-overview.svg
│   ├── 02-components.svg
│   └── notes.md
├── dense-operator-console/
│   ├── 01-dashboard.svg
│   ├── 02-data-table.svg
│   └── notes.md
├── warm-creator-tool/
│   ├── 01-home.svg
│   ├── 02-editor.svg
│   └── notes.md
├── editorial-content-system/
│   ├── 01-landing.svg
│   ├── 02-content-flow.svg
│   └── notes.md
└── playful-consumer-app/
    ├── 01-mobile.svg
    ├── 02-empty-state.svg
    └── notes.md
```

要求：

- 使用自制 SVG 或 PNG；
- 不使用第三方产品截图；
- 不使用真实品牌 Logo；
- 每个包的 `notes.md` 说明适用场景、可借鉴特征和避免事项。

---

## 8. 需要修改的既有文件

### 8.1 `docs/PRD.md`

应替换或更新为 visual-workflow revision。

如果仓库中需要保留旧版 PRD，必须放到归档目录，例如：

```text
docs/archive/PRD-v0.1.0-alpha-initial.md
```

但当前生效版本必须只有一个：

```text
docs/PRD.md
```

### 8.2 `README.zh-CN.md`

必须增加：

- `VISUAL_DESIGN.md` 与 `STATE.md` 的区别；
- 新视觉流程：Visual Seed → Reference Images → Palette → Design Exclusions → Prototype；
- 如何上传或放置参考图片；
- 如何使用内置视觉参考包；
- 配色确认和设计禁区确认是 `visual-direction-approval` 下的子检查点；
- 后续任务如何读取视觉基线；
- 不要求用户填写产品人格。

### 8.3 `README.md`

英文版也要同步核心概念，不能只链接中文版。

### 8.4 `skills/design-engineering/SKILL.md`

必须更新：

- frontmatter description；
- Full Mode 视觉阶段；
- Steward 调用时机；
- 视觉子检查点写状态要求；
- `VISUAL_DESIGN.md` 读取和更新要求；
- 明确禁止产品人格必填流程；
- 明确禁止新增 `palette-approval` 或 `anti-homogeneity` Gate。

### 8.5 `skills/design-engineering/agents/openai.yaml`

更新展示描述和默认 prompt，让其包含：

```text
视觉参考解析、配色确认、设计禁区确认、原型、实现、验证和关闭确认
```

不得声明不存在的 MCP 依赖。

### 8.6 `agents/design-state-steward.toml`

需要补充 Steward 处理视觉子检查点的状态职责：

- 在 `palette-selection` 前写入等待状态；
- 在用户确认配色后记录批准决定；
- 在 `design-exclusions` 前写入等待状态；
- 在用户确认禁区后记录批准决定；
- closure readiness 中检查 `VISUAL_DESIGN.md` 是否已创建或更新，或说明无需更新的理由。

但 Steward 仍然不得设计页面或选择配色。

### 8.7 `STATE.template.md`

正文新增：

```markdown
## 视觉设计上下文
### Visual Seed
### 参考图片与解析
### 已确认配色
### 已确认设计禁区
### 视觉原型摘要
```

YAML frontmatter 不需要新增状态枚举。

### 8.8 `WORK_ITEMS.template.md`

通常无需大改，但示例和说明要保持：

- 它只是索引；
- `STATE.md` 仍然是权威来源；
- 示例中的 gate/phase 要与视觉子检查点一致。

### 8.9 `examples/idea-storm-lab/`

必须更新：

- 增加 `VISUAL_DESIGN.md`；
- 增加 `reference-images/README.md`；
- DE-001 的 `STATE.md` 要展示视觉流程已完成，包括 Visual Seed、参考解析、配色、设计禁区、原型和视觉文档更新；
- DE-002 作为 Successor，必须体现它读取并遵守 `VISUAL_DESIGN.md`；
- sealed 的 DE-001 不得被重新激活。

### 8.10 `evals/scenarios/`

从 7 个场景扩展为 10 个场景。

新增：

```text
08-visual-seed-reference-palette.md
09-no-product-personality-taxonomy.md
10-visual-design-document.md
```

---

## 9. 不应该做的事情

本次迁移不得：

- 把版本号改成 v0.2；
- 推翻 Work Item / STATE.md / Gate / Steward 架构；
- 新增 `palette-approval` Gate；
- 新增 `anti-homogeneity` Gate；
- 要求用户填写产品人格或品牌气质矩阵；
- 把“用户感受目标”做成必填表单；
- 打包第三方产品截图；
- 打包真实品牌 Logo；
- 引入 UI 组件库依赖；
- 引入 CLI、Hook、Plugin、statectl 或自动安装器；
- 让 Steward 参与页面设计或代码实现；
- 修改 sealed 状态；
- 保留与新版流程冲突的旧版“固定 2–3 个视觉方向”表述。

---

## 10. 冲突处理规则

如果文件之间存在冲突，按以下优先级处理：

```text
用户当前明确要求
> docs/PRD.md visual-workflow revision
> 本版本差异说明
> 增量开发说明
> 现有仓库实现
> 旧版 CODEX_BUILD_BRIEF.md
> 旧版 README 或示例
```

特别注意：旧版 `CODEX_BUILD_BRIEF.md` 若仍在仓库中，只能作为历史参考，不得作为当前实现依据。

建议将旧版开工单归档或在文件顶部标记：

```text
Deprecated: use CODEX_INCREMENTAL_BUILD_BRIEF_visual_workflow.md instead.
```

---

## 11. 迁移检查清单

Codex 完成后，至少检查这些问题。

### 11.1 结构检查

- [ ] `VISUAL_DESIGN.template.md` 存在；
- [ ] `templates/project/docs/design/VISUAL_DESIGN.md` 存在；
- [ ] `templates/project/docs/design/reference-images/.gitkeep` 存在；
- [ ] `visual-reference-packs/` 下 5 个参考包完整；
- [ ] `visual-workflow.md` 存在；
- [ ] `examples/idea-storm-lab/docs/design/VISUAL_DESIGN.md` 存在；
- [ ] 评测场景共有 10 个。

### 11.2 术语检查

- [ ] `Visual Seed` 只作为原始视觉输入；
- [ ] `VISUAL_DESIGN.md` 被解释为项目视觉基线；
- [ ] `STATE.md` 仍然是 Work Item 权威状态；
- [ ] `WORK_ITEMS.md` 仍然只是索引；
- [ ] `palette-selection` 和 `design-exclusions` 被描述为视觉子步骤，不是 Gate enum。

### 11.3 禁止项检查

可用 grep 检查旧表达是否残留。允许在“禁止事项”语境下出现，但不得作为正向流程要求出现。

```bash
grep -R "产品人格\|品牌气质\|用户感受目标\|anti-homogeneity\|palette-approval" .
```

检查目标：

- 这些词不得出现在要求用户填写的正向流程中；
- `palette-approval` 不得出现在 Gate 枚举中；
- `anti-homogeneity` 不得作为 Gate 或正式状态出现。

### 11.4 示例检查

- [ ] “检查项目上下文”仍然是 `NO_STATE`；
- [ ] “优化前端样式”仍然是 `CREATE DE-001` 并封存；
- [ ] DE-001 展示新版视觉流程；
- [ ] “统一内容模块问题长度换行”仍然是 `SUCCESSOR DE-002`；
- [ ] DE-002 读取并遵守 `VISUAL_DESIGN.md`；
- [ ] DE-001 sealed 后没有被重新激活。

---

## 12. 推荐迁移顺序

建议 Codex 按以下顺序做增量迁移：

```text
1. 审计现有仓库结构和旧版实现
2. 确认当前生效 PRD 为 visual-workflow revision
3. 更新术语文档和 README
4. 更新 STATE / WORK_ITEMS / VISUAL_DESIGN 模板
5. 新增 visual-workflow.md
6. 新增 visual-reference-packs/
7. 更新 Skill 和 openai.yaml
8. 更新 Steward TOML
9. 更新 idea-storm-lab 示例
10. 新增 3 个评测场景，总数变为 10
11. 运行一致性检查
12. 输出最终变更摘要和未实现能力
```

迁移时不要先删除已有仓库再重建。应优先保留仍符合新版 PRD 的核心状态文件和文档，再按差异修补。
