# Codex Design Harness

Codex Design Harness 是一套给 Codex 使用的 Human-in-the-loop 设计工程协议：它把重要 UI/UX 工作组织成可恢复、可审计、可由用户批准关闭的 Work Item，并把已确认的视觉结果沉淀为项目级 `VISUAL_DESIGN.md`。

它不是组件库、CLI 或自动化平台。v0.1.3-alpha 是在 v0.1.2-alpha Color Card Registry 版基础上的增量：继续保持文档型交付，并新增 Project Lifecycle Memory & Artifacts，让 Work Item、`STATE.md`、Project Memory、Outputs、Review 和后续 Successor 可以串起来。本版本补充了 Lifecycle Event ID、`project-memory/`、`outputs/`、Fast Profile、Context-bound Final Review 和 `PD` 产品设计事件；它仍然不是插件市场包、Hook、云服务或外部运行时。

v0.2.3 更新 runtime-aware 的 Product Business Modeling Core：业务语义层仍在 `core/product-design/business-modeling/` 下保持 Agent-neutral，继续使用 shared Agent Skill Facade、Codex / Claude Code / Cursor / generic / multi-runtime adapter resolution，并新增 `docs/product/BUSINESS_MODEL_OVERVIEW.md` 作为唯一默认用户总览。它同时强化 canonical Work Item 文件、冻结 State Schema、Dictionary / Index / Schema 精确合同、stable references 和 Core 写入后的 consistency validation。它仍然是文档型能力，不是 CLI、Hook、插件包、安装器、迁移工具、API 生成器或外部运行时依赖。

v0.1.4 更新独立 Product Business Analysis Core：保留 v0.1.3 Choice-first 决策支持，并补上 Decision Boundary 与 Choice Closure。它新增 Mixed-turn Interpretation、Choice Loop Closure、Decision Scope Lock、Post-decision Clarification、Artifact Boundary Gate、No Execution Offer、State Enum Enforcement、schema 3 状态资产，以及 ARCOS“确认路线 + 追问实施细节”回归覆盖。它不依赖业务建模、Motivation Analysis 或任何兄弟能力，不创建跨模块 Trigger、downstream views 或共享 Work Item 目录。

## 它解决的问题

普通 Codex 对话容易把 Thread 误当作任务。换一个 Thread 后，设计方向、批准决定和验收证据可能丢失；任务完成后，后续需求也可能静默改写历史。Design Harness 把状态绑定到 Work Item，而不是绑定到 Thread。

视觉设计还有一个常见问题：如果只让用户输入“产品人格”“品牌气质”这类抽象词，Agent 容易回到通用 SaaS 页面、白底卡片和蓝紫渐变。新版流程改为让用户确认更具体的材料：Visual Seed、参考图片、配色样张、设计禁区和视觉原型。

Reference Library 增量进一步解决另一个问题：用户不需要知道“某个产品的具体设计优势”。Agent 应先判断这是 Web 工作台、移动 App、响应式 Web、桌面端还是多端任务，再从长期参考资料中筛选依据，并转译成“效率工作台”“引导式助手”“内容探索”“快速记录”等业务语义。Color Card Registry 继续补齐配色方向：色卡不是图片，而是 `palette-index.yml` entry、image、palette 和 annotation 组成的完整参考对象。

核心约定：

- Thread 是一次 Codex 对话，是临时工作现场。
- Work Item 是可独立验收的产品或设计任务。
- `STATE.md` 是 Work Item 的权威状态快照。
- `WORK_ITEMS.md` 只是索引，冲突时以 `STATE.md` 为准。
- `reference-library/` 是长期视觉参考资料层。
- `REFERENCE_SELECTION.md` 是某个 Work Item 本次如何消费参考库和色卡注册表的记录。
- `Color Card Registry` 是 `reference-library/assets/color-cards/` 下的可校验配色参考资料层。
- `project-memory/` 是跨 Work Item 的长期项目记忆，保存业务、产品、UX、视觉、工程和决策基线。
- `outputs/` 是交付物系统，区分当前确认入口和历史事件归档。
- `VISUAL_DESIGN.md` 是项目级视觉基线，不替代任何 Work Item 状态。
- 新 Work Item 优先使用 `yyyy-mm-dd-hhmm-UX-001` 或 `yyyy-mm-dd-hhmm-PD-001`；旧 `DE-xxx` 继续有效。
- Gate 是必须等用户决定的阶段边界。
- `completed + sealed` 的状态只能只读引用，后续工作必须创建 Successor。

