# Codex Design Harness — 产品需求文档

- **版本**：v0.1.0-alpha / visual-workflow revision
- **文档状态**：可执行草案
- **目标仓库名**：`codex-design-harness`
- **产品显示名**：Design Engineering Harness
- **主要语言**：简体中文；配置字段、状态枚举、文件名使用英文
- **发布日期目标**：完成首个可手动复用、可真实试运行的 GitHub 仓库
- **本版核心变化**：保留 Work Item / STATE.md / Gate / Steward 的状态架构，重写视觉设计流程，减少抽象输入，增加参考图片、配色确认、设计禁区确认、视觉参考包和项目级视觉设计文档。

---

## 1. 产品摘要

Codex Design Harness 是一套面向 Codex 的 **Human-in-the-loop 产品设计工作流**。

它把一次普通的 UI/UX 开发请求，组织为可恢复、可审计、有人类审批门槛、并能沉淀视觉设计结果的任务生命周期：

```text
识别当前工作任务
→ 理解业务与设计目标
→ 收集视觉种子与参考图片
→ 解析可观察视觉特征
→ 输出并确认配色方案
→ 输出并确认设计禁区
→ 输出视觉原型
→ 确认关键 UX 决策
→ 生产实现
→ 浏览器与规范验收
→ 输出或更新视觉设计文档
→ 请求用户确认关闭
→ 封存任务状态
```

本产品不是新的 UI 组件库，也不是单纯的长 Prompt。它由以下核心构件组成：

```text
AGENTS.md 规则片段
        ↓
design-engineering Skill
        ↓
design_state_steward 自定义 Agent
        ↓
Work Item + STATE.md
        ↓
用户 Gate + 视觉流程 + 实现与验收
        ↓
VISUAL_DESIGN.md
```

其中：

- **Codex 对话线程**是临时工作现场；
- **Work Item** 是可独立验收的产品或设计任务；
- **`STATE.md`** 是该 Work Item 的权威状态快照；
- **`WORK_ITEMS.md`** 是导航索引，不是权威状态来源；
- **`design-engineering`** 负责编排设计工程流程；
- **`design_state_steward`** 负责状态解析、状态写入、Gate 检查点、关闭检查和封存；
- **`VISUAL_DESIGN.md`** 是项目级视觉基线文档，由已确认的设计结果沉淀而来；
- **用户**保留目标解释权、视觉偏好确认权、重大决策权、纠偏权和最终关闭权。

---

## 2. 背景与问题

使用 Codex 开发产品时，常见问题包括：

1. 新对话无法稳定恢复之前已经确认的设计方向和业务决定；
2. 对话线程被误当成任务边界，同一个任务可能产生多份互相冲突的记忆；
3. 相近的新需求可能被错误并入已完成任务，或反过来重复创建任务；
4. Codex 容易先完成高成本实现，再让用户被动“确认”；
5. 关键交互存在歧义时，Codex 可能自行决定并形成产品行为；
6. “代码完成”常被误认为“产品任务完成”；
7. 用户无法清楚知道一个任务当前位于哪个阶段、等待什么决定；
8. 已完成任务缺少封存语义，后续对话可能静默改写历史结论；
9. 视觉设计结果容易同质化，尤其容易退回普通 SaaS dashboard、白底卡片、蓝紫渐变、通用圆角组件等默认样式；
10. 让非 UX 用户输入“产品人格”“品牌气质”“用户感受目标”等抽象分类，会增加流程难度，且 Agent 难以稳定转译为具体视觉；
11. 如果没有参考图片、配色确认和设计禁区，Agent 往往只能依赖通用审美，最终输出缺少项目识别度；
12. 即使第一个页面做出较好效果，如果没有项目级视觉基线，后续 Work Item 仍可能重新回到默认视觉风格。

现有 Prompt、Skill 和 `AGENTS.md` 可以提供流程指令，但单独使用时仍缺少：

- 明确的任务身份；
- 跨线程状态恢复；
- 生命周期与 Gate；
- 已批准决定的持久记录；
- 完成后的只读封存；
- 新任务与前任任务的关系表达；
- 面向非专业用户的低抽象视觉流程；
- 可复用的视觉参考图片库；
- 项目级视觉设计文档。

---

## 3. 产品愿景

让 Codex 从“接到需求就写代码的执行者”，升级为一个遵循产品开发协议的设计工程协作者：

> AI 负责理解、比较、拆解、生成、实现和验证；人负责目标、偏好确认、高影响决策与最终责任。

在视觉设计上，本产品不要求用户掌握 UX 或品牌方法论，而是通过更具体的中间产物来推进：

```text
用户给出粗略方向或参考图
→ Agent 拆解图片中的可执行视觉特征
→ Agent 先给配色和设计禁区
→ 用户确认具体产物
→ Agent 再执行视觉设计和生产实现
```

长期愿景是形成可安装的 Codex Plugin；但 v0.1 只验证工作流本体、状态模型和视觉流程文档化能力。

---

## 4. v0.1 目标

### 4.1 核心目标

v0.1 必须实现：

