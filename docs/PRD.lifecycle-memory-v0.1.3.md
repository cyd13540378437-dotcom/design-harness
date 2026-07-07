# Codex Design Harness — Project Lifecycle Memory & Artifacts 增量 PRD

- **版本**：v0.1.3-alpha
- **文档状态**：可执行增量 PRD
- **基线版本**：v0.1.2-alpha / Color Card Registry 版
- **产品显示名**：Design Engineering Harness
- **新增核心能力**：Project Lifecycle Memory & Artifacts
- **主要语言**：简体中文；配置字段、状态枚举和文件名使用英文

---

## 1. 产品摘要

v0.1.3 在 v0.1 的 Work Item / `STATE.md` / Gate / Steward 状态化工作流、v0.1.1 的 Reference Library、v0.1.2 的 Color Card Registry 基础上，补齐项目级生命周期记忆和交付物管理能力。

本次增量的核心不是新增一个孤立 Skill，而是把 `docs/design/` 从“任务状态目录”升级为项目设计生产记忆区：

```text
Lifecycle Event ID
        ↓
Work Item + STATE.md
        ↓
Reference Selection / Color Selection / Artifacts
        ↓
Context-bound Final Review
        ↓
outputs/archive + outputs/current
        ↓
project-memory 更新
        ↓
后续 Work Item / Successor / PD → UX 继承
```

一句话：

> designHarness 不只是帮助 Codex 完成一次 UI/UX 任务，而是帮助项目持续沉淀业务决策、设计约束、交付产物、验收证据和后续可继承的上下文。

---

## 2. 背景与问题

v0.1 已经证明了状态化 Work Item、跨 Thread 恢复、Human Gate、完成封存和 Successor 闭环成立。v0.1.1 和 v0.1.2 又分别增强了视觉参考和配色参考的判断依据。

但当前仓库仍存在以下缺口：

1. `docs/design/work-items/` 可以保存任务状态，但项目长期业务记忆仍缺少明确位置；
2. Work Item 产物、最终输出和历史归档缺少统一索引，后续 Agent 很难判断哪个文件是最新、已确认、可作为基线；
3. `STATE.md` 已经承担状态快照职责，但还缺少设计契约、审视视角和产物引用的标准字段；
4. 当前 `DE-001` 这类 ID 能表达设计工程任务，但不足以表示跨角色、跨时间的项目生命周期事件；
5. 产品设计任务，如会员体系、定价模型、功能边界，不一定是 UX 页面任务，但会成为后续 UX、视觉和工程实现的上游约束；
6. “快速修改”和“最终审查”容易被误解成脱离上下文的审美检查，需要明确绑定当前 `STATE.md`、项目记忆和已确认决策。

本次增量要解决这些问题，同时不得破坏 v0.1 / v0.1.1 / v0.1.2 已有能力。

---

## 3. 本次增量目标

v0.1.3 必须实现：

1. 新增项目级 `docs/design/project-memory/` 结构，用于保存跨 Work Item 长期有效的业务、产品、UX、视觉和工程上下文；
2. 新增 `docs/design/outputs/` 结构，用于区分当前交付物、历史归档和产物索引；
3. 新增生命周期事件 ID 规则，支持 `yyyy-mm-dd-hhmm-UX-001` 和 `yyyy-mm-dd-hhmm-PD-001` 形式；
4. 保留并兼容既有 `DE-001` / `DE-002` 示例和状态解析能力，不强制迁移历史 Work Item；
5. 更新 `STATE.template.md`，加入 `event_id`、`domain`、`execution_profile`、`design_contract`、`review_lens`、`artifacts`、`outputs`、`project_memory_updates` 等字段；
6. 定义 Fast Profile：在已有项目中快速完成明确局部任务，轻量读取上下文，不重走完整 Gate，但仍保留状态价值和完成确认；
7. 定义 Context-bound Final Review：最终审查必须基于本次 `STATE.md`、Design Contract、Review Lens、Reference Selection、Color Direction 和项目记忆，不得进行脱离上下文的审美审计；
8. 支持 `PD` 域生命周期事件，用于产品设计任务，如会员体系、定价模型、功能边界、产品策略文档；
9. 支持后续 `UX` Work Item 通过 `predecessors` 继承 `PD` 事件的产品约束；
10. 更新 `design-engineering` Skill，使其在状态恢复、设计、实现、QA 和完成确认时读取并维护 Project Memory 与 Outputs；
11. 更新 `design_state_steward` 的职责说明，使其可以记录项目记忆更新摘要和产物索引，但仍不得承担设计判断、产品决策或业务实现；
12. 更新项目 `AGENTS.fragment.md`，加入 Project Memory、Artifacts、Outputs、Fast Profile 和 Final Review 使用规则；
13. 新增模板、示例和人工评测，证明新生命周期记忆能力不会破坏旧状态模型、Reference Library 和 Color Card Registry。

---

## 4. 强兼容性合同：必须保护的既有能力

本次增量必须遵守以下兼容性合同。任何实现如果破坏这些能力，应视为不符合 v0.1.3。

### 4.1 v0.1 状态模型不得破坏

- 状态解析结果仍然只能是：

```text
CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
```

- `Thread` 仍然不等于 `Work Item`；
- 每个独立 Work Item 最多只有一个权威 `STATE.md`；
- `WORK_ITEMS.md` 仍然只是索引，冲突时以 `STATE.md` 为准；
- `completed + sealed` 仍然不得恢复、不得修改，只能只读引用或创建 Successor；
- `completion-approval` Gate 仍然是封存前的必要 Gate；
- `design_state_steward` 仍然只管理状态，不实现业务代码，不设计页面，不代替用户批准；
- 不得为了项目记忆完整性而自动创建无价值状态；只读探索仍可返回 `NO_STATE`。