## 架构

```text
AGENTS.md 项目规则
        ↓
design-engineering Skill
        ↓
design_state_steward Agent
        ↓
docs/design/reference-library/
        ↓
Surface Resolution + REFERENCE_SELECTION.md
        ↓
docs/design/work-items/<ID-slug>/STATE.md
        ↓
docs/design/project-memory/ + docs/design/outputs/
        ↓
用户 Gate、视觉流程、实现、验证、封存
        ↓
docs/design/VISUAL_DESIGN.md
```

更多结构说明见 [docs/architecture.md](docs/architecture.md)。


## Product Business Modeling Core

`product-business-modeling` v0.2.3 把产品业务语义从 UI/UX 执行中拆出来。Core 位于 [core/product-design/business-modeling](core/product-design/business-modeling/)，shared facade 位于 [adapters/shared/agent-skill-facade/product-business-modeling](adapters/shared/agent-skill-facade/product-business-modeling/)，仓库级可调用 Skill 位于 [skills/product-business-modeling](skills/product-business-modeling/)。入口文档是 [AGENT_START_HERE.md](AGENT_START_HERE.md)、[CODEX_START_HERE.md](CODEX_START_HERE.md) 和 [docs/PRD.product-business-modeling-v0.2.3.md](docs/PRD.product-business-modeling-v0.2.3.md)。

准备目标项目之前，必须先执行 Runtime Adapter Resolution：读取 `core/product-design/business-modeling/protocols/agent-runtime-adapter-resolution.md` 和 `adapters/adapter-registry.yml`。默认只选择一个 profile：`codex`、`claude-code`、`cursor` 或 `generic-agent`；只有用户明确要求多个工具时才使用 `multi-runtime`。如果 runtime 信号冲突，必须停下询问用户。

默认项目模板只包含可移植的 `docs/product/**` 和 runtime-selection metadata。Runtime-specific 文件必须留在 `templates/project/runtime-overlays/<runtime>/`，直到 resolver 选中某个 profile；默认 `templates/project/` 根层不得包含 `.agents/`、`.codex/`、`.claude/` 或 `.cursor/`。

业务模型 source of truth 是 `docs/product/business-modeling/`。被动触发使用 `docs/product/model-triggers/MT-xxx.md`，任务状态位于 `docs/product/work-items/BM-xxx/`。核心模型只写业务属性，不写数据库字段；`schema-view.json` 只保留业务对象、业务领域、对象分类、业务属性和属性示例内容。

默认给产品负责人阅读的唯一入口是 `docs/product/BUSINESS_MODEL_OVERVIEW.md`。它是 consistency validation 之后编译出来的派生总览，不是 source of truth；它必须把待确认的 `BMD-xxx` 人类决策压缩到用户无需打开详细文件也能回复。新的持久 BM Work Item 使用 canonical 根文件：`STATE.md`、`MODELING_CONSUMPTION.md`、`MODELING_OUTPUT.md` 和 `DECISION_NOTES.md`。

业务模型可以通过派生下游视图影响 UX：`ux-design-engineering-view.md` 和 `ux-business-model-context.md/yml`。既有 `docs/design/`、Reference Library、Color Card Registry、`REFERENCE_SELECTION.md` 和 sealed UX `STATE.md` 仍由 Design Engineering 管理，Business Modeling 不直接修改。

## Product Business Analysis Core