1. 一个可被 Codex 识别和调用的 `design-engineering` Skill；
2. 一个项目级 `design_state_steward` 自定义 Agent；
3. 每个独立 Work Item 拥有一个权威 `STATE.md`；
4. 在任务开始时解析 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`；
5. 在视觉方向、静态原型、关键交互和任务关闭处提供 Human Gate；
6. 支持不同 Codex 对话继续同一个 Work Item；
7. 支持同一项目中多个 Work Item 并行存在；
8. `completed + sealed` 的状态不可恢复执行，只能只读引用；
9. 用户明确批准后才可关闭并封存任务；
10. 提供完整 README、模板、真实示例和人工评测场景；
11. 提供面向非 UX 用户的视觉流程：视觉种子、参考图片、参考解析、配色确认、设计禁区确认、视觉原型；
12. 提供自制视觉参考图片包，供用户没有参考图时选择；
13. 在项目模板中提供 `VISUAL_DESIGN.md`，用于沉淀已确认的项目视觉基线；
14. 示例必须展示配色确认、设计禁区确认和视觉设计文档的生成或更新。

### 4.2 成功标准

一个没有参与本产品设计的人应能够：

- 阅读中文 README 理解核心概念；
- 在 10 分钟内手动把 Skill 和 Agent 复制到 Codex 环境；
- 在任意 Git 项目中初始化状态目录；
- 通过示例理解什么时候创建、恢复、继任或不创建状态；
- 用两个不同 Codex 对话继续同一个任务；
- 验证封存任务不会被重新激活；
- 不需要阅读本 PRD 也能正确使用仓库；
- 不需要理解“产品人格”等抽象分类，也能通过参考图片和色板确认推进视觉设计；
- 在没有外部组件库和额外 Skill 的情况下，仍能完成一个可审查的视觉设计流程；
- 在完成首个视觉 Work Item 后，获得一份可被后续任务复用的 `VISUAL_DESIGN.md`。

---

## 5. v0.1 非目标

以下内容明确不属于 v0.1：

- 自动安装器；
- Codex Plugin 和 Marketplace 发布；
- CLI；
- Hook；
- `statectl.py` 或确定性状态机脚本；
- 云端数据库或同步服务；
- 多用户并发锁；
- GitHub Issues、Linear、Jira 集成；
- 自动读取或索引全部 Codex 对话；
- 完整项目管理系统；
- 自研 UI 组件库；
- 打包或复制第三方 Skill；
- 版本级聚合状态机；
- 强制用户输入产品人格、品牌人格、情绪坐标、品牌气质矩阵；
- 新增“反同质化 Gate”；
- 自动从互联网抓取、保存或复制第三方产品截图；
- 保证生成商业级品牌系统；
- 代替专业设计师完成完整品牌策略。

v0.1 可以在 `STATE.md` 中记录 `release` 字段，但不为每个 Release 创建独立状态树。

---

## 6. 目标用户

### 6.1 主要用户

- 使用 Codex 独立开发产品的创作者；
- 同时承担产品、UX、UI 和前端工作的个人开发者；
- 没有专业设计背景，但希望获得更稳定视觉流程的用户；
- 希望不同 Codex 对话共享可靠任务记忆的用户；
- 希望 AI 在关键节点主动请求确认，而不是擅自做产品决定的用户。

### 6.2 次要用户

- 使用 Codex 的小型产品团队；
- 希望将设计流程沉淀为仓库规则的团队；
- 希望研究 Agent 工作流、状态管理和 Human-in-the-loop 的开发者；
- 想为内部项目积累轻量设计规范的前端工程师。

---

## 7. 核心概念

### 7.1 Thread

Codex 的一次对话或工作线程，是临时交互现场，不是任务身份。

一个 Thread 可以：

- 继续一个已有 Work Item；
- 创建一个新 Work Item；
- 在用户确认后切换到另一个 Work Item；
- 只做探索而不创建状态。

同一个 Work Item 可以跨越多个 Thread。

### 7.2 Work Item

Work Item 是具有以下特征的独立工作流实例：

- 独立业务目标；
- 清晰范围；
- 可验证的验收标准；
- 一个或多个设计 Gate；
- 明确结束条件；
- 可独立关闭和封存。

Work Item 不等于版本，也不等于对话。

### 7.3 `STATE.md`

`STATE.md` 是某个 Work Item 的：

```text
当前状态快照
+ 当前 Gate
+ 已批准决定摘要
+ 视觉输入与视觉子步骤
+ 待确认问题
+ 重要假设
+ 验收标准
+ 验证证据
+ 下一步行动
+ 相关任务链接
```

它是 **有损上下文压缩文件**，不是完整聊天记录，也不是无限追加的日志。

它类似“游戏存档”，而不是“游戏录像”。

### 7.4 `WORK_ITEMS.md`

`WORK_ITEMS.md` 是项目中的导航索引和缓存，不是最终权威来源。

若索引与各 Work Item 的 `STATE.md` 冲突：

> `STATE.md` 为准，`design_state_steward` 应修复索引。

### 7.5 Gate

Gate 是工作流必须等待人类决定的阶段边界。

v0.1 支持以下 Gate 枚举：

- `work-item-binding`：仅在任务归属不明确时；
- `visual-direction-approval`；
- `prototype-approval`；
- `interaction-decision`；
- `completion-approval`。

本版不新增 `palette-approval` 或 `design-exclusion-approval` 枚举。配色确认和设计禁区确认是 `visual-direction-approval` 下的视觉子检查点。

### 7.6 Sealed State

当 Work Item 完成并由用户批准关闭后：

```yaml
status: completed
sealed: true
```

该状态：

- 不得恢复为 active；
- 不得继续追加新的实现阶段；
- 不得静默改写已批准决定；
- 可以只读检索和引用；
- 可以成为新 Work Item 的 predecessor。

任何后续工作必须创建 `SUCCESSOR`。

### 7.7 Visual Seed

Visual Seed 是用户对视觉方向的原始输入。

它可以是：

- 一个词；
- 一句话；
- 一段描述；
- 产品名或参考产品名；
- 空输入。

示例：

```text
极简、干净，有一点内容产品感
```

```text
更像创作者工具，不要传统后台
```

```text
我说不清，先看参考图
```

Visual Seed 只记录用户原文，不强制归纳为产品人格。

### 7.8 Reference Images

Reference Images 是用户上传或放入仓库的设计参考图片。

参考图片可以来自：

- 用户上传到当前对话的图片；
- 项目中已有的图片文件；
- 用户放入 `docs/design/reference-images/` 的图片；
- 本仓库提供的自制视觉参考包。

Agent 应分析图片中的可观察视觉特征，而不是要求用户解释抽象偏好。

### 7.9 Palette

Palette 是视觉流程中必须先于完整视觉设计确认的配色方案。它不是单套色值清单，而是至少 3 套候选调色盘及其 UI 效果对比。

对用户展示时至少包含：

- 主色；
- 次色；
- 末级强调色。

每次 `palette-selection` 必须提供至少 3 套候选调色盘。Agent 可以标注推荐方案，但不得只给 1 套让用户确认。

用户可以选择候选调色盘，也可以直接输入自己的颜色偏好，例如主色、背景色、品牌色或“少点紫色”。直接输入颜色同样是有效的 `palette-selection` 用户决定。

实现和文档中还应包含：

- 页面背景色；
- surface 色；
- elevated surface 色；
- 主要文字色；
- 次级文字色；
- muted 文字色；
- border / divider；
- success / warning / error / info 等语义色。

用户确认的是调色盘在同构 UI 样张中的实际感受，不只是色值列表。候选调色盘必须能横向比较颜色对比、文字可读性、按钮状态、卡片层级和标签/状态表达。若用户直接输入颜色偏好，Agent 必须基于该偏好调整最终配色，并记录它与候选调色盘的关系。

### 7.10 Design Exclusions

Design Exclusions 是简化后的视觉禁区。

它不是复杂的品牌策略文档，而是一组短句，用于告诉 Agent 不要走哪些视觉方向。

示例：

```markdown
不要：
- 普通 SaaS 后台感
- 大面积蓝紫渐变 AI 工具风
- 玻璃拟态卡片堆叠
- 过度圆角和过度留白
- 看起来像模板站
```

设计禁区由 Agent 根据产品上下文、视觉种子、参考图片和已选配色生成，再交给用户确认。

### 7.11 `VISUAL_DESIGN.md`

`VISUAL_DESIGN.md` 是项目级视觉基线文档。

它不是任务状态，不替代 `STATE.md`。它的价值是：在一个 Work Item 完成视觉设计后，将可复用的视觉决定沉淀下来，供后续 Work Item 读取。

职责划分：

```text
STATE.md
记录某个 Work Item 当前状态、Gate、批准决定、验收标准和验证证据。