### 4.2 v0.1 工作模式不得破坏

v0.1 的 `mode` 枚举保持有效：

```text
full / lightweight / delegated
```

v0.1.3 新增的 Fast Profile 不应强行替代 `lightweight`。推荐持久化方式：

```yaml
mode: "lightweight"
execution_profile: "fast"
```

如果现有实现已经使用 `mode: fast`，本 PRD 要求 Codex 在文档中标明其为兼容别名，但新模板优先使用 `mode: lightweight + execution_profile: fast`，以保护旧模式语义。

### 4.3 v0.1.1 Reference Library 不得破坏

- `reference-library/` 仍然是长期资料层；
- `REFERENCE_SELECTION.md` 仍然是 Work Item 级消费结果；
- `STATE.md` 仍然只保存参考摘要和链接；
- 不得创建 `docs/design/reference-library/reference-packs/`；
- Surface Resolution 仍然在视觉方向前执行；
- 用户仍然只确认业务语义和取舍，不需要理解具体参考产品术语。

### 4.4 v0.1.2 Color Card Registry 不得破坏

- `palette-index.yml` 仍然是色卡机器权威清单；
- `images/`、`palettes/`、`annotations/` 仍然不得存在 orphan 正式资产；
- 只有 `status: ready` 且 `gate_preview: true` 的色卡可进入配色确认；
- 配色确认必须展示大图色卡和业务语义，不得只展示 HEX/RGB 或小 icon；
- Work Item 采用的色卡仍写入 `REFERENCE_SELECTION.md`，`STATE.md` 只写摘要和链接；
- 不得创建 `color-cards/cards/<id>/`。

### 4.5 v0.2+ 非目标仍不得提前实现

本次仍然不实现：

- 自动安装器；
- Codex Plugin；
- Marketplace；
- Hook；
- CLI；
- `statectl` 或状态管理脚本；
- Schema 自动校验器；
- 云端服务；
- 外部运行时依赖；
- 多用户并发锁；
- 自动下载截图；
- 自动 OCR 或视觉识别流水线。

---

## 5. 核心概念

### 5.1 Lifecycle Event

Lifecycle Event 是项目生命周期中的一次可追溯事件。它可以是 UX 设计、产品设计、视觉设计、工程实现、最终审查或交付封存中的一个独立工作单元。

在 v0.1.3 中，Lifecycle Event 通过 Work Item 承载。也就是说：

```text
Lifecycle Event 是项目生命周期语义
Work Item 是执行与验收边界
STATE.md 是该事件的权威状态快照
```

### 5.2 Lifecycle Event ID

新建 Work Item 推荐使用统一生命周期 ID：

```text
yyyy-mm-dd-hhmm-<DOMAIN>-<SEQ>
```

示例：

```text
2026-07-06-1530-UX-001
2026-07-06-1605-PD-001
```

说明：

- `yyyy-mm-dd-hhmm` 使用创建该事件时的项目本地时间或 Codex 会话可获得的本地时间；
- 文件系统中不使用冒号；
- `DOMAIN` 在 v0.1.3 中至少支持 `UX` 和 `PD`；
- `SEQ` 是当天或当前项目上下文中的三位序号；
- 展示层可显示为 `2026-07-06 15:30 UX-001`；
- 旧 `DE-001` 仍是合法 legacy ID，不得被自动重命名。

### 5.3 Domain

`domain` 表示当前生命周期事件的主语义。

v0.1.3 支持：

```text
UX  用户体验 / 界面 / 交互 / 页面与流程设计
PD  产品设计 / 功能边界 / 会员体系 / 定价模型 / 产品策略
```

后续版本可以扩展 `VISUAL`、`ENG`、`RESEARCH`，但 v0.1.3 不要求实现。

### 5.4 Project Memory

Project Memory 是跨 Work Item 长期有效的项目认知，不等于某一次任务状态，也不等于完整聊天记录。

推荐位置：

```text
docs/design/project-memory/
```

它保存：

- 业务背景；
- 产品设计决策；
- UX 设计原则；
- 视觉系统基线；
- 工程约束；
- 长期有效的禁区和风险；
- 已封存事件对项目基线的影响。

### 5.5 Outputs

Outputs 是项目交付物系统，负责区分“当前最新交付物”和“历史归档”。

推荐位置：

```text
docs/design/outputs/
```

它保存：

- 已确认 PRD；
- UX 文稿；
- HTML 原型；
- 截图；
- QA 证据；
- demo 页面；
- 当前最新版本索引；
- 历史事件归档。

### 5.6 Design Contract

Design Contract 是本次 Work Item 必须遵守的设计契约。

它回答：

```text
这次必须保持什么？
这次必须改变什么？
这次明确不能做什么？
哪些产品、视觉、工程约束不可破坏？
```

### 5.7 Review Lens

Review Lens 是最终审查时使用的上下文视角。

它回答：

```text
最终产物应该基于什么问题被判断？
哪些用户目标、业务目标、范围边界和已批准决策最重要？
```

### 5.8 Context-bound Final Review

Context-bound Final Review 是 `design-engineering` 在完成确认前的上下文绑定审查。

它不是通用审美打分，也不是脱离任务的 checklist。它必须基于：

