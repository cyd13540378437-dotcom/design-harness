# Design Engineering Harness 产品总结说明（Reference Library 版）

## 1. 产品定位

Design Engineering Harness 是一套面向 Codex 的 Human-in-the-loop UI/UX 设计工程工作流。

它让一次普通的产品设计或前端改造请求，变成可恢复、可审计、可审批、可封存的 Work Item，并通过 Reference Library 帮助 Agent 在视觉方向阶段形成更专业、更贴合终端的建议。

一句话：

> Thread 是工作现场，Work Item 是任务身份，STATE.md 是权威状态快照，Reference Library 是长期视觉参考资料层，REFERENCE_SELECTION.md 是本任务如何消费资料库的记录。

---

## 2. 产品解决的问题

当前产品主要解决五类问题：

1. **跨对话记忆不稳定**：通过 Work Item 和 `STATE.md` 让不同 Codex 对话可以恢复同一个任务。
2. **任务边界混乱**：Thread 不等于 Work Item，避免一个对话创建多个冲突状态。
3. **高成本实现前缺少确认**：通过视觉方向、原型、关键交互和完成确认 Gate，把用户放在关键决策点。
4. **完成状态不清楚**：只有用户批准后才能 `completed + sealed`，封存后只读引用，后续需求创建 Successor。
5. **视觉方向缺少依据**：通过 `reference-library/` 和 `REFERENCE_SELECTION.md`，让 Agent 基于终端和任务内容提出设计建议。

---

## 3. Reference Library 版的关键变化

Reference Library 版不是简单加一个“放图文件夹”，而是新增一个独立资料层：

```text
reference-library = 长期可复用资料
REFERENCE_SELECTION.md = 某个 Work Item 本次实际消费的参考
STATE.md = 本任务状态、批准决定和证据摘要
```

这版特别修正了一个重要体验：

> 用户不需要专业地说出“Linear 的密度”“Notion 的低噪音”或“Airbnb 的卡片优势”。这些应该由 Agent 根据任务内容和终端判断。用户只需要确认“效率优先 / 上手优先 / 引导优先 / 内容探索”等业务语义和取舍。

---

## 4. 当前产品核心流程

```text
用户提出 UI/UX 任务
        ↓
状态解析：CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS
        ↓
业务理解：用户、任务、成功标准、约束
        ↓
终端判断：web-app / mobile-app / responsive-web / desktop-app / tablet / multi-surface
        ↓
参考检索：从 reference-library 按终端、页面类型、任务类型筛选
        ↓
Work Item 参考选择：写入 REFERENCE_SELECTION.md
        ↓
视觉方向：用业务语言给出 2–3 个方向和推荐
        ↓
visual-direction-approval
        ↓
静态原型
        ↓
prototype-approval
        ↓
关键 UX 决策
        ↓
生产实现
        ↓
目标终端 QA
        ↓
completion-approval
        ↓
用户批准后 completed + sealed
```

---

## 5. 当前产品文件夹结构、中文名称和存在目的

### 5.1 Harness 仓库结构

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
│       │   ├── REFERENCE_SELECTION.template.md
│       │   └── AGENTS.fragment.md
│       └── references/
│           ├── workflow-model.md
│           ├── human-in-the-loop.md
│           ├── state-lifecycle.md
│           ├── state-resolution.md
│           └── reference-library-consumption.md
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
│               ├── reference-library/
│               └── work-items/
│
├── examples/
│   └── idea-storm-lab/
│
├── evals/
│   └── scenarios/
│
└── docs/
    ├── PRD.md
    ├── architecture.md
    ├── manual-test-guide.md
    └── product-summary.reference-library-version.md