`product-business-analysis` v0.1.4 是独立、Choice-first 且具备选择闭环边界的商业决策支持能力。Core 位于 [core/product-design/business-analysis](core/product-design/business-analysis/)，运行时 adapter 片段位于 `adapters/codex/product-business-analysis/`、`adapters/claude-code/product-business-analysis/` 和 `adapters/cursor/product-business-analysis/`，项目模板位于 [templates/project/docs/product/business-analysis](templates/project/docs/product/business-analysis/)。入口文档是 [docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.4-complete.md](docs/CODEX_BUILD_BRIEF.product-business-analysis-core-v0.1.4-complete.md) 和 [docs/PRD.product-business-analysis-v0.1.4.md](docs/PRD.product-business-analysis-v0.1.4.md)。

商业分析的项目资产根目录是 `docs/product/business-analysis/`。Decision Case 的唯一权威文件位于 `decision-cases/BA-DC-xxx.md`；BA Work Item 位于 `work-items/BA-xxx/`，只链接 Case，不复制 `DECISION_CASE.md`。Decision Network 和 Evidence Ledger 的 YML 是机器权威源，Markdown 是人读视图。

商业分析的后续对话必须先恢复当前 BA Work Item 和所链接的 Decision Case，再回答用户；总结和结论请求也必须绑定 Case。v0.1.4 保留 provisional Choice Set、Recommendation Obligation、Choice Delta、Claim-level Assurance 和 No Dead-End Rule，并要求同轮分别解析决定信号与追问：一条回复可以同时确认选择并询问后续概念。用户确认后必须关闭 Choice Loop，将推荐转为 `user_confirmed`，写入 `DECISION_NOTES.md`，并停止再次请求同一选择。

Standard 默认输出收敛为 `STATE.md`、权威 Decision Case、按需 `ANALYSIS_WORKSPACE.md`、`DECISION_SUMMARY.md` 和发生用户决定时的 `DECISION_NOTES.md`。Deep / Audit 过程文件仍只能放在 `work-items/BA-xxx/artifacts/` 下，不创建 `intake/`，也不散落在 Work Item 根目录。State 资产升级到 schema 3，并强制使用固定 `status`、`phase`、`gate` 枚举；`simulator-design` 这类业务专属 phase 非法。ready Analysis Model Cards 必须包含 `runtime_role`、七个 usage prompts、Choice Delta、Choice Loop Closure Guard、Decision Scope Lock 和实施边界守卫；v0.1.4 共 26 张 ready 卡。

商业分析采用五个运行域，不继承业务建模的 Passive Trigger。决定确认后的澄清只能停留在原业务决策层，说明目的、理由、取舍、证据边界、升级、停止和复审条件；不得继续生产实施 Runbook、手工指南、具体 Schema、样例数据、公式、脚本、UI / 技术设计或主动执行提议。跨模块触发、跨模块影响传播、downstream view、共享 `docs/product/work-items/`、CLI、Hook、Plugin、安装器、外部依赖和自动替用户确认 D2/D3 决定均不属于当前版本。

## Agent 兼容安装

请用完整的 `design-harness` 仓库安装。轻量的 `designharness` 规则目录只包含 Skill Routing Gate 规则，不包含完整 Skill、Reference Library、Color Card Registry 或项目模板。

兼容安装脚本：

```bash
./scripts/install-agent-compat.sh codex /path/to/project
./scripts/install-agent-compat.sh claude /path/to/project
./scripts/install-agent-compat.sh cursor /path/to/project
```

脚本会复制完整 skill 目录，安装对应客户端能识别的项目入口，并检查嵌套的 `docs/design/` 模板文件是否齐全。更多说明见 [docs/agent-compatibility.md](docs/agent-compatibility.md)。

如果要检查某个项目到底缺哪些文件，运行：

```bash
./scripts/install-agent-compat.sh doctor /path/to/project
```

## 五种状态解析结果

`design_state_steward` 在状态解析阶段只能返回：

- `CREATE`：创建新的独立 Work Item。
- `RESUME`：恢复一个未封存 Work Item。
- `SUCCESSOR`：引用已封存前任，并创建新的后继 Work Item。
- `NO_STATE`：当前请求不值得持久化状态，例如只读上下文检查。
- `AMBIGUOUS`：存在多个合理候选，必须停下请用户选择。