- 当前 `STATE.md`；
- Design Contract；
- Review Lens；
- 已批准 Gate；
- Reference Selection；
- Approved Color Direction；
- Project Memory；
- 实际实现与验证证据。

### 5.9 Fast Profile

Fast Profile 是已有项目中的明确局部任务加速形态。

它适用于：

- 用户明确要求快速优化；
- 范围小且边界清楚；
- 不改变整体视觉方向、信息架构或产品核心语义；
- 项目已有视觉或 UX 基线；
- 可以通过轻量读取 Project Memory 和现有状态建立 Design Contract。

Fast Profile 不是跳过责任。它仍然必须：

- 判断是否需要状态；
- 必要时创建或恢复 Work Item；
- 记录范围和不做什么；
- 记录 Design Contract 和 Review Lens；
- 完成前提供证据；
- 经过 `completion-approval` 后才能 seal。

---

## 6. 目录结构要求

### 6.1 目标业务项目结构增量

v0.1.3 在现有 `docs/design/` 下新增：

```text
product-repository/
└── docs/
    └── design/
        ├── WORK_ITEMS.md
        ├── work-items/
        │   └── 2026-07-06-1530-UX-001-settings-empty-state/
        │       ├── STATE.md
        │       ├── REFERENCE_SELECTION.md
        │       ├── artifacts/
        │       └── review.md
        ├── reference-library/
        ├── project-memory/
        │   ├── README.md
        │   ├── BUSINESS_CONTEXT.md
        │   ├── PRODUCT_DESIGN.md
        │   ├── UX_DESIGN.md
        │   ├── VISUAL_DESIGN.md
        │   ├── ENGINEERING_CONTEXT.md
        │   └── DECISIONS.md
        └── outputs/
            ├── README.md
            ├── index.yml
            ├── current/
            │   ├── index.yml
            │   └── .gitkeep
            └── archive/
                └── 2026-07-06-1530-UX-001/
                    ├── summary.md
                    ├── artifacts.yml
                    ├── screenshots/
                    └── .gitkeep
```

### 6.2 路径原则

- `docs/design/work-items/` 继续保存 Work Item 状态和任务内素材；
- `docs/design/project-memory/` 保存跨任务长期有效的项目记忆；
- `docs/design/outputs/current/` 保存当前最新或被用户确认可作为基线的交付物入口；
- `docs/design/outputs/archive/<event_id>/` 保存某个生命周期事件的历史归档；
- `docs/design/reference-library/` 仍然只保存长期参考资料，不保存 Work Item 专属结果；
- 不在 v0.1.3 中新建 `product-work-items/`，所有 `PD` 和 `UX` 事件统一进入 `docs/design/work-items/`，通过 `domain` 区分。

### 6.3 禁止结构

不得创建：

```text
docs/design/reference-library/reference-packs/
docs/design/reference-library/assets/color-cards/cards/<id>/
docs/design/product-work-items/
outputs/  # 项目根目录 outputs，除非用户现有项目已经采用且明确要求
```

说明：v0.1.3 推荐把设计交付物放在 `docs/design/outputs/`，避免与业务项目自身构建产物、发布产物或测试输出目录冲突。

---

## 7. Lifecycle Event ID 与 legacy ID 兼容规则

### 7.1 新 Work Item ID

新建 v0.1.3 Work Item 时，Codex 应优先生成：

```text
2026-07-06-1530-UX-001-settings-empty-state
2026-07-06-1605-PD-001-membership-system
```

其中目录名由：

```text
<event_id>-<slug>
```

组成。

### 7.2 legacy `DE-xxx` 兼容

已有目录不得自动重命名：

```text
docs/design/work-items/DE-001-optimize-frontend-style/
docs/design/work-items/DE-002-content-module-line-wrap/
```

`design_state_steward` 必须继续能够解析、恢复、引用和 seal legacy `DE-xxx` 状态。

### 7.3 `state_id` 与 `event_id`

v0.1.3 的新状态推荐：

```yaml
state_id: "2026-07-06-1530-UX-001"
event_id: "2026-07-06-1530-UX-001"
domain: "UX"
legacy_ids: []
```

legacy 状态可以保持：

```yaml
state_id: "DE-001"
event_id: ""
domain: "UX"
legacy_ids: []
```

如果 Codex 为 legacy 状态补充 `event_id`，必须先确认该状态未 sealed；sealed 状态不得为了补充字段而修改。

---

## 8. Project Memory 规则

### 8.1 Project Memory 文件

项目模板必须新增：

```text
docs/design/project-memory/README.md
docs/design/project-memory/BUSINESS_CONTEXT.md
docs/design/project-memory/PRODUCT_DESIGN.md
docs/design/project-memory/UX_DESIGN.md
docs/design/project-memory/VISUAL_DESIGN.md
docs/design/project-memory/ENGINEERING_CONTEXT.md
docs/design/project-memory/DECISIONS.md
```

### 8.2 文件职责

| 文件 | 职责 |
|---|---|
| `BUSINESS_CONTEXT.md` | 目标用户、业务目标、市场假设、商业约束、合规边界。 |
| `PRODUCT_DESIGN.md` | 功能边界、套餐/权限、产品策略、核心对象模型、产品决策。 |
| `UX_DESIGN.md` | 用户路径、信息架构、交互原则、空/错/加载状态策略。 |
| `VISUAL_DESIGN.md` | 视觉基线、色彩、字体、组件密度、布局原则、视觉禁区。 |
| `ENGINEERING_CONTEXT.md` | 技术栈、组件复用约束、实现边界、测试与部署注意事项。 |
| `DECISIONS.md` | 跨文件的重要项目决策索引，记录来自哪个 event。 |

