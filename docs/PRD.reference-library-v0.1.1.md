# Codex Design Harness — Reference Library 版 PRD

- **版本**：v0.1.1-alpha
- **文档状态**：可执行增量 PRD
- **基线版本**：v0.1.0-alpha
- **产品显示名**：Design Engineering Harness
- **新增核心能力**：Product Visual Reference Library
- **主要语言**：简体中文；配置字段、状态枚举和文件名使用英文

---

## 1. 产品摘要

v0.1.1 在 v0.1 的 Work Item、`STATE.md`、Gate、Skill、Steward 基础上，新增一个独立的产品视觉参考资料层：

```text
Reference Library
        ↓
Surface Resolution
        ↓
Task-level Reference Selection
        ↓
Visual Direction
        ↓
Prototype / Implementation / QA
        ↓
STATE.md summary
```

这次增量的目标不是让用户说出“某产品的某设计优势”，而是让 Agent 基于任务内容和目标终端做专业筛选，然后把结果压缩成用户能判断的产品方向。

核心原则：

> 参考资源是 Agent 的判断证据，不是用户必须掌握的专业词汇。

---

## 2. 背景与问题

v0.1 已经解决了任务状态、跨线程恢复、审批 Gate 和封存语义。但 UI/UX 设计工作还存在三个缺口：

1. Agent 在视觉方向阶段缺少结构化参考依据，容易凭经验泛泛描述；
2. 用户不应被要求理解 Linear、Notion、Airbnb 等产品的具体设计优势；
3. 找参考前没有明确目标终端，可能把 native mobile app 的截图错误用于 Web 工作台或桌面端产品。

v0.1.1 通过引入 `reference-library/`、`REFERENCE_SELECTION.md` 和 `Surface Resolution` 补齐这些缺口。

---

## 3. 本次增量目标

v0.1.1 必须实现：

1. 在项目模板中新增 `docs/design/reference-library/`；
2. 将已有 App 参考资料转换为 LLM 友好的 Markdown/YAML；
3. 将资料库从 “App Reference” 升级为 “Product Visual Reference”，支持 Web、mobile app、responsive web、desktop app、tablet 等终端；
4. 在参考库中维护产品总索引、设计模式、截图来源、截图素材目录、色卡预留目录和 schema；
5. 不在 `reference-library/` 中创建 `reference-packs/`；
6. 每个 Work Item 的实际参考消费结果写入 `REFERENCE_SELECTION.md`；
7. 在视觉方向前增加 `Surface Resolution` 检查点；
8. 修改 `design-engineering` Skill，使其按终端和任务内容检索资料库；
9. 修改 `STATE.template.md`，只记录参考选择摘要和链接；
10. 修改项目 `AGENTS.fragment.md`，让参考库消费成为 UI/UX 任务的默认协议；
11. 预留 `assets/color-cards/`，用于后续色卡图片和解释；
12. 更新 README、architecture、manual test guide、examples 和 evals 中与视觉方向相关的说明。

---

## 4. 非目标

v0.1.1 仍然不实现：

- 自动安装器；
- Codex Plugin；
- Marketplace；
- Hook；
- CLI；
- `statectl`；
- 自动下载第三方截图；
- 自动 OCR 或视觉识别截图；
- 云端素材库；
- 外部运行时依赖；
- 第三方截图版权托管；
- 将 reference-library 变成项目管理系统。

---

## 5. 核心概念

### 5.1 Reference Library

仓库级、长期、可版本化的视觉参考资料层。

位置：

```text
docs/design/reference-library/
```

它保存跨任务复用的资料：产品索引、设计模式、来源、截图素材、色卡素材和 schema。

它不保存某个 Work Item 的专属选择结果。

### 5.2 Surface Target

本次设计任务要落地的目标终端。

枚举建议：

```text
web-app
mobile-app
responsive-web
desktop-app
tablet
multi-surface
```

找参考前必须先明确 Surface Target。

### 5.3 Reference Selection

某个 Work Item 从 Reference Library 中筛选出的任务级参考集合。

位置：

```text
docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md
```

它属于 Work Item，不属于 Reference Library。

### 5.4 Product Reference

某个优秀产品的结构化参考条目，包括：行业、终端、页面类型、任务类型、模式标签、视觉标签、可借鉴点、不借鉴点和来源。

### 5.5 Pattern Reference

从多个产品中抽象出的设计模式，包括适用终端、风险终端、适用条件、可借鉴点、不借鉴点和 QA 检查。

---

## 6. 产品原则

### 6.1 用户不承担专业参考判断

错误体验：

```text
你想用 Linear 的密度、Notion 的低噪音，还是 Airbnb 的卡片？
```

正确体验：

```text
我判断这是 Web 端工作台任务。建议采用“效率工作台”方向：突出任务状态、下一步行动和最近对象。代价是首屏更紧凑，但更适合高频使用。
```

参考产品可以作为依据出现在说明中，但不能成为用户必须理解的选择语言。

### 6.2 先明确终端，再找参考