## 新视觉流程

Full Mode 的视觉流程是：

```text
Visual Seed
→ Surface Resolution
→ Reference Library / Color Card Registry / Reference Images / Reference Packs
→ Reference Analysis
→ Palette Proposal
→ Palette Confirmation
→ Typography Proposal
→ Typography Confirmation
→ Design Exclusions
→ Exclusions Confirmation
→ Visual Prototype
```

`Visual Seed` 只记录用户原始视觉输入，可以是一句话、一个词、参考产品名，甚至为空。Agent 先解析参考图中可观察的视觉特征，再输出至少 3 套候选调色盘、同构 UI 样张和对比/可读性说明。用户可以选择候选，也可以直接输入自己的颜色偏好；无论哪种都必须写入 `STATE.md`。用户确认配色后，Agent 还必须确认字体字号与排版系统，记录字体族、fallback、字号阶梯、行高、字重、用途映射、响应式调整、授权/加载说明和可读性风险。之后 Agent 生成 4-8 条设计禁区，用户确认后才进入视觉原型。

配色确认、字体字号确认和设计禁区确认不新增 Gate 枚举。它们都是：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

在 `STATE.md` 正文中记录视觉子步骤：

```text
palette-selection
typography-selection
design-exclusions
```

## Reference Library 与 Surface Resolution

如果目标项目存在：

```text
docs/design/reference-library/
```

Agent 在视觉方向前必须先判断目标终端：

```text
web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface
```

然后按同终端、同页面类型、同任务类型、相近内容密度和交互复杂度、相近用户成熟度、相邻行业、视觉标签的顺序筛选参考。

Reference Library 是长期资料层；每个 Work Item 的实际参考选择写入：

```text
docs/design/work-items/<ID-slug>/REFERENCE_SELECTION.md
```

`STATE.md` 只记录目标终端、Reference Selection 链接、采用原则摘要、用户批准方向和关键排除项。不要在 `reference-library/` 下创建任务专属 `reference-packs/`。

给用户看的方向必须是业务语义和取舍，不是产品名选择题。跨终端参考只能抽象借鉴，不能直接复制布局、导航、手势、密度或视觉比例。


## Color Card Registry

如果目标项目存在：

```text
docs/design/reference-library/assets/color-cards/palette-index.yml
```

Agent 在配色方向前必须读取色卡注册表。正式色卡不是单张图片，而是：

```text
palette-index.yml entry + image + palette + annotation
```

`palette-index.yml` 是机器权威清单，`palette-index.md` 是人读索引。`images/`、`palettes/` 和 `annotations/` 继续保持集中式目录，不改成每张色卡一个目录。任何正式资产都不得 orphan。只有 `status: ready` 且 `gate_preview: true`，并且 image / palette / annotation 与 id 一致的色卡，才能进入 `visual-direction-approval`。

配色确认时，用户应看到大图色卡、业务语义、适合场景、代价和落地建议，而不是主要通过 HEX/RGB 或小色块 icon 做选择。Work Item 采用的色卡写入 `REFERENCE_SELECTION.md`；`STATE.md` 只保留色卡 ID、采用摘要、风险摘要和链接。

## Project Memory 与 Outputs

v0.1.3 新增：

```text
docs/design/project-memory/
docs/design/outputs/
```

`project-memory/` 保存长期有效的项目认知：业务背景、产品决策、UX 原则、视觉基线、工程约束和决策索引。它不是聊天记录，也不复制完整 `STATE.md`、完整参考分析或完整色卡知识。

`outputs/` 保存交付物索引：

- `outputs/archive/<event_id>/`：sealed 生命周期事件的交付快照。
- `outputs/current/`：用户确认或项目采纳的当前入口。
- `outputs/index.yml`：记录 current、archive、source `STATE.md` 和 baseline 资格。