### 8.3 更新原则

Project Memory 是“经过压缩的长期上下文”，不得变成完整聊天记录。

Codex 可以在完成 Work Item 后提出 Project Memory 更新建议，但必须遵守：

1. 只沉淀跨任务长期有效的信息；
2. 不记录微小实现步骤；
3. 不复制完整 `STATE.md`、`REFERENCE_SELECTION.md`、palette 或 annotation；
4. 不静默改写与 sealed 状态相冲突的历史决定；
5. 若要修正历史决定，必须创建新的 Work Item 或在 `DECISIONS.md` 中追加 supersedes 关系；
6. 用户未批准关闭 Work Item 时，不得把未确认结果写成项目基线；
7. `project_memory_updates` 应先记录在 `STATE.md`，再写入目标 Project Memory 文件。

### 8.4 Project Memory 更新记录格式

在 `STATE.md` 中记录：

```yaml
project_memory_updates:
  - target: "docs/design/project-memory/PRODUCT_DESIGN.md"
    status: "proposed"
    summary: "记录免费版/专业版/团队版的功能边界。"
    source_event: "2026-07-06-1605-PD-001"
  - target: "docs/design/project-memory/UX_DESIGN.md"
    status: "applied"
    summary: "将升级入口路径作为套餐页 UX 基线。"
    source_event: "2026-07-06-1710-UX-001"
```

`status` 建议值：

```text
none / proposed / applied / skipped
```

这些不是 Work Item 生命周期状态，不得与 v0.1 `status` 枚举混淆。

---

## 9. Outputs 与 Artifact Archive 规则

### 9.1 Outputs 目录

项目模板必须新增：

```text
docs/design/outputs/README.md
docs/design/outputs/index.yml
docs/design/outputs/current/index.yml
docs/design/outputs/current/.gitkeep
docs/design/outputs/archive/.gitkeep
```

### 9.2 Work Item artifacts 与 outputs/archive 的区别

```text
work-items/<event>/artifacts/ = 本任务工作现场内的素材、原型、截图、临时证据
outputs/archive/<event>/ = 本事件封存时可追溯的交付物快照
outputs/current/ = 当前被用户确认或项目采纳的最新入口
```

规则：

- Work Item `artifacts/` 可以包含中间素材；
- `outputs/archive/<event_id>/` 应只放与该事件最终结果相关的交付物和证据摘要；
- `outputs/current/` 只放最新入口或索引，不应复制大量历史文件；
- 任何进入 `outputs/current/` 的文件必须在 `index.yml` 中说明来源 event、确认状态和基线资格。

### 9.3 `outputs/index.yml` 示例

```yaml
schema_version: 1
current:
  ux_prototype: "current/latest-ux-prototype.html"
  product_prd: "current/latest-product-prd.md"
archive:
  - event_id: "2026-07-06-1530-UX-001"
    title: "Settings empty state optimization"
    domain: "UX"
    status: "confirmed"
    archive_path: "archive/2026-07-06-1530-UX-001/"
    source_state: "../work-items/2026-07-06-1530-UX-001-settings-empty-state/STATE.md"
    baseline_candidate: true
```

### 9.4 `artifacts.yml` 示例

每个 archive 目录可以包含：

```yaml
schema_version: 1
event_id: "2026-07-06-1530-UX-001"
source_state: "../../work-items/2026-07-06-1530-UX-001-settings-empty-state/STATE.md"
artifacts:
  - path: "prototype.html"
    type: "html-prototype"
    status: "confirmed"
    can_be_baseline: true
  - path: "screenshots/desktop.png"
    type: "qa-evidence"
    status: "evidence"
    can_be_baseline: false
```

---

## 10. `STATE.md` Schema 增量

v0.1.3 推荐 `schema_version: 2`，但必须能继续读取 `schema_version: 1`。

### 10.1 Frontmatter 示例

```yaml
---
schema_version: 2
state_id: "2026-07-06-1530-UX-001"
event_id: "2026-07-06-1530-UX-001"
legacy_ids: []
title: "优化设置页空状态"
slug: "settings-empty-state"
scope_type: "work-item"
domain: "UX"
release: ""

status: "active"
phase: "qa"
gate: "none"
awaiting_user: false
sealed: false

mode: "lightweight"
execution_profile: "fast"
predecessors: []
related_items: []
approved_gates: []

surface_target:
  primary: "web-app"
  secondary: []
  explicitly_out_of_scope: []

reference_selection: "./REFERENCE_SELECTION.md"
approved_color_card: ""

created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""

outputs:
  current: []
  archive: []

project_memory_updates: []
---
```

### 10.2 正文新增小节

`STATE.template.md` 必须在既有小节基础上新增或调整：

```markdown
## 生命周期事件

## 业务上下文摘要

## 设计对象与终端

## Design Contract

### 必须保持
### 必须改变
### 明确不做
### 约束来源

## Review Lens

### 核心审视问题
### 验收时重点观察
### 不应使用的审美标准

## 参考资源摘要

## 产物与交付物索引

## Project Memory 更新计划

## Context-bound Final Review
```

### 10.3 压缩规则保持不变

`STATE.md` 仍然是有损上下文压缩文件，不是完整聊天记录。

新增字段不得导致 `STATE.md` 无限膨胀。完整参考分析继续写在 `REFERENCE_SELECTION.md`，完整色卡知识继续写在 Color Card Registry，完整交付物继续写在 `outputs/` 或 `artifacts/`。