VISUAL_DESIGN.md
记录项目长期复用的视觉基线：参考图、配色、禁区、组件风格、token、示例。
```

`VISUAL_DESIGN.md` 不要求用户一开始填写，而是在视觉方向、原型或生产实现被确认后由 Agent 创建或更新。

### 7.12 Visual Reference Pack

Visual Reference Pack 是本仓库提供的自制视觉参考图片包。

它用于用户没有参考图时，帮助用户通过“选图片”而不是“描述抽象风格”来启动视觉流程。

每个参考包至少包含：

- 2 张自制 SVG 或 PNG 样张；
- `notes.md`，描述可借鉴特征和应避免复制的内容；
- 可使用场景；
- 不适用场景。

参考包不得使用未经授权的第三方产品截图。

---

## 8. 产品原则

### 8.1 状态属于任务，不属于对话

不得因为开启了新 Thread 就创建新 `STATE.md`。

### 8.2 人参与，但不被琐碎问题淹没

只在高影响、互斥、难以撤销或定义产品语义的问题上询问用户。

视觉阶段需要用户确认的不是抽象理论，而是具体产物：参考图理解、配色样张、设计禁区和原型。

### 8.3 具体视觉证据优先于抽象品牌词

不要求非 UX 用户填写产品人格、品牌人格、情绪坐标或气质矩阵。

优先使用：

- 用户原始视觉种子；
- 参考图片；
- Agent 对参考图的可观察特征解析；
- 配色样张；
- 设计禁区；
- 视觉原型。

### 8.4 AI 必须先做决策压缩

提问前应：

- 给出当前理解；
- 解释为什么重要；
- 提供 2–3 个可行选项，或说明为什么当前只需一个主方案；
- 说明影响；
- 给出推荐方案。

### 8.5 高成本实现之前确认

完整视觉设计、核心页面结构和关键交互应在生产实现前确认。

### 8.6 视觉方向不再默认要求固定 2–3 套完整方案

原流程中“Full Mode 必须提出 2–3 个视觉方向”的要求容易制造表面差异。

新版规则：

- 如果视觉输入不清晰、参考图不足或参考之间明显冲突，Agent 应输出 2–3 个候选方向；
- 如果视觉种子、参考图、配色和设计禁区已经清晰，Agent 应输出 1 个主方案，必要时附 1 个备选；
- 不得只通过改颜色、改圆角或换图标伪装成不同方向。

### 8.7 不新增“反同质化 Gate”

同质化问题应通过更好的输入材料和更成熟的视觉步骤解决，而不是新增一个形式化检查点。

Skill 可以写入内部设计要求：避免模板化 SaaS 默认风格、避免只做表面变化、必须依据参考图和配色执行。

但不得让用户审批“是否足够反同质化”。

### 8.8 状态可审计、可恢复、最小化

状态文件只保存恢复工作所需的最小权威上下文。

视觉参考、配色和禁区应以摘要形式保留，详细规范沉淀到 `VISUAL_DESIGN.md`。

### 8.9 关闭权属于用户

Codex 可以判断“达到关闭条件”，但不能单方面宣布 Work Item 已封存。

### 8.10 历史不可被静默重写

已封存 Work Item 的后续变化必须通过 Successor 表达。

---

## 9. 工作模式

### 9.1 Full Mode

适用于：

- 新产品；
- 新页面或重要模块；
- 跨页面流程；
- 大规模 UI/UX 重构；
- 未明确视觉方向；
- 视觉同质化风险较高的页面；
- 存在显著产品交互歧义。

默认执行所有适用 Gate，并执行完整视觉流程：

```text
Visual Seed
→ Reference Images / Reference Packs
→ Reference Analysis
→ Palette Proposal
→ Palette Confirmation
→ Design Exclusions
→ Exclusions Confirmation
→ Visual Prototype
```

### 9.2 Lightweight Mode

适用于：

- 小型组件修改；
- 已有设计系统内的局部功能；
- 明确参考页面下的轻量改造；
- 不改变信息架构的 UI 修复；
- 只需遵守已有 `VISUAL_DESIGN.md` 的局部调整。

可以跳过完整视觉方向和原型 Gate，但有状态的任务仍必须经过完成 Gate。

即使跳过完整视觉流程，也必须读取已有 `VISUAL_DESIGN.md`，避免局部改造破坏项目视觉基线。

### 9.3 Delegated Mode

当用户明确说“你自己决定”“直接完成”“普通问题不用问我”时启用。

可以自动通过普通视觉与原型决策，但以下问题仍必须确认：

- 权限；
- 数据删除或覆盖；
- 隐私；
- 付费或额度；
- 不可逆操作；
- 会改变产品核心语义的互斥流程；
- 会明显改变已批准项目视觉基线的方向。

v0.1 中，**任务封存仍必须在展示完成证据后获得明确用户批准**。

---

## 10. Work Item 解析协议

`design_state_steward` 在状态解析阶段只能返回以下五种结果。

### 10.1 `CREATE`

当前需求是新的独立 Work Item。

触发条件包括：

- 新目标拥有独立验收标准；
- 新目标不属于任何活动 Work Item 的既定范围；
- 与已有任务相关，但不依赖它继续处于活动状态；
- 用户明确要求作为新任务处理。

行为：

- 创建新目录和 `STATE.md`；
- 分配唯一 ID；
- 更新 `WORK_ITEMS.md`；
- 将其绑定为当前工作流。

### 10.2 `RESUME`

当前请求明确属于一个未封存 Work Item。

可恢复状态：

- `active`；
- `paused`；
- 等待用户的 active 状态。

不得对 `completed + sealed` 返回 `RESUME`。

### 10.3 `SUCCESSOR`

当前请求与一个或多个封存任务相关，但应创建新的工作流实例。

行为：

- 创建新 Work Item；
- 在新状态中记录 `predecessors`；
- 旧状态保持只读；
- 更新索引中的关系。

### 10.4 `NO_STATE`

当前请求不需要持久工作流状态。

常见情况：

- 只读检查项目上下文；
- 解释代码；
- 临时研究；
- 极小且一次性的无风险调整；
- 不涉及 UI/UX 工作流的任务。

不得为了“流程完整”而创建无价值状态。

### 10.5 `AMBIGUOUS`

存在多个合理状态或无法确定新旧任务边界。

行为：

- 不创建状态；
- 不修改候选状态；
- 向用户列出候选项；
- 给出推荐；
- 停止并等待用户选择。

---

## 11. 任务切换协议

当一个 Thread 已绑定活动 Work Item，用户又提出明显不同的新需求时，系统不得静默放弃当前任务。

必须判断并提供以下选项中的适用项：

1. 将新需求作为当前 Work Item 的剩余范围；
2. 暂停当前 Work Item，并创建新 Work Item；
3. 当前 Work Item 已达到验收条件，先进入完成确认；
4. 把剩余事项拆为 Successor；
5. 用户明确指定其他处理方式。

未达到完成条件时，不得仅为了切换任务而将当前 Work Item 标记为 completed。

---

## 12. 设计工程工作流

### 阶段 0：状态解析

1. 读取项目 `AGENTS.md`；
2. 读取 `docs/design/WORK_ITEMS.md`；
3. 读取语义相关的活动或封存状态；
4. 读取 `docs/design/VISUAL_DESIGN.md`，如果存在；
5. 显式调用 `design_state_steward`；
6. 获得五类结果之一；
7. 若为 `AMBIGUOUS`，请求用户决定并停止。

### 阶段 1：业务理解与视觉种子

形成：

- 目标用户；
- 核心任务；
- 成功标准；
- 业务约束；
- 技术约束；
- 未解决问题；
- 用户原始 Visual Seed。

Visual Seed 可来自用户输入，也可以为空。

不得要求用户填写：

- 产品人格；
- 品牌气质矩阵；
- 理性 / 感性；
- 专业 / 亲和；
- 克制 / 表现力；
- 工具感 / 内容感；
- 用户感受目标必填表。

这些词可以作为 Agent 内部分析语言，但不能成为用户必须回答的问题。

### 阶段 2：参考图片收集与解析

Agent 应优先使用具体视觉材料。

输入来源优先级：

1. 用户在对话中上传的参考图片；
2. 用户放入项目 `docs/design/reference-images/` 的图片；
3. 项目已有 `VISUAL_DESIGN.md` 中记录的参考；
4. 本仓库内置的 `visual-reference-packs`；
5. 用户只提供文字时，使用 Visual Seed 生成初始候选。

如果用户没有提供参考图，Agent 应从内置视觉参考包中选出 3 个最相关的参考包，并让用户选择更接近哪一个。

Agent 解析参考图片时必须遵守：

- 只描述可观察视觉特征；
- 不把图片归纳成抽象人格；
- 不复制第三方品牌资产；
- 不要求用户解释每张图喜欢什么，先由 Agent 给出理解；
- 明确区分“可借鉴”和“不应复制”。

输出格式：

```markdown
## 参考图解析

### Reference A
来源：用户上传 / 项目文件 / 内置参考包

可借鉴：
- ...
- ...

不应复制：
- ...
- ...