Web、mobile app、responsive web、desktop app 的参考不能混用。

跨终端参考只能用于抽象模式，不得直接用于布局、密度、导航、手势或视觉比例。

### 6.3 Reference Library 独立于 Work Item

`reference-library/` 是长期资料层；`REFERENCE_SELECTION.md` 是某个任务的消费结果；`STATE.md` 是任务状态快照。

### 6.4 `STATE.md` 保持最小权威上下文

`STATE.md` 只记录：

- 目标终端；
- Reference Selection 链接；
- 采用的设计原则摘要；
- 用户批准的方向；
- 明确不采用的参考；
- 验证证据。

不要把完整参考分析、产品截图和长表格塞进 `STATE.md`。

---

## 7. 目录结构要求

### 7.1 目标业务项目结构

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
        │       ├── product-reference.schema.yml
        │       ├── pattern-reference.schema.yml
        │       └── reference-selection.schema.yml
        └── work-items/
            └── DE-001-example/
                ├── STATE.md
                ├── REFERENCE_SELECTION.md
                └── artifacts/
```

### 7.2 禁止结构

不得创建：

```text
docs/design/reference-library/reference-packs/
```

原因：`reference-packs` 会混淆长期资料层和 Work Item 级消费结果。

---

## 8. 工作流变更

### 阶段 1 前新增检查点：Surface Resolution

在业务理解与视觉方向之前，Agent 必须判断：

```yaml
surface_target:
  primary: web-app | mobile-app | responsive-web | desktop-app | tablet | multi-surface
  secondary: []
  explicitly_out_of_scope: []
  evidence: []
  open_questions: []
```

如果终端可以从用户请求、项目结构、技术栈或已有状态判断，Agent 直接记录假设并继续。

只有当终端不明确且会显著影响参考选择、原型范围或实现方式时，才询问用户。

### 阶段 1 中新增：Reference Retrieval

如果 `docs/design/reference-library/` 存在，Agent 必须按以下顺序检索：

1. 同终端；
2. 同页面类型；
3. 同任务类型；
4. 相近内容密度和交互复杂度；
5. 相近用户成熟度；
6. 相邻行业；
7. 视觉标签。

### 阶段 1 中新增：Reference Selection

检索结果写入：

```text
docs/design/work-items/<STATE_ID>-<slug>/REFERENCE_SELECTION.md
```

该文件至少包含：

- Work Item；
- Surface Target；
- Task Diagnosis；
- Reference Query；
- Selected References；
- Rejected References；
- Design Principles；
- User-facing Direction Summary；
- Copyright Boundary。

### 阶段 1 Gate 表达修正

`visual-direction-approval` Gate 给用户的选项必须是业务语义，而不是产品名。

示例：

```text
方向 A：效率工作台
适合：高频使用、熟练用户、任务推进
代价：首次视觉更紧凑
参考依据：Web SaaS 工作台和专业工具模式

方向 B：引导式助手
适合：新用户、不确定下一步、AI 辅助
代价：信息密度较低
参考依据：AI 输入优先和答案可信化模式
```

---

## 9. Skill 要求增量

`design-engineering/SKILL.md` 必须新增：

1. UI/UX Work Item 在视觉方向前执行 Surface Resolution；
2. 如果项目存在 `reference-library/`，必须检索该资料库；
3. 参考检索结果写入 Work Item 的 `REFERENCE_SELECTION.md`；
4. 用户方向选择必须用业务语言表达；
5. 不要求用户理解具体参考产品的设计优势；
6. 实现阶段遵循已批准的设计原则，不直接照搬第三方截图；
7. QA 阶段按目标终端验证，并对照 Reference Selection。

---

## 10. Steward 要求增量

`design_state_steward` 仍然只管理状态，不负责设计页面或挑选参考。

新增职责边界：

- 可以在 `STATE.md` 中记录 Surface Target、Reference Selection 链接和摘要；
- 不把完整参考分析写进 `STATE.md`；
- 不在 `reference-library/` 中创建 Work Item 专属文件；
- 不修改 sealed 状态以补充新参考。

---

## 11. 模板要求增量

### 11.1 `STATE.template.md`

新增正文小节：

```markdown
## 设计对象与终端

## 参考资源摘要
```

### 11.2 `REFERENCE_SELECTION.template.md`

新增模板文件：

```text
skills/design-engineering/assets/REFERENCE_SELECTION.template.md
```

可选复制到项目模板：

```text
templates/project/docs/design/work-items/REFERENCE_SELECTION.template.md
```

### 11.3 `AGENTS.fragment.md`

新增 Reference Library 使用规则，包括：

- 先明确终端；
- 按终端和任务类型筛选参考；
- 不让用户承担专业参考判断；
- 不复制第三方资产；
- Work Item 的参考选择写入 `REFERENCE_SELECTION.md`。

---

## 12. 色卡目录预留要求

必须创建：

```text
docs/design/reference-library/assets/color-cards/
├── README.md
├── palette-index.md
├── color-card.schema.yml
├── images/
│   └── .gitkeep
├── palettes/
│   └── .gitkeep
└── annotations/
    └── .gitkeep