```

### 5.2 Harness 仓库文件夹说明

| 路径 | 中文名称 | 存在目的 |
|---|---|---|
| `skills/` | Skill 目录 | 存放可被 Codex 调用的设计工程 Skill。 |
| `skills/design-engineering/` | 设计工程 Skill | 编排 UI/UX 工作流：状态解析、视觉方向、原型、实现、QA、完成确认。 |
| `skills/design-engineering/assets/` | Skill 模板资产 | 存放 `STATE.md`、`WORK_ITEMS.md`、`REFERENCE_SELECTION.md` 和项目规则片段模板。 |
| `skills/design-engineering/references/` | Skill 参考说明 | 存放流程模型、状态生命周期、人参与规则和参考库消费规则。 |
| `skills/design-engineering/agents/` | Skill 展示配置 | 存放 `openai.yaml`，用于 Codex 展示和隐式调用策略。 |
| `agents/` | 自定义 Agent 目录 | 存放 `design_state_steward` 的 TOML 定义。 |
| `templates/project/` | 目标项目模板 | 用户把 Harness 应用到自己的产品仓库时复制的初始结构。 |
| `templates/project/docs/design/` | 目标项目设计工作区模板 | 包含任务索引、参考库和 Work Item 目录。 |
| `templates/project/docs/design/reference-library/` | 产品视觉参考库模板 | 长期保存跨任务可复用的产品视觉参考资料。 |
| `templates/project/docs/design/work-items/` | Work Item 模板目录 | 存放每个设计任务的 `STATE.md`、`REFERENCE_SELECTION.md` 和 artifacts。 |
| `examples/` | 示例项目 | 展示真实任务如何 CREATE、SUCCESSOR、completion-review 和 sealed。 |
| `evals/scenarios/` | 人工评测场景 | 用 Given / When / Then 验证状态解析、封存、并行任务和参考库消费。 |
| `docs/` | 产品文档 | 存放 PRD、架构说明、手动测试指南和产品总结。 |

---

## 6. 目标业务项目结构

当用户把 Harness 应用到自己的产品仓库后，推荐结构如下：

```text
product-repository/
├── AGENTS.md
├── .codex/
│   └── agents/
│       └── design-state-steward.toml
└── docs/
    └── design/
        ├── WORK_ITEMS.md
        ├── reference-library/
        │   ├── README.md
        │   ├── product-index.md
        │   ├── product-index.yml
        │   ├── pattern-index.md
        │   ├── pattern-index.yml
        │   ├── source-manifest.yml
        │   ├── llm-usage-guide.md
        │   ├── products/
        │   ├── patterns/
        │   ├── assets/
        │   │   ├── screenshots/
        │   │   │   ├── web-app/
        │   │   │   ├── mobile-app/
        │   │   │   ├── responsive-web/
        │   │   │   ├── desktop-app/
        │   │   │   └── tablet/
        │   │   └── color-cards/
        │   │       ├── README.md
        │   │       ├── palette-index.md
        │   │       ├── color-card.schema.yml
        │   │       ├── images/
        │   │       ├── palettes/
        │   │       └── annotations/
        │   └── schemas/
        └── work-items/
            └── DE-001-example/
                ├── STATE.md
                ├── REFERENCE_SELECTION.md
                └── artifacts/
