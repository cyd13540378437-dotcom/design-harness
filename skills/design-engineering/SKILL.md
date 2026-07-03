---
name: design-engineering
description: 对新产品界面、重要功能页面、跨页面用户流程和显著 UI/UX 改造执行人参与的设计工程工作流。负责识别或恢复 Work Item，执行 Surface Resolution、参考库消费、Color Card Registry 消费、Visual Seed、参考解析、配色确认、字体字号与排版系统确认、设计禁区确认、视觉原型、实现验证与完成确认，并通过 STATE.md、REFERENCE_SELECTION.md 与 VISUAL_DESIGN.md 跨 Codex 对话恢复状态。
---

# Design Engineering

当用户请求涉及重要产品设计或 UI/UX 工程时使用本 Skill：新界面、重要功能页、跨页面流程、大范围视觉重构、视觉方向不明确，或需要用户批准的产品交互。

不要为了流程完整而创建无意义状态。只读检查、代码解释、临时研究和极小的安全非设计修改通常应解析为 `NO_STATE`。

## 核心规则

父级 Agent 在开始状态化设计工作前，必须显式调用状态 Steward。Codex 中调用 `design_state_steward`；Claude Code 中使用 `design-state-steward` subagent；Cursor 中若没有 subagent 机制，则按 `.cursor/design-harness/agents/design-state-steward.md` 的状态规则由主 Agent 执行。父流程不得自行伪造或推断 Steward 的状态解析结果。

Steward 只负责状态。父级 Agent 继续负责产品推理、参考图解析、视觉方案、实现、验证和用户沟通。

不得新增 Gate 枚举。配色确认、字体字号与排版系统确认、设计禁区确认是 `visual-direction-approval` 下的视觉子检查点，不是 `palette-approval`、`typography-approval`、`design-exclusion-approval` 或 `anti-homogeneity`。

不得要求用户填写产品人格、品牌气质矩阵或用户感受目标表单。可以把这些作为内部分析语言，但用户流程应围绕 Visual Seed、参考图片、配色样张、字体字号样张、设计禁区和视觉原型。

如果项目存在 `docs/design/reference-library/`，视觉方向前必须先执行 Surface Resolution，再按目标终端和任务内容检索参考库。参考资源是 Agent 的判断证据，不是用户必须掌握的专业词汇；给用户的方向必须用业务语义和取舍表达，不得让用户在产品名之间做专业选择。

每个状态化 UI/UX Work Item 的参考消费结果应写入该任务目录下的 `REFERENCE_SELECTION.md`。`STATE.md` 只记录目标终端、Reference Selection 链接、采用原则摘要、用户批准方向和关键排除项。

如果项目存在 `docs/design/reference-library/assets/color-cards/palette-index.yml`，配色方向前必须读取 Color Card Registry。色卡不是图片；有效色卡必须由 `palette-index.yml` entry、image、palette 和 annotation 共同组成。只有 `status: ready` 且 `gate_preview: true`，并通过路径和 ID 完整性检查的色卡，才能进入 `visual-direction-approval`。配色确认必须展示大图色卡和业务语义，不得只用 HEX/RGB 或小色块让用户决定。

## 模式

`full`：默认用于新页面、重要模块、跨页面流程、方向不明确或重要 UX 改动。执行完整视觉流程和所有适用 Gate。

`lightweight`：用于既有视觉基线内的小范围 UI 修改。可以跳过完整视觉方向和原型 Gate，但必须读取已有 `docs/design/VISUAL_DESIGN.md`，状态化任务仍必须经过完成批准。

`delegated`：当用户明确要求 Codex 自行决定普通细节时使用。Codex 可以处理低影响视觉选择，但权限、删除、隐私、付费、不可逆行为、核心产品语义、明显改变已批准视觉基线的方向和最终封存仍必须询问用户。

## 必须执行的状态解析

状态化设计任务开始时：