```

当前不预填具体色卡。

后续新聊天将围绕该结构补充：

- 色卡图片；
- 色彩解释；
- 适用终端；
- 情绪关键词；
- design token 转化建议；
- 无障碍风险。

---

## 13. 示例与评测增量

新增或修改评测场景：

### 13.1 Web 端任务不得默认使用移动 App 参考

Given：用户要求优化 Web 管理后台首页。

When：Agent 检索参考库。

Then：优先选择 `web-app` / SaaS dashboard / professional workspace 参考；mobile app 只能作为抽象模式补充。

### 13.2 Mobile App 任务不得照搬 Web 工作台

Given：用户要求设计原生移动 App 的记录页。

When：Agent 检索参考库。

Then：优先选择 `mobile-app` 参考；Web 表格/侧边栏只能作为对象关系参考。

### 13.3 Work Item 参考选择不得写入 reference-library

Given：存在 `reference-library/`。

When：Agent 为 DE-003 选择参考。

Then：创建 `work-items/DE-003-*/REFERENCE_SELECTION.md`，不创建 `reference-library/reference-packs/`。

### 13.4 用户不需要选择产品名

Given：Agent 输出视觉方向。

When：进入 `visual-direction-approval`。

Then：方向以业务语义表达，并可在说明中附带参考依据。

---

## 14. 与 v0.1 的对比和增量

| 模块 | v0.1 | v0.1.1 增量 |
|---|---|---|
| 核心闭环 | Work Item + STATE.md + Gate + Steward | 保持不变 |
| 视觉方向 | Agent 提出 2–3 个方向 | 方向必须基于 Surface Resolution 和 Reference Library 检索 |
| 用户角色 | 用户批准方向 | 用户批准业务语义和取舍，不需要懂参考产品术语 |
| 参考资料 | 未定义项目级资料层 | 新增 `docs/design/reference-library/` |
| 本任务参考 | 未定义 | 新增 Work Item 级 `REFERENCE_SELECTION.md` |
| 终端判断 | QA 阶段有桌面/移动验证建议 | 视觉方向前新增 Surface Resolution 检查点 |
| 文件结构 | `docs/design/WORK_ITEMS.md` + `work-items/` | 新增 `reference-library/` 和色卡预留区 |
| State 模板 | 状态、范围、验收、证据 | 新增“设计对象与终端”“参考资源摘要” |
| Agent/Skill | Steward 管状态，Skill 编排流程 | Skill 负责参考检索；Steward 只记录摘要和链接 |
| Non-goals | 不做 CLI/Plugin/Hook/外部依赖 | 保持不变，也不做自动截图下载 |

---

## 15. Definition of Done 增量

- [ ] 项目模板包含完整 `reference-library/` 结构；
- [ ] `product-index.md` 与 `product-index.yml` 可读且字段一致；
- [ ] `pattern-index.md` 与 `pattern-index.yml` 可读且字段一致；
- [ ] 每个产品条目包含 surface、page type、task type、borrow、avoid、source；
- [ ] 每个模式条目包含 suitable surfaces、risky surfaces、avoid 和 QA checks；
- [ ] 色卡目录存在，但不预填具体色卡；
- [ ] `REFERENCE_SELECTION.template.md` 存在；
- [ ] `STATE.template.md` 包含终端和参考摘要小节；
- [ ] `AGENTS.fragment.md` 包含参考库消费规则；
- [ ] `design-engineering` Skill 明确 Surface Resolution 和 Reference Selection 流程；
- [ ] 示例中至少一个 UI/UX Work Item 包含 `REFERENCE_SELECTION.md`；
- [ ] 新增评测能证明 Web/mobile 参考不会被错误混用；
- [ ] 没有创建 `reference-library/reference-packs/`；
- [ ] 没有下载、内嵌或对外复用第三方版权截图。

---

## 16. 实施顺序建议

### Milestone 1：目录与资料库

- 创建 `reference-library/`；
- 写 README、LLM 使用指南、source manifest；
- 生成 product index 和 pattern index；
- 创建 products、patterns、screenshots、color-cards、schemas。

### Milestone 2：模板更新

- 新增 `REFERENCE_SELECTION.template.md`；
- 更新 `STATE.template.md`；
- 更新项目 `AGENTS.fragment.md`。

### Milestone 3：Skill / Steward 文档更新

- 更新 `design-engineering/SKILL.md`；
- 新增 `reference-library-consumption.md`；
- 更新 Steward 职责边界说明。

### Milestone 4：README / architecture / manual test

- 更新中英文 README；
- 更新 architecture；
- 更新 manual test guide。

### Milestone 5：示例和评测

- 给示例 Work Item 补充 `REFERENCE_SELECTION.md`；
- 新增 Web/mobile/reference-selection 的评测场景；
- 自检 v0.1.0-alpha visual-workflow revision 已有 10 个评测仍然成立。