Work Item 的 `artifacts/` 是任务现场；`outputs/archive/` 是封存快照；`reference-library/` 仍然是长期参考资料层。

## 为什么不要求产品人格

v0.1 不要求用户填写产品人格、品牌气质矩阵或用户感受目标表单。这些词可以作为 Agent 内部分析语言，但不应成为用户必须回答的问题。用户更容易判断的是参考图片、配色样张、设计禁区和原型。

## 参考图片与参考包

用户可以把参考图放到目标项目：

```text
docs/design/reference-images/
```

如果用户没有参考图，Skill 可以使用内置自制参考包：

```text
skills/design-engineering/assets/visual-reference-packs/
```

参考包只用于启发，不复制第三方产品截图，不使用真实品牌 Logo。Agent 应说明哪些特征可借鉴，哪些不应复制。

配色方向使用 Color Card Registry 的 project-first 解析：如果项目存在 `docs/design/reference-library/assets/color-cards/palette-index.yml`，优先使用项目色卡库；如果项目没有安装色卡库，Skill 会把内置 `skills/design-engineering/assets/color-cards/` 安装到项目路径，在 `REFERENCE_SELECTION.md` 中记录来源为 `project-installed-from-skill-bundled`，并用大图色卡和业务语义让用户确认。只有项目安装不安全或失败时，才临时使用 `skill-bundled`；只有项目级和内置色卡都不可用时，才退回非 registry 配色方案。

## `VISUAL_DESIGN.md` 与 `STATE.md`

`STATE.md` 记录单个 Work Item 的状态、Gate、批准决定、验收标准和验证证据。

`VISUAL_DESIGN.md` 记录项目长期复用的视觉基线：Visual Seed、参考图解析、已确认配色、已确认字体字号与排版系统、设计禁区、组件语言、布局原则和示例。它只记录已确认结果，不记录未批准实验方案。

后续 Work Item 必须先读取 `VISUAL_DESIGN.md`。如果新任务改变视觉基线，必须在对应 `STATE.md` 说明原因，并更新 `VISUAL_DESIGN.md`。

## Human-in-the-loop 工作流

`design-engineering` 负责流程编排，`design_state_steward` 负责状态读写。典型 Full Mode 流程：

1. 解析 Work Item 归属，并读取已有 `VISUAL_DESIGN.md`。
2. 理解业务目标、约束和 Visual Seed。
3. 执行 Surface Resolution，记录目标终端和证据。
4. 若存在 Reference Library，筛选参考并写入 Work Item 的 `REFERENCE_SELECTION.md`。
5. 解析参考图片、参考库条目或参考包，并把结果转译成业务语义方向。
6. 若存在 Color Card Registry，读取 `palette-index.yml`，跳过不完整、draft 或 deprecated 色卡，并将可用候选写入 `REFERENCE_SELECTION.md`。
7. 在 `visual-direction-approval` 下写入 `palette-selection` 等待状态。
8. 用户确认配色或输入自定义颜色后，写入用户原始颜色输入、最终配色和选择理由。
9. 在同一 Gate 下写入 `typography-selection` 等待状态。
10. 用户确认字体字号或输入自定义排版方向后，写入用户原始输入、最终排版系统和选择理由。
11. 在同一 Gate 下写入 `design-exclusions` 等待状态。
12. 用户确认设计禁区后，再输出视觉原型。
13. 在 `prototype-approval` Gate 前写入检查点并等待。
14. 处理高影响 UX 交互问题，必要时进入 `interaction-decision` Gate。
15. 按已批准方向生产实现。
16. 按目标终端完成浏览器或可替代证据 QA。
17. 创建或更新 `VISUAL_DESIGN.md`。
18. 在 `completion-approval` Gate 展示证据，等待用户明确关闭。
19. 用户批准后，Steward 才能写入 `status: completed` 与 `sealed: true`。