1. 读取项目 `AGENTS.md`。
2. 读取现有 `docs/design/WORK_ITEMS.md`。
3. 读取语义相关的 active、paused 和 sealed `STATE.md`。
4. 读取 `docs/design/VISUAL_DESIGN.md`，如果存在。
5. 检查 `docs/design/reference-library/` 是否存在；若存在，后续视觉方向必须按 Surface Resolution 检索它。
6. 检查 `docs/design/reference-library/assets/color-cards/palette-index.yml` 是否存在；若存在，配色方向必须按 Color Card Registry 规则检索它。
7. 显式调用状态 Steward：Codex 使用 `design_state_steward`，Claude Code 使用 `design-state-steward`，Cursor 使用已安装的 steward 规则文件。
8. 只接受以下结果之一：

   ```text
   CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
   ```

9. 若结果为 `AMBIGUOUS`，请用户选择并停止。
10. 若结果为 `NO_STATE`，不创建设计状态，直接完成当前请求。

不得恢复 `completed + sealed` 状态。相关后续工作必须使用 `SUCCESSOR`。

## Gate 协议

每个 Gate 或视觉子检查点前，先让 `design_state_steward` 写入检查点：当前 phase、gate、`awaiting_user: true`、正文中的视觉子步骤、简洁上下文、可选方案和下一步行动。

用户回复 Gate 后，先让 `design_state_steward` 记录批准、拒绝、修改要求、暂停或 successor 指令，再继续工作。

如果 Steward 结果与用户当前明确回复冲突，以用户当前回复为准，并相应更新状态。

不得让多个 Agent 同时写同一个 `STATE.md`。

## Full 工作流

### 0. 状态解析

将当前请求解析为 `CREATE`、`RESUME`、`SUCCESSOR`、`NO_STATE` 或 `AMBIGUOUS`，并读取已有项目视觉基线。

### 1. 业务理解、Surface Resolution 与 Visual Seed

总结：

- 目标用户
- 核心任务
- 成功标准
- 业务约束
- 技术约束
- 未解决问题
- 用户原始 Visual Seed

Visual Seed 只记录用户原文，可以为空。不要强制归纳为产品人格。

在提出视觉方向前解析目标终端：

```yaml
primary_surface: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
secondary_surfaces: []
explicitly_out_of_scope: []
evidence: []
open_questions: []
```

如果终端能从用户请求、项目结构、技术栈或已有状态判断，直接记录假设并继续。只有终端不明确且会显著影响参考选择、原型范围或实现方式时，才询问用户。

### 2. Reference Library、Color Card Registry、参考图片与参考包

若项目存在 `docs/design/reference-library/`，先按以下顺序检索：

1. 同终端；
2. 同页面类型；
3. 同任务类型；
4. 相近内容密度和交互复杂度；
5. 相近用户成熟度；
6. 相邻行业；
7. 视觉标签。

将本任务实际选择和排除的参考写入 `docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md`。跨终端参考只能用于抽象模式，不得直接落地布局、导航、密度、手势或视觉比例。

若项目存在 `docs/design/reference-library/assets/color-cards/palette-index.yml`，在提出配色方向前读取注册表并执行完整性检查：排除 `draft`、`deprecated`、缺少 image / palette / annotation、文件 stem 与 id 不一致、palette id 不一致或 annotation frontmatter id 不一致的条目。只有 `status: ready` 且 `gate_preview: true` 的色卡可作为用户确认候选。

将本任务考虑、排除和最终采用的色卡写入 `REFERENCE_SELECTION.md`。`STATE.md` 只记录已批准色卡 ID、标题、采用摘要、风险摘要和 `REFERENCE_SELECTION.md` 链接。

按以下优先级收集视觉参考：

1. 用户在对话中上传的参考图片。
2. 用户放入项目 `docs/design/reference-images/` 的图片。
3. 项目已有 `VISUAL_DESIGN.md` 中记录的参考。
4. 项目 `reference-library/` 中匹配当前终端和任务的 Product / Pattern Reference。
5. 本 Skill 内置 `assets/visual-reference-packs/`。
6. 只有文字时，使用 Visual Seed 生成候选方向。