可能影响：
- 配色：...
- 布局：...
- 组件：...
- 信息密度：...
```

若参考图之间存在明显冲突，Agent 应指出冲突，并给出 2–3 个可选处理方式。

### 阶段 3：配色方案

Agent 必须在完整视觉设计之前提出配色方案。

配色方案数量规则：

- 每次 `palette-selection` 至少输出 3 套候选调色盘；
- 可以标注 1 套推荐方案，但仍必须提供另外至少 2 套可比较备选；
- 输入不清晰、参考图冲突或用户犹豫时，可以输出 4–5 套；
- 不得只给色值，必须给调色盘对比板和同构 UI 样张。

调色盘对比板必须让用户看到同一组组件在不同配色下的效果。每套候选都使用相同结构，至少包含：

- 主色、次色、末级强调色、背景、surface、文字、边框和语义色的色块；
- 主按钮、次按钮、卡片、输入框或筛选器、标签或状态徽标、一段正文、一个轻量提示或空状态；
- 主要文字与背景的可读性说明；
- 按钮文字与主色的对比说明；
- 次级文字、边框和标签是否足够清楚；
- 该方案更适合的情绪或使用场景；
- 明显风险，例如过亮、过冷、过甜、过度企业感或弱对比。

每套配色必须包含用户可理解的三级结构：

```markdown
主色：用于主要按钮、关键状态、当前选中项
次色：用于辅助强调、标签、次级操作
末级强调色：用于轻量装饰、局部提示、低优先级视觉变化
```

每套配色还必须包含实现所需基础 token：

```markdown
背景：page / surface / elevated surface
文字：primary / secondary / muted
边框：default border / subtle divider
语义：success / warning / error / info
```

每套配色必须配一个小型 UI 样张，至少包含：

- 主按钮；
- 次按钮；
- 卡片；
- 输入框或筛选器；
- 标签或状态徽标；
- 一段正文；
- 一个轻量提示或空状态。

#### 子检查点：配色确认

在请求用户确认配色前，必须先让 `design_state_steward` 将 `STATE.md` 更新为：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

`STATE.md` 正文的 `## 当前检查点` 应明确写明：

```text
视觉子步骤：palette-selection
等待用户：在至少 3 套候选调色盘中选择 A / B / C，或说明需要调整的颜色方向。
```

用户确认配色后，必须先记录到 `STATE.md` 的 `## 已批准决定`，并记录候选调色盘对比摘要、用户原始颜色输入、已确认配色、最终配色来源和选择理由，再继续设计禁区步骤。

最终配色来源可以是：

```text
candidate / modified-candidate / custom
```

### 阶段 4：设计禁区

配色确认后，Agent 应根据以下材料生成设计禁区：

- 产品上下文；
- Visual Seed；
- 参考图片解析；
- 已确认配色；
- 项目已有 `VISUAL_DESIGN.md`；
- 常见模板化风险。

设计禁区必须简短、可执行，建议 4–8 条。

示例：

```markdown
## 设计禁区

不要：
- 普通 SaaS 后台感
- 大面积蓝紫渐变 AI 工具风
- 玻璃拟态卡片堆叠
- 所有内容都做成独立圆角卡片
- 过度营销式插画
- 过高饱和霓虹强调色
```

#### 子检查点：设计禁区确认

在请求用户确认设计禁区前，必须先让 `design_state_steward` 更新 `STATE.md`：

```yaml
phase: visual-direction
gate: visual-direction-approval
awaiting_user: true
```

`STATE.md` 正文的 `## 当前检查点` 应明确写明：

```text
视觉子步骤：design-exclusions
等待用户：确认、删除或增加设计禁区。
```

用户确认设计禁区后，必须先记录到 `STATE.md` 的 `## 已批准决定`，再进入视觉原型。

### 阶段 5：视觉原型

视觉原型以已确认的参考图理解、配色和设计禁区为准。

原型数量规则：

- 如果视觉输入清晰：输出 1 个主方案；
- 如果参考图冲突或用户仍不确定：输出 2 个方案；
- 如果用户完全没有参考图且未选择参考包：输出 2–3 个方向；
- 不得输出只有色彩差异的伪方案。

优先方式：

1. 现有 Storybook；
2. 隔离的预览路由；
3. 独立 HTML/CSS 原型；
4. 无法运行页面时才使用静态图或 SVG 样张。

原型用于验证：

- 页面结构；
- 信息层级；
- 内容密度；
- 核心组件；
- 已确认配色；
- 设计禁区是否被遵守；
- 关键响应式表现；
- 空、加载、错误等状态之一。

#### Gate：`prototype-approval`

展示入口或截图、待检查重点、未实现内容和风险，然后停止等待。

请求用户确认前必须先让 Steward 写入等待状态：

```yaml
phase: prototype
gate: prototype-approval
awaiting_user: true
```

### 阶段 6：UX 流程与关键交互

至少考虑：

- 入口与完成路径；
- 返回与取消；
- 加载、空、错误、权限不足；
- 首次使用；
- 网络失败；
- 长内容和极端数据；
- 键盘操作；
- 移动端；
- 破坏性操作；
- 成功后的反馈。

#### Gate：`interaction-decision`

只有会显著改变产品行为的问题才中断用户。

中断前必须：

- 说明问题；
- 给出 2–3 个选项；
- 说明影响；
- 给出推荐；
- 先写入 `STATE.md` 的等待状态。

### 阶段 7：生产实现

以批准后的状态、配色、设计禁区和原型为准：

- 复用现有组件和设计令牌；
- 不创建平行设计系统；
- 不静默偏离批准方向；
- 实现完整状态；
- 处理响应式与无障碍；
- 新的高影响歧义必须重新进入 Gate。

如果目标项目没有现成组件库或设计系统：

- 不得阻塞；
- 可以创建项目内最小必要 tokens；
- 可以创建最小必要基础组件；
- 不得假装项目已有外部设计系统；
- 不得为了 UI 效果强行引入第三方组件库。

若检测到 `ui-design` Skill，可作为增强能力使用；没有时不得阻塞核心流程。

### 阶段 8：审查与验证

优先使用真实浏览器验证：

- 桌面端建议 `1440 × 900`；
- 移动端建议 `390 × 844`；
- 重要项目可增加 `768 × 1024`。

验证内容：

- 信息层级；
- 对齐和间距；
- 字体与可读性；
- 溢出和长文本；
- 响应式重排；
- 焦点和键盘；
- 各类交互状态；
- 与已批准原型的一致性；
- 与已确认配色的一致性；
- 是否违反设计禁区；
- 是否符合已有 `VISUAL_DESIGN.md`。

Playwright 是优先工具，但 v0.1 不强制依赖特定浏览器工具。无法完成真实浏览器验证时，应在状态中记录 blocker，不得伪称已完成视觉验收。

若检测到 `web-design-guidelines` Skill，可作为增强审查能力使用；没有时不得阻塞核心流程。

### 阶段 9：视觉设计文档更新

在以下任一条件满足时，Agent 应创建或更新 `docs/design/VISUAL_DESIGN.md`：

- 用户确认视觉原型；
- 生产实现完成并通过 QA；
- 用户批准关闭 Work Item 前，项目还没有视觉基线文档；
- 当前 Work Item 明显改变了已有视觉基线。

`VISUAL_DESIGN.md` 更新内容必须来自已确认结果，不得写入未批准的实验方案。

如果当前 Work Item 只是轻量修复，且不改变视觉基线，可以只在 `STATE.md` 中说明无需更新。

### 阶段 10：完成确认

当实现与验证满足验收标准后：

```yaml
phase: completion-review
gate: completion-approval
awaiting_user: true
```

Codex 必须展示：

- 已完成内容；
- 验收标准逐项结果；
- 浏览器或其他验证证据；
- 配色、设计禁区和原型一致性结果；
- `VISUAL_DESIGN.md` 是否已创建或更新；
- 仍存在的限制；
- 建议关闭、继续、暂停或拆分 Successor。

#### Gate：`completion-approval`

用户可回复：

- `关闭`；
- `继续调整……`；
- `暂停`；
- `关闭当前任务，并把……创建为后继任务`。