---

## 11. Fast Profile 工作流

### 11.1 适用条件

当用户请求类似：

```text
帮我快速优化设置页的空状态，不要重新设计整体视觉。
```

Codex 可以进入 Fast Profile，前提是：

1. 项目已有可读取的上下文或视觉基线；
2. 用户明确要求局部优化；
3. 不改变整体视觉方向、产品主流程或信息架构；
4. 不需要新增 Reference Library 检索或 Color Card 选择；
5. 不存在高影响产品语义歧义。

### 11.2 必须读取的轻量上下文

Fast Profile 至少读取：

- 当前用户请求；
- 相关 active Work Item 或 sealed predecessor；
- `docs/design/project-memory/VISUAL_DESIGN.md` 或现有视觉基线；
- 相关页面、组件或文件；
- 必要时读取 `REFERENCE_SELECTION.md` 摘要，而不是完整重做参考选择。

### 11.3 状态记录要求

Fast Profile 的 `STATE.md` 至少记录：

```yaml
mode: "lightweight"
execution_profile: "fast"
domain: "UX"
scope: "settings empty state only"
design_contract:
  must_keep:
    - "现有色彩、圆角、密度和导航结构"
  must_change:
    - "空状态的引导文案和下一步行动"
  must_not_do:
    - "不重设整体视觉语言"
review_lens:
  primary_question: "空状态是否帮助用户理解下一步，而不改变页面身份？"
```

### 11.4 Gate 规则

Fast Profile 可以跳过 `visual-direction-approval` 和 `prototype-approval`，但以下情况必须回到对应 Gate：

- 需要改变整体视觉方向；
- 需要新增或替换色卡；
- 需要改变关键产品路径；
- 需要大规模重构页面结构；
- 用户明确要求先看原型；
- Codex 无法建立可靠 Design Contract。

Fast Profile 不得跳过 `completion-approval`。

---

## 12. Context-bound Final Review 工作流

### 12.1 触发时机

在进入 `completion-review` 前，`design-engineering` 必须执行 Context-bound Final Review。

推荐阶段：

```text
qa → context-bound final review → completion-review → completion-approval → completed + sealed
```

不新增 Gate；最终用户关闭仍使用既有 `completion-approval`。

### 12.2 审查输入

Final Review 必须读取：

- 当前 `STATE.md`；
- Design Contract；
- Review Lens；
- 验收标准；
- 已批准决定；
- `REFERENCE_SELECTION.md` 摘要；
- Approved Color Direction 摘要；
- Project Memory 中相关基线；
- 生产实现或原型；
- 浏览器、截图或其他 QA 证据。

### 12.3 审查输出

每个 Work Item 应生成：

```text
docs/design/work-items/<event-id>-<slug>/review.md
```

`review.md` 至少包含：

```markdown
# Context-bound Final Review

## Review Inputs
## Design Contract Check
## Review Lens Check
## Approved Decisions Consistency
## Reference / Color Consistency
## UX State Coverage
## Responsive / Accessibility Evidence
## Deviations
## Required Fixes Before Completion
## Completion Recommendation
```

### 12.4 禁止行为

Final Review 不得：

- 只给通用审美意见；
- 脱离本次业务目标评价“高级感”；
- 忽略用户已批准的方向；
- 推翻 sealed predecessor；
- 把 checklist 当成独立审美裁判；
- 未验证却声称浏览器验收完成。

---

## 13. PD 域产品设计事件

### 13.1 适用任务

`PD` 事件适用于：

- 会员体系；
- 定价模型；
- 功能边界；
- 权限与套餐；
- 产品策略；
- 用户分层；
- 产品对象模型；
- PRD 或 decision map。

示例请求：

```text
帮我设计会员体系，明确免费版、专业版、团队版的功能边界。
```

### 13.2 目录示例

```text
docs/design/work-items/
  2026-07-06-1605-PD-001-membership-system/
    STATE.md
    artifacts/
      membership-prd.md
      pricing-model.md
      decision-map.md
    review.md

docs/design/outputs/archive/
  2026-07-06-1605-PD-001/
    membership-prd.md
    pricing-model.md
    decision-map.md
    summary.md
```

### 13.3 PD `STATE.md` 必须记录

```text
目标用户
业务目标
版本边界
功能分层
定价假设
权限与额度
风险
未决问题
已确认决策
对后续 UX 的约束
对工程实现的约束
Project Memory 更新计划
```

### 13.4 PD → UX 继承

如果用户后续请求：

```text
基于刚才的会员体系，设计升级弹窗和套餐页。
```

新的 UX Work Item 必须记录：

```yaml
predecessors:
  - "2026-07-06-1605-PD-001"
inherited_context:
  - "套餐名称"
  - "功能边界"
  - "目标转化"
  - "权益不得夸大"
  - "合规文案约束"
  - "核心升级路径"
```

PD 事件一旦 `completed + sealed`，UX 事件只能只读引用它，不得修改 PD 的 `STATE.md`。

---

## 14. Skill 要求增量

`skills/design-engineering/SKILL.md` 必须新增以下行为：