解析时只描述可观察视觉特征，明确区分可借鉴和不应复制。不自动从互联网抓取或保存第三方产品截图。

视觉方向给用户时使用“效率工作台 / 引导式助手 / 内容探索 / 快速记录”等业务语言。可以说明参考依据，但不要把产品名作为用户必须理解的选项。

### 3. 配色确认

完整视觉设计前必须先确认配色。每次 `palette-selection` 必须提出至少 3 套候选调色盘；可以标注推荐方案，但不得只给 1 套让用户确认。

如果存在通过完整性检查的 ready 色卡，配色候选应优先使用大图色卡和业务语义表达：标题、适合场景、代价、推荐用法和无障碍风险。色卡候选可以作为候选调色盘的视觉依据，但不得让用户主要通过 HEX/RGB、token 表或小色块 icon 做决定。若没有可用 ready 色卡，应说明 registry 中没有可用候选，并继续使用非 registry 的配色方案。

必须把候选配色放在同一个调色盘对比板中展示。每套配色都必须配同构的小型 UI 样张，不得只给色值。用户应能横向比较不同配色在同一组按钮、卡片、标签、导航、文字和状态上的实际效果。

对用户展示：

- 主色：主要按钮、关键状态、当前选中项
- 次色：辅助强调、标签、次级操作
- 末级强调色：轻量装饰、局部提示、低优先级视觉变化

实现记录还应包含背景、文字、边框和语义色。

每套候选还必须提供简短对比说明：

- 主要文字与背景的可读性；
- 按钮文字与主色的对比；
- 次级文字、边框和标签是否足够清楚；
- 该方案更适合的情绪或使用场景；
- 明显风险，例如过亮、过冷、过甜、过度企业感或弱对比。

写入等待状态：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文写：

```text
视觉子步骤：palette-selection
```

在用户确认前停止。用户确认后，先让 Steward 记录批准决定、已确认配色、被比较过的候选调色盘摘要和选择理由。

用户可以不选择 A/B/C，而是直接补充自己的颜色偏好，例如“主色用白色”“少点紫色”“背景要黑色”“用品牌红”。这种回复仍然视为 `palette-selection` 的用户决定。父级 Agent 必须基于用户输入调整最终配色，并让 Steward 记录：

- 用户原始颜色输入；
- 候选调色盘或色卡对比摘要；
- 若采用 Color Card，记录 color-card ID、title、image path、palette path、annotation path；
- 最终采用的配色规格；
- 是否从候选方案或色卡派生；
- 选择或调整理由。

### 4. 字体字号与排版系统确认

配色确认后、视觉原型前，Full Mode 必须确认排版系统。若项目已有明确 `VISUAL_DESIGN.md` 或设计系统字体规范，且本任务不改变排版基线，可以继承并记录为已确认；否则进入 `typography-selection` 子检查点。

字体方案必须用同构 UI 样张展示，不得只给字体名或字号表。候选应覆盖标题、正文、导航、按钮、表单标签、辅助说明、数据/代码或长内容场景。若没有品牌指定字体，优先使用系统字体或开源/可商用字体，并说明加载成本、授权风险、回退链和跨平台表现。

每个候选或最终排版系统必须记录：

- 字体族与 fallback stack；
- 字号阶梯或 token：display、title、heading、body、label、caption、code/data；
- 行高、字重、字距；字距默认 `0`，除非项目已有明确品牌规范；
- 不同终端或断点的字号调整；
- 长文本、密集数据、表单、按钮和状态文案的用途映射；
- 可读性风险，例如过小、过窄、行高不足、中文/英文混排不稳、Web 字体加载失败或授权不明。

写入等待状态：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文写：

```text
视觉子步骤：typography-selection
```