只有明确批准关闭后才可封存。

---

## 13. 状态生命周期

```text
active
  ├── paused ──→ active
  ├── active + awaiting_user
  ├── completion-review
  │      ├── 用户要求继续 ──→ active
  │      ├── 用户要求暂停 ──→ paused
  │      └── 用户批准关闭 ──→ completed + sealed
  └── 用户取消 ──→ cancelled + sealed
```

### 13.1 状态字段

`status`：

- `active`
- `paused`
- `completed`
- `cancelled`

`phase`：

- `intake`
- `discovery`
- `visual-direction`
- `prototype`
- `ux-flow`
- `implementation`
- `qa`
- `completion-review`
- `complete`

`gate`：

- `none`
- `work-item-binding`
- `visual-direction-approval`
- `prototype-approval`
- `interaction-decision`
- `completion-approval`

视觉子步骤不进入 `gate` 枚举。视觉子步骤应写入 `STATE.md` 正文的 `## 当前检查点`。

建议视觉子步骤命名：

- `visual-seed`
- `reference-analysis`
- `palette-selection`
- `design-exclusions`
- `visual-prototype`

### 13.2 封存规则

当 `sealed: true`：

- 禁止变更 status、phase、gate、验收标准和批准决定；
- 只允许只读引用；
- 后续实现必须创建 Successor；
- v0.1 不提供 unseal 功能。

---

## 14. `STATE.md` Schema

模板必须至少包含：

```yaml
---
schema_version: 1
state_id: "DE-001"
title: "优化前端样式"
slug: "optimize-frontend-style"
scope_type: "work-item"
release: ""

status: "active"
phase: "discovery"
gate: "none"
awaiting_user: false
sealed: false

mode: "full"
predecessors: []
related_items: []
approved_gates: []

created_at: "YYYY-MM-DDTHH:mm:ssZ"
updated_at: "YYYY-MM-DDTHH:mm:ssZ"
completed_at: ""
---
```

正文必须包含：

```markdown
# Work Item State

## 任务摘要
## 范围
### 包含
### 不包含
## 验收标准
## 当前检查点
## 视觉设计上下文
### Visual Seed
### 参考图片与解析
### 已确认配色
### 已确认设计禁区
### 视觉原型摘要
## 已批准决定
## 待确认问题
## 工作假设
## 产物与链接
## 验证证据
## 下一步行动
## 关键状态变更摘要
```

### 14.1 视觉信息记录规则

`STATE.md` 中的视觉信息应简洁记录：

- 用户原始 Visual Seed；
- 参考图片路径或来源摘要；
- 参考图解析的关键结论；
- 已确认配色名称和核心色值；
- 已确认设计禁区；
- 原型入口或截图路径；
- 是否已更新 `VISUAL_DESIGN.md`。

不要把完整视觉规范写进每个 `STATE.md`。

### 14.2 压缩规则

- 不复制完整对话；
- 不记录每个微小操作；
- 使用当前事实替换已失效的中间描述；
- 保留会影响后续工作的批准决定；
- 保留未解决问题与 blocker；
- 保留简短的关键状态变更摘要；
- 详细历史由 Git 和原对话承担。

建议单个 `STATE.md` 保持在约 200 行以内；超过时应压缩，而非无限追加。

---

## 15. 项目目录结构

目标 GitHub 仓库：

```text
codex-design-harness/
├── README.md
├── README.zh-CN.md
├── CHANGELOG.md
├── LICENSE
├── AGENTS.md
│
├── skills/
│   └── design-engineering/
│       ├── SKILL.md
│       ├── agents/
│       │   └── openai.yaml
│       ├── assets/
│       │   ├── STATE.template.md
│       │   ├── WORK_ITEMS.template.md
│       │   ├── VISUAL_DESIGN.template.md
│       │   ├── AGENTS.fragment.md
│       │   └── visual-reference-packs/
│       │       ├── README.md
│       │       ├── reference-index.md
│       │       ├── clean-minimal-product/
│       │       │   ├── 01-overview.svg
│       │       │   ├── 02-components.svg
│       │       │   └── notes.md
│       │       ├── dense-operator-console/
│       │       │   ├── 01-dashboard.svg
│       │       │   ├── 02-data-table.svg
│       │       │   └── notes.md
│       │       ├── warm-creator-tool/
│       │       │   ├── 01-home.svg
│       │       │   ├── 02-editor.svg
│       │       │   └── notes.md
│       │       ├── editorial-content-system/
│       │       │   ├── 01-landing.svg
│       │       │   ├── 02-content-flow.svg
│       │       │   └── notes.md
│       │       └── playful-consumer-app/
│       │           ├── 01-mobile.svg
│       │           ├── 02-empty-state.svg
│       │           └── notes.md
│       └── references/
│           ├── workflow-model.md
│           ├── visual-workflow.md
│           ├── human-in-the-loop.md
│           ├── state-lifecycle.md
│           └── state-resolution.md
│
├── agents/
│   └── design-state-steward.toml
│
├── templates/
│   └── project/
│       ├── AGENTS.fragment.md
│       └── docs/
│           └── design/
│               ├── WORK_ITEMS.md
│               ├── VISUAL_DESIGN.md
│               ├── reference-images/
│               │   └── .gitkeep
│               └── work-items/
│                   └── .gitkeep
│
├── examples/
│   └── idea-storm-lab/
│       ├── README.md
│       └── docs/
│           └── design/
│               ├── WORK_ITEMS.md
│               ├── VISUAL_DESIGN.md
│               ├── reference-images/
│               │   └── README.md
│               └── work-items/
│                   ├── DE-001-optimize-frontend-style/
│                   │   └── STATE.md
│                   └── DE-002-content-module-line-wrap/
│                       └── STATE.md
│
├── evals/
│   └── scenarios/
│       ├── 01-no-state-for-context-check.md
│       ├── 02-create-new-work-item.md
│       ├── 03-resume-across-thread.md
│       ├── 04-create-successor.md
│       ├── 05-parallel-work-items.md
│       ├── 06-ambiguous-binding.md
│       ├── 07-close-and-seal.md
│       ├── 08-visual-seed-reference-palette.md
│       ├── 09-no-product-personality-taxonomy.md
│       └── 10-visual-design-document.md
│
└── docs/
    ├── PRD.md
    ├── architecture.md
    └── manual-test-guide.md
```

目标业务项目初始化后的结构：

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
        ├── reference-images/
        │   └── .gitkeep
        └── work-items/
            └── DE-001-example/
                └── STATE.md