1. 状态解析前读取 `docs/design/project-memory/` 的相关摘要，但不得把整个项目记忆复制进回复；
2. 新建 Work Item 时优先使用 Lifecycle Event ID；
3. 继续支持 legacy `DE-xxx` Work Item 的恢复和 Successor；
4. 根据任务判断 `domain: UX | PD`；
5. Fast Profile 仅作为 lightweight 的加速形态，使用 `execution_profile: fast`；
6. 在进入实现或审查前写入或更新 Design Contract；
7. 在 QA 后、completion-review 前生成 Context-bound Final Review；
8. 完成确认时展示 `review.md` 摘要、验收标准结果、输出归档路径和 Project Memory 更新建议；
9. 用户批准关闭后，才更新 `outputs/current/` 和 Project Memory 基线；
10. 对 PD 任务跳过不适用的视觉 Gate，但仍使用状态解析、必要决策确认、产物归档和完成确认；
11. 对 UX 任务继续遵守 Surface Resolution、Reference Library 和 Color Card Registry；
12. 不得为了新目录结构改写 sealed 状态。

---

## 15. Steward 要求增量

`design_state_steward` 仍然只管理状态。

### 15.1 可以新增的职责

Steward 可以：

- 分配或记录 Lifecycle Event ID；
- 记录 `domain`、`execution_profile`、`design_contract`、`review_lens`；
- 更新 `STATE.md` 中的 artifact / output / project_memory_updates 摘要；
- 更新 `WORK_ITEMS.md` 索引中的 domain、event id、phase、gate、state；
- 在 closure readiness 检查中确认 `review.md`、outputs archive 和验收证据是否存在；
- 在用户批准关闭后记录 sealed 状态；
- 在 Project Memory 文件更新后记录对应 event 来源。

### 15.2 仍然禁止的职责

Steward 不得：

- 设计页面；
- 做产品策略判断；
- 挑选参考产品；
- 挑选色卡；
- 实现业务代码；
- 自动批准 Gate；
- 修改 sealed 状态；
- 把完整聊天记录、完整参考分析或完整色卡知识写入 `STATE.md`；
- 在 `AMBIGUOUS` 时自行选择；
- 把未确认的 Work Item 结果写成 Project Memory 基线。

### 15.3 状态解析返回格式兼容

现有返回格式保持：

```yaml
decision: CREATE | RESUME | SUCCESSOR | NO_STATE | AMBIGUOUS
current_state: ""
new_state: ""
candidates: []
reason: ""
user_question: ""
recommended_action: ""
```

v0.1.3 可选增加字段：

```yaml
event_id: ""
domain: "UX | PD"
legacy_state: true | false
execution_profile: "standard | fast"
```

这些新增字段不得替代既有字段，也不得改变 `decision` 枚举。

---

## 16. `WORK_ITEMS.md` 增量

`WORK_ITEMS.md` 仍然是索引，不是权威来源。

模板可扩展为：

```markdown
# Design Work Items

> This file is a navigation index. Each Work Item's STATE.md is authoritative.

## Active

| ID | Domain | Title | Release | Phase | Gate | Profile | State |
|---|---|---|---|---|---|---|---|

## Paused

| ID | Domain | Title | Release | Phase | Reason | State |
|---|---|---|---|---|---|---|

## Completed

| ID | Domain | Title | Release | Completed | Successors | Archive | State |
|---|---|---|---|---|---|---|---|

## Cancelled

| ID | Domain | Title | Cancelled | State |
|---|---|---|---|---|

## Legacy IDs

| Legacy ID | Current Event ID | Title | State |
|---|---|---|---|
```

如果仓库中已有旧格式 `WORK_ITEMS.md`，Codex 可以保留旧表结构并追加新表；不得因为格式升级导致旧示例链接失效。

---

## 17. 模板要求增量

### 17.1 新增模板

必须新增：

```text
skills/design-engineering/assets/PROJECT_MEMORY_README.template.md
skills/design-engineering/assets/PROJECT_MEMORY.template.md
skills/design-engineering/assets/OUTPUTS_README.template.md
skills/design-engineering/assets/OUTPUTS_INDEX.template.yml
skills/design-engineering/assets/ARTIFACTS_MANIFEST.template.yml
```

也可在项目模板中直接放置已初始化文件。

### 17.2 更新模板

必须更新：

```text
skills/design-engineering/assets/STATE.template.md
skills/design-engineering/assets/WORK_ITEMS.template.md
skills/design-engineering/assets/AGENTS.fragment.md
templates/project/AGENTS.fragment.md
```

### 17.3 新增 reference 文档

必须新增：

```text
skills/design-engineering/references/project-memory-and-artifacts.md
skills/design-engineering/references/lifecycle-event-id.md
skills/design-engineering/references/context-bound-final-review.md
skills/design-engineering/references/product-design-events.md
```

---

## 18. README / Architecture / Manual Test 要求

必须更新：

```text
README.md
README.zh-CN.md
docs/architecture.md
docs/manual-test-guide.md
docs/product-summary.lifecycle-memory-version.md
CHANGELOG.md
```

更新内容至少包括：

1. designHarness 从任务工作流升级为项目生命周期记忆系统；
2. Lifecycle Event ID 与 legacy `DE-xxx` 的关系；
3. Project Memory / Work Item / STATE / Reference Library / Color Card / Outputs 的边界；
4. Fast Profile 使用条件和不能跳过的责任；
5. Context-bound Final Review 的输入、输出和禁止行为；
6. PD 事件如何成为后续 UX 事件的 predecessor；
7. 如何保护 v0.1 / v0.1.1 / v0.1.2 能力；
8. 手动安装仍然不覆盖用户已有 `AGENTS.md`；
9. 当前仍不实现 CLI、Plugin、Hook、installer、外部依赖。

---

## 19. 示例要求

### 19.1 不修改旧示例语义

`examples/idea-storm-lab/` 的原始三类请求仍必须成立：