Lightweight Mode 可跳过完整视觉流程，但仍必须读取已有 `VISUAL_DESIGN.md`。Fast Profile 是 lightweight 的加速形态，记录为 `mode: "lightweight"` + `execution_profile: "fast"`；它可以跳过不适用的视觉方向或原型 Gate，但不能跳过 Design Contract、Review Lens、证据记录和 `completion-approval`。Delegated Mode 可让 Codex 自动处理普通设计细节，但任务封存仍必须由用户明确批准。

进入 `completion-review` 前，v0.1.3 需要 Context-bound Final Review。它基于当前 `STATE.md`、Design Contract、Review Lens、已批准决定、Reference Selection、Approved Color Direction、Project Memory 和实际 QA 证据，不是脱离上下文的通用审美审计。

会员体系、定价模型、功能边界、权限与套餐、产品策略、PRD 或 decision map 使用 `domain: PD`。后续 UX Work Item 可以通过 `predecessors` 只读继承 sealed PD 事件的产品约束。

## 手动安装

跨 Codex / Claude / Cursor 的场景建议优先使用上面的兼容安装脚本。下面保留 Codex-only 手动安装方式。

1. 将 [skills/design-engineering](skills/design-engineering/) 复制到用户级 Skill 目录：

   ```text
   ~/.agents/skills/design-engineering/
   ```

2. 将 [agents/design-state-steward.toml](agents/design-state-steward.toml) 复制到目标项目：

   ```text
   .codex/agents/design-state-steward.toml
   ```

3. 将 [templates/project/AGENTS.fragment.md](templates/project/AGENTS.fragment.md) 合并进目标项目根目录的 `AGENTS.md`。不要覆盖用户已有内容。

4. 将 [templates/project/docs/design](templates/project/docs/design/) 复制到目标项目的 `docs/design/`。

5. 如果有自己的参考图，放入：

   ```text
   docs/design/reference-images/
   ```

   长期可复用产品参考放在 `docs/design/reference-library/`；色卡注册表放在 `docs/design/reference-library/assets/color-cards/`；某个任务的实际参考选择放在该 Work Item 的 `REFERENCE_SELECTION.md`。长期项目记忆放在 `docs/design/project-memory/`；交付物入口和归档放在 `docs/design/outputs/`。

6. 开启新的 Codex 会话，用只读 Prompt 验证：

   ```text
   使用 $design-engineering 检查项目上下文，不要修改文件。
   ```

   预期结果是 Steward 返回 `NO_STATE`，且不创建 Work Item。

## 项目初始化后的结构

```text
product-repository/
├── AGENTS.md
├── .codex/
│   └── agents/
│       └── design-state-steward.toml
└── docs/
    └── design/
        ├── WORK_ITEMS.md
        ├── VISUAL_DESIGN.md
        ├── project-memory/
        │   ├── BUSINESS_CONTEXT.md
        │   ├── PRODUCT_DESIGN.md
        │   ├── UX_DESIGN.md
        │   ├── VISUAL_DESIGN.md
        │   ├── ENGINEERING_CONTEXT.md
        │   └── DECISIONS.md
        ├── outputs/
        │   ├── index.yml
        │   ├── current/
        │   └── archive/
        ├── reference-images/
        ├── reference-library/
        │   ├── product-index.md
        │   ├── pattern-index.md
        │   ├── products/
        │   ├── patterns/
        │   └── assets/color-cards/
        │       ├── palette-index.yml
        │       ├── images/
        │       ├── palettes/
        │       └── annotations/
        └── work-items/
            └── DE-001-example/
                ├── STATE.md
                └── REFERENCE_SELECTION.md
```

## 完整示例

[examples/idea-storm-lab](examples/idea-storm-lab/) 展示三个连续请求：

1. “检查项目上下文”返回 `NO_STATE`。
2. “优化前端样式”创建 `DE-001`，完成 Visual Seed、参考解析、配色确认、字体字号确认、设计禁区确认、视觉原型、实现、QA、`VISUAL_DESIGN.md` 更新和用户关闭批准，最终 `completed + sealed`。
3. “统一内容模块问题长度换行”与 `DE-001` 相关，但因为前任已封存，所以创建 `DE-002` successor，读取并遵守 `VISUAL_DESIGN.md`，用 `REFERENCE_SELECTION.md` 记录本任务参考选择，停在 `completion-approval`。