```

---

## 16. `design-engineering` Skill 要求

### 16.1 元数据

`SKILL.md` frontmatter：

```yaml
---
name: design-engineering
description: 对新产品界面、重要功能页面、跨页面用户流程和显著 UI/UX 改造执行人参与的设计工程工作流。负责识别或恢复 Work Item，经过参考图片、配色、设计禁区、视觉原型、关键交互与完成确认 Gate，并在跨 Codex 对话中通过 STATE.md 恢复状态。Use for human-in-the-loop UX discovery, visual reference analysis, palette confirmation, prototyping, implementation, state recovery, and completion approval.
---
```

### 16.2 必须行为

Skill 必须明确要求父 Agent：

1. 开始状态化设计任务时显式 spawn `design_state_steward`；
2. 不自行伪造状态解析结果；
3. 每个 Gate 或视觉子检查点之前先让 Steward 写入检查点；
4. 用户回复 Gate 或视觉子检查点后先更新状态再继续；
5. 任务切换前执行状态解析；
6. 关闭前执行 closure readiness 检查；
7. 用户批准后才执行 seal；
8. Steward 结果与用户当前回复冲突时，以用户当前回复为准并更新状态；
9. 不让多个 Agent 同时写同一个状态文件；
10. 没有状态价值的小任务使用 `NO_STATE`；
11. 不要求用户填写产品人格或品牌气质矩阵；
12. 视觉设计优先使用参考图片和可观察特征；
13. 没有用户参考图片时，使用内置视觉参考包辅助选择；
14. 完整视觉设计前必须提出并确认至少 3 套候选调色盘；
15. 完整视觉设计前必须提出并确认设计禁区；
16. 原型必须体现已确认配色和设计禁区；
17. 实现前必须读取已有 `VISUAL_DESIGN.md`，如果存在；
18. 视觉 Work Item 完成前必须创建或更新 `VISUAL_DESIGN.md`，除非说明无需更新的理由。

### 16.3 不得行为

Skill 不得要求或鼓励：

- 用产品人格分类替代参考图；
- 用“高级、年轻、专业”等抽象词直接进入实现；
- 只输出 1 套配色让用户确认；
- 只输出色值而不输出 UI 样张；
- 输出多套色值但没有调色盘对比板或可读性说明；
- 只改变颜色或圆角来制造多个视觉方向；
- 新增 `palette-approval` 或 `anti-homogeneity` Gate；
- 把第三方产品截图打包进仓库；
- 在没有用户批准的情况下封存任务。

### 16.4 `openai.yaml`

必须创建：

```yaml
interface:
  display_name: "Design Engineering"
  short_description: "交互式 UX 探索、视觉参考解析、配色确认、任务状态恢复、原型确认、实现与视觉验收"
  default_prompt: "使用 $design-engineering 推进当前产品设计任务。先解析或恢复 Work Item，再按适用的 Human Gate 完成参考图解析、配色确认、设计禁区确认、原型、实现、验证和关闭确认。"

policy:
  allow_implicit_invocation: true
```

v0.1 不声明 MCP 依赖。

---

## 17. `design_state_steward` Agent 要求

### 17.1 文件位置

仓库源文件：

```text
agents/design-state-steward.toml
```

用户手动使用时复制到项目：

```text
.codex/agents/design-state-steward.toml
```

### 17.2 Agent Schema

必须定义：

```toml
name = "design_state_steward"
description = "..."
developer_instructions = """..."""
```

不在 v0.1 中固定 model，让它继承父会话配置。

### 17.3 职责边界

Agent 只负责：

- 解析当前请求应绑定哪个 Work Item；
- 返回五种解析结果之一；
- 创建或更新 `STATE.md`；
- 更新 `WORK_ITEMS.md`；
- 在 Gate 或视觉子检查点前写入等待状态；
- 在用户回复后记录批准决定；
- 记录已确认配色和设计禁区；
- 检查 closure readiness；
- 在用户批准后封存状态；
- 发现索引与状态冲突时，以状态为准修复索引。

Agent 不得：

- 实现业务代码；
- 设计页面；
- 分析图片并代替设计 Agent 给出视觉方案；
- 代替用户通过 Gate；
- 修改 sealed 状态；
- 将完整聊天内容写入状态；
- 在 `AMBIGUOUS` 时自行选择；
- 同时管理多个不相关 Work Item 的内容更新。

### 17.4 返回格式

状态解析时返回：

```yaml
decision: CREATE | RESUME | SUCCESSOR | NO_STATE | AMBIGUOUS
current_state: ""
new_state: ""
candidates: []
reason: ""
user_question: ""
recommended_action: ""
```

关闭检查时返回：

```yaml
ready_to_close: true | false
state_id: "DE-001"
criteria:
  - item: ""
    result: pass | fail | unknown
blockers: []
visual_baseline:
  visual_design_updated: true | false
  reason: ""
recommended_action: ""
```

---

## 18. `WORK_ITEMS.md` 要求

模板应包含：

```markdown
# Design Work Items

> This file is a navigation index. Each Work Item's STATE.md is authoritative.

## Active

| ID | Title | Release | Phase | Gate | State |
|---|---|---|---|---|---|

## Paused

| ID | Title | Release | Phase | Reason | State |
|---|---|---|---|---|---|

## Completed

| ID | Title | Release | Completed | Successors | State |
|---|---|---|---|---|---|

## Cancelled

| ID | Title | Cancelled | State |
|---|---|---|---|
```

索引更新规则：

- 每次创建、暂停、恢复、完成、取消后更新；
- 更新前重新读取文件，尽量减少覆盖；
- 状态文件优先于索引；
- v0.1 不解决真正并发写锁。

---

## 19. `VISUAL_DESIGN.md` 要求

模板位置：

```text
skills/design-engineering/assets/VISUAL_DESIGN.template.md
templates/project/docs/design/VISUAL_DESIGN.md
```

项目中位置：

```text
docs/design/VISUAL_DESIGN.md
```

模板必须包含：

```markdown
# Visual Design Baseline

> This file records the approved visual baseline for this project. Work Item STATE.md files remain authoritative for individual task status.

## Status

- Last updated:
- Source Work Item:
- Stability: draft | approved | evolving

## Visual Seed

## Reference Images

## Reference Analysis Summary

## Approved Palette

### User-facing hierarchy

- Primary:
- Secondary:
- Tertiary accent:

### UI tokens

- Background:
- Surface:
- Elevated surface:
- Text primary:
- Text secondary:
- Text muted:
- Border:
- Divider:
- Success:
- Warning:
- Error:
- Info:

## Design Exclusions

## Typography

## Spacing and Density

## Component Language

## Layout Principles

## Interaction and Motion Notes

## Accessibility Notes

## Example Screens or Prototypes

## Change Summary
```

规则：

- `VISUAL_DESIGN.md` 只记录已确认视觉结果；
- 不记录未批准方案；
- 不替代 `STATE.md`；
- 后续 Work Item 必须先读取它；
- 当后续任务改变视觉基线时，必须在对应 `STATE.md` 中记录原因，并更新本文件。

---

## 20. Visual Reference Packs 要求

目录位置：

```text
skills/design-engineering/assets/visual-reference-packs/
```

必须提供至少 5 个自制参考包：

1. `clean-minimal-product`；
2. `dense-operator-console`；
3. `warm-creator-tool`；
4. `editorial-content-system`；
5. `playful-consumer-app`。

每个参考包必须包含：

```text
01-*.svg
02-*.svg
notes.md
```

`reference-index.md` 必须说明：

- 每个参考包适合什么类型的产品；
- 视觉特征；
- 不适合场景；
- 建议搭配的配色方向；
- 可能的同质化风险。

`notes.md` 必须包含：

```markdown
# Pack Name

## 适合

## 可借鉴视觉特征

## 不应复制

## 配色倾向

## 布局倾向

## 组件倾向