```text
检查项目上下文 → NO_STATE
优化前端样式 → CREATE / completed + sealed
统一内容模块问题长度换行 → SUCCESSOR
```

不得为了展示新 ID 而重命名旧示例，除非同步更新所有 README、evals 和说明，并证明 v0.1 原评测仍成立。

### 19.2 新增生命周期示例

新增：

```text
examples/lifecycle-memory-lab/
```

至少包含两个 Work Item：

```text
2026-07-06-1530-UX-001-settings-empty-state
2026-07-06-1605-PD-001-membership-system
```

示例必须包含：

- `STATE.md`；
- `review.md`；
- `artifacts/`；
- `outputs/archive/<event_id>/summary.md`；
- `outputs/index.yml`；
- `project-memory/PRODUCT_DESIGN.md` 或 `UX_DESIGN.md` 更新示例；
- UX 事件对 PD predecessor 的继承示例。

---

## 20. 人工评测增量

新增评测场景，文件名建议：

```text
evals/scenarios/15-lifecycle-event-id-create.md
evals/scenarios/16-legacy-de-id-resume.md
evals/scenarios/17-fast-profile-local-ux.md
evals/scenarios/18-context-bound-final-review.md
evals/scenarios/19-pd-event-project-memory.md
evals/scenarios/20-pd-to-ux-predecessor.md
evals/scenarios/21-outputs-archive-current-index.md
evals/scenarios/22-no-sealed-state-mutation-for-memory.md
```

### 20.1 Lifecycle Event ID Create

Given：项目已有 v0.1.3 模板。

When：用户要求创建新的设置页空状态优化。

Then：创建 `yyyy-mm-dd-hhmm-UX-001` 格式 Work Item；`state_id` 与 `event_id` 一致；`WORK_ITEMS.md` 索引包含该事件。

### 20.2 Legacy DE ID Resume

Given：项目存在 legacy `DE-001` active 状态。

When：新 Thread 中用户要求继续 `DE-001`。

Then：返回 `RESUME`；不重命名目录；不创建重复状态。

### 20.3 Fast Profile Local UX

Given：项目已有 `VISUAL_DESIGN.md`，用户要求快速优化局部 UI 且不改变整体视觉。

When：Codex 执行状态解析。

Then：使用 `mode: lightweight` 与 `execution_profile: fast`；记录 Design Contract 和 Review Lens；可跳过视觉方向 Gate；不得跳过 completion approval。

### 20.4 Context-bound Final Review

Given：实现和 QA 已完成。

When：Codex 准备进入 completion-review。

Then：生成 `review.md`；审查内容必须引用 `STATE.md`、Design Contract、Review Lens 和已批准决定；不得只输出通用审美 checklist。

### 20.5 PD Event Project Memory

Given：用户要求设计会员体系。

When：创建 PD Work Item。

Then：生成 `domain: PD` 的生命周期事件；产出 PRD / pricing model / decision map；提出 `PRODUCT_DESIGN.md` 和 `BUSINESS_CONTEXT.md` 更新。

### 20.6 PD to UX Predecessor

Given：PD 会员体系已 completed + sealed。

When：用户要求基于会员体系设计升级弹窗。

Then：创建新的 UX Work Item；`predecessors` 引用 PD event；只读继承套餐名称、功能边界和合规文案约束；不修改 sealed PD 状态。

### 20.7 Outputs Archive Current Index

Given：用户批准关闭一个 UX Work Item。

When：Codex seal 状态。

Then：创建或更新 `outputs/archive/<event_id>/`；更新 `outputs/index.yml`；只有被用户确认的交付物才进入 `outputs/current/`。

### 20.8 No Sealed State Mutation for Memory

Given：sealed 状态缺少 `event_id` 或 Project Memory 摘要。

When：Codex 执行 v0.1.3 更新。

Then：不得修改 sealed `STATE.md`；可以在新 successor 或 `DECISIONS.md` 中追加只读引用。

---

## 21. 与旧版本对比

| 模块 | v0.1.2 当前状态 | v0.1.3 增量 |
|---|---|---|
| Work Item ID | `DE-xxx` 为主 | 新增 Lifecycle Event ID；legacy 继续支持 |
| 状态模型 | Work Item + STATE + Gate | 保持不变，STATE 增加可执行上下文字段 |
| Project Memory | 未标准化 | 新增 `project-memory/` 长期记忆层 |
| Artifacts | Work Item 内局部存在 | 新增 `outputs/current` 与 `outputs/archive` |
| Fast / Lightweight | Lightweight Mode 已有 | 新增 Fast Profile，不替代 lightweight |
| Final Review | QA 与 completion-review | 新增 Context-bound Final Review，不新增 Gate |
| Product Design | 未形成正式 domain | 新增 `domain: PD` 生命周期事件 |
| Reference Library | 长期资料层 | 保持不变，继续独立于 Work Item |
| Color Card Registry | 色卡完整性与 ready-only | 保持不变，继续由 Reference Selection 消费 |
| Steward | 状态管理员 | 仍只管状态，增加 event/output/memory 摘要记录 |

---

## 22. Definition of Done 增量

只有全部满足，才可认为 v0.1.3 完成。

### 22.1 兼容性

- [ ] v0.1 原七个评测仍成立；
- [ ] v0.1.1 Reference Library 评测仍成立；
- [ ] v0.1.2 Color Card Registry 评测仍成立；
- [ ] `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS` 枚举未改变；
- [ ] `completed + sealed` 仍然只读，不为补字段而修改；
- [ ] legacy `DE-xxx` 示例仍可恢复和引用；
- [ ] 没有新增 CLI、Hook、Plugin、安装器、脚本或外部依赖。