在用户确认前停止。用户确认后，先让 Steward 记录批准决定、用户原始字体/字号输入、候选对比摘要、最终排版系统和选择理由。

### 5. 设计禁区确认

字体字号与排版系统确认后，基于产品上下文、Visual Seed、参考解析、已确认配色、已确认排版系统和已有 `VISUAL_DESIGN.md` 生成 4-8 条简短、可执行的设计禁区。

写入等待状态：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

正文写：

```text
视觉子步骤：design-exclusions
```

在用户确认前停止。用户确认后，先让 Steward 记录批准决定和已确认设计禁区。

### 6. 视觉原型

优先使用现有 Storybook，其次是隔离预览路由，再其次是独立 HTML/CSS 原型；只有无法运行 UI 时才使用静态图。

原型必须体现页面结构、信息层级、内容密度、核心组件、已确认配色、已确认字体字号与排版系统、已确认设计禁区、关键响应式表现，以及空、加载、错误等状态之一。

方案数量规则：

- 视觉输入清晰：输出 1 个主方案。
- 参考图冲突或用户不确定：输出 2 个方案。
- 用户完全没有参考图且未选择参考包：输出 2-3 个方向。
- 不得输出只有颜色或圆角差异的伪方案。

Gate：`prototype-approval`

在用户明确批准或要求修改前停止。

### 7. UX 流程与关键交互

检查入口与完成路径、返回与取消、加载、空状态、错误、权限、首次使用、网络失败、长内容、键盘、移动端、破坏性操作和成功反馈。

Gate：`interaction-decision`

只有未解决交互会显著改变产品行为时才使用此 Gate。

### 8. 生产实现

按照已批准状态、Surface Target、Reference Selection、配色、字体字号与排版系统、设计禁区和原型实现。复用本地组件和设计令牌。不要创建平行设计系统，也不要静默偏离已批准方向，不直接照搬第三方截图或品牌资产。

若出现新的高影响歧义，返回对应 Gate。

### 9. 审查与验证

优先使用真实浏览器按目标终端验证，并对照 `REFERENCE_SELECTION.md` 中的设计原则检查。验证内容必须包含字号、行高、字重、长文本换行、按钮/标签内文字容纳、移动端可读性和 Web 字体 fallback。将证据记录到 `STATE.md`。如果无法完成真实浏览器验证，记录为 blocker 或剩余风险；不得声称视觉 QA 已通过。

第三方 UI 或浏览器 Skill 可作为可选增强；缺失时不得阻塞核心流程。

### 10. 视觉基线更新

视觉 Work Item 完成前，必须创建或更新 `docs/design/VISUAL_DESIGN.md`，除非在 `STATE.md` 中说明无需更新的理由。

`VISUAL_DESIGN.md` 只记录已确认视觉结果：Visual Seed、参考解析、已确认配色、已确认字体字号与排版系统、已确认设计禁区、组件语言、布局原则和示例。不要写入未批准实验方案。

### 11. 完成确认

关闭前，先请 `design_state_steward` 检查 closure readiness。检查必须包含 `VISUAL_DESIGN.md` 是否已创建或更新，或无需更新的理由。

若已准备好，进入：

```yaml
phase: completion-review
gate: completion-approval
awaiting_user: true
```

向用户展示：

- 已完成内容
- 验收标准结果
- 验证证据
- `VISUAL_DESIGN.md` 更新状态
- 剩余限制
- 建议关闭、继续、暂停或创建 successor

Gate：`completion-approval`

只有用户明确批准关闭后，`design_state_steward` 才能封存状态。

## 参考

- [workflow-model.md](references/workflow-model.md)
- [visual-workflow.md](references/visual-workflow.md)
- [reference-library-consumption.md](references/reference-library-consumption.md)
- [color-card-consumption.md](references/color-card-consumption.md)
- [human-in-the-loop.md](references/human-in-the-loop.md)
- [state-lifecycle.md](references/state-lifecycle.md)
- [state-resolution.md](references/state-resolution.md)