## 不适合
```

参考包图片要求：

- 必须为自制 SVG 或 PNG；
- 不得复制第三方产品截图；
- 不得包含真实品牌 Logo；
- 不要求高保真，但要足够表达布局、色彩、密度和组件气质；
- SVG 中的文字应为示意文案，不使用真实产品专有内容。

---

## 21. 示例：idea-storm-lab

示例必须体现三个用户请求。

### 请求 1：检查项目上下文

预期：

```text
NO_STATE
```

理由：只读探索，没有独立验收任务。

### 请求 2：优化前端样式

预期：

```text
CREATE DE-001
```

示例状态应展示：

- 完整设计模式；
- 用户给出 Visual Seed，或 Agent 使用内置参考包辅助；
- 参考图片或参考包解析；
- 配色方案获得用户批准；
- 设计禁区获得用户批准；
- 视觉原型获得批准；
- 实现和 QA 完成；
- `VISUAL_DESIGN.md` 已创建或更新；
- 用户批准关闭；
- `status: completed`；
- `sealed: true`。

### 请求 3：统一内容模块问题长度换行

预期：

```text
SUCCESSOR DE-002
predecessor: DE-001
```

理由：它与前端样式优化相关，但 DE-001 已经封存，且新需求有独立验收标准。

DE-002 示例可以处于：

```yaml
status: active
phase: completion-review
gate: completion-approval
awaiting_user: true
sealed: false
```

以展示等待用户关闭的状态。

DE-002 应展示：

- 已读取 `VISUAL_DESIGN.md`；
- 保持 DE-001 已确认视觉基线；
- 只处理内容模块长文本换行问题；
- 不修改 sealed 的 DE-001。

---

## 22. 人工评测场景

每个评测文件使用 Given / When / Then 格式。

### 22.1 Context Check

- Given：项目没有活动状态；
- When：用户要求“检查项目上下文，不要修改文件”；
- Then：返回 `NO_STATE`，不创建目录。

### 22.2 Create

- Given：没有相关 Work Item；
- When：用户要求设计一个新的重要功能；
- Then：创建状态，进入适用阶段。

### 22.3 Resume Across Thread

- Given：已有等待原型批准的 DE-001；
- When：新 Thread 中用户说“继续上次前端样式任务，我批准原型”；
- Then：恢复 DE-001，记录批准，不创建新状态。

### 22.4 Successor

- Given：DE-001 已 completed + sealed；
- When：用户提出相关但独立的新优化；
- Then：创建 DE-002，引用 DE-001，不修改 DE-001。

### 22.5 Parallel Work Items

- Given：DE-002 active；
- When：用户开启另一项独立产品功能；
- Then：创建 DE-003；索引同时显示 DE-002 和 DE-003 active。

### 22.6 Ambiguous Binding

- Given：存在两个语义相近的 active Work Item；
- When：用户只说“继续之前的界面改动”；
- Then：返回 `AMBIGUOUS`，列出候选，不写状态。

### 22.7 Close and Seal

- Given：实现和 QA 已完成；
- When：Codex 进入 completion review，但用户尚未批准；
- Then：不得 completed。
- When：用户明确回复“关闭”；
- Then：completed + sealed，索引移动到 Completed。

### 22.8 Visual Seed, Reference, and Palette

- Given：用户要求优化一个页面视觉，并提供一句粗略视觉方向和两张参考图；
- When：Codex 使用 Full Mode；
- Then：不得要求用户填写产品人格；
- And：必须解析参考图的可观察特征；
- And：必须输出至少 3 套候选调色盘、同构 UI 样张和可读性/对比说明；
- And：必须在配色确认前写入 `visual-direction-approval` 等待状态；
- And：用户可以选择候选，也可以直接输入自定义颜色；
- And：用户确认配色或输入自定义颜色后，必须记录用户原始颜色输入、最终配色来源和已确认配色，然后才能继续。

### 22.9 No Product Personality Taxonomy

- Given：用户是非 UX 专业用户；
- When：用户只说“我想要更干净一点”；
- Then：Codex 不应追问产品人格矩阵；
- And：应请求参考图片或提供内置视觉参考包；
- And：应把视觉维度作为内部分析工具，而不是用户表单。

### 22.10 Visual Design Document

- Given：DE-001 完成视觉原型、实现和 QA；
- When：进入 completion review；
- Then：必须说明 `VISUAL_DESIGN.md` 已创建或更新；
- And：该文件包含已确认配色、设计禁区、组件语言和示例；
- And：后续 DE-002 必须读取并遵守该视觉基线。

---

## 23. README 要求

`README.zh-CN.md` 必须包含：

1. 产品一句话介绍；
2. 它解决的问题；
3. 架构图；
4. Thread / Work Item / STATE / Gate / VISUAL_DESIGN 的区别；
5. 五种状态解析结果；
6. Human-in-the-loop 工作流；
7. 新视觉流程：Visual Seed → Reference Images → Palette → Design Exclusions → Prototype；
8. 为什么不要求用户填写产品人格；
9. 如何使用内置视觉参考包；
10. 手动安装步骤；
11. 项目初始化步骤；
12. 一个从 CREATE 到 seal 的完整示例；
13. 如何跨 Thread 恢复；
14. 如何处理并行任务；
15. 如何处理封存任务的后续需求；
16. 当前限制；
17. v0.1 路线图；
18. 官方 Codex 机制参考。

`README.md` 提供英文版核心说明，可以略短，但不得只放一句跳转链接。

---

## 24. 手动安装说明

v0.1 只提供手动方式。

README 应指导用户：

1. 将：

```text
skills/design-engineering/
```

复制到：

```text
~/.agents/skills/design-engineering/
```

2. 将：

```text
agents/design-state-steward.toml
```

复制到目标项目：

```text
.codex/agents/design-state-steward.toml
```

3. 将 `templates/project/AGENTS.fragment.md` 合并进项目根目录 `AGENTS.md`，不得要求覆盖用户已有内容；

4. 将项目模板中的 `docs/design/` 复制到目标项目；

5. 如果用户有自己的参考图，引导用户放入：

```text
docs/design/reference-images/
```

6. 开启新的 Codex 会话验证 Skill、Agent 和项目指令；

7. 提供只读验证 Prompt。

---

## 25. 平台约束

实现时必须遵守当前 Codex 官方机制：

- Skill 是包含必需 `SKILL.md`、可选 `scripts/`、`references/`、`assets/` 和 `agents/openai.yaml` 的目录；
- 用户级 Skill 路径为 `$HOME/.agents/skills`，项目级 Skill 路径为项目中的 `.agents/skills`；
- `agents/openai.yaml` 用于展示、调用策略和工具依赖，不是自定义 subagent 文件；
- 自定义 Agent 使用独立 TOML，位于 `~/.codex/agents/` 或项目 `.codex/agents/`；
- 自定义 Agent 必须定义 `name`、`description` 和 `developer_instructions`；
- Codex 只有在父流程显式要求时才会 spawn subagent，因此 `SKILL.md` 必须明确写出调用步骤；
- `AGENTS.md` 在每次 Codex run 开始时按全局和项目层级加载；
- 项目模板不应覆盖用户已有 `AGENTS.md`。

官方参考：

- Agent Skills: https://developers.openai.com/codex/skills
- Subagents: https://developers.openai.com/codex/subagents
- AGENTS.md: https://developers.openai.com/codex/guides/agents-md

---

## 26. 实现约束

Codex 创建仓库时必须遵守：

1. 不实现 v0.1 非目标；
2. 不添加 npm、Python 或其他运行时依赖；
3. 不创建空洞的大量占位文档；
4. 所有示例必须内部一致；
5. YAML、TOML、Markdown 和 SVG 语法有效；
6. 中文文档自然清楚，不机械翻译；
7. 英文标识符保持稳定一致；
8. 不虚构 Codex 不支持的配置字段；
9. 第三方 Skill 仅写为可选增强，不复制其内容；
10. 不把 `STATE.md` 写成完整聊天日志；
11. 不允许 sealed 状态在示例中被重新激活；
12. 所有 Gate 和视觉子检查点示例都必须先写状态，再停止等待用户；
13. `WORK_ITEMS.md` 明确标注为索引而非权威来源；
14. `VISUAL_DESIGN.md` 明确标注为项目视觉基线而非 Work Item 状态；
15. 参考包必须使用自制 SVG 或 PNG，不使用第三方截图；
16. 不要求用户输入产品人格；
17. 不新增 anti-homogeneity gate；
18. 仓库自身的 `AGENTS.md` 要求后续修改保持 PRD、Skill、Agent、模板、视觉参考包和示例一致。

---

## 27. 交付物

v0.1 交付必须包含：

- 完整仓库结构；
- 中英文 README；
- `design-engineering/SKILL.md`；
- `design-engineering/agents/openai.yaml`；
- 五份核心 reference 文档：
  - `workflow-model.md`
  - `visual-workflow.md`
  - `human-in-the-loop.md`
  - `state-lifecycle.md`
  - `state-resolution.md`
- `STATE.template.md`；
- `WORK_ITEMS.template.md`；
- `VISUAL_DESIGN.template.md`；
- 项目 `AGENTS.fragment.md`；
- `design-state-steward.toml`；
- 至少 5 个自制视觉参考包；
- idea-storm-lab 完整示例；
- 十个人工评测场景；
- 架构说明；
- 手动测试指南；
- MIT License；
- `CHANGELOG.md`；
- 仓库自身 `AGENTS.md`。

---

## 28. Definition of Done

只有全部满足才能认为 v0.1 完成。

### 文档

- [ ] 新用户能独立理解核心概念；
- [ ] 中英文 README 与实际文件结构一致；
- [ ] 所有相对链接有效；
- [ ] 没有把 Thread 与 Work Item 混同；
- [ ] 明确解释 sealed 状态只读但可引用；
- [ ] 明确解释 `VISUAL_DESIGN.md` 与 `STATE.md` 的区别；
- [ ] 明确解释为什么不要求用户填写产品人格；
- [ ] 视觉流程说明足够非 UX 用户理解。

### Skill

- [ ] `SKILL.md` frontmatter 有效；
- [ ] 能区分 full / lightweight / delegated；
- [ ] 明确要求显式调用 Steward；
- [ ] 各 Gate 有停止条件；
- [ ] 视觉子检查点有停止条件；
- [ ] 关闭前必须展示证据并等待用户；
- [ ] 完整视觉设计前必须确认配色；
- [ ] 完整视觉设计前必须确认设计禁区；
- [ ] 不要求产品人格输入；
- [ ] 没有反同质化 Gate。

### Agent

- [ ] TOML 包含全部必需字段；
- [ ] 职责窄且不实现业务代码；
- [ ] 只返回五种状态解析结果；
- [ ] 不修改 sealed 状态；
- [ ] `AMBIGUOUS` 时不写文件；
- [ ] closure readiness 与 seal 分为两个步骤；
- [ ] 能记录配色、设计禁区和视觉文档更新状态；
- [ ] 不代替用户批准视觉子检查点。

### 状态模型

- [ ] 模板包含 schema version；
- [ ] 状态、阶段和 Gate 枚举一致；
- [ ] 没有新增未定义 Gate；
- [ ] 当前事实、批准决定、待确认项和证据齐全；
- [ ] 示例状态与索引一致；
- [ ] successor 关系明确；
- [ ] 视觉输入、参考解析、已确认配色和设计禁区可恢复。

### 视觉参考包

- [ ] 至少 5 个参考包；
- [ ] 每个参考包至少 2 张自制 SVG 或 PNG；
- [ ] 每个参考包有 `notes.md`；
- [ ] 有 `reference-index.md`；
- [ ] 不包含第三方产品截图或真实品牌 Logo；
- [ ] 参考包可被 README 和 Skill 正确引用。

### 示例与评测

- [ ] “检查项目上下文”不创建状态；
- [ ] “优化前端样式”创建并封存 DE-001；
- [ ] “优化前端样式”展示参考解析、配色确认、设计禁区确认和原型确认；
- [ ] “统一内容模块问题长度换行”创建 DE-002 successor；
- [ ] DE-002 读取并遵守 `VISUAL_DESIGN.md`；
- [ ] 跨 Thread 恢复场景不创建重复状态；
- [ ] 并行任务场景保留多个 active Work Item；
- [ ] ambiguous 场景停止等待用户；
- [ ] completion 场景没有用户批准时不会封存；
- [ ] 视觉流程评测覆盖“不要求产品人格”；
- [ ] 视觉文档评测覆盖 `VISUAL_DESIGN.md` 创建或更新。

### 范围控制

- [ ] 没有安装器；
- [ ] 没有 Plugin；
- [ ] 没有 Hook；
- [ ] 没有 CLI；
- [ ] 没有状态管理脚本；
- [ ] 没有外部运行时依赖；
- [ ] 没有自动抓取外部参考图。

---

## 29. 实施顺序

建议 Codex 按以下顺序实施。

### Milestone 1：骨架与术语

- 建立目录；
- 写仓库 `AGENTS.md`；
- 写中英文 README 骨架；
- 写 architecture 和术语；
- 明确 Thread / Work Item / STATE / VISUAL_DESIGN / Gate 的边界。

### Milestone 2：核心状态模型

- 完成 `STATE.template.md`；
- 完成 `WORK_ITEMS.template.md`；
- 完成 `VISUAL_DESIGN.template.md`；
- 完成 state lifecycle 和 resolution 文档；
- 交叉检查状态、阶段、Gate 枚举。

### Milestone 3：视觉流程与参考包

- 完成 `visual-workflow.md`；
- 创建 `visual-reference-packs/`；
- 创建 5 个自制 SVG 参考包；
- 写每个参考包的 `notes.md`；
- 写 `reference-index.md`；
- 检查所有图片和链接有效。

### Milestone 4：Skill 与 Agent

- 完成 `SKILL.md`；
- 完成 `openai.yaml`；
- 完成 `design-state-steward.toml`；
- 确保 Skill 显式要求调用 Steward；
- 确保 Steward 只管理状态；
- 确保视觉子检查点不新增 Gate 枚举。

### Milestone 5：示例与评测

- 完成 idea-storm-lab 示例；
- 完成十个 Given / When / Then 场景；
- 验证索引、状态、视觉文档和 successor 关系一致；
- 确认示例不重新激活 sealed 状态。

### Milestone 6：使用与验收

- 完成手动安装说明；
- 完成 manual test guide；
- 检查 Markdown 链接、YAML、TOML、SVG；
- 对照 Definition of Done 自检；
- 输出最终实现摘要和已知限制。

---

## 30. 后续路线图（不在 v0.1 实现）

### v0.2

- 确定性 `statectl`；
- Schema 校验；
- 自动生成索引；
- 状态迁移；
- 更可靠的并发冲突检测；
- 视觉 token schema 校验；
- 可选视觉基线 diff。

### v0.3

- 安装与初始化命令；
- `doctor` 检查；
- 受管 `AGENTS.md` 区块；
- 自动升级与卸载；
- 可选参考包安装选择器。

### v0.4

- Codex Plugin；
- Marketplace 分发；
- 可选 Hook；
- 可选 Playwright MCP 依赖；
- 可选浏览器截图评测。

### Future

- Release 级编排；
- GitHub Issue 映射；
- 多人审批；
- 可视化 Work Item 面板；
- 任务与对话的自动关联；
- 设计决策知识图谱；
- 更强的视觉参考检索和相似度分析；
- 专业设计师可插拔 Review Agent。

---

## 31. 最终产品定义

Codex Design Harness v0.1 不是一个自动化平台，而是一份能够在真实项目中运行的、可版本控制的产品开发协议：

```text
Thread 是工作现场
Work Item 是任务身份
STATE.md 是权威状态快照
Gate 是人的控制点
Skill 是流程编排器
Steward 是状态管理员
Visual Seed 是低成本视觉输入
Reference Images 是视觉证据
Palette 和 Design Exclusions 是可确认中间产物
VISUAL_DESIGN.md 是项目视觉基线
用户拥有最终关闭权
```

它的第一版价值，不在于拥有最多功能，而在于证明以下闭环真实成立：

```text
创建或恢复正确任务
→ 跨对话保持一致
→ 用图片和样张替代抽象人格描述
→ 先确认配色和设计禁区
→ 在高成本实现前获得批准
→ 记录关键产品与视觉决定
→ 用证据请求完成确认
→ 沉淀项目视觉基线
→ 封存历史
→ 用 Successor 开启下一次迭代
```