[examples/lifecycle-memory-lab](examples/lifecycle-memory-lab/) 展示 v0.1.3 的 Lifecycle Event ID、Project Memory、outputs archive/current、Context-bound Final Review、`domain: PD` 会员体系事件，以及后续 UX 事件如何只读继承 sealed PD predecessor。

[examples/product-business-modeling](examples/product-business-modeling/) 展示 v0.2.3 Business Modeling 的 Seat-based pricing 被动触发、BM Work Item、影响分析、单一总览和人类决策等待；其中 `work-order-intelligent-dispatch` 示例展示 Greenfield 业务模型的完整合同收口。业务模型评测场景位于 [evals/product-business-modeling](evals/product-business-modeling/)。

## 跨 Thread 恢复

新 Thread 不等于新任务。Codex 应读取 `docs/design/WORK_ITEMS.md`、语义相关的 `STATE.md` 和已有 `VISUAL_DESIGN.md`，再显式调用 `design_state_steward`。如果用户说“继续上次前端样式任务，我批准原型”，且 `DE-001` 未封存，Steward 应返回 `RESUME` 并记录 Gate 批准。

## 并行任务

同一项目可以同时存在多个 active Work Item。`WORK_ITEMS.md` 同时列出它们，但每个 Work Item 仍只能有一个权威 `STATE.md`。当用户请求含糊，例如“继续之前的界面改动”，且有多个合理候选时，必须返回 `AMBIGUOUS`，不写状态，等待用户选择。

## 封存后的后续需求

封存状态：

```yaml
status: completed
sealed: true
```

不得恢复为 active，也不得继续追加实现阶段。新的相关需求应创建 `SUCCESSOR`，并在新状态的 `predecessors` 中引用旧 Work Item。

## 当前限制

- 没有 CLI 产品、Hook、Codex Plugin 或 Marketplace 分发。
- 没有 `statectl`、Schema 校验脚本或自动索引生成器。
- 不自动生成 ready 色卡；只有用户提供图片或明确视觉描述后，才能生产完整色卡知识。
- 没有并发写锁；写入前需要重新读取索引和状态。
- 不自动读取全部历史对话。
- 不自动从互联网抓取或保存第三方参考图。
- 不在 `reference-library/` 下创建 Work Item 专属 `reference-packs/`。
- 不创建 `docs/design/product-work-items/`；UX 与 PD 都在 `docs/design/work-items/` 下通过 `domain` 区分。
- 不默认创建项目根目录 `outputs/`；设计交付物放在 `docs/design/outputs/`。
- 浏览器验证是推荐流程，不绑定特定工具。
- Product Business Modeling v0.2.3 是 runtime-aware 但仍为文档型能力，不提供 CLI、Hook、插件包、安装器、外部运行时依赖、自动数据库迁移或 API 生成。
- Product Business Analysis v0.1.4 是 standalone 且文档型能力，不提供 Motivation Analysis 集成、跨能力 Trigger、downstream views、共享 Work Item 目录、实施 Runbook、样例数据、脚本、UI / 技术设计、主动执行提议、CLI、Hook、插件包、安装器、外部运行时依赖、自动 D2/D3 决定或方案设计实现流程。

## v0.1 路线图

本仓库的 v0.1.3-alpha 范围仍是文档型、可手动复用、可真实试运行的协议闭环。Lifecycle Memory 是 v0.1.2-alpha Color Card Registry 之上的增量，不是 v0.2。后续版本计划见 [CHANGELOG.md](CHANGELOG.md) 和 [docs/PRD.md](docs/PRD.md) 的路线图。

## 官方 Codex 机制参考

- [Agent Skills](https://developers.openai.com/codex/skills)
- [Subagents](https://developers.openai.com/codex/subagents)
- [AGENTS.md](https://developers.openai.com/codex/guides/agents-md)