```

### 6.1 目标业务项目文件夹说明

| 路径 | 中文名称 | 存在目的 |
|---|---|---|
| `AGENTS.md` | 项目规则文件 | 每次 Codex run 开始时读取，告诉 Codex 如何使用 Harness。 |
| `.codex/agents/` | 项目级自定义 Agent 目录 | 存放 `design_state_steward`，负责状态解析、更新和封存。 |
| `docs/design/` | 设计工作区 | 产品设计任务、状态、参考资料和验收证据的根目录。 |
| `docs/design/WORK_ITEMS.md` | Work Item 索引 | 导航和缓存所有任务；冲突时以各任务的 `STATE.md` 为准。 |
| `docs/design/reference-library/` | 产品视觉参考库 | 长期、跨任务复用的视觉资料层。 |
| `docs/design/reference-library/product-index.md` | 产品总索引 | 面向人和 LLM 的产品参考总表。 |
| `docs/design/reference-library/product-index.yml` | 机器可读产品索引 | 让 Agent 更稳定地按字段筛选产品。 |
| `docs/design/reference-library/products/` | 单产品参考 | 每个优秀产品一份结构化说明，包含终端、页面类型、借鉴点和不借鉴点。 |
| `docs/design/reference-library/pattern-index.md` | 设计模式索引 | 汇总可复用的视觉/交互模式。 |
| `docs/design/reference-library/patterns/` | 单设计模式说明 | 每个模式说明适用终端、风险终端、代表产品、QA 检查。 |
| `docs/design/reference-library/assets/screenshots/` | 截图素材区 | 存放内部收集的截图，按终端分类。 |
| `docs/design/reference-library/assets/color-cards/` | 色卡素材区 | 预留给后续色卡图片、解释、token 转化和无障碍说明。 |
| `docs/design/reference-library/schemas/` | 资料字段约定 | 约束产品参考、模式参考和 Reference Selection 的字段。 |
| `docs/design/work-items/` | 任务状态目录 | 每个独立 UI/UX Work Item 一个子目录。 |
| `docs/design/work-items/DE-xxx/STATE.md` | 权威状态快照 | 保存当前阶段、Gate、批准决定、验收标准、证据和下一步。 |
| `docs/design/work-items/DE-xxx/REFERENCE_SELECTION.md` | 本任务参考选择 | 记录本任务从参考库中选了什么、排除了什么、转化成哪些设计原则。 |
| `docs/design/work-items/DE-xxx/artifacts/` | 任务产物与证据 | 存放原型截图、浏览器验证截图、QA 证据等。 |

---

## 7. 关键角色分工

### 用户

- 提供目标、偏好、约束和业务判断；
- 在关键 Gate 上批准、纠偏或暂停；
- 保留最终关闭权。

### design-engineering Skill

- 编排设计工作流；
- 显式调用 `design_state_steward`；
- 做业务理解、终端判断、参考检索、视觉方向、原型、实现和 QA；
- 把参考产品转译成用户可理解的产品方向。

### design_state_steward

- 只管理状态；
- 解析 `CREATE / RESUME / SUCCESSOR / NO_STATE / AMBIGUOUS`；
- 创建或更新 `STATE.md` 和 `WORK_ITEMS.md`；
- 在 Gate 前写入等待状态；
- 用户批准后记录决定；
- 完成前检查 closure readiness；
- 用户批准关闭后 seal。

### Reference Library

- 不主动执行任务；
- 不存放 Work Item 专属参考包；
- 为 Agent 提供可筛选的长期参考资料。

---

## 8. 当前版本的使用方式

用户在新任务中只需要表达业务目标，例如：

```text
帮我优化这个后台首页，让用户更容易知道下一步该做什么。
```

Agent 应该自动完成：

```text
1. 判断这是 Web 工作台任务；
2. 从 reference-library 里优先找 Web SaaS dashboard / dense productivity workspace / AI copilot panel 等参考；
3. 写入 REFERENCE_SELECTION.md；
4. 给出“效率工作台 / 引导式助手 / 内容探索”等业务方向；
5. 推荐一个方向并解释代价；
6. 等用户批准后再进入原型。
```

用户不需要说：

```text
我要 Linear 的密度和 Notion 的低噪音。
```

这些专业映射应该由 Agent 完成。

---

## 9. 当前版本边界

Reference Library 版仍然是文档型产品，不做自动化平台。

明确不做：

- 自动安装器；
- Plugin；
- Hook；
- CLI；
- 自动截图下载；
- 自动视觉识别；
- 云端素材库；
- 外部运行时依赖。

它的价值在于把设计工程流程、状态管理、用户 Gate 和视觉参考依据都沉淀到项目仓库中，让 Codex 可以在真实项目里稳定复用。