### 22.2 Lifecycle Event ID

- [ ] 新 Work Item 示例使用 `yyyy-mm-dd-hhmm-UX-001` / `PD` ID；
- [ ] `state_id`、`event_id`、目录名、outputs archive 路径一致；
- [ ] 文件系统路径不使用冒号；
- [ ] `WORK_ITEMS.md` 可同时显示 legacy ID 和 lifecycle ID。

### 22.3 Project Memory

- [ ] 项目模板包含 `docs/design/project-memory/`；
- [ ] Project Memory 文件职责清楚；
- [ ] `STATE.md` 包含 `project_memory_updates`；
- [ ] 未确认结果不会写成项目基线；
- [ ] Project Memory 不复制完整聊天记录、完整参考分析或完整色卡知识。

### 22.4 Outputs / Artifacts

- [ ] 项目模板包含 `docs/design/outputs/`；
- [ ] `outputs/index.yml` 说明 current 与 archive；
- [ ] 每个新增示例 archive 都能追溯 source state；
- [ ] current 只指向已确认或可作为基线的交付物；
- [ ] Work Item `artifacts/` 与 `outputs/archive/` 边界清楚。

### 22.5 STATE / Review

- [ ] `STATE.template.md` 包含 `event_id`、`domain`、`execution_profile`、Design Contract、Review Lens、outputs、project memory updates；
- [ ] `review.md` 模板或示例存在；
- [ ] Final Review 基于上下文，不是通用审美审计；
- [ ] `completion-approval` 仍是 seal 前必要 Gate。

### 22.6 Fast Profile

- [ ] Fast Profile 文档明确其是 lightweight 的加速形态；
- [ ] Fast Profile 可跳过不适用的视觉/原型 Gate；
- [ ] Fast Profile 不得跳过 completion approval；
- [ ] Fast Profile 必须记录 Design Contract 和 Review Lens。

### 22.7 PD Domain

- [ ] 支持 `domain: PD`；
- [ ] PD 示例包含 PRD、pricing model、decision map 或等价产物；
- [ ] PD 事件可以更新 `PRODUCT_DESIGN.md` / `BUSINESS_CONTEXT.md`；
- [ ] 后续 UX 事件可以通过 `predecessors` 继承 PD 约束；
- [ ] sealed PD 状态不被后续 UX 修改。

---

## 23. 实施顺序建议

### Milestone 1：兼容性基线与目录结构

- 阅读 `docs/PRD.md`、`docs/PRD.reference-library-v0.1.1.md`、`docs/PRD.color-card-registry-v0.1.2.md`；
- 确认原 v0.1 / v0.1.1 / v0.1.2 evals 不变；
- 新增 `project-memory/` 和 `outputs/` 项目模板；
- 不重命名 legacy `DE-xxx` 示例。

### Milestone 2：Lifecycle Event ID 与 STATE 模板

- 更新 `STATE.template.md`；
- 更新 `WORK_ITEMS.template.md`；
- 新增 lifecycle-event-id reference；
- 更新 Steward 文档，支持 optional `event_id` / `domain` / `execution_profile` 字段。

### Milestone 3：Project Memory 与 Outputs 文档

- 新增 Project Memory 模板和 README；
- 新增 Outputs README、index template、artifacts manifest template；
- 更新 architecture 和 manual test。

### Milestone 4：Skill / AGENTS 规则

- 更新 `design-engineering/SKILL.md`；
- 新增 context-bound-final-review reference；
- 新增 product-design-events reference；
- 更新 `templates/project/AGENTS.fragment.md`。

### Milestone 5：示例与评测

- 保持 `examples/idea-storm-lab/` 语义不变；
- 新增 `examples/lifecycle-memory-lab/`；
- 新增 v0.1.3 evals；
- 交叉检查所有路径、ID、索引、State、outputs、Project Memory 是否一致。

### Milestone 6：README / 总结 / DoD 自检

- 更新中英文 README；
- 新增 `docs/product-summary.lifecycle-memory-version.md`；
- 更新 CHANGELOG；
- 对照本 PRD Definition of Done 逐项自检；
- 最终回复说明保护旧能力的验证结果。

---

## 24. Codex 最终回复要求

实现完成后，Codex 最终回复必须说明：

1. 创建或修改了哪些核心文件；
2. 如何保护 v0.1 的状态模型、Gate、sealed、legacy `DE-xxx` 示例；
3. 如何保护 v0.1.1 Reference Library；
4. 如何保护 v0.1.2 Color Card Registry；
5. Lifecycle Event ID 如何与 legacy ID 共存；
6. Project Memory、Work Item、STATE、Outputs、Reference Library 的边界；
7. Fast Profile 和 Context-bound Final Review 如何进入流程；
8. PD 事件如何成为后续 UX 的 predecessor；
9. 原有评测和新增评测是否满足；
10. 当前仍未实现的 v0.2+ / 非目标能力。

---

## 25. 最终产品定义

v0.1.3 后，Design Engineering Harness 的定义应升级为：

```text
Design Engineering Harness 是一个由文件系统承载的产品设计工程记忆系统。
它通过 Lifecycle Event ID 串联 Work Item、STATE、Reference Selection、Color Direction、Artifacts、Outputs、Project Memory 和 Review，
让 Codex 不只是完成一次任务，而是能持续沉淀决策、恢复上下文、生成交付物，并安全进入下一次迭代。
```
